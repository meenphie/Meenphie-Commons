#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using System;
using System.Collections.Generic;
using System.IO;

public static class SpecularLightLayerAutoAssigner
{
    // ---- Tweak these to match your project -----------------------------

    // Folder to search for baked lightmap textures. Narrow this if your
    // project has lightmap-named textures elsewhere that shouldn't be
    // picked up (e.g. other scenes' bakes).
    private const string LIGHTMAP_SEARCH_FOLDER = "Assets";

    private const string LIGHTMAP_SUFFIX = "_Lightmap";
    private const string LIGHTMAP_DENOISED_SUFFIX = "_Lightmap_denoised";

    // Exact asset name (no extension) of the global ambient/background
    // lightmap. Always becomes physical array slice 0 — update this if
    // yours is named differently (e.g. "Lightmap_Base").
    private const string BASE_LIGHTMAP_NAME = "Base_Lightmap";

    // Where a brand-new array asset gets created if the manager doesn't
    // already have one assigned. If mgr.lightLayerArray is already set,
    // that existing asset is overwritten in place instead (so material/
    // shader references to it keep working).
    private const string OUTPUT_FOLDER = "Assets/Lightmaps/";
    private const string OUTPUT_NAME = "LightmapLayerArray";

    private const TextureFormat ARRAY_FORMAT = TextureFormat.BC6H; // HDR lightmap data
    private const bool LINEAR = true;               // not sRGB
    private static readonly bool MIPMAPS = true;    // not const: keeps the compiler from flagging BuildArray's non-mip branch as unreachable
    private const int QUALITY = 100;
    private const TextureWrapMode WRAP = TextureWrapMode.Clamp;
    private const FilterMode FILTER = FilterMode.Trilinear;
    private const int ANISO = 1;

    // ----------------------------------------------------------------------

    private static Material _blitCopyMat;

    private static readonly List<TextureFormat> UncompressedFormats = new List<TextureFormat>
    {
        TextureFormat.RGBAFloat,
        TextureFormat.RGBAHalf,
        TextureFormat.ARGB32,
        TextureFormat.RGBA32,
        TextureFormat.RGB24,
        TextureFormat.Alpha8
    };

