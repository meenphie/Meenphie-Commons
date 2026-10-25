using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

/// <summary>
/// One bake pass for everything the "Meenphie/Standard/Opaque" shader needs in array mode:
///  - 5 texture arrays (albedo, normal, metallic, roughness, emission), PC + Quest
///  - a material table (_Color, subsurface, emission, metallic/roughness fallbacks)
///  - baked meshes (single submesh) carrying the indices:
///        UV0  (Vector4) : MainUV.xy + LightmapUV.zw   (kept intact)
///        UV2.xy         : emission slice, material table column   (zw preserved)
///        UV3  (TEXCOORD3): albedo, normal, metallic, roughness slices
///  - one shared material per (shader, _Offset, keywords, LUT)
/// It always reads the ORIGINAL mesh/materials (from the registry once applied),
/// so Rebake is stable.
/// </summary>
public static class MeshArrayBaker
{
    // Only renderers whose materials ALL use one of these shaders are processed.
    private static readonly string[] TargetShaders = { "Meenphie/Standard/Opaque" };

    private const int MaxPcRes = 2048;
    private const int SliceWarn = 64;
    private const string MasterKeyword = "_UDON_MESH_ARRAYS_ON";

    private static string RegistryPath => BakePaths.Root + "BakedMeshRegistry.asset";
    private static string TablePath => BakePaths.Tables + "MaterialTable.asset";

    // ───────────────────────── Channels ─────────────────────────

    private sealed class Channel
    {
        public string Name, TexProp, ArrayName, Folder;
        public bool Srgb, IsNormal;
        public List<Texture2D> Textures = new List<Texture2D>();
        public Dictionary<Texture2D, int> Index = new Dictionary<Texture2D, int>();

        public string PathPC => Folder + ArrayName + "_PC.asset";
        public string PathQuest => Folder + ArrayName + "_Quest.asset";
        public string NamesPath => Folder + ArrayName + "_Slices.txt";          // "index<TAB>source asset path"
        public string GlobalName => "_Udon" + ArrayName;                       // _UdonAlbedoArray
        public string MgrField => char.ToLower(Name[0]) + Name.Substring(1) + "Array"; // albedoArray (+PC/Quest)
        public int IndexOf(Texture2D t) => t != null && Index.TryGetValue(t, out var i) ? i : -1;
    }

    private static Channel[] MakeChannels() => new[]
    {
        new Channel { Name = "Albedo",    TexProp = "_MainTex",        ArrayName = "AlbedoArray",    Folder = BakePaths.Albedo,    Srgb = true  },
        new Channel { Name = "Normal",    TexProp = "_BumpMap",        ArrayName = "NormalArray",    Folder = BakePaths.Normal,    IsNormal = true },
        new Channel { Name = "Metallic",  TexProp = "_MetallicMap",    ArrayName = "MetallicArray",  Folder = BakePaths.Metallic  },
        new Channel { Name = "Roughness", TexProp = "_GlossinessMap",  ArrayName = "RoughnessArray", Folder = BakePaths.Roughness },
        new Channel { Name = "Emission",  TexProp = "_EmissionMap",    ArrayName = "EmissionArray",  Folder = BakePaths.Emission,  Srgb = true  },
    };

    // ───────────────────────── Resolve ─────────────────────────

    private sealed class Resolved
    {
        public MeshRenderer r;
        public MeshFilter mf;
        public string id;
        public Mesh origMesh;
        public Material[] origMats;   // full original array
        public Material[] mats;       // trimmed to submesh count
        public string meshPath, matPath;
        public bool valid;
        public string reason;
    }

    private static IEnumerable<MeshRenderer> FindRenderers() =>
        Object.FindObjectsOfType<MeshRenderer>(true)
              .Where(r => r != null && r.gameObject.scene.IsValid() && !EditorUtility.IsPersistent(r));

