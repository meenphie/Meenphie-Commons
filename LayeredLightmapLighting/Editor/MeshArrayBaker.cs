using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using Object = UnityEngine.Object;

/// <summary>
/// Bakes the "Meenphie/Standard/Opaque" shader's array inputs:
///  5 texture arrays (albedo, normal, metallic, roughness, emission), PC + Quest,
///  a 4-row material table, one shared material per variant, baked meshes with
///  slice/column indices packed into UV2/UV3 and the shared reflection-probe plan packed into UV8.
/// Rebake always re-reads the original meshes/materials from the registry, so it is stable.
/// </summary>
public static partial class MeshArrayBaker
{
    private const int SliceWarn = 64;

    private static string RegistryPath => BakePaths.Root + "BakedMeshRegistry.asset";
    private static string TablePath => BakePaths.Tables + "MaterialTable.asset";

    private sealed class Resolved
    {
        public MeshRenderer r;
        public MeshFilter mf;
        public string id;
        public Mesh origMesh;
        public Material[] origMats;
        public string meshPath;
        public string[] matPaths;
        public string[] submeshMatPaths;
        public string matPath;
        public int reflectionProbeIndex;
        public string reason;
    }

    public sealed class ReflectionProbePlan
    {
        private readonly Dictionary<Renderer, int> _rendererProbeIndices;

        internal ReflectionProbePlan(
            ReflectionProbe[] probes,
            Dictionary<Renderer, int> rendererProbeIndices)
        {
            Probes = probes;
            _rendererProbeIndices = rendererProbeIndices;
        }

        public ReflectionProbe[] Probes { get; }
        public IEnumerable<KeyValuePair<Renderer, int>> Assignments => _rendererProbeIndices;

        public int GetProbeIndex(Renderer renderer) =>
            renderer != null && _rendererProbeIndices.TryGetValue(renderer, out int index) ? index : -1;
    }

    // ───────────────────────── Bake ─────────────────────────

    public static void Bake()
    {
        if (BlockedInPlayMode("Bake")) return;
        Bake(CreateReflectionProbePlan());
    }