    [MenuItem("Meenphie/Lighting/Speculars/Auto-Assign Light Layers (Build Array)")]
    public static void AutoAssignLightLayers()
    {
        SpecularLightManager mgr = UnityEngine.Object.FindObjectOfType<SpecularLightManager>();
        if (mgr == null)
        {
            Debug.LogError("[Specular World] No SpecularLightManager found in scene.");
            return;
        }

        // Make sure childLights is populated before we try to match against it.
        SpecularLightManagerEditor.ForceRescanNow();

        if (mgr.childLights == null || mgr.childLights.Length == 0)
        {
            Debug.LogError("[Specular World] SpecularLightManager has no childLights — nothing to assign.");
            return;
        }

        Dictionary<string, string> texturesByName = CollectProjectTextures();

        int count = mgr.childLights.Length;

        // DEBUG: dump the texture pool before doing anything else
        Debug.Log($"[Specular World][DEBUG] {count} childLights, {texturesByName.Count} textures found under \"{LIGHTMAP_SEARCH_FOLDER}\".");

        var matchedTextures = new Texture2D[count];
        var matchedSlice = new int[count];
        for (int i = 0; i < count; i++) matchedSlice[i] = -1;

        var report = new System.Text.StringBuilder();
        int matchCount = 0;

        for (int i = 0; i < count; i++)
        {
            Light l = mgr.childLights[i];
            if (l == null) continue;

            string texPath = FindLightmapTexture(l.name, texturesByName);
            if (texPath == null)
            {
                report.AppendLine($"  [skip]  {l.name}  ->  no matching lightmap texture found");

                // DEBUG: Unity appends ".001", ".005" etc. to duplicate
                // GameObject names, but the baked texture filename usually
                // doesn't carry that suffix. Strip a trailing ".NNN" and
                // search the pool for anything containing the base name, so
                // a naming mismatch shows up directly instead of just "not
                // found".
                string baseName = System.Text.RegularExpressions.Regex.Replace(l.name, @"\.\d+$", "");
                var fuzzyMatches = new List<string>();
                foreach (var kvp in texturesByName)
                    if (kvp.Key.IndexOf(baseName, StringComparison.OrdinalIgnoreCase) >= 0)
                        fuzzyMatches.Add(kvp.Key);

                if (fuzzyMatches.Count > 0)
                    Debug.Log($"[Specular World][DEBUG] \"{l.name}\" (base \"{baseName}\") found no exact match, " +
                              $"but {fuzzyMatches.Count} pool entries contain the base name: {string.Join(", ", fuzzyMatches)}");
                else
                    Debug.Log($"[Specular World][DEBUG] \"{l.name}\" (base \"{baseName}\") — no pool entry contains the base name at all.");

                continue;
            }

            Texture2D tex = AssetDatabase.LoadAssetAtPath<Texture2D>(texPath);
            if (tex == null)
            {
                report.AppendLine($"  [skip]  {l.name}  ->  matched \"{texPath}\" but it failed to load");
                continue;
            }

            matchedTextures[i] = tex;
            matchedSlice[i] = matchCount; // childLightLayerSlices value — shader adds +1 to get the physical array slice
            report.AppendLine($"  [ok]    {l.name}  ->  childLightLayerSlices {matchCount}  (array slice {matchCount + 1}, {texPath})");
            matchCount++;
        }

        Debug.Log($"[Specular World][DEBUG] {matchCount} out of {count} lights matched a texture.\n{report}");

        if (matchCount == 0)
        {
            Debug.LogWarning("[Specular World] No lights matched a lightmap texture. Nothing was built.\n" + report);
            return;
        }

        // The shader samples per-light layers at "sliceIndex + 1", reserving
        // physical slice 0 for the global ambient/background lightmap — so
        // that texture (if present) has to go in first, ahead of every
        // per-light texture. If there's no base lightmap in this scene, slice
        // 0 is left black instead.
        bool hasBase = texturesByName.TryGetValue(BASE_LIGHTMAP_NAME, out string basePath);
        Texture2D baseTex = null;
        bool basePlaceholder = false;

        if (hasBase)
        {
            baseTex = AssetDatabase.LoadAssetAtPath<Texture2D>(basePath);
            if (baseTex == null)
            {
                Debug.LogError($"[Specular World] Found \"{basePath}\" for the base lightmap but it failed to load.");
                return;
            }
        }
        else
        {
            Texture2D firstMatched = null;
            for (int i = 0; i < count; i++)
                if (matchedTextures[i] != null) { firstMatched = matchedTextures[i]; break; }

            baseTex = CreateBlackPlaceholder(firstMatched.width, firstMatched.height);
            basePlaceholder = true;
            report.AppendLine($"  (note) no texture named \"{BASE_LIGHTMAP_NAME}\" found under {LIGHTMAP_SEARCH_FOLDER} " +
                               "— array slice 0 left black instead of erroring.");
        }

        var orderedTextures = new List<Texture2D>(matchCount + 1) { baseTex };
        for (int i = 0; i < count; i++)
            if (matchedTextures[i] != null) orderedTextures.Add(matchedTextures[i]);

        report.Insert(0, hasBase
            ? $"  [base]  (array slice 0)  <-  {basePath}\n"
            : "  [base]  (array slice 0)  <-  black placeholder (no base lightmap found)\n");

        Texture2DArray builtArray = BuildArray(orderedTextures, report);

        if (basePlaceholder) UnityEngine.Object.DestroyImmediate(baseTex);

        if (builtArray == null)
        {
            Debug.LogError("[Specular World] Texture array build failed.\n" + report);
            return;
        }

        Texture2DArray savedArray = SaveArrayAsset(builtArray, mgr);

        if (mgr.childLightLayerSlices == null || mgr.childLightLayerSlices.Length != count)
            mgr.childLightLayerSlices = new int[count];
        for (int i = 0; i < count; i++)
            mgr.childLightLayerSlices[i] = matchedSlice[i];

        mgr.lightLayerArray = savedArray;
        EditorUtility.SetDirty(mgr);
        AssetDatabase.SaveAssets();

        Debug.Log($"[Specular World] Auto-assigned {matchCount}/{count} lights (+1 base) into " +
                  $"\"{AssetDatabase.GetAssetPath(savedArray)}\" ({savedArray.width}x{savedArray.height}, " +
                  $"{savedArray.depth} slices, {ARRAY_FORMAT}).\n" + report);
    }

    // ----------------------------------------------------------------------
    // Matching
    // ----------------------------------------------------------------------

    // Generates an in-memory black texture to stand in for slice 0 when no
    // base lightmap is found. Goes through the same blit/compress pipeline
    // as everything else in BuildArray, so it's not special-cased there.
    private static Texture2D CreateBlackPlaceholder(int width, int height)
    {
        Texture2D tex = new Texture2D(width, height, TextureFormat.RGBAFloat, false, true) { name = "BlackPlaceholder_Slice0" };
        Color[] black = new Color[width * height];
        for (int i = 0; i < black.Length; i++) black[i] = Color.black;
        tex.SetPixels(black);
        tex.Apply(false);
        return tex;
    }

