#if UNITY_EDITOR && UDONSHARP

using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Linq;

public static class LayeredLightingAssigner
{
    private const string LIGHTMAP_SEARCH_FOLDER = "Assets";
    private const string RNM_X_SUFFIX = "_RNMX";
    private const string RNM_Y_SUFFIX = "_RNMY";
    private const string RNM_Z_SUFFIX = "_RNMZ";
    private const string DENOISED_INFIX = "_denoised";
    private const string MATERIAL_GROUP_DELIMITER = " - ";

    private const string OUTPUT_FOLDER = "Assets/Lightmaps/";
    private const string OUTPUT_NAME = "LightmapLayerArray";

    private const TextureFormat ARRAY_FORMAT = TextureFormat.BC6H;
    private const bool LINEAR = true;
    private static readonly bool MIPMAPS = true;
    private const int QUALITY = 100;
    private const TextureWrapMode WRAP = TextureWrapMode.Clamp;
    private const FilterMode FILTER = FilterMode.Trilinear;
    private const int ANISO = 1;

    private const int MAX_GROUPS = 20;

    private const string REQUIRED_PREFIX = "GI";

    private static Material _blitCopyMat;

    private static readonly List<TextureFormat> UncompressedFormats = new List<TextureFormat>
    {
        TextureFormat.RGBAFloat, TextureFormat.RGBAHalf, TextureFormat.ARGB32,
        TextureFormat.RGBA32, TextureFormat.RGB24, TextureFormat.Alpha8
    };

    private struct RNMSet
    {
        public Texture2D X, Y, Z;
        public bool IsValid => X != null || Y != null || Z != null;
    }

    // ─────────────────────────────────────────────────────────────────────────
    [MenuItem("Meenphie/Layered Lighting/Build Array")]
    public static void AutoAssignLightLayers()
    {
        try
        {
            EditorUtility.DisplayProgressBar("Layered Lighting", "Initialising…", 0.0f);

            LayeredLightingManager mgr = UnityEngine.Object.FindObjectOfType<LayeredLightingManager>();
            if (mgr == null) { Debug.LogError("[Layered Lighting] No LayeredLightingManager found."); return; }

            LayeredLightingEditor.RebuildLightData();

            if (mgr.childLights == null || mgr.childLights.Length == 0)
            { Debug.LogError("[Layered Lighting] LayeredLightingManager has no childLights."); return; }

            var report = new System.Text.StringBuilder();

            // ── 1. Scan material groups ──────────────────────────────────────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Scanning material groups…", 0.05f);
            var groupMaterials = CollectSpecularMaterialGroups();
            if (groupMaterials.Count == 0) { Debug.LogError("[Layered Lighting] No materials found with pattern X - Group - Y."); return; }

            var groupNames = groupMaterials.Keys.OrderBy(g => g, StringComparer.OrdinalIgnoreCase).ToList();
            if (groupNames.Count > MAX_GROUPS) { Debug.LogError("[Layered Lighting] Too many groups (" + groupNames.Count + "), max " + MAX_GROUPS); return; }

            report.AppendLine("=== " + groupNames.Count + " groups: " + string.Join(", ", groupNames) + " ===");

            // ── 2. Collect project textures ──────────────────────────────────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Collecting project textures…", 0.10f);
            Dictionary<string, string> texturesByName = CollectProjectTextures();
            report.AppendLine(texturesByName.Count + " textures found under Assets.");

            int originalLightCount = mgr.childLights.Length;

            // Snapshot current light settings (only fields that exist in the manager)
            var lightData = new (
                Light light, Vector3 bakedColor, Vector2 halfExtents,
                bool isRealtime, bool diffuse, bool specular,
                float specularMaxDist, float diffuseMaxDist,
                LightFaultState faultState,
                AudioClip audioOverride
            )[originalLightCount];

            for (int i = 0; i < originalLightCount; i++)
            {
                Light l = mgr.childLights[i];
                if (l == null) continue;

                lightData[i] = (
                    l,
                    SafeVec(mgr.childLightBakedColors, i, new Vector3(l.color.r, l.color.g, l.color.b)),
                    SafeVec(mgr.childLightHalfExtents, i, new Vector2(0.01f, 0.01f)),
                    SafeBool(mgr.childLightIsRealtime, i, false),
                    SafeBool(mgr.childLightDiffuseEnabled, i, true),
                    SafeBool(mgr.childLightSpecularDistance, i, true),
                    SafeFloat(mgr.childLightSpecularMaxDistance, i, 30f),
                    SafeFloat(mgr.childLightDiffuseMaxDistance, i, 60f),
                    SafeFaultState(mgr.childLightFaultState, i, LightFaultState.Normal),
                    SafeClip(mgr.childLightAudioClipOverride, i)
                );
            }

            // ── 3. Collect RNM textures per group (for mask generation) ──────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Resolving texture dimensions…", 0.12f);

            var groupRNMTextures = new Dictionary<string, List<Texture2D>>(StringComparer.OrdinalIgnoreCase);
            foreach (string group in groupNames)
                groupRNMTextures[group] = new List<Texture2D>();

            Texture2D dimRef = null;
            for (int li = 0; li < originalLightCount; li++)
            {
                var d = lightData[li];
                if (d.light == null) continue;
                foreach (string group in groupNames)
                {
                    RNMSet rnm = FindRNMSet(group, d.light.name, texturesByName);
                    if (!rnm.IsValid) continue;
                    if (rnm.X != null) { groupRNMTextures[group].Add(rnm.X); if (dimRef == null) dimRef = rnm.X; }
                    if (rnm.Y != null) { groupRNMTextures[group].Add(rnm.Y); if (dimRef == null) dimRef = rnm.Y; }
                    if (rnm.Z != null) { groupRNMTextures[group].Add(rnm.Z); if (dimRef == null) dimRef = rnm.Z; }
                }
            }

            int sizeX = dimRef != null ? dimRef.width : 1024;
            int sizeY = dimRef != null ? dimRef.height : 1024;
            report.AppendLine("  [dim]  " + sizeX + "x" + sizeY +
                              " (from " + (dimRef != null ? dimRef.name : "fallback") + ")");

            // ── 4. Generate one mask per group ───────────────────────────────
            var maskTextures = new List<Texture2D>();
            for (int gi = 0; gi < groupNames.Count; gi++)
            {
                string group = groupNames[gi];
                float prog = Mathf.Lerp(0.14f, 0.34f, (float)gi / Mathf.Max(groupNames.Count - 1, 1));
                EditorUtility.DisplayProgressBar("Layered Lighting",
                    "Generating mask for '" + group + "' (" + (gi + 1) + "/" + groupNames.Count + ")…", prog);

                List<Texture2D> rnmList = groupRNMTextures[group];
                if (rnmList.Count == 0)
                {
                    Debug.LogWarning("[Layered Lighting] No RNM textures found for group '" + group +
                                     "' — inserting black mask at slice " + gi);
                    Texture2D black = CreateBlackPlaceholder(sizeX, sizeY);
                    black.hideFlags = HideFlags.DontSave;
                    maskTextures.Add(black);
                    report.AppendLine("  [mask] Group='" + group + "' -> slice " + gi + " (BLACK — no textures)");
                    continue;
                }

                Texture2D maskTex = BuildMaskTexture(rnmList, sizeX, sizeY, gi, groupNames.Count, report);
                if (maskTex == null)
                {
                    Debug.LogError("[Layered Lighting] Mask generation failed for group '" + group + "'.\n" + report);
                    return;
                }
                maskTex.hideFlags = HideFlags.DontSave;
                maskTextures.Add(maskTex);
                report.AppendLine("  [mask] Group='" + group + "' -> slice " + gi);
            }

            // ── 5. Match lights to groups, assign slice indices ──────────────
            var newChildLights = new List<Light>();
            var newSlice = new List<int>();
            var newGroupMask = new List<int>();
            var newBakedCol = new List<Vector3>();
            var newHalfExt = new List<Vector2>();
            var newIsRt = new List<bool>();
            var newDiff = new List<bool>();
            var newSpec = new List<bool>();
            var newSpecMax = new List<float>();
            var newDiffMax = new List<float>();
            var newFault = new List<LightFaultState>();
            var newAudioOverride = new List<AudioClip>();
            var orderedTextures = new List<Texture2D>();
            int matchCount = 0;

            for (int li = 0; li < originalLightCount; li++)
            {
                float p = Mathf.Lerp(0.35f, 0.50f, (float)li / Mathf.Max(originalLightCount - 1, 1));
                EditorUtility.DisplayProgressBar("Layered Lighting",
                    "Matching lights… (" + (li + 1) + " / " + originalLightCount + ")", p);

                var d = lightData[li];
                if (d.light == null) continue;
                string lightName = d.light.name;
                bool hasAnyGroup = false;

                foreach (string group in groupNames)
                {
                    RNMSet rnm = FindRNMSet(group, lightName, texturesByName);
                    if (!rnm.IsValid) continue;

                    int sliceSlot = orderedTextures.Count / 3;
                    int bit = 1 << groupNames.IndexOf(group);

                    newChildLights.Add(d.light);
                    newSlice.Add(sliceSlot);
                    newGroupMask.Add(bit);
                    newBakedCol.Add(d.bakedColor);
                    newHalfExt.Add(d.halfExtents);
                    newIsRt.Add(d.isRealtime);
                    newDiff.Add(d.diffuse);
                    newSpec.Add(d.specular);
                    newSpecMax.Add(d.specularMaxDist);
                    newDiffMax.Add(d.diffuseMaxDist);
                    newFault.Add(d.faultState);
                    newAudioOverride.Add(d.audioOverride);

                    orderedTextures.Add(rnm.X);
                    orderedTextures.Add(rnm.Y);
                    orderedTextures.Add(rnm.Z);

                    hasAnyGroup = true;
                    matchCount++;
                    report.AppendLine("  [ok]   " + lightName + "  group=" + group +
                                      "  sliceSlot=" + sliceSlot +
                                      "  arraySlice=" + (sliceSlot * 3 + groupNames.Count) +
                                      "  bit=" + bit);
                }

                if (!hasAnyGroup)
                {
                    newChildLights.Add(d.light);
                    newSlice.Add(-1);
                    newGroupMask.Add(~0);
                    newBakedCol.Add(d.bakedColor);
                    newHalfExt.Add(d.halfExtents);
                    newIsRt.Add(d.isRealtime);
                    newDiff.Add(d.diffuse);
                    newSpec.Add(d.specular);
                    newSpecMax.Add(d.specularMaxDist);
                    newDiffMax.Add(d.diffuseMaxDist);
                    newFault.Add(d.faultState);
                    newAudioOverride.Add(d.audioOverride);
                    report.AppendLine("  [skip] " + lightName + " -> no group textures");
                }
            }

            // ── 6. User confirmation ─────────────────────────────────────────
            EditorUtility.ClearProgressBar();

            int totalSlices = maskTextures.Count + orderedTextures.Count;
            bool applySlices = EditorUtility.DisplayDialog(
                "Layered Lightmap Lighting",
                groupNames.Count + " zone(s): " + string.Join(", ", groupNames) + "\n" +
                groupNames.Count + " mask slice(s) + " + matchCount + " lights × 3 = " +
                totalSlices + " total slices.\n\nApply?",
                "Fuck Yeah",
                "Nah Later"
            );
            if (!applySlices)
            {
                Debug.Log("[Layered Lighting] Cancelled.\n" + report);
                return;
            }

            // ── 7. Build texture array ───────────────────────────────────────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Preparing texture array…", 0.52f);

            var finalTextureList = new List<Texture2D>();
            finalTextureList.AddRange(maskTextures);
            finalTextureList.AddRange(orderedTextures);

            report.AppendLine("Array layout: " + maskTextures.Count + " mask(s) + " +
                              orderedTextures.Count + " RNM textures = " +
                              finalTextureList.Count + " total slices.");

            Texture2DArray builtArray = BuildArray(finalTextureList, sizeX, sizeY, report);

            foreach (var tex in orderedTextures)
                if (tex != null && tex.name.StartsWith("BlackPlaceholder"))
                    UnityEngine.Object.DestroyImmediate(tex);

            foreach (var tex in maskTextures)
                if (tex != null)
                    UnityEngine.Object.DestroyImmediate(tex);

            if (builtArray == null)
            {
                Debug.LogError("[Layered Lighting] Texture array build failed.\n" + report);
                return;
            }

            // ── 8. Save array asset to disk ──────────────────────────────────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Saving array to disk…", 0.97f);
            EnsureFolder(OUTPUT_FOLDER);
            string assetPath = OUTPUT_FOLDER + OUTPUT_NAME + ".asset";

            Texture2DArray existingAsset = AssetDatabase.LoadAssetAtPath<Texture2DArray>(assetPath);
            if (existingAsset != null)
            {
                EditorUtility.CopySerialized(builtArray, existingAsset);
                UnityEngine.Object.DestroyImmediate(builtArray);
                builtArray = existingAsset;
            }
            else
            {
                AssetDatabase.CreateAsset(builtArray, assetPath);
            }
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            report.AppendLine("  [save] " + assetPath);

            // ── 9. Assign to manager ─────────────────────────────────────────
            Undo.RecordObject(mgr, "Layered Lighting Build Array");

            mgr.lightLayerArray = builtArray;
            mgr.lightmapGroupCount = groupNames.Count;
            mgr.childLights = newChildLights.ToArray();
            mgr.childLightLayerSlices = newSlice.ToArray();
            mgr.childLightGroupIndex = newGroupMask.ToArray();
            mgr.childLightBakedColors = newBakedCol.ToArray();
            mgr.childLightHalfExtents = newHalfExt.ToArray();
            mgr.childLightIsRealtime = newIsRt.ToArray();
            mgr.childLightDiffuseEnabled = newDiff.ToArray();
            mgr.childLightSpecularDistance = newSpec.ToArray();
            mgr.childLightSpecularMaxDistance = newSpecMax.ToArray();
            mgr.childLightDiffuseMaxDistance = newDiffMax.ToArray();
            mgr.childLightFaultState = newFault.ToArray();
            mgr.childLightAudioClipOverride = newAudioOverride.ToArray();

            EditorUtility.SetDirty(mgr);

            // ── 10. Assign material properties ───────────────────────────────
            for (int gi = 0; gi < groupNames.Count; gi++)
            {
                string group = groupNames[gi];
                float matMask = (float)(1 << gi);

                foreach (Material mat in groupMaterials[group])
                {
                    if (mat.HasProperty("_IsDynamicMesh") && mat.GetFloat("_IsDynamicMesh") > 0.5f)
                    {
                        report.AppendLine("  [skip] " + mat.name + " -> dynamic mesh, no mask assigned");
                        continue;
                    }

                    mat.SetFloat("_LightGroupMask", matMask);
                    EditorUtility.SetDirty(mat);
                    report.AppendLine("  [mat]  " + mat.name +
                                      " -> _LightGroupMask=" + matMask);
                }
            }

            Debug.Log("[Layered Lighting] Done. " + matchCount + " light slots, " +
                      groupNames.Count + " groups, " + totalSlices + " total slices. " +
                      "Array: " + builtArray.width + "x" + builtArray.height +
                      ", depth=" + builtArray.depth +
                      ". Saved to: " + assetPath + "\n" + report);
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }

    // ── Per-group mask generation ─────────────────────────────────────────────
    private static Texture2D BuildMaskTexture(List<Texture2D> rnmTextures,
        int sizeX, int sizeY, int groupIndex, int totalGroups,
        System.Text.StringBuilder report)
    {
        if (rnmTextures == null || rnmTextures.Count == 0) return null;

        if (sizeX % 4 != 0 || sizeY % 4 != 0)
            Debug.LogWarning("[Layered Lighting] Mask size " + sizeX + "x" + sizeY +
                             " not multiple of 4 — BC6H may be padded.");

        EnsureBlitMat();
        if (_blitCopyMat == null) return null;

        var mask = new Texture2D(sizeX, sizeY, TextureFormat.RGBAHalf, false, true)
        {
            name = "LightmapMask_Generated",
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Bilinear
        };

        float[] accum = new float[sizeX * sizeY];

        RenderTexture cache = RenderTexture.active;
        var rt = new RenderTexture(sizeX, sizeY, 0,
            RenderTextureFormat.ARGBFloat, RenderTextureReadWrite.Linear);
        rt.Create();

        for (int i = 0; i < rnmTextures.Count; i++)
        {
            Texture2D src = rnmTextures[i];
            if (src == null) continue;

            float globalMin = (float)groupIndex / Mathf.Max(totalGroups, 1);
            float globalMax = (float)(groupIndex + 1) / Mathf.Max(totalGroups, 1);
            float p = Mathf.Lerp(globalMin, globalMax,
                (float)i / Mathf.Max(rnmTextures.Count - 1, 1));
            EditorUtility.DisplayProgressBar("Layered Lighting",
                "Generating mask… " + (i + 1) + "/" + rnmTextures.Count +
                " (" + src.name + ")", p);

            RenderTexture.active = rt;
            bool cachedSrgb = GL.sRGBWrite;
            GL.sRGBWrite = false;
            _blitCopyMat.SetFloat("_ColorConversion", 0);
            Graphics.Blit(src, rt, _blitCopyMat);
            GL.sRGBWrite = cachedSrgb;

            var temp = new Texture2D(sizeX, sizeY, TextureFormat.RGBAFloat, false, true);
            temp.ReadPixels(new Rect(0, 0, sizeX, sizeY), 0, 0, false);
            RenderTexture.active = null;

            Color[] pixels = temp.GetPixels();
            for (int pIdx = 0; pIdx < pixels.Length; pIdx++)
            {
                Color c = pixels[pIdx];
                accum[pIdx] += Mathf.Abs(c.r * 0.299f + c.g * 0.587f + c.b * 0.114f);
            }
            UnityEngine.Object.DestroyImmediate(temp);
        }

        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);
        RenderTexture.active = cache;

        Color[] maskPixels = new Color[sizeX * sizeY];
        for (int i = 0; i < accum.Length; i++)
        {
            float v = accum[i];
            maskPixels[i] = new Color(v, v, v, 1f);
        }
        mask.SetPixels(maskPixels);
        mask.Apply(false);

        EditorUtility.DisplayProgressBar("Layered Lighting",
            "Compressing mask to BC6H…", 0.0f);
        EditorUtility.CompressTexture(mask, TextureFormat.BC6H, 100);
        mask.Apply(false);

        report.AppendLine("  [mask] BC6H " + sizeX + "x" + sizeY +
                          " from " + rnmTextures.Count + " RNM textures.");
        return mask;
    }

    // ── Texture2DArray construction ───────────────────────────────────────────
    private static Texture2DArray BuildArray(List<Texture2D> textures,
        int sizeX, int sizeY, System.Text.StringBuilder report)
    {
        if (textures.Count == 0) return null;

        EnsureBlitMat();
        if (_blitCopyMat == null) return null;

        bool isCompressed = !UncompressedFormats.Contains(ARRAY_FORMAT);
        var textureArray = new Texture2DArray(sizeX, sizeY, textures.Count,
            ARRAY_FORMAT, MIPMAPS, LINEAR)
        {
            wrapMode = WRAP,
            filterMode = FILTER,
            anisoLevel = ANISO
        };
        textureArray.Apply(false);

        RenderTexture cache = RenderTexture.active;
        var rt = new RenderTexture(sizeX, sizeY, 0, RenderTextureFormat.ARGBFloat,
            LINEAR ? RenderTextureReadWrite.Linear : RenderTextureReadWrite.sRGB);
        rt.Create();

        for (int i = 0; i < textures.Count; i++)
        {
            float p = Mathf.Lerp(0.52f, 0.96f, (float)i / Mathf.Max(textures.Count - 1, 1));
            EditorUtility.DisplayProgressBar("Layered Lighting",
                "Building array… slice " + (i + 1) + " / " + textures.Count, p);

            Texture2D src = textures[i];
            if (src == null)
                src = CreateBlackPlaceholder(sizeX, sizeY);

            if (src.width != sizeX || src.height != sizeY)
                report.AppendLine("  (note) " + src.name + " resized to " + sizeX + "x" + sizeY);

            RenderTexture.active = rt;
            bool cachedSrgb = GL.sRGBWrite;
            GL.sRGBWrite = !LINEAR;
            _blitCopyMat.SetFloat("_ColorConversion", LINEAR ? 0 : 1);
            Graphics.Blit(src, rt, _blitCopyMat);
            GL.sRGBWrite = cachedSrgb;

            TextureFormat readFmt = isCompressed ? TextureFormat.RGBAFloat : ARRAY_FORMAT;
            var t2d = new Texture2D(sizeX, sizeY, readFmt, MIPMAPS, LINEAR);
            t2d.ReadPixels(new Rect(0, 0, sizeX, sizeY), 0, 0, MIPMAPS);
            RenderTexture.active = null;

            if (isCompressed)
                EditorUtility.CompressTexture(t2d, ARRAY_FORMAT, QUALITY);
            t2d.Apply(false);

            int numLevels = MIPMAPS
                ? 1 + (int)Mathf.Floor(Mathf.Log(Mathf.Max(sizeX, sizeY), 2))
                : 1;
            for (int mip = 0; mip < numLevels; mip++)
                CopyToArray(t2d, textureArray, i, mip, isCompressed);

            UnityEngine.Object.DestroyImmediate(t2d);
        }

        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);
        RenderTexture.active = cache;
        textureArray.Apply(false, false);
        return textureArray;
    }

    private static void CopyToArray(Texture2D from, Texture2DArray to,
        int arrayIndex, int mipLevel, bool compressed)
    {
        if (compressed)
            Graphics.CopyTexture(from, 0, mipLevel, to, arrayIndex, mipLevel);
        else
            to.SetPixels(from.GetPixels(mipLevel), arrayIndex, mipLevel);
    }

    // ── Material group collection ─────────────────────────────────────────────
    private static Dictionary<string, List<Material>> CollectSpecularMaterialGroups()
    {
        var result = new Dictionary<string, List<Material>>(StringComparer.OrdinalIgnoreCase);
        var unparsed = new List<string>();
        Material[] allMats = Resources.FindObjectsOfTypeAll<Material>();

        foreach (Material mat in allMats)
        {
            string path = AssetDatabase.GetAssetPath(mat);
            if (string.IsNullOrEmpty(path)) continue;

            if (mat.HasProperty("_IsDynamicMesh") && mat.GetFloat("_IsDynamicMesh") > 0.5f)
                continue;

            string group = ExtractGroupFromMaterialName(mat.name);
            if (string.IsNullOrEmpty(group))
            {
                if (mat.name.Contains(MATERIAL_GROUP_DELIMITER.Trim()))
                    unparsed.Add(mat.name);
                continue;
            }

            if (!result.ContainsKey(group)) result[group] = new List<Material>();
            result[group].Add(mat);
        }

        if (unparsed.Count > 0)
            Debug.LogWarning("[Layered Lighting] " + unparsed.Count +
                             " unparsed material(s): " + string.Join(", ", unparsed));
        return result;
    }

    private static string ExtractGroupFromMaterialName(string materialName)
    {
        string[] parts = materialName.Split(
            new[] { MATERIAL_GROUP_DELIMITER }, StringSplitOptions.None);

        if (parts.Length < 3) return null;

        string prefix = parts[0].Trim();
        if (!prefix.StartsWith("GI", StringComparison.OrdinalIgnoreCase))
            return null;

        return parts[1].Trim();
    }

    // ── Project texture scanning ──────────────────────────────────────────────
    private static Dictionary<string, string> CollectProjectTextures()
    {
        var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        string[] guids = AssetDatabase.FindAssets("t:Texture2D",
            new[] { LIGHTMAP_SEARCH_FOLDER });
        foreach (string guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            string name = Path.GetFileNameWithoutExtension(path);
            if (!dict.ContainsKey(name)) dict[name] = path;
        }
        return dict;
    }

    private static RNMSet FindRNMSet(string group, string lightName,
        Dictionary<string, string> texturesByName)
    {
        var rnm = new RNMSet();
        foreach (string sfx in new[] { DENOISED_INFIX, "" })
        {
            if (rnm.X == null && texturesByName.TryGetValue(
                group + "_" + lightName + RNM_X_SUFFIX + sfx, out string px))
                rnm.X = AssetDatabase.LoadAssetAtPath<Texture2D>(px);
            if (rnm.Y == null && texturesByName.TryGetValue(
                group + "_" + lightName + RNM_Y_SUFFIX + sfx, out string py))
                rnm.Y = AssetDatabase.LoadAssetAtPath<Texture2D>(py);
            if (rnm.Z == null && texturesByName.TryGetValue(
                group + "_" + lightName + RNM_Z_SUFFIX + sfx, out string pz))
                rnm.Z = AssetDatabase.LoadAssetAtPath<Texture2D>(pz);
        }
        return rnm;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private static Texture2D CreateBlackPlaceholder(int width, int height)
    {
        var tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false, true)
        { name = "BlackPlaceholder" };
        tex.SetPixels(new Color[width * height]);
        tex.Apply(false);
        return tex;
    }

    private static void EnsureFolder(string folderPath)
    {
        string trimmed = folderPath.TrimEnd('/');
        if (!AssetDatabase.IsValidFolder(trimmed))
        {
            string parent = Path.GetDirectoryName(trimmed);
            string leaf = Path.GetFileName(trimmed);
            AssetDatabase.CreateFolder(parent, leaf);
        }
    }

    private static void EnsureBlitMat()
    {
        if (_blitCopyMat != null) return;
        Shader s = Shader.Find("Hidden/ASEBlitCopy");
        if (s == null) { Debug.LogError("[Layered Lighting] Hidden/ASEBlitCopy not found."); return; }
        _blitCopyMat = new Material(s) { hideFlags = HideFlags.HideAndDontSave };
    }

    // Safe accessors
    private static Vector3 SafeVec(Vector3[] arr, int i, Vector3 def) => arr != null && i < arr.Length ? arr[i] : def;
    private static Vector2 SafeVec(Vector2[] arr, int i, Vector2 def) => arr != null && i < arr.Length ? arr[i] : def;
    private static bool SafeBool(bool[] arr, int i, bool def) => arr != null && i < arr.Length ? arr[i] : def;
    private static float SafeFloat(float[] arr, int i, float def) => arr != null && i < arr.Length ? arr[i] : def;
    private static int SafeInt(int[] arr, int i, int def) => arr != null && i < arr.Length ? arr[i] : def;
    private static AudioClip SafeClip(AudioClip[] arr, int i) => arr != null && i < arr.Length ? arr[i] : null;
    private static LightFaultState SafeFaultState(LightFaultState[] arr, int i, LightFaultState def) => arr != null && i < arr.Length ? arr[i] : def;
}

#endif