    private static Resolved Resolve(MeshRenderer r, BakedMeshRegistry reg)
    {
        var v = new Resolved { r = r, mf = r.GetComponent<MeshFilter>() };
        if (v.mf == null || v.mf.sharedMesh == null) { v.reason = "no mesh"; return v; }

        v.id = BakedMeshRegistry.IdOf(r);

        if (reg != null && reg.TryGet(v.id, out var e) && e.originalMesh != null && e.originalMaterials != null)
        {
            v.origMesh = e.originalMesh;
            v.origMats = e.originalMaterials;
        }
        else
        {
            v.origMesh = v.mf.sharedMesh;
            v.origMats = r.sharedMaterials;
            if (AssetDatabase.GetAssetPath(v.origMesh).StartsWith(BakePaths.Meshes))
            { v.reason = "baked mesh without registry entry"; return v; }
        }

        int sub = v.origMesh.subMeshCount;
        if (v.origMats == null || v.origMats.Length < sub) { v.reason = "fewer materials than submeshes"; return v; }
        v.mats = v.origMats.Take(sub).ToArray();

        foreach (var m in v.mats)
        {
            if (m == null || m.shader == null) { v.reason = "null material"; return v; }
            if (!TargetShaders.Contains(m.shader.name)) { v.reason = "other shader"; return v; }
            if (m.HasProperty("_IsDynamicMesh") && m.GetFloat("_IsDynamicMesh") > 0.5f) { v.reason = "dynamic mesh"; return v; }
        }
        for (int s = 0; s < sub; s++)
            if (v.origMesh.GetTopology(s) != MeshTopology.Triangles) { v.reason = "non-triangle topology"; return v; }

        // Unique, deterministic names
        string meshAsset = AssetDatabase.GetAssetPath(v.origMesh);
        string meshKey = (string.IsNullOrEmpty(meshAsset) ? v.id : meshAsset) + "|" + v.origMesh.name + "|" +
                         v.origMesh.vertexCount + "|" + string.Join(",", v.mats.Select(MatKey));
        v.meshPath = $"{BakePaths.Meshes}Baked_{Safe(v.origMesh.name)}_{Hash(meshKey)}.asset";

        var m0 = v.mats[0];
        string variant = $"{m0.shader.name}|{Fl(m0, "_Offset", 0)}|{Kw(m0, "_DIFFUSE_ON")}{Kw(m0, "_SPECULARS_ON")}{Kw(m0, "_REFLECTIONS_ON")}|{LutKey(m0)}";
        v.matPath = $"{BakePaths.Materials}BakedShared_{Safe(m0.shader.name)}_{Hash(variant)}.mat";

        v.valid = true;
        return v;
    }

    // ───────────────────────── Bake ─────────────────────────