    public static void Bake(ReflectionProbePlan probePlan)
    {
        if (probePlan == null) throw new System.ArgumentNullException(nameof(probePlan));
        if (BlockedInPlayMode("Bake")) return;
        if (!BakeUtil.EnsureScenesSaved()) return;
        BakePaths.EnsureAll();
        var reg = LoadOrCreateRegistry();

        try
        {
            Progress("Scanning renderers…", 0f);
            var all = FindRenderers()
                .Select(r => Resolve(r, reg, probePlan.GetProbeIndex(r)))
                .ToList();
            ReportSkipped(all);
            var valid = all.Where(x => x.reason == null).ToList();
            if (valid.Count == 0) { Debug.LogWarning("[MeshArrays] No eligible renderer found."); return; }

            var mats = valid.SelectMany(v => v.origMats).Distinct()
                            .OrderBy(m => AssetDatabase.GetAssetPath(m)).ThenBy(m => m.name).ToList();

            // 1. Unique textures per channel (DÉDUPLICATION PAR CONTENU)
            foreach (var ch in Channels)
            {
                var uniqueTextures = new List<Texture2D>();
                var seenHashes = new Dictionary<Hash128, Texture2D>();
                var seenTextures = new HashSet<Texture2D>();

                foreach (var m in mats)
                {
                    var tex = GetTex(m, ch.TexProp);
                    if (tex == null) continue;
                    if (seenTextures.Contains(tex)) continue; // Déjà vu par référence

                    var hash = tex.imageContentsHash;
                    if (hash.isValid)
                    {
                        if (seenHashes.ContainsKey(hash)) continue; // Déjà vu par contenu
                        seenHashes[hash] = tex;
                    }

                    seenTextures.Add(tex);
                    uniqueTextures.Add(tex);
                }

                // Tri pour avoir un ordre déterministe
                ch.Textures = uniqueTextures.OrderBy(t => AssetDatabase.GetAssetPath(t)).ThenBy(t => t.name).ToList();

                // Reconstruction des index
                ch.Index.Clear();
                ch.HashIndex.Clear();
                for (int i = 0; i < ch.Textures.Count; i++)
                {
                    var t = ch.Textures[i];
                    ch.Index[t] = i;
                    var h = t.imageContentsHash;
                    if (h.isValid) ch.HashIndex[h] = i;
                }
            }

            // 2. Material table columns
            var matId = new Dictionary<Material, int>();
            var cols = new List<Vector4[]>();
            var colIdx = new Dictionary<(Vector4, Vector4, Vector4, Vector4), int>();
            foreach (var m in mats)
            {
                var p = ReadParams(m);
                var key = (p[0], p[1], p[2], p[3]);
                if (!colIdx.TryGetValue(key, out int id)) { id = cols.Count; colIdx[key] = id; cols.Add(p); }
                matId[m] = id;
            }

            for (int c = 0; c < Channels.Length; c++)
                BakeChannel(Channels[c], 0.1f + 0.45f * c / Channels.Length);
            AssetDatabase.SaveAssets();
            BakeMaterialTable(cols);

            // 3. Baked meshes + shared materials
            var builtMeshes = new HashSet<string>();
            foreach (var assignment in probePlan.Assignments)
            {
                if (!(assignment.Key is SkinnedMeshRenderer skinnedRenderer))
                    continue;

                Mesh originalMesh = GetOriginalSkinnedMesh(skinnedRenderer, reg);
                if (originalMesh != null)
                    builtMeshes.Add(SkinnedProbeMeshPath(skinnedRenderer, originalMesh, assignment.Value));
            }

            var builtMats = new HashSet<string>();
            int n = 0;
            foreach (var v in valid)
            {
                Progress($"Meshes… {++n}/{valid.Count}", 0.65f + 0.3f * n / valid.Count);

                if (builtMeshes.Add(v.meshPath))
                    BakeUtil.SaveOrReplace(BuildBakedMesh(v, matId), v.meshPath);

                for (int i = 0; i < v.matPaths.Length; i++)
                {
                    if (builtMats.Add(v.matPaths[i]))
                    {
                        var shared = AssetDatabase.LoadAssetAtPath<Material>(v.matPaths[i]);
                        if (shared == null)
                        {
                            shared = new Material(v.origMats[i]) { name = Path.GetFileNameWithoutExtension(v.matPaths[i]) };
                            AssetDatabase.CreateAsset(shared, v.matPaths[i]);
                        }
                        ConfigureShared(shared);
                    }
                }
            }
            AssetDatabase.SaveAssets();

            // 4. Hand references to LightingManager + editor globals
            foreach (var ch in Channels)
            {
                BakeUtil.SetManagerField(ch.MgrField + "PC", AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC));
                BakeUtil.SetManagerField(ch.MgrField + "Quest", AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathQuest));
            }
            BakeUtil.SetManagerField("materialTable", AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath));
            PushGlobals();

            Debug.Log($"[MeshArrays] Bake OK — {valid.Count} renderers, {builtMeshes.Count} meshes, " +
                      $"{builtMats.Count} shared material(s), {cols.Count} material column(s), " +
                      string.Join(", ", Channels.Select(c => $"{c.Name}:{c.Textures.Count}")));

            // Rebake: keep an already-applied scene consistent (old meshes carry stale indices)
            if (reg.entries.Count > 0)
            {
                Apply(probePlan);
                BakeUtil.DeleteUnused(BakePaths.Meshes, builtMeshes, "t:Mesh");
                BakeUtil.DeleteUnused(BakePaths.Materials, builtMats, "t:Material");
            }
        }
        finally { EditorUtility.ClearProgressBar(); }
    }

    private static void BakeChannel(Channel ch, float progress)
    {
        Progress($"Building {ch.Name} array ({ch.Textures.Count} slices)…", progress);
        if (ch.Textures.Count > SliceWarn)
            Debug.LogWarning($"[MeshArrays] {ch.Name}: {ch.Textures.Count} slices (> {SliceWarn}).");

        int pcRes = ch.Textures.Count == 0
            ? 4
            : Mathf.Min(Mathf.NextPowerOfTwo(ch.Textures.Max(t => Mathf.Max(t.width, t.height))), MaxPcRes);
        var pc = BuildArray(ch, pcRes, ch.ArrayName + "_PC");
        var quest = BuildArray(ch, Mathf.Max(4, pcRes / 2), ch.ArrayName + "_Quest");
        if (pc == null || quest == null) return;

        BakeUtil.SaveOrReplace(pc, ch.PathPC);
        BakeUtil.SaveOrReplace(quest, ch.PathQuest);
        File.WriteAllLines(Path.GetFullPath(ch.NamesPath),
            ch.Textures.Select((t, i) => i + "\t" + AssetDatabase.GetAssetPath(t)));
        AssetDatabase.ImportAsset(ch.NamesPath);
    }

    private static void BakeMaterialTable(List<Vector4[]> cols)
    {
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
    }

    // ───────────────────────── Apply / Restore / Delete ─────────────────────────

    public static void Apply()
    {
        if (BlockedInPlayMode("Apply")) return;
        Apply(CreateReflectionProbePlan());
    }

    public static void Apply(ReflectionProbePlan probePlan)
    {
        if (probePlan == null) throw new System.ArgumentNullException(nameof(probePlan));
        if (BlockedInPlayMode("Apply")) return;
        if (!BakeUtil.EnsureScenesSaved()) return;
        var reg = LoadOrCreateRegistry();
        int ok = 0, skinnedOk = 0, missing = 0, skinnedSkipped = 0;

        Undo.IncrementCurrentGroup();
        Undo.SetCurrentGroupName("Apply Mesh Arrays");
        try
        {
            var rends = FindRenderers().ToList();
            for (int i = 0; i < rends.Count; i++)
            {
                if (i % 50 == 0) Progress($"Applying… {i}/{rends.Count}", (float)i / rends.Count);
                var v = Resolve(rends[i], reg, probePlan.GetProbeIndex(rends[i]));
                if (v.reason != null) continue;

                var baked = AssetDatabase.LoadAssetAtPath<Mesh>(v.meshPath);
                if (baked == null) { missing++; continue; }

                bool missingMat = false;
                foreach (var p in v.matPaths) if (AssetDatabase.LoadAssetAtPath<Material>(p) == null) missingMat = true;
                if (missingMat) { missing++; continue; }

                reg.Register(v.id, v.origMesh, v.origMats);
                ApplyOne(v, baked);
                ok++;
            }

            var skinnedAssignments = probePlan.Assignments
                .Where(assignment => assignment.Key is SkinnedMeshRenderer)
                .ToList();
            for (int i = 0; i < skinnedAssignments.Count; i++)
            {
                var assignment = skinnedAssignments[i];
                var renderer = (SkinnedMeshRenderer)assignment.Key;
                if (i % 50 == 0)
                    Progress($"Applying skinned probes… {i}/{skinnedAssignments.Count}",
                        (float)i / Mathf.Max(skinnedAssignments.Count, 1));

                if (ApplySkinnedProbeAssignment(renderer, assignment.Value, reg))
                    skinnedOk++;
                else
                    skinnedSkipped++;
            }

            EditorUtility.SetDirty(reg);
            AssetDatabase.SaveAssets();
        }
        finally { EditorUtility.ClearProgressBar(); }

        string skippedSummary = missing > 0
            ? $", {missing} mesh renderer(s) skipped (run Bake first)"
            : "";
        if (skinnedSkipped > 0)
            skippedSummary += $", {skinnedSkipped} skinned renderer(s) skipped";
        Debug.Log($"[MeshArrays] Apply: {ok} mesh renderers and {skinnedOk} skinned renderers updated" +
                  skippedSummary + ".");
    }

    private static bool ApplySkinnedProbeAssignment(
        SkinnedMeshRenderer renderer, int probeIndex, BakedMeshRegistry reg)
    {
        Mesh originalMesh = GetOriginalSkinnedMesh(renderer, reg);
        if (originalMesh == null || !IsProbeAssignmentEligible(renderer, reg))
        {
            Debug.LogWarning($"[MeshArrays] Skipped skinned renderer '{renderer.name}': mesh or materials are no longer eligible.");
            return false;
        }

        Material[] originalMaterials = reg.TryGet(renderer, out var entry) && entry.originalMaterials != null
            ? entry.originalMaterials
            : renderer.sharedMaterials;
        string path = SkinnedProbeMeshPath(renderer, originalMesh, probeIndex);
        Mesh bakedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(path);
        if (bakedMesh == null)
        {
            bakedMesh = Object.Instantiate(originalMesh);
            bakedMesh.name = originalMesh.name + "_ProbeAssigned";
            var probeUvs = new List<Vector4>(originalMesh.vertexCount);
            Vector4 assignment = probeIndex >= 0
                ? new Vector4(probeIndex + 1f, 0f, 0f, 0f)
                : Vector4.zero;
            for (int i = 0; i < originalMesh.vertexCount; i++)
                probeUvs.Add(assignment);
            bakedMesh.SetUVs(7, probeUvs);
            AssetDatabase.CreateAsset(bakedMesh, path);
        }

        reg.Register(renderer, originalMesh, originalMaterials);
        Undo.RecordObject(renderer, "Apply Skinned Reflection Probe");
        renderer.sharedMesh = bakedMesh;
        PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);
        EditorUtility.SetDirty(renderer);
        EditorSceneManager.MarkSceneDirty(renderer.gameObject.scene);
        return true;
    }

    private static Mesh GetOriginalSkinnedMesh(SkinnedMeshRenderer renderer, BakedMeshRegistry reg)
    {
        return renderer != null && reg != null && reg.TryGet(renderer, out var entry) &&
               entry.originalMesh != null
            ? entry.originalMesh
            : renderer != null ? renderer.sharedMesh : null;
    }

    private static string SkinnedProbeMeshPath(
        SkinnedMeshRenderer renderer, Mesh originalMesh, int probeIndex)
    {
        string assetPath = AssetDatabase.GetAssetPath(originalMesh);
        string dependencyHash = string.IsNullOrEmpty(assetPath)
            ? string.Empty
            : AssetDatabase.GetAssetDependencyHash(assetPath).ToString();
        string meshKey = BakedMeshRegistry.IdOf(renderer) + "|" + assetPath + "|" + dependencyHash +
                         "|" + originalMesh.name + "|" + originalMesh.vertexCount + "|" +
                         originalMesh.subMeshCount + "|reflectionProbe:" + probeIndex;
        return $"{BakePaths.Meshes}Skinned_{BakeUtil.SafeFileName(originalMesh.name)}_{BakeUtil.ShortHash(meshKey)}.asset";
    }

    private static void ApplyOne(Resolved v, Mesh baked)
    {
        var sharedMats = new Material[v.matPaths.Length];
        for (int i = 0; i < v.matPaths.Length; i++)
            sharedMats[i] = AssetDatabase.LoadAssetAtPath<Material>(v.matPaths[i]);

        Undo.RecordObject(v.mf, "Apply Mesh Arrays");
        Undo.RecordObject(v.r, "Apply Mesh Arrays");
        v.mf.sharedMesh = baked;
        v.r.sharedMaterials = sharedMats;
        PrefabUtility.RecordPrefabInstancePropertyModifications(v.mf);
        PrefabUtility.RecordPrefabInstancePropertyModifications(v.r);
        EditorUtility.SetDirty(v.mf);
        EditorUtility.SetDirty(v.r);
        EditorSceneManager.MarkSceneDirty(v.r.gameObject.scene);
    }

    public static int Restore()
    {
        if (BlockedInPlayMode("Restore")) return 0;
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

        foreach (SkinnedMeshRenderer renderer in FindProbeAssignmentRenderers().OfType<SkinnedMeshRenderer>())
        {
            if (!reg.TryGet(renderer, out var entry) || entry.originalMesh == null)
                continue;

            Undo.RecordObject(renderer, "Restore Skinned Mesh");
            renderer.sharedMesh = entry.originalMesh;
            if (entry.originalMaterials != null)
                renderer.sharedMaterials = entry.originalMaterials;
            PrefabUtility.RecordPrefabInstancePropertyModifications(renderer);
            EditorUtility.SetDirty(renderer);
            EditorSceneManager.MarkSceneDirty(renderer.gameObject.scene);
            restored.Add(entry.id);
        }

        reg.RemoveWhere(e => restored.Contains(e.id));
        EditorUtility.SetDirty(reg);
        AssetDatabase.SaveAssets();
        Debug.Log($"[MeshArrays] Restore: {restored.Count} renderers restored.");
        return restored.Count;
    }

    public static bool DeleteAll()
    {
        if (BlockedInPlayMode("Delete All")) return false;
        Restore();
        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        if (reg != null && reg.entries.Count > 0 &&
            !EditorUtility.DisplayDialog("Delete All",
                $"{reg.entries.Count} registry entrie(s) could not be restored (object deleted, or its scene is not open).\n\n" +
                "Deleting now will leave those renderers with missing meshes. Continue?", "Delete", "Cancel"))
            return false;

        foreach (var ch in Channels)
        {
            AssetDatabase.DeleteAsset(ch.PathPC);
            AssetDatabase.DeleteAsset(ch.PathQuest);
            AssetDatabase.DeleteAsset(ch.NamesPath);
            BakeUtil.SetManagerField(ch.MgrField + "PC", null);
            BakeUtil.SetManagerField(ch.MgrField + "Quest", null);
        }
        BakeUtil.SetManagerField("materialTable", null);
        AssetDatabase.DeleteAsset(TablePath);
        AssetDatabase.DeleteAsset(RegistryPath);
        foreach (var f in new[] { BakePaths.Meshes, BakePaths.Materials })
            if (AssetDatabase.IsValidFolder(f.TrimEnd('/'))) AssetDatabase.DeleteAsset(f.TrimEnd('/'));

        AssetDatabase.Refresh();
        PushGlobals();
        Debug.Log("[MeshArrays] Delete All done.");
        return true;
    }

    // ───────────────────────── Resolve / Scan ─────────────────────────

    private static IEnumerable<MeshRenderer> FindRenderers() =>
        Object.FindObjectsOfType<MeshRenderer>(true)
              .Where(r => r != null && r.gameObject.scene.IsValid() && !EditorUtility.IsPersistent(r));

    private static IEnumerable<Renderer> FindProbeAssignmentRenderers() =>
        Object.FindObjectsOfType<Renderer>(true)
              .Where(r => r != null && r.gameObject.scene.IsValid() && !EditorUtility.IsPersistent(r))
              .Where(r => r is MeshRenderer || r is SkinnedMeshRenderer);

    private static bool IsProbeAssignmentEligible(Renderer renderer, BakedMeshRegistry reg)
    {
        if (renderer is MeshRenderer meshRenderer)
            return Resolve(meshRenderer, reg, -1).reason == null;

        if (!(renderer is SkinnedMeshRenderer skinnedRenderer) || skinnedRenderer.sharedMesh == null)
            return false;

        Material[] materials = skinnedRenderer.sharedMaterials;
        if (materials == null || materials.Length == 0 ||
            materials.Length != skinnedRenderer.sharedMesh.subMeshCount)
            return false;

        foreach (Material material in materials)
            if (material == null || material.shader == null || !TargetShaders.Contains(material.shader.name))
                return false;

        return true;
    }

    private static Resolved Resolve(MeshRenderer r, BakedMeshRegistry reg, int reflectionProbeIndex)
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
            if (r.isPartOfStaticBatch)
            { v.reason = "static-batched at runtime (combined mesh)"; return v; }

            v.origMesh = v.mf.sharedMesh;
            v.origMats = r.sharedMaterials;
            if (AssetDatabase.GetAssetPath(v.origMesh).StartsWith(BakePaths.Meshes))
            { v.reason = "baked mesh without registry entry"; return v; }
        }

        int sub = v.origMesh.subMeshCount;
        if (v.origMats == null || v.origMats.Length != sub)
        { v.reason = $"material count mismatch ({v.origMats?.Length ?? 0} vs {sub})"; return v; }

        foreach (var m in v.origMats)
        {
            if (m == null || m.shader == null) { v.reason = "null material"; return v; }
            if (!TargetShaders.Contains(m.shader.name)) { v.reason = "other shader"; return v; }
            if (m.HasProperty("_IsDynamicMesh") && m.GetFloat("_IsDynamicMesh") > 0.5f) { v.reason = "dynamic mesh"; return v; }
        }
        for (int s = 0; s < sub; s++)
            if (v.origMesh.GetTopology(s) != MeshTopology.Triangles) { v.reason = "non-triangle topology"; return v; }

        v.reflectionProbeIndex = reflectionProbeIndex;

        CompleteResolve(v);
        return v;
    }

    private static void CompleteResolve(Resolved v)
    {
        string meshAsset = AssetDatabase.GetAssetPath(v.origMesh);
        string meshKey = (string.IsNullOrEmpty(meshAsset) ? v.id : meshAsset) + "|" + v.origMesh.name + "|" +
                         v.origMesh.vertexCount + "|" + string.Join(",", v.origMats.Select(MeshMatKey)) +
                         "|reflectionProbe:" + v.reflectionProbeIndex;
        v.meshPath = $"{BakePaths.Meshes}Baked_{BakeUtil.SafeFileName(v.origMesh.name)}_{BakeUtil.ShortHash(meshKey)}.asset";
        v.submeshMatPaths = new string[v.origMats.Length];
        var uniqueMatPaths = new List<string>();
        var seenMatPaths = new HashSet<string>();
        for (int i = 0; i < v.origMats.Length; i++)
        {
            string path = $"{BakePaths.Materials}{VariantName(v.origMats[i])}.mat";
            v.submeshMatPaths[i] = path;
            if (seenMatPaths.Add(path))
                uniqueMatPaths.Add(path);
        }
        v.matPaths = uniqueMatPaths.ToArray();
        v.matPath = v.matPaths[0];
    }

    public sealed class RendererReport
    {
        public MeshRenderer renderer;
        public Mesh originalMesh;
        public Material[] originalMaterials;
        public ReflectionProbe reflectionProbe;
        public int reflectionProbeIndex;
        public string reflectionProbeName;
        public bool eligible, applied;
        public string reason;
        public string sharedMaterialPath;
        public string[] sharedMaterialPaths;
    }

    public static List<RendererReport> Scan()
    {
        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        ReflectionProbePlan plan = CreateReflectionProbePlan();
        var resolved = FindRenderers()
            .Select(renderer => new
            {
                renderer,
                value = Resolve(renderer, reg, plan.GetProbeIndex(renderer))
            })
            .Where(item => item.value.mf != null && item.value.mf.sharedMesh != null)
            .ToList();

        var reports = new List<RendererReport>(resolved.Count);
        foreach (var item in resolved)
        {
            Resolved value = item.value;
            reports.Add(new RendererReport
            {
                renderer = item.renderer,
                originalMesh = value.origMesh,
                originalMaterials = value.origMats,
                reflectionProbe = value.reflectionProbeIndex >= 0
                    ? plan.Probes[value.reflectionProbeIndex]
                    : null,
                reflectionProbeIndex = value.reflectionProbeIndex,
                reflectionProbeName = value.reflectionProbeIndex >= 0
                    ? plan.Probes[value.reflectionProbeIndex].name
                    : "(no probe contains mesh surface)",
                eligible = value.reason == null,
                reason = value.reason,
                applied = reg != null && value.id != null && reg.TryGet(value.id, out _),
                sharedMaterialPath = value.matPath,
                sharedMaterialPaths = value.matPaths
            });
        }

        return reports;
    }

    public static ReflectionProbePlan CreateReflectionProbePlan()
    {
        BakedMeshRegistry reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        ReflectionProbe[] allProbes = ReflectionProbeArrayBuilder.GetAllBakedProbes();
        var rendererProbeIndices = new Dictionary<Renderer, int>();
        var usedProbeIndices = new bool[allProbes.Length];

        foreach (Renderer renderer in FindProbeAssignmentRenderers())
        {
            if (!IsProbeAssignmentEligible(renderer, reg))
                continue;

            int probeIndex = ReflectionProbeArrayBuilder.SelectNearestProbeForRenderer(
                renderer, allProbes);
            rendererProbeIndices.Add(renderer, probeIndex);
            if (probeIndex >= 0 && probeIndex < usedProbeIndices.Length)
                usedProbeIndices[probeIndex] = true;
        }

        var probeIndexRemap = new int[allProbes.Length];
        var probes = new List<ReflectionProbe>();
        for (int i = 0; i < allProbes.Length; i++)
        {
            probeIndexRemap[i] = -1;
            if (!usedProbeIndices[i]) continue;
            probeIndexRemap[i] = probes.Count;
            probes.Add(allProbes[i]);
        }

        var compactAssignments = new Dictionary<Renderer, int>(rendererProbeIndices.Count);
        foreach (var assignment in rendererProbeIndices)
        {
            int sourceIndex = assignment.Value;
            compactAssignments.Add(assignment.Key,
                sourceIndex >= 0 && sourceIndex < probeIndexRemap.Length
                    ? probeIndexRemap[sourceIndex]
                    : -1);
        }

        return new ReflectionProbePlan(probes.ToArray(), compactAssignments);
    }

    public static bool[] GetUsedReflectionProbeIndices(ReflectionProbe[] probes)
    {
        var used = new bool[probes != null ? probes.Length : 0];
        if (used.Length == 0) return used;

        var reg = AssetDatabase.LoadAssetAtPath<BakedMeshRegistry>(RegistryPath);
        foreach (Renderer renderer in FindProbeAssignmentRenderers())
        {
            if (!IsProbeAssignmentEligible(renderer, reg)) continue;
            int probeIndex = ReflectionProbeArrayBuilder.SelectNearestProbeForRenderer(
                renderer, probes);
            if (probeIndex >= 0 && probeIndex < used.Length)
                used[probeIndex] = true;
        }

        return used;
    }

    // ───────────────────────── Status / Preview API ─────────────────────────

    public static bool IsBaked => AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath) != null;

    public static string Status()
    {
        if (!IsBaked) return "Not baked";
        var sb = new StringBuilder();
        long bytes = 0;
        foreach (var ch in Channels)
        {
            var a = AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC);
            sb.Append($"{ch.Name[0]}:{(a != null ? a.depth : 0)} ");
            bytes += BakeUtil.SizeOnDiskBytes(ch.PathPC);
        }
        var t = AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath);
        sb.Append($"· {t.width} materials · {bytes / (1024f * 1024f):F1} MB");
        return sb.ToString();
    }

    public static (int count, bool warn) SliceInfo()
    {
        int max = 0;
        foreach (var ch in Channels)
        {
            var a = AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC);
            if (a != null) max = Mathf.Max(max, a.depth);
        }
        return (max, max > SliceWarn);
    }

    public static string[] ChannelNames => Channels.Select(c => c.Name).ToArray();
    public static Texture2DArray LoadArray(int channel) => AssetDatabase.LoadAssetAtPath<Texture2DArray>(Channels[channel].PathPC);
    public static bool IsSrgbChannel(int channel) => Channels[channel].Srgb;
    public static bool IsNormalChannel(int channel) => Channels[channel].IsNormal;
    public static Texture2D LoadTable() => AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath);

    public static string[] LoadSliceNames(int channel)
    {
        var full = Path.GetFullPath(Channels[channel].NamesPath);
        if (!File.Exists(full)) return new string[0];
        return File.ReadAllLines(full)
                   .Select(l => { int i = l.IndexOf('\t'); return i >= 0 ? l.Substring(i + 1) : l; })
                   .ToArray();
    }

    // ───────────────────────── Editor globals ─────────────────────────

    [InitializeOnLoadMethod]
    private static void Init()
    {
        EditorApplication.delayCall += PushGlobals;
        EditorSceneManager.sceneOpened += (s, m) => PushGlobals();
    }

    public static void PushGlobals()
    {
        foreach (var ch in Channels)
            Shader.SetGlobalTexture(ch.GlobalName, AssetDatabase.LoadAssetAtPath<Texture2DArray>(ch.PathPC));
        var table = AssetDatabase.LoadAssetAtPath<Texture2D>(TablePath);
        Shader.SetGlobalTexture("_UdonMaterialTable", table);
        if (table != null)
            Shader.SetGlobalVector("_UdonMaterialTable_TexelSize",
                new Vector4(1f / table.width, 1f / table.height, table.width, table.height));
    }

    // ───────────────────────── Helpers ─────────────────────────

    private static bool BlockedInPlayMode(string action)
    {
        if (!EditorApplication.isPlayingOrWillChangePlaymode) return false;
        Debug.LogWarning($"[MeshArrays] {action} is disabled in Play Mode (scene instances are temporary).");
        return true;
    }

    private static BakedMeshRegistry LoadOrCreateRegistry()
    {
        BakePaths.EnsureAll();
        return BakeUtil.LoadOrCreate<BakedMeshRegistry>(RegistryPath);
    }

    private static void ReportSkipped(List<Resolved> all)
    {
        var skipped = all.Where(x => x.reason != null && x.reason != "no mesh").ToList();
        if (skipped.Count == 0) return;
        Debug.Log("[MeshArrays] Skipped renderers → " + string.Join(", ",
            skipped.GroupBy(x => x.reason).Select(g => $"{g.Key}: {g.Count()}")));
    }

    private static void Progress(string msg, float p) => EditorUtility.DisplayProgressBar("Mesh Arrays", msg, p);
}