using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Linq;
using Meenphie.Commons;

public static class ArrayBuilder
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

            LightingManager mgr = UnityEngine.Object.FindObjectOfType<LightingManager>();
            if (mgr == null) { Debug.LogError("[Layered Lighting] No LightingManager found."); return; }

            LightingEditorScene.RebuildLightData();

            if (mgr.childLights == null || mgr.childLights.Length == 0)
            { Debug.LogError("[Layered Lighting] LightingManager has no childLights."); return; }

            var report = new System.Text.StringBuilder();

            // Scan material groups
            EditorUtility.DisplayProgressBar("Layered Lighting", "Scanning material groups…", 0.05f);
            var groupMaterials = CollectSpecularMaterialGroups();
            if (groupMaterials.Count == 0) { Debug.LogError("[Layered Lighting] No materials found with pattern X - Group - Y."); return; }

            var allGroupNames = groupMaterials.Keys.OrderBy(g => g, StringComparer.OrdinalIgnoreCase).ToList();
            report.AppendLine("=== Material groups found: " + allGroupNames.Count + " ===");

            // Collect project textures
            EditorUtility.DisplayProgressBar("Layered Lighting", "Collecting project textures…", 0.10f);
            Dictionary<string, string> texturesByName = CollectProjectTextures();
            report.AppendLine(texturesByName.Count + " textures found under Assets.");

            // Determine which groups have actual lightmap textures and count lights per group
            EditorUtility.DisplayProgressBar("Layered Lighting", "Checking lightmap availability…", 0.15f);
            var validGroups = new List<string>();
            var lightCountPerGroup = new Dictionary<string, int>();
            bool anyGroupHasTextures = false;

            foreach (string group in allGroupNames)
            {
                int lightsWithTextures = 0;
                // Check every light for any RNM texture starting with this group
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    RNMSet rnm = FindRNMSet(group, l.name, texturesByName);
                    if (rnm.IsValid) lightsWithTextures++;
                }
                if (lightsWithTextures > 0)
                {
                    validGroups.Add(group);
                    lightCountPerGroup[group] = lightsWithTextures;
                    anyGroupHasTextures = true;
                }
            }

            if (!anyGroupHasTextures)
            {
                Debug.LogError("[Layered Lighting] No lightmap textures found for any material group. Aborting.");
                return;
            }

            report.AppendLine("=== Valid groups (with lightmaps): " + validGroups.Count + " ===");

            // Show confirmation dialog BEFORE any mask generation
            EditorUtility.ClearProgressBar();
            string groupInfo = "";
            foreach (string g in validGroups)
                groupInfo += $"\n• {g} ({lightCountPerGroup[g]} lights)";

            int totalLights = lightCountPerGroup.Values.Sum();
            string message = validGroups.Count + " zone(s) with lightmaps:" + groupInfo +
                             "\n\n" + totalLights + " lights total × 3 = " + (totalLights * 3) +
                             " slices, plus " + validGroups.Count + " mask slices = " +
                             (totalLights * 3 + validGroups.Count) + " total slices.\n\nBuild array?";

            if (!EditorUtility.DisplayDialog("Layered Lightmap Lighting", message, "Build", "Cancel"))
            {
                Debug.Log("[Layered Lighting] Cancelled.\n" + report);
                return;
            }

            // User agreed – now do the heavy work: generate masks, build array
            EditorUtility.DisplayProgressBar("Layered Lighting", "Preparing data…", 0.20f);

            // Snapshot current light settings (unchanged from original)
            int originalLightCount = mgr.childLights.Length;
            var lightData = new (
                Light light, Vector3 bakedColor, Vector2 halfExtents,
                bool isRealtime, bool diffuse, bool specular,
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
                    SafeFaultState(mgr.childLightFaultState, i, LightFaultState.Normal),
                    SafeClip(mgr.childLightAudioClipOverride, i)
                );
            }

            // Resolve texture dimensions (need one valid texture for size)
            Texture2D dimRef = null;
            foreach (string group in validGroups)
            {
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    RNMSet rnm = FindRNMSet(group, l.name, texturesByName);
                    if (rnm.IsValid)
                    {
                        if (rnm.X != null) { dimRef = rnm.X; break; }
                        if (rnm.Y != null) { dimRef = rnm.Y; break; }
                        if (rnm.Z != null) { dimRef = rnm.Z; break; }
                    }
                }
                if (dimRef != null) break;
            }
            int sizeX = dimRef != null ? dimRef.width : 1024;
            int sizeY = dimRef != null ? dimRef.height : 1024;

            // Generate masks per group
            var maskTextures = new List<Texture2D>();
            for (int gi = 0; gi < validGroups.Count; gi++)
            {
                string group = validGroups[gi];
                float prog = Mathf.Lerp(0.25f, 0.50f, (float)gi / Mathf.Max(validGroups.Count - 1, 1));
                EditorUtility.DisplayProgressBar("Layered Lighting",
                    "Generating mask for '" + group + "' (" + (gi + 1) + "/" + validGroups.Count + ")…", prog);

                List<Texture2D> rnmList = new List<Texture2D>();
                // Collect all RNM textures for lights in this group
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    RNMSet rnm = FindRNMSet(group, l.name, texturesByName);
                    if (rnm.IsValid)
                    {
                        if (rnm.X != null) rnmList.Add(rnm.X);
                        if (rnm.Y != null) rnmList.Add(rnm.Y);
                        if (rnm.Z != null) rnmList.Add(rnm.Z);
                    }
                }

                Texture2D maskTex = BuildMaskTexture(rnmList, sizeX, sizeY, gi, validGroups.Count, report);
                if (maskTex == null)
                {
                    Debug.LogError("[Layered Lighting] Mask generation failed for group '" + group + "'.\n" + report);
                    return;
                }
                maskTex.hideFlags = HideFlags.DontSave;
                maskTextures.Add(maskTex);
                report.AppendLine("  [mask] Group='" + group + "' -> slice " + gi);
            }

            // Match lights to groups and assign slice indices (unchanged from original)
            var newChildLights = new List<Light>();
            var newSlice = new List<int>();
            var newGroupMask = new List<int>();
            var newBakedCol = new List<Vector3>();
            var newHalfExt = new List<Vector2>();
            var newIsRt = new List<bool>();
            var newDiff = new List<bool>();
            var newSpec = new List<bool>();
            var newFault = new List<LightFaultState>();
            var newAudioOverride = new List<AudioClip>();
            var orderedTextures = new List<Texture2D>();

            for (int li = 0; li < originalLightCount; li++)
            {
                float p = Mathf.Lerp(0.55f, 0.75f, (float)li / Mathf.Max(originalLightCount - 1, 1));
                EditorUtility.DisplayProgressBar("Layered Lighting",
                    "Matching lights… (" + (li + 1) + " / " + originalLightCount + ")", p);

                var d = lightData[li];
                if (d.light == null) continue;
                string lightName = d.light.name;
                bool hasAnyGroup = false;

                foreach (string group in validGroups)
                {
                    RNMSet rnm = FindRNMSet(group, lightName, texturesByName);
                    if (!rnm.IsValid) continue;

                    int sliceSlot = orderedTextures.Count / 3;
                    int bit = 1 << validGroups.IndexOf(group);

                    newChildLights.Add(d.light);
                    newSlice.Add(sliceSlot);
                    newGroupMask.Add(bit);
                    newBakedCol.Add(d.bakedColor);
                    newHalfExt.Add(d.halfExtents);
                    newIsRt.Add(d.isRealtime);
                    newDiff.Add(d.diffuse);
                    newSpec.Add(d.specular);
                    newFault.Add(d.faultState);
                    newAudioOverride.Add(d.audioOverride);

                    orderedTextures.Add(rnm.X);
                    orderedTextures.Add(rnm.Y);
                    orderedTextures.Add(rnm.Z);

                    hasAnyGroup = true;
                    report.AppendLine("  [ok]   " + lightName + "  group=" + group +
                                      "  sliceSlot=" + sliceSlot +
                                      "  arraySlice=" + (sliceSlot * 3 + validGroups.Count) +
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
                    newFault.Add(d.faultState);
                    newAudioOverride.Add(d.audioOverride);
                    report.AppendLine("  [skip] " + lightName + " -> no group textures");
                }
            }

            // Build texture array
            EditorUtility.DisplayProgressBar("Layered Lighting", "Building texture array…", 0.80f);
            var finalTextureList = new List<Texture2D>();
            finalTextureList.AddRange(maskTextures);
            finalTextureList.AddRange(orderedTextures);

            Texture2DArray builtArray = BuildArray(finalTextureList, sizeX, sizeY, report);
            if (builtArray == null)
            {
                Debug.LogError("[Layered Lighting] Texture array build failed.\n" + report);
                return;
            }

            // Donner un nom au tableau AVANT la sauvegarde pour éviter le warning d'Unity
            builtArray.name = OUTPUT_NAME;

            // Clean up temp textures (avant sauvegarde car elles ne servent plus)
            foreach (var tex in maskTextures) if (tex != null) UnityEngine.Object.DestroyImmediate(tex);
            foreach (var tex in orderedTextures)
                if (tex != null && tex.name.StartsWith("BlackPlaceholder"))
                    UnityEngine.Object.DestroyImmediate(tex);

            // Save array and assign to manager
            EditorUtility.DisplayProgressBar("Layered Lighting", "Saving array…", 0.95f);
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

            Undo.RecordObject(mgr, "Layered Lighting Build Array");
            mgr.lightLayerArray = builtArray;
            mgr.lightmapGroupCount = validGroups.Count;
            mgr.childLights = newChildLights.ToArray();
            mgr.childLightLayerSlices = newSlice.ToArray();
            mgr.childLightGroupIndex = newGroupMask.ToArray();
            mgr.childLightBakedColors = newBakedCol.ToArray();
            mgr.childLightHalfExtents = newHalfExt.ToArray();
            mgr.childLightIsRealtime = newIsRt.ToArray();
            mgr.childLightDiffuseEnabled = newDiff.ToArray();
            mgr.childLightSpecularDistance = newSpec.ToArray();
            mgr.childLightFaultState = newFault.ToArray();
            mgr.childLightAudioClipOverride = newAudioOverride.ToArray();
            EditorUtility.SetDirty(mgr);

            // 11. Assign material group masks
            for (int gi = 0; gi < validGroups.Count; gi++)
            {
                string group = validGroups[gi];
                float matMask = (float)(1 << gi);
                if (!groupMaterials.ContainsKey(group)) continue;
                foreach (Material mat in groupMaterials[group])
                {
                    if (mat.HasProperty("_IsDynamicMesh") && mat.GetFloat("_IsDynamicMesh") > 0.5f)
                        continue;
                    mat.SetFloat("_LightGroupMask", matMask);
                    EditorUtility.SetDirty(mat);
                }
            }

            Debug.Log("[Layered Lighting] Done. " + validGroups.Count + " groups, " +
                      totalLights + " lights, " + builtArray.depth + " slices. Saved to: " + assetPath + "\n" + report);
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
        textureArray.name = OUTPUT_NAME;

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
        // Redondant mais garanti : le nom est bien positionné avant de quitter
        textureArray.name = OUTPUT_NAME;
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

            // Ignorer les matériaux internes Unity et les atlas de polices
            if (path.Contains("unity_builtin_extra")
                || mat.name.StartsWith("DroidSans")
                || mat.name.StartsWith("NotoSans")
                || mat.name.StartsWith("Inter")
                || mat.name.StartsWith("LiberationSans")
                || mat.name.StartsWith("FreeSans")
                || mat.name.StartsWith("DejavuSans")
                || mat.name == "Sprites-Default"
                || mat.name == "Default-Material"
                || mat.name == "Default-Skybox")
                continue;

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
        if (!prefix.StartsWith(REQUIRED_PREFIX, StringComparison.OrdinalIgnoreCase))
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
        // Suffixes: try denoised first, then raw
        string[] xSuffixes = { RNM_X_SUFFIX + DENOISED_INFIX, RNM_X_SUFFIX };
        string[] ySuffixes = { RNM_Y_SUFFIX + DENOISED_INFIX, RNM_Y_SUFFIX };
        string[] zSuffixes = { RNM_Z_SUFFIX + DENOISED_INFIX, RNM_Z_SUFFIX };

        foreach (string sx in xSuffixes)
        {
            rnm.X = FindTextureForGroupAndLight(group, lightName, sx, texturesByName);
            if (rnm.X != null) break;
        }
        foreach (string sy in ySuffixes)
        {
            rnm.Y = FindTextureForGroupAndLight(group, lightName, sy, texturesByName);
            if (rnm.Y != null) break;
        }
        foreach (string sz in zSuffixes)
        {
            rnm.Z = FindTextureForGroupAndLight(group, lightName, sz, texturesByName);
            if (rnm.Z != null) break;
        }
        return rnm;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private static Texture2D FindTextureForGroupAndLight(
        string group, string lightName, string suffix,
        Dictionary<string, string> texturesByName)
    {
        string searchStart = group;
        string searchEnd = suffix;
        // try the non-denoised version if denoised not found
        foreach (var kvp in texturesByName)
        {
            string texName = kvp.Key;

            if (texName.StartsWith(searchStart, StringComparison.OrdinalIgnoreCase) &&
                texName.IndexOf(lightName, StringComparison.OrdinalIgnoreCase) >= 0)
            {
                if (texName.EndsWith(suffix, StringComparison.OrdinalIgnoreCase))
                    return AssetDatabase.LoadAssetAtPath<Texture2D>(kvp.Value);
            }
        }
        return null;
    }

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
    private static int SafeInt(int[] arr, int i, int def) => arr != null && i < arr.Length ? arr[i] : def;
    private static AudioClip SafeClip(AudioClip[] arr, int i) => arr != null && i < arr.Length ? arr[i] : null;
    private static LightFaultState SafeFaultState(LightFaultState[] arr, int i, LightFaultState def) => arr != null && i < arr.Length ? arr[i] : def;
}