    public static void Bake()
    {
        if (!ScenesSaved()) return;
        BakePaths.EnsureAll();
        var reg = LoadOrCreateRegistry();
        var channels = MakeChannels();

        try
        {
            Progress("Scanning renderers…", 0f);
            var all = FindRenderers().Select(r => Resolve(r, reg)).ToList();
            ReportSkipped(all);
            var valid = all.Where(x => x.valid).ToList();
            if (valid.Count == 0) { Debug.LogWarning("[MeshArrays] No eligible renderer found."); return; }

            var mats = valid.SelectMany(v => v.mats).Distinct()
                            .OrderBy(m => AssetDatabase.GetAssetPath(m)).ThenBy(m => m.name).ToList();

            // 1. Unique textures per channel (dedupe by texture only: tint lives in the table)
            foreach (var ch in channels)
            {
                var set = new HashSet<Texture2D>();
                foreach (var m in mats) { var t = GetTex(m, ch.TexProp); if (t != null) set.Add(t); }
                ch.Textures = set.OrderBy(t => AssetDatabase.GetAssetPath(t)).ThenBy(t => t.name).ToList();
                ch.Index.Clear();
                for (int i = 0; i < ch.Textures.Count; i++) ch.Index[ch.Textures[i]] = i;
            }

            // 2. Material table columns
            var matId = new Dictionary<Material, int>();
            var cols = new List<Vector4[]>();
            var colIndex = new Dictionary<(Vector4, Vector4, Vector4, Vector4), int>();
            foreach (var m in mats)
            {
                var p = ReadParams(m);
                var key = (p[0], p[1], p[2], p[3]);
                if (!colIndex.TryGetValue(key, out int id)) { id = cols.Count; colIndex[key] = id; cols.Add(p); }
                matId[m] = id;
            }

            // 3. Arrays
            for (int c = 0; c < channels.Length; c++)
            {
                var ch = channels[c];
                Progress($"Building {ch.Name} array ({ch.Textures.Count} slices)…", 0.1f + 0.45f * c / channels.Length);

                if (ch.Textures.Count == 0)
                {
                    AssetDatabase.DeleteAsset(ch.PathPC);
                    AssetDatabase.DeleteAsset(ch.PathQuest);
                    AssetDatabase.DeleteAsset(ch.NamesPath);
                    continue;
                }
                if (ch.Textures.Count > SliceWarn)
                    Debug.LogWarning($"[MeshArrays] {ch.Name}: {ch.Textures.Count} slices (> {SliceWarn}).");

                int maxSrc = ch.Textures.Max(t => Mathf.Max(t.width, t.height));
                int pcRes = Mathf.Min(Mathf.NextPowerOfTwo(maxSrc), MaxPcRes);
                int questRes = Mathf.Max(4, pcRes / 2);

                var pc = BuildArray(ch, pcRes, ch.ArrayName + "_PC");
                var quest = BuildArray(ch, questRes, ch.ArrayName + "_Quest");
                if (pc == null || quest == null) return;
                BakeUtil.SaveOrReplace(pc, ch.PathPC);
                BakeUtil.SaveOrReplace(quest, ch.PathQuest);

                File.WriteAllLines(Path.GetFullPath(ch.NamesPath),
                    ch.Textures.Select((t, i) => i + "\t" + AssetDatabase.GetAssetPath(t)));
                AssetDatabase.ImportAsset(ch.NamesPath);
            }
            AssetDatabase.SaveAssets();

            // 4. Material table (4 rows x N columns, point filtered)
            Progress("Building material table…", 0.6f);
            int w = Mathf.Max(1, cols.Count);
            var table = new Texture2D(w, 4, TextureFormat.RGBAFloat, false, true)
            { name = "MaterialTable", filterMode = FilterMode.Point, wrapMode = TextureWrapMode.Clamp };
            var px = new Color[w * 4];
            for (int x = 0; x < cols.Count; x++)
                for (int row = 0; row < 4; row++)
                {
                    var q = cols[x][row];
                    px[row * w + x] = new Color(q.x, q.y, q.z, q.w);
                }
            table.SetPixels(px);
            table.Apply(false, false);
            BakeUtil.SaveOrReplace(table, TablePath);

            // 5. Baked meshes (one per unique mesh+materials) and shared materials (one per variant)
            var builtMeshes = new HashSet<string>();
            var builtMats = new HashSet<string>();
            int n = 0;
            foreach (var v in valid)
            {
                Progress($"Meshes… {++n}/{valid.Count}", 0.65f + 0.3f * n / valid.Count);

                if (builtMeshes.Add(v.meshPath))
                    BakeUtil.SaveOrReplace(BuildBakedMesh(v, channels, matId), v.meshPath);

                if (builtMats.Add(v.matPath))
                {
                    var shared = AssetDatabase.LoadAssetAtPath<Material>(v.matPath);
                    if (shared == null)
                    {
                        shared = new Material(v.mats[0]) { name = Path.GetFileNameWithoutExtension(v.matPath) };
                        AssetDatabase.CreateAsset(shared, v.matPath);
                    }
                    ConfigureShared(shared);
                }
            }
            AssetDatabase.SaveAssets();

            // 6. Hand references to the LightingManager (runtime push) + editor globals
            foreach (var ch in channels)
            {
                SetManager(ch.MgrField + "PC", AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC));
                SetManager(ch.MgrField + "Quest", AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathQuest));
            }
            SetManager("materialTable", AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath));
            PushGlobals();

            Debug.Log($"[MeshArrays] Bake OK — {valid.Count} renderers, {builtMeshes.Count} meshes, " +
                      $"{builtMats.Count} shared material(s), {cols.Count} material column(s), " +
                      string.Join(", ", channels.Select(c => $"{c.Name}:{c.Textures.Count}")));

            // Rebake: keep an already-applied scene consistent (old meshes carry stale indices)
            if (reg.entries.Count > 0)
            {
                Apply();
                Cleanup(builtMeshes, BakePaths.Meshes, "t:Mesh");
                Cleanup(builtMats, BakePaths.Materials, "t:Material");
            }
        }
        finally { EditorUtility.ClearProgressBar(); }
    }

    // ───────────────────────── Apply / Restore / Delete ─────────────────────────

    public static void Apply()
    {
        if (!ScenesSaved()) return;
        var reg = LoadOrCreateRegistry();
        int ok = 0, missing = 0;

        Undo.IncrementCurrentGroup();
        Undo.SetCurrentGroupName("Apply Mesh Arrays");
        try
        {
            var rends = FindRenderers().ToList();
            for (int i = 0; i < rends.Count; i++)
            {
                if (i % 50 == 0) Progress($"Applying… {i}/{rends.Count}", (float)i / rends.Count);
                var v = Resolve(rends[i], reg);
                if (!v.valid) continue;

                var baked = AssetDatabase.LoadAssetAtPath<Mesh>(v.meshPath);
                var shared = AssetDatabase.LoadAssetAtPath<Material>(v.matPath);
                if (baked == null || shared == null) { missing++; continue; }

                reg.Register(v.id, v.origMesh, v.origMats);

                Undo.RecordObject(v.mf, "Apply Mesh Arrays");
                Undo.RecordObject(v.r, "Apply Mesh Arrays");
                v.mf.sharedMesh = baked;
                v.r.sharedMaterials = new[] { shared };
                PrefabUtility.RecordPrefabInstancePropertyModifications(v.mf);
                PrefabUtility.RecordPrefabInstancePropertyModifications(v.r);
                EditorUtility.SetDirty(v.mf);
                EditorUtility.SetDirty(v.r);
                EditorSceneManager.MarkSceneDirty(v.r.gameObject.scene);
                ok++;
            }
            EditorUtility.SetDirty(reg);
            AssetDatabase.SaveAssets();
        }
        finally { EditorUtility.ClearProgressBar(); }

        Debug.Log($"[MeshArrays] Apply: {ok} renderers updated" + (missing > 0 ? $", {missing} skipped (run Bake first)." : "."));
    }

    /// <summary>Puts the original mesh/materials back on every renderer found in the loaded scenes.</summary>
    public static int Restore()
    {
        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        if (reg == null) return 0;

        var restored = new HashSet<string>();
        Undo.IncrementCurrentGroup();
        Undo.SetCurrentGroupName("Restore Original Meshes");
        foreach (var r in FindRenderers())
        {
            var mf = r.GetComponent<MeshFilter>();
            if (mf == null) continue;
            string id = BakedMeshRegistry.IdOf(r);
            if (!reg.TryGet(id, out var e)) continue;

            Undo.RecordObject(mf, "Restore");
            Undo.RecordObject(r, "Restore");
            mf.sharedMesh = e.originalMesh;
            r.sharedMaterials = e.originalMaterials;
            PrefabUtility.RecordPrefabInstancePropertyModifications(mf);
            PrefabUtility.RecordPrefabInstancePropertyModifications(r);
            EditorUtility.SetDirty(mf);
            EditorUtility.SetDirty(r);
            EditorSceneManager.MarkSceneDirty(r.gameObject.scene);
            restored.Add(id);
        }
        reg.RemoveWhere(e => restored.Contains(e.id));
        EditorUtility.SetDirty(reg);
        AssetDatabase.SaveAssets();
        Debug.Log($"[MeshArrays] Restore: {restored.Count} renderers restored.");
        return restored.Count;
    }

    /// <summary>Restores the scene, then deletes every generated asset. Returns false if cancelled.</summary>
    public static bool DeleteAll()
    {
        Restore();
        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        if (reg != null && reg.entries.Count > 0 &&
            !EditorUtility.DisplayDialog("Delete All",
                $"{reg.entries.Count} registry entrie(s) could not be restored (object deleted, or its scene is not open).\n\n" +
                "Deleting now will leave those renderers with missing meshes. Continue?", "Delete", "Cancel"))
            return false;

        foreach (var ch in MakeChannels())
        {
            AssetDatabase.DeleteAsset(ch.PathPC);
            AssetDatabase.DeleteAsset(ch.PathQuest);
            AssetDatabase.DeleteAsset(ch.NamesPath);
            SetManager(ch.MgrField + "PC", null);
            SetManager(ch.MgrField + "Quest", null);
        }
        SetManager("materialTable", null);
        AssetDatabase.DeleteAsset(TablePath);
        AssetDatabase.DeleteAsset(RegistryPath);
        foreach (var f in new[] { BakePaths.Meshes, BakePaths.Materials })
            if (AssetDatabase.IsValidFolder(f.TrimEnd('/'))) AssetDatabase.DeleteAsset(f.TrimEnd('/'));

        AssetDatabase.Refresh();
        PushGlobals();
        Debug.Log("[MeshArrays] Delete All done.");
        return true;
    }

    // ───────────────────────── Status ─────────────────────────

    public static bool IsBaked => AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath) != null;

    public static string Status()
    {
        if (!IsBaked) return "Not baked";
        var sb = new StringBuilder();
        long bytes = 0;
        foreach (var ch in MakeChannels())
        {
            var a = AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC);
            sb.Append($"{ch.Name[0]}:{(a != null ? a.depth : 0)} ");
            bytes += FileSize(ch.PathPC);
        }
        var t = AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath);
        sb.Append($"· {t.width} materials · {bytes / (1024f * 1024f):F1} MB");
        return sb.ToString();
    }

    public static (int count, bool warn) SliceInfo()
    {
        int max = 0;
        foreach (var ch in MakeChannels())
        {
            var a = AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC);
            if (a != null) max = Mathf.Max(max, a.depth);
        }
        return (max, max > SliceWarn);
    }

    // ───────────────────────── Preview API (BakeManagerWindow) ─────────────────────────

    public static string[] ChannelNames => MakeChannels().Select(c => c.Name).ToArray();
    public static Texture2DArray LoadArray(int channel) => AssetDatabase.LoadAssetAtPath<Texture2DArray>(MakeChannels()[channel].PathPC);
    public static bool IsSrgbChannel(int channel) => MakeChannels()[channel].Srgb;
    public static bool IsNormalChannel(int channel) => MakeChannels()[channel].IsNormal;
    public static Texture2D LoadTable() => AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath);

    /// <summary>Source texture asset path per slice (empty if baked before this feature: rebake).</summary>
    public static string[] LoadSliceNames(int channel)
    {
        var full = Path.GetFullPath(MakeChannels()[channel].NamesPath);
        if (!File.Exists(full)) return new string[0];
        return File.ReadAllLines(full).Select(l => { int i = l.IndexOf('\t'); return i >= 0 ? l.Substring(i + 1) : l; }).ToArray();
    }

    // ───────────────────────── Editor globals ─────────────────────────

    [InitializeOnLoadMethod]
    private static void Init()
    {
        EditorApplication.delayCall += PushGlobals;
        EditorSceneManager.sceneOpened += (s, m) => PushGlobals();
    }

    /// <summary>Editor-side upload so the Scene view is correct after reload. Runtime is handled by LightingManager.</summary>
    public static void PushGlobals()
    {
        foreach (var ch in MakeChannels())
            Shader.SetGlobalTexture(ch.GlobalName, AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC));
        Shader.SetGlobalTexture("_UdonMaterialTable", AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath));
    }

    // ───────────────────────── Arrays ─────────────────────────

    private static bool GetFormat(Channel ch, out GraphicsFormat gfx, out TextureFormat tex)
    {
        gfx = default; tex = default;
        if (ch.IsNormal)
        {
            if (!SystemInfo.SupportsTextureFormat(TextureFormat.BC5)) { Debug.LogError("[MeshArrays] BC5 not supported by this editor GPU."); return false; }
            gfx = GraphicsFormat.RG_BC5_UNorm; tex = TextureFormat.BC5; return true;
        }
        if (ch.Srgb) { (gfx, tex) = BakeUtil.BestSrgbFormat(); return true; }
        if (!SystemInfo.SupportsTextureFormat(TextureFormat.BC4)) { Debug.LogError("[MeshArrays] BC4 not supported by this editor GPU."); return false; }
        gfx = GraphicsFormat.R_BC4_UNorm; tex = TextureFormat.BC4; return true;
    }

    private static Texture2DArray BuildArray(Channel ch, int res, string assetName)
    {
        if (!GetFormat(ch, out var gfx, out var texFmt)) return null;

        int mips = 1 + (int)Mathf.Floor(Mathf.Log(res, 2));
        var arr = new Texture2DArray(res, res, ch.Textures.Count, gfx, TextureCreationFlags.MipChain, mips)
        { name = assetName, wrapMode = TextureWrapMode.Repeat, filterMode = FilterMode.Trilinear, anisoLevel = 4 };

        for (int i = 0; i < ch.Textures.Count; i++)
        {
            var rt = RenderTexture.GetTemporary(res, res, 0, RenderTextureFormat.ARGB32,
                ch.Srgb ? RenderTextureReadWrite.sRGB : RenderTextureReadWrite.Linear);
            var prev = RenderTexture.active;
            Graphics.Blit(ch.Textures[i], rt);

            var tmp = new Texture2D(res, res, TextureFormat.RGBA32, true, !ch.Srgb);
            RenderTexture.active = rt;
            tmp.ReadPixels(new Rect(0, 0, res, res), 0, 0, true);
            RenderTexture.active = prev;
            RenderTexture.ReleaseTemporary(rt);

            if (ch.IsNormal) UnpackNormalsToRG(tmp);
            tmp.Apply(true);

            EditorUtility.CompressTexture(tmp, texFmt, TextureCompressionQuality.Best);
            tmp.Apply(false);

            int copyMips = Mathf.Min(mips, tmp.mipmapCount);
            for (int m = 0; m < copyMips; m++) Graphics.CopyTexture(tmp, 0, m, arr, i, m);
            Object.DestroyImmediate(tmp);
        }
        return arr;
    }

    // Unity's UnpackNormalmapRGorAG: x = r * a, y = g (works for DXT5nm and plain RG storage).
    // We store the encoded xy in RG (BC5); the shader rebuilds z.
    private static void UnpackNormalsToRG(Texture2D tex)
    {
        var px = tex.GetPixels32();
        for (int i = 0; i < px.Length; i++)
        {
            var c = px[i];
            float x = (c.r / 255f) * (c.a / 255f);
            px[i] = new Color32((byte)Mathf.RoundToInt(Mathf.Clamp01(x) * 255f), c.g, 0, 255);
        }
        tex.SetPixels32(px);
    }

    // ───────────────────────── Mesh ─────────────────────────

    private static Mesh BuildBakedMesh(Resolved v, Channel[] ch, Dictionary<Material, int> matId)
    {
        var src = v.origMesh;
        int subCount = src.subMeshCount;

        var srcV = src.vertices;
        var srcN = src.normals; bool hasN = srcN != null && srcN.Length == srcV.Length;
        var srcT = src.tangents; bool hasT = srcT != null && srcT.Length == srcV.Length;
        var srcC = src.colors32; bool hasC = srcC != null && srcC.Length == srcV.Length;

        var srcUV = new List<Vector4>[8];
        for (int c = 0; c < 8; c++)
            if (src.HasVertexAttribute((VertexAttribute)((int)VertexAttribute.TexCoord0 + c)))
            { srcUV[c] = new List<Vector4>(); src.GetUVs(c, srcUV[c]); }

        var verts = new List<Vector3>(); var norms = new List<Vector3>(); var tngs = new List<Vector4>();
        var cols = new List<Color32>();
        var uv = new List<Vector4>[8];
        for (int c = 0; c < 8; c++) if (srcUV[c] != null || c == 2 || c == 3) uv[c] = new List<Vector4>();
        var tris = new List<int>();

        for (int sm = 0; sm < subCount; sm++)
        {
            var mat = v.mats[sm];
            var a = new Vector4(
                ch[0].IndexOf(GetTex(mat, ch[0].TexProp)),   // albedo    -> x
                ch[1].IndexOf(GetTex(mat, ch[1].TexProp)),   // normal    -> y
                ch[2].IndexOf(GetTex(mat, ch[2].TexProp)),   // metallic  -> z
                ch[3].IndexOf(GetTex(mat, ch[3].TexProp)));  // roughness -> w
            float emissionSlice = ch[4].IndexOf(GetTex(mat, ch[4].TexProp));
            float column = matId[mat];

            var remap = new Dictionary<int, int>();
            foreach (int o in src.GetTriangles(sm))
            {
                if (!remap.TryGetValue(o, out int ni))
                {
                    ni = verts.Count; remap[o] = ni;
                    verts.Add(srcV[o]);
                    if (hasN) norms.Add(srcN[o]);
                    if (hasT) tngs.Add(srcT[o]);
                    if (hasC) cols.Add(srcC[o]);
                    for (int c = 0; c < 8; c++)
                    {
                        if (uv[c] == null) continue;
                        Vector4 val = srcUV[c] != null ? srcUV[c][o] : Vector4.zero;
                        if (c == 2) { val.x = emissionSlice; val.y = column; }
                        else if (c == 3) val = a;
                        uv[c].Add(val);
                    }
                }
                tris.Add(ni);
            }
        }

        var m = new Mesh
        {
            name = Path.GetFileNameWithoutExtension(v.meshPath),
            indexFormat = verts.Count > 65535 ? IndexFormat.UInt32 : IndexFormat.UInt16
        };
        m.SetVertices(verts);
        if (hasN) m.SetNormals(norms);
        if (hasC) m.SetColors(cols);
        for (int c = 0; c < 8; c++) if (uv[c] != null) m.SetUVs(c, uv[c]);   // Vector4: UV0.zw survives
        m.SetTriangles(tris, 0);
        if (!hasN) m.RecalculateNormals();
        if (hasT) m.SetTangents(tngs); else m.RecalculateTangents();
        m.RecalculateBounds();
        return m;
    }

    // ───────────────────────── Material ─────────────────────────

    private static void ConfigureShared(Material m)
    {
        foreach (var p in new[] { "_MainTex", "_BumpMap", "_MetallicMap", "_GlossinessMap", "_EmissionMap" })
            if (m.HasProperty(p)) m.SetTexture(p, null);

        m.EnableKeyword(MasterKeyword);
        // belt and braces: keep the classic map switches on (wire the master switch outermost in ASE anyway)
        m.EnableKeyword("_METALLICMAP"); m.EnableKeyword("_GLOSSINESSMAP"); m.EnableKeyword("_BUMPMAP");

        if (m.HasProperty("_LightGroupMask")) m.SetFloat("_LightGroupMask", 0f);
        if (m.HasProperty("_IsDynamicMesh")) m.SetFloat("_IsDynamicMesh", 0f);
        EditorUtility.SetDirty(m);
    }

    /// <summary>Rows: 0 _Color | 1 subsurface rgb + thickness | 2 emission rgb + intensity | 3 metallic, roughness.</summary>
    private static Vector4[] ReadParams(Material m)
    {
        bool lin = PlayerSettings.colorSpace == ColorSpace.Linear;
        Color c = Col(m, "_Color", Color.white);
        Color sc = Col(m, "_SubsurfaceColor", new Color(1f, 0.42f, 0.37f, 0f));
        Color ec = Col(m, "_EmissionColor", Color.white);          // [Gamma] property: uploaded as-is
        if (lin) { c = c.linear; sc = sc.linear; }                  // normal Color properties are linearised on upload
        return new[]
        {
            new Vector4(c.r, c.g, c.b, c.a),
            new Vector4(sc.r, sc.g, sc.b, Fl(m, "_Thickness", 0f)),
            new Vector4(ec.r, ec.g, ec.b, Fl(m, "_EmissionIntensity", 0f)),
            new Vector4(Fl(m, "_Metallic", 0f), Fl(m, "_Glossiness", 0.5f), 0f, 0f),
        };
    }

    // ───────────────────────── Helpers ─────────────────────────

    private static Texture2D GetTex(Material m, string prop) => m.HasProperty(prop) ? m.GetTexture(prop) as Texture2D : null;
    private static Color Col(Material m, string p, Color d) => m.HasProperty(p) ? m.GetColor(p) : d;
    private static float Fl(Material m, string p, float d) => m.HasProperty(p) ? m.GetFloat(p) : d;
    private static int Kw(Material m, string k) => m.IsKeywordEnabled(k) ? 1 : 0;
    private static string MatKey(Material m) => AssetDatabase.GetAssetPath(m) + "/" + m.name;
    private static string LutKey(Material m) => m.HasProperty("_LUT") && m.GetTexture("_LUT") != null ? AssetDatabase.GetAssetPath(m.GetTexture("_LUT")) : "";

    private static string Safe(string s) => string.Join("_", s.Replace('/', '_').Split(Path.GetInvalidFileNameChars()));

    private static string Hash(string s)
    {
        using (var md5 = MD5.Create())
        {
            var b = md5.ComputeHash(Encoding.UTF8.GetBytes(s));
            return BitConverter.ToString(b, 0, 4).Replace("-", "").ToLowerInvariant();
        }
    }

    private static long FileSize(string assetPath)
    {
        var full = Path.GetFullPath(assetPath);
        return File.Exists(full) ? new FileInfo(full).Length : 0;
    }

    private static void Progress(string msg, float p) => EditorUtility.DisplayProgressBar("Mesh Arrays", msg, p);

    private static bool ScenesSaved()
    {
        for (int i = 0; i < SceneManager.sceneCount; i++)
        {
            var s = SceneManager.GetSceneAt(i);
            if (s.isLoaded && string.IsNullOrEmpty(s.path))
            {
                Debug.LogError("[MeshArrays] Save the scene first (renderer ids need a saved scene).");
                return false;
            }
        }
        return true;
    }

    private static BakedMeshRegistry LoadOrCreateRegistry()
    {
        BakePaths.EnsureAll();
        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        if (reg == null)
        {
            reg = ScriptableObject.CreateInstance<BakedMeshRegistry>();
            AssetDatabase.CreateAsset(reg, RegistryPath);
        }
        return reg;
    }

    private static void ReportSkipped(List<Resolved> all)
    {
        var groups = all.Where(x => !x.valid && x.reason != "no mesh")
                        .GroupBy(x => x.reason).Select(g => $"{g.Key}: {g.Count()}").ToList();
        if (groups.Count > 0) Debug.Log("[MeshArrays] Skipped renderers → " + string.Join(", ", groups));
    }

    private static void Cleanup(HashSet<string> keep, string folder, string filter)
    {
        if (!AssetDatabase.IsValidFolder(folder.TrimEnd('/'))) return;
        foreach (var g in AssetDatabase.FindAssets(filter, new[] { folder.TrimEnd('/') }))
        {
            var p = AssetDatabase.GUIDToAssetPath(g);
            if (!keep.Contains(p)) AssetDatabase.DeleteAsset(p);
        }
    }

    /// <summary>Writes a reference on the LightingManager by property name (no compile-time coupling).</summary>
    private static void SetManager(string field, Object value)
    {
        var mgr = Object.FindObjectsOfType<MonoBehaviour>().FirstOrDefault(m => m != null && m.GetType().Name == "LightingManager");
        if (mgr == null) return;
        var so = new SerializedObject(mgr);
        var prop = so.FindProperty(field);
        if (prop == null) { Debug.LogWarning($"[MeshArrays] LightingManager has no field '{field}'."); return; }
        prop.objectReferenceValue = value;
        so.ApplyModifiedProperties();
    }
}

public class MeshArraysBakeOp : IBakeOperation
{
    public string DisplayName => "Mesh Arrays + Material Table";
    public bool IsBaked => MeshArrayBaker.IsBaked;
    public string GetStatus() => MeshArrayBaker.Status();
    public (int count, bool warn) GetSliceInfo() => MeshArrayBaker.SliceInfo();
    public void Bake() => MeshArrayBaker.Bake();
    public void Delete() => MeshArrayBaker.DeleteAll();
}