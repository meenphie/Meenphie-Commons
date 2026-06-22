#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

// ============================================================================
// Naming convention this script expects:
//
//   Textures:   {Group}_{LightName}_RNMX   (+ _RNMY, _RNMZ, optional _denoised)
//               e.g. "Cube A_Point.001_RNMX"
//
//   Materials:  "{ShaderType} - {Group} - {MaterialName}"
//               e.g. "GI Opaque - Cube A - Send"
//
// ============================================================================

public static class SpecularLightLayerAutoAssigner
{
    private const string LIGHTMAP_SEARCH_FOLDER = "Assets";
    private const string RNM_X_SUFFIX = "_RNMX";
    private const string RNM_Y_SUFFIX = "_RNMY";
    private const string RNM_Z_SUFFIX = "_RNMZ";
    private const string DENOISED_INFIX = "_denoised";
    private const string MATERIAL_GROUP_DELIMITER = " - ";
    private const string BASE_LIGHTMAP_NAME = "Base_Lightmap";

    private const string OUTPUT_FOLDER = "Assets/Lightmaps/";
    private const string OUTPUT_NAME = "LightmapLayerArray";

    private const TextureFormat ARRAY_FORMAT = TextureFormat.BC6H;
    private const bool LINEAR = true;
    private static readonly bool MIPMAPS = true;
    private const int QUALITY = 100;
    private const TextureWrapMode WRAP = TextureWrapMode.Clamp;
    private const FilterMode FILTER = FilterMode.Trilinear;
    private const int ANISO = 1;

    private const int MAX_GROUPS = 20;   // float32 bitmask precision cap

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

    // =========================================================================
    // MENU ENTRY
    // =========================================================================

    [MenuItem("Meenphie/Lighting/Speculars/Auto-Assign Light Layers (Build Array)")]
    public static void AutoAssignLightLayers()
    {
        try
        {
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Initialising…", 0f);

            SpecularLightManager mgr = UnityEngine.Object.FindObjectOfType<SpecularLightManager>();
            if (mgr == null)
            {
                Debug.LogError("[Specular World] No SpecularLightManager found in scene.");
                return;
            }

            SpecularLightManagerEditor.ForceRescanNow();

            if (mgr.childLights == null || mgr.childLights.Length == 0)
            {
                Debug.LogError("[Specular World] SpecularLightManager has no childLights — nothing to assign.");
                return;
            }

            var report = new System.Text.StringBuilder();

            // ---- 1. Find all materials with the group naming pattern ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Scanning material groups…", 0.03f);
            var groupMaterials = CollectSpecularMaterialGroups();
            if (groupMaterials.Count == 0)
            {
                Debug.LogError("[Specular World] No materials found with pattern " +
                              $"\"X{MATERIAL_GROUP_DELIMITER}Group{MATERIAL_GROUP_DELIMITER}Y\". Nothing to assign.");
                return;
            }

            var groupNames = groupMaterials.Keys.OrderBy(g => g, StringComparer.OrdinalIgnoreCase).ToList();
            if (groupNames.Count > MAX_GROUPS)
            {
                Debug.LogError($"[Specular World] {groupNames.Count} groups found, but bitmask packing only " +
                                $"supports up to {MAX_GROUPS}. Aborting.");
                return;
            }

            report.AppendLine($"=== {groupNames.Count} groups: {string.Join(", ", groupNames)} ===");

            // ---- 2. Collect all project textures ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Collecting project textures…", 0.08f);
            Dictionary<string, string> texturesByName = CollectProjectTextures();
            report.AppendLine($"{texturesByName.Count} textures found under \"{LIGHTMAP_SEARCH_FOLDER}\".");

            // ---- 3. Read light data from manager ----
            int originalLightCount = mgr.childLights.Length;
            var lightData = new (Light light, Transform transform, float bakedIntensity, Vector3 bakedColor,
                                Vector2 halfExtents, bool isRealtime, bool diffuse, bool specular,
                                bool animated, int styleIdx, float animSpeed)[originalLightCount];

            for (int i = 0; i < originalLightCount; i++)
            {
                Light l = mgr.childLights[i];
                if (l == null) continue;
                float bakedInt = (mgr.childLightBakedIntensities != null && i < mgr.childLightBakedIntensities.Length)
                    ? mgr.childLightBakedIntensities[i] : l.intensity;
                Vector3 bakedCol = (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                    ? mgr.childLightBakedColors[i] : new Vector3(l.color.r, l.color.g, l.color.b);
                Vector2 halfExt = (mgr.childLightHalfExtents != null && i < mgr.childLightHalfExtents.Length)
                    ? mgr.childLightHalfExtents[i] : new Vector2(0.01f, 0.01f);
                bool isRt = (mgr.childLightIsRealtime != null && i < mgr.childLightIsRealtime.Length)
                    ? mgr.childLightIsRealtime[i] : true;
                bool diff = (mgr.childLightDiffuseEnabled != null && i < mgr.childLightDiffuseEnabled.Length)
                    ? mgr.childLightDiffuseEnabled[i] : true;
                bool spec = (mgr.childLightSpecularEnabled != null && i < mgr.childLightSpecularEnabled.Length)
                    ? mgr.childLightSpecularEnabled[i] : true;
                bool anim = (mgr.childLightIsAnimated != null && i < mgr.childLightIsAnimated.Length)
                    ? mgr.childLightIsAnimated[i] : false;
                int stIdx = (mgr.childLightStyleIndex != null && i < mgr.childLightStyleIndex.Length)
                    ? mgr.childLightStyleIndex[i] : 0;
                float spd = (mgr.childLightAnimationSpeed != null && i < mgr.childLightAnimationSpeed.Length)
                    ? mgr.childLightAnimationSpeed[i] : 1.0f;

                lightData[i] = (l, l.transform, bakedInt, bakedCol, halfExt, isRt, diff, spec, anim, stIdx, spd);
            }

            // ---- 4. Match lights to groups ----
            var newChildLights  = new List<Light>();
            var newSlice        = new List<int>();
            var newGroupMask    = new List<int>();
            var newBakedInt     = new List<float>();
            var newBakedCol     = new List<Vector3>();
            var newHalfExt      = new List<Vector2>();
            var newIsRt         = new List<bool>();
            var newDiff         = new List<bool>();
            var newSpec         = new List<bool>();
            var newAnim         = new List<bool>();
            var newStyleIdx     = new List<int>();
            var newAnimSpeed    = new List<float>();

            var orderedTextures = new List<Texture2D>();
            int matchCount = 0;

            for (int li = 0; li < originalLightCount; li++)
            {
                float p = 0.12f + 0.38f * ((float)li / Mathf.Max(originalLightCount - 1, 1));
                EditorUtility.DisplayProgressBar("Specular Auto-Assign",
                    $"Matching lights to groups… ({li + 1} / {originalLightCount})", p);

                var data = lightData[li];
                if (data.light == null) continue;
                string lightName = data.light.name;

                bool hasAnyGroup = false;
                foreach (string group in groupNames)
                {
                    RNMSet rnm = FindRNMSet(group, lightName, texturesByName);
                    if (!rnm.IsValid) continue;

                    int sliceSlot = orderedTextures.Count / 3;
                    newChildLights.Add(data.light);
                    newSlice.Add(sliceSlot);
                    int bit = 1 << groupNames.IndexOf(group);
                    newGroupMask.Add(bit);
                    newBakedInt.Add(data.bakedIntensity);
                    newBakedCol.Add(data.bakedColor);
                    newHalfExt.Add(data.halfExtents);
                    newIsRt.Add(data.isRealtime);
                    newDiff.Add(data.diffuse);
                    newSpec.Add(data.specular);
                    newAnim.Add(data.animated);
                    newStyleIdx.Add(data.styleIdx);
                    newAnimSpeed.Add(data.animSpeed);

                    orderedTextures.Add(rnm.X);
                    orderedTextures.Add(rnm.Y);
                    orderedTextures.Add(rnm.Z);
                    hasAnyGroup = true;
                    matchCount++;
                    report.AppendLine($"  [ok]   {lightName}  group {group} -> slice slot {sliceSlot} (bit {bit})");
                }

                if (!hasAnyGroup)
                {
                    newChildLights.Add(data.light);
                    newSlice.Add(-1);
                    newGroupMask.Add(~0);
                    newBakedInt.Add(data.bakedIntensity);
                    newBakedCol.Add(data.bakedColor);
                    newHalfExt.Add(data.halfExtents);
                    newIsRt.Add(data.isRealtime);
                    newDiff.Add(data.diffuse);
                    newSpec.Add(data.specular);
                    newAnim.Add(data.animated);
                    newStyleIdx.Add(data.styleIdx);
                    newAnimSpeed.Add(data.animSpeed);
                    report.AppendLine($"  [skip] {lightName} -> no group textures, default global light");
                }
            }

            // ---- 5. Base texture (slice 0) ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Resolving base texture…", 0.51f);
            Texture2D baseTex = ResolveBaseTexture(texturesByName, orderedTextures, out bool basePlaceholder, report);
            if (baseTex == null)
            {
                Debug.LogError("[Specular World] Could not resolve base texture.\n" + report);
                return;
            }

            var finalTextureList = new List<Texture2D> { baseTex };
            finalTextureList.AddRange(orderedTextures);
            report.AppendLine($"Total array depth: {finalTextureList.Count} slices (1 base + {matchCount} lights × 3)");

            // ---- 6. Build array (progress 0.52 → 0.90 inside BuildArray) ----
            Texture2DArray builtArray = BuildArray(finalTextureList, report);
            if (basePlaceholder) UnityEngine.Object.DestroyImmediate(baseTex);
            foreach (var tex in orderedTextures)
                if (tex != null && tex.name.StartsWith("BlackPlaceholder"))
                    UnityEngine.Object.DestroyImmediate(tex);

            if (builtArray == null)
            {
                Debug.LogError("[Specular World] Texture array build failed.\n" + report);
                return;
            }

            // ---- 7. Save asset ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Saving texture array asset…", 0.91f);
            Texture2DArray savedArray = SaveArrayAsset(builtArray, mgr);
            mgr.lightLayerArray = savedArray;

            // ---- 8. Write back arrays ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Writing manager arrays…", 0.94f);
            mgr.childLights                = newChildLights.ToArray();
            mgr.childLightLayerSlices      = newSlice.ToArray();
            mgr.childLightGroupIndex       = newGroupMask.ToArray();
            mgr.childLightBakedIntensities = newBakedInt.ToArray();
            mgr.childLightBakedColors      = newBakedCol.ToArray();
            mgr.childLightHalfExtents      = newHalfExt.ToArray();
            mgr.childLightIsRealtime       = newIsRt.ToArray();
            mgr.childLightDiffuseEnabled   = newDiff.ToArray();
            mgr.childLightSpecularEnabled  = newSpec.ToArray();
            mgr.childLightIsAnimated       = newAnim.ToArray();
            mgr.childLightStyleIndex       = newStyleIdx.ToArray();
            mgr.childLightAnimationSpeed   = newAnimSpeed.ToArray();

            // ---- 9. Assign material group masks ----
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Assigning material group masks…", 0.97f);
            foreach (string group in groupNames)
            {
                int bit = 1 << groupNames.IndexOf(group);
                float matMask = (float)bit;
                foreach (Material mat in groupMaterials[group])
                {
                    mat.SetFloat("_LightGroupMask", matMask);
                    EditorUtility.SetDirty(mat);
                    report.AppendLine($"  [mat]  {mat.name}  ->  _LightGroupMask = {matMask}  (group: {group})");
                }
            }

            EditorUtility.SetDirty(mgr);
            AssetDatabase.SaveAssets();

            Debug.Log($"[Specular World] Created {matchCount} per‑group light slots across {groupNames.Count} groups. " +
                      $"Array: {savedArray.width}x{savedArray.height}, {savedArray.depth} slices, {ARRAY_FORMAT}.\n" + report);
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }

    // =========================================================================
    // HELPERS
    // =========================================================================

    private static Dictionary<string, List<Material>> CollectSpecularMaterialGroups()
    {
        var result   = new Dictionary<string, List<Material>>(StringComparer.OrdinalIgnoreCase);
        var unparsed = new List<string>();
        Material[] allMats = Resources.FindObjectsOfTypeAll<Material>();

        foreach (Material mat in allMats)
        {
            string path = AssetDatabase.GetAssetPath(mat);
            if (string.IsNullOrEmpty(path)) continue;

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
            Debug.LogWarning($"[Specular World] {unparsed.Count} material(s) contain \"-\" but didn't match: " +
                             string.Join(", ", unparsed));

        return result;
    }

    private static string ExtractGroupFromMaterialName(string materialName)
    {
        string[] parts = materialName.Split(new[] { MATERIAL_GROUP_DELIMITER }, StringSplitOptions.None);
        return parts.Length >= 3 ? parts[1].Trim() : null;
    }

    private static Dictionary<string, string> CollectProjectTextures()
    {
        var dict  = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        string[] guids = AssetDatabase.FindAssets("t:Texture2D", new[] { LIGHTMAP_SEARCH_FOLDER });
        foreach (string guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            string name = Path.GetFileNameWithoutExtension(path);
            if (!dict.ContainsKey(name)) dict[name] = path;
        }
        return dict;
    }

    private static RNMSet FindRNMSet(string group, string lightName, Dictionary<string, string> texturesByName)
    {
        var rnm = new RNMSet();
        foreach (string sfx in new[] { DENOISED_INFIX, "" })
        {
            if (rnm.X == null && texturesByName.TryGetValue($"{group}_{lightName}{RNM_X_SUFFIX}{sfx}", out string px))
                rnm.X = AssetDatabase.LoadAssetAtPath<Texture2D>(px);
            if (rnm.Y == null && texturesByName.TryGetValue($"{group}_{lightName}{RNM_Y_SUFFIX}{sfx}", out string py))
                rnm.Y = AssetDatabase.LoadAssetAtPath<Texture2D>(py);
            if (rnm.Z == null && texturesByName.TryGetValue($"{group}_{lightName}{RNM_Z_SUFFIX}{sfx}", out string pz))
                rnm.Z = AssetDatabase.LoadAssetAtPath<Texture2D>(pz);
        }
        return rnm;
    }

    private static Texture2D ResolveBaseTexture(Dictionary<string, string> texturesByName,
        List<Texture2D> existingTextures, out bool isPlaceholder, System.Text.StringBuilder report)
    {
        isPlaceholder = false;
        if (texturesByName.TryGetValue(BASE_LIGHTMAP_NAME, out string basePath))
        {
            var tex = AssetDatabase.LoadAssetAtPath<Texture2D>(basePath);
            if (tex != null)
            {
                report.AppendLine($"  [base] slice 0 <- {basePath}");
                return tex;
            }
        }

        foreach (var t in existingTextures)
        {
            if (t != null)
            {
                report.AppendLine($"  [base] slice 0 <- black placeholder, sized to \"{t.name}\" (no Base_Lightmap found)");
                isPlaceholder = true;
                return CreateBlackPlaceholder(t.width, t.height);
            }
        }

        report.AppendLine("  [base] slice 0 <- black placeholder 1024x1024");
        isPlaceholder = true;
        return CreateBlackPlaceholder(1024, 1024);
    }

    private static Texture2D CreateBlackPlaceholder(int width, int height)
    {
        var tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false, true) { name = "BlackPlaceholder" };
        Color[] black = new Color[width * height];
        tex.SetPixels(black);
        tex.Apply(false);
        return tex;
    }

    // Progress inside BuildArray covers the range 0.52 → 0.90
    private static Texture2DArray BuildArray(List<Texture2D> textures, System.Text.StringBuilder report)
    {
        if (textures.Count == 0) return null;

        int sizeX = textures[0].width;
        int sizeY = textures[0].height;

        if (_blitCopyMat == null)
        {
            Shader blitShader = Shader.Find("Hidden/ASEBlitCopy");
            if (blitShader == null)
            {
                Debug.LogError("[Specular World] Could not find Hidden/ASEBlitCopy.");
                return null;
            }
            _blitCopyMat = new Material(blitShader) { hideFlags = HideFlags.HideAndDontSave };
        }

        bool isCompressed = !UncompressedFormats.Contains(ARRAY_FORMAT);
        var textureArray = new Texture2DArray(sizeX, sizeY, textures.Count, ARRAY_FORMAT, MIPMAPS, LINEAR)
        {
            wrapMode   = WRAP,
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
            float p = 0.52f + 0.38f * ((float)i / Mathf.Max(textures.Count - 1, 1));
            EditorUtility.DisplayProgressBar("Specular Auto-Assign",
                $"Building texture array… slice {i + 1} / {textures.Count}", p);

            Texture2D src = textures[i];
            if (src.width != sizeX || src.height != sizeY)
                report.AppendLine($"  (note) \"{src.name}\" is {src.width}x{src.height}, resized to {sizeX}x{sizeY}");

            RenderTexture.active = rt;
            bool cachedSrgb = GL.sRGBWrite;
            GL.sRGBWrite = !LINEAR;
            _blitCopyMat.SetFloat("_ColorConversion", LINEAR ? 0 : 1);
            Graphics.Blit(src, rt, _blitCopyMat);
            GL.sRGBWrite = cachedSrgb;

            TextureFormat readFormat = isCompressed ? TextureFormat.RGBAFloat : ARRAY_FORMAT;
            var t2d = new Texture2D(sizeX, sizeY, readFormat, MIPMAPS, LINEAR);
            t2d.ReadPixels(new Rect(0, 0, sizeX, sizeY), 0, 0, MIPMAPS);
            RenderTexture.active = null;

            if (isCompressed)
                EditorUtility.CompressTexture(t2d, ARRAY_FORMAT, QUALITY);
            t2d.Apply(false);

            if (MIPMAPS)
            {
                int numLevels = 1 + (int)Mathf.Floor(Mathf.Log(Mathf.Max(sizeX, sizeY), 2));
                for (int mip = 0; mip < numLevels; mip++)
                    CopyToArray(t2d, textureArray, i, mip, isCompressed);
            }
            else
            {
                CopyToArray(t2d, textureArray, i, 0, isCompressed);
            }

            UnityEngine.Object.DestroyImmediate(t2d);
        }

        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);
        RenderTexture.active = cache;
        textureArray.Apply(false, false);
        return textureArray;
    }

    private static void CopyToArray(Texture2D from, Texture2DArray to, int arrayIndex, int mipLevel, bool compressed)
    {
        if (compressed)
            Graphics.CopyTexture(from, 0, mipLevel, to, arrayIndex, mipLevel);
        else
            to.SetPixels(from.GetPixels(mipLevel), arrayIndex, mipLevel);
    }

    private static Texture2DArray SaveArrayAsset(Texture2DArray array, SpecularLightManager mgr)
    {
        if (mgr.lightLayerArray != null)
        {
            string existingPath = AssetDatabase.GetAssetPath(mgr.lightLayerArray);
            if (!string.IsNullOrEmpty(existingPath))
            {
                EditorUtility.CopySerialized(array, mgr.lightLayerArray);
                AssetDatabase.SaveAssets();
                UnityEngine.Object.DestroyImmediate(array);
                return mgr.lightLayerArray;
            }
        }

        if (!AssetDatabase.IsValidFolder(OUTPUT_FOLDER))
        {
            Directory.CreateDirectory(OUTPUT_FOLDER);
            AssetDatabase.Refresh();
        }

        string path = AssetDatabase.GenerateUniqueAssetPath($"{OUTPUT_FOLDER}/{OUTPUT_NAME}.asset");
        AssetDatabase.CreateAsset(array, path);
        AssetDatabase.SaveAssets();
        EditorGUIUtility.PingObject(array);
        return array;
    }
}
#endif