    private static Dictionary<string, string> CollectProjectTextures()
    {
        var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        string[] guids = AssetDatabase.FindAssets("t:Texture2D", new[] { LIGHTMAP_SEARCH_FOLDER });
        foreach (string guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            string name = Path.GetFileNameWithoutExtension(path);
            if (!dict.ContainsKey(name)) dict[name] = path;
        }
        return dict;
    }

    private static string FindLightmapTexture(string lightName, Dictionary<string, string> texturesByName)
    {
        string denoisedKey = lightName + LIGHTMAP_DENOISED_SUFFIX;
        if (texturesByName.TryGetValue(denoisedKey, out string exact))
            return exact;

        string prefix = lightName + LIGHTMAP_SUFFIX;
        string fallback = null;
        foreach (var kvp in texturesByName)
        {
            if (!kvp.Key.StartsWith(prefix, StringComparison.OrdinalIgnoreCase)) continue;
            if (kvp.Key.IndexOf("denoised", StringComparison.OrdinalIgnoreCase) >= 0)
                return kvp.Value;
            fallback = kvp.Value;
        }
        return fallback;
    }

    // ----------------------------------------------------------------------
    // Array building — trimmed copy of TextureArrayCreatorAssetEditor.BuildArray,
    // hardcoded to BC6H and driven by the light-name matches above instead of
    // a manually curated texture list.
    // ----------------------------------------------------------------------

    private static Texture2DArray BuildArray(List<Texture2D> textures, System.Text.StringBuilder report)
    {
        if (textures.Count == 0) return null;

        // Size is taken from the base lightmap (always slice 0); every other
        // texture gets resized to fit via the blit below (matches ASE's own
        // behavior for mismatched input sizes).
        int sizeX = textures[0].width;
        int sizeY = textures[0].height;

        if (_blitCopyMat == null)
        {
            Shader blitShader = Shader.Find("Hidden/ASEBlitCopy");
            if (blitShader == null)
            {
                Debug.LogError("[Specular World] Could not find Hidden/ASEBlitCopy — is Amplify Shader Editor installed?");
                return null;
            }
            _blitCopyMat = new Material(blitShader) { hideFlags = HideFlags.HideAndDontSave };
        }

        bool isCompressed = !UncompressedFormats.Contains(ARRAY_FORMAT);

        Texture2DArray textureArray = new Texture2DArray(sizeX, sizeY, textures.Count, ARRAY_FORMAT, MIPMAPS, LINEAR);
        textureArray.wrapMode = WRAP;
        textureArray.filterMode = FILTER;
        textureArray.anisoLevel = ANISO;
        textureArray.Apply(false);

        RenderTexture cache = RenderTexture.active;
        RenderTexture rt = new RenderTexture(sizeX, sizeY, 0, RenderTextureFormat.ARGBFloat,
            LINEAR ? RenderTextureReadWrite.Linear : RenderTextureReadWrite.sRGB);
        rt.Create();

        for (int i = 0; i < textures.Count; i++)
        {
            Texture2D src = textures[i];

            if (src.width != sizeX || src.height != sizeY)
                report.AppendLine($"  (note) \"{src.name}\" is {src.width}x{src.height}, resized to {sizeX}x{sizeY} to match slice 0");

            RenderTexture.active = rt;
            bool cachedSrgb = GL.sRGBWrite;
            GL.sRGBWrite = !LINEAR;
            _blitCopyMat.SetFloat("_ColorConversion", LINEAR ? 0 : 1);
            Graphics.Blit(src, rt, _blitCopyMat);
            GL.sRGBWrite = cachedSrgb;

            TextureFormat readFormat = isCompressed ? TextureFormat.RGBAFloat : ARRAY_FORMAT;
            Texture2D t2d = new Texture2D(sizeX, sizeY, readFormat, MIPMAPS, LINEAR);
            t2d.ReadPixels(new Rect(0, 0, sizeX, sizeY), 0, 0, MIPMAPS);
            RenderTexture.active = null;

            if (isCompressed)
                EditorUtility.CompressTexture(t2d, ARRAY_FORMAT, QUALITY);
            t2d.Apply(false);

            if (MIPMAPS)
            {
                int maxSize = Mathf.Max(sizeX, sizeY);
                int numLevels = 1 + (int)Mathf.Floor(Mathf.Log(maxSize, 2));
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
        // If the manager already points at an array asset, overwrite it in
        // place so existing material/shader references keep working.
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