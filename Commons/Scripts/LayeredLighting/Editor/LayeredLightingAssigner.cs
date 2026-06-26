#if UNITY_EDITOR
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

    private const int MAX_GROUPS = 20;

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

    [MenuItem("Meenphie/Layered Lighting/Build Array")]
    public static void AutoAssignLightLayers()
    {
        try
        {
            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Initialising…", 0f);

            LayeredLightingManager mgr = UnityEngine.Object.FindObjectOfType<LayeredLightingManager>();
            if (mgr == null)
            {
                Debug.LogError("[Specular World] No LayeredLightingManager found in scene.");
                return;
            }

            LayeredLightingEditor.RebuildLightData();

            if (mgr.childLights == null || mgr.childLights.Length == 0)
            {
                Debug.LogError("[Specular World] LayeredLightingManager has no childLights — nothing to assign.");
                return;
            }

            var report = new System.Text.StringBuilder();

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Scanning material groups…", 0.03f);
            var groupMaterials = CollectSpecularMaterialGroups();
            if (groupMaterials.Count == 0)
            {
                Debug.LogError("[Specular World] No materials found with pattern X - Group - Y. Nothing to assign.");
                return;
            }

            var groupNames = groupMaterials.Keys.OrderBy(g => g, StringComparer.OrdinalIgnoreCase).ToList();
            if (groupNames.Count > MAX_GROUPS)
            {
                Debug.LogError("[Specular World] " + groupNames.Count + " groups found, but bitmask packing only supports up to " + MAX_GROUPS + ". Aborting.");
                return;
            }

            report.AppendLine("=== " + groupNames.Count + " groups: " + string.Join(", ", groupNames) + " ===");

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Collecting project textures…", 0.08f);
            Dictionary<string, string> texturesByName = CollectProjectTextures();
            report.AppendLine(texturesByName.Count + " textures found under Assets.");

            int originalLightCount = mgr.childLights.Length;

            var lightData = new (
                Light light,
                Transform transform,
                Vector3 bakedColor,
                Vector2 halfExtents,
                bool isRealtime,
                bool diffuse,
                bool specular,
                float specularMaxDist,
                float diffuseMaxDist,
                bool animated,
                int animModel,
                bool isBroken,
                float failureRate,
                AudioClip audioOverride
            )[originalLightCount];

            for (int i = 0; i < originalLightCount; i++)
            {
                Light l = mgr.childLights[i];
                if (l == null) continue;

                Vector3 bakedCol = (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                    ? mgr.childLightBakedColors[i] : new Vector3(l.color.r, l.color.g, l.color.b);
                Vector2 halfExt = (mgr.childLightHalfExtents != null && i < mgr.childLightHalfExtents.Length)
                    ? mgr.childLightHalfExtents[i] : new Vector2(0.01f, 0.01f);
                bool isRt = (mgr.childLightIsRealtime != null && i < mgr.childLightIsRealtime.Length)
                    ? mgr.childLightIsRealtime[i] : true;
                bool diff = (mgr.childLightDiffuseEnabled != null && i < mgr.childLightDiffuseEnabled.Length)
                    ? mgr.childLightDiffuseEnabled[i] : true;
                bool spec = (mgr.childLightSpecularDistance != null && i < mgr.childLightSpecularDistance.Length)
                    ? mgr.childLightSpecularDistance[i] : true;
                float specMax = (mgr.childLightSpecularMaxDistance != null && i < mgr.childLightSpecularMaxDistance.Length)
                    ? mgr.childLightSpecularMaxDistance[i] : 0f;
                float diffMax = (mgr.childLightDiffuseMaxDistance != null && i < mgr.childLightDiffuseMaxDistance.Length)
                    ? mgr.childLightDiffuseMaxDistance[i] : 0f;
                bool anim = (mgr.childLightIsAnimated != null && i < mgr.childLightIsAnimated.Length)
                    ? mgr.childLightIsAnimated[i] : false;
                int animMdl = (mgr.childLightAnimationModel != null && i < mgr.childLightAnimationModel.Length)
                    ? mgr.childLightAnimationModel[i] : 0;
                bool broken = (mgr.childLightIsBroken != null && i < mgr.childLightIsBroken.Length)
                    ? mgr.childLightIsBroken[i] : false;
                float failureRate = (mgr.childLightFailureRate != null && i < mgr.childLightFailureRate.Length)
                    ? mgr.childLightFailureRate[i] : 0.5f;
                AudioClip audioOvr = (mgr.childLightAudioClipOverride != null && i < mgr.childLightAudioClipOverride.Length)
                    ? mgr.childLightAudioClipOverride[i] : null;

                lightData[i] = (l, l.transform, bakedCol, halfExt, isRt, diff, spec, specMax, diffMax, anim, animMdl, broken, failureRate, audioOvr);
            }

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
            var newAnim = new List<bool>();
            var newAnimModel = new List<int>();
            var newIsBroken = new List<bool>();
            var newFailureRate = new List<float>();
            var newAudioOverride = new List<AudioClip>();

            var orderedTextures = new List<Texture2D>();
            int matchCount = 0;

            for (int li = 0; li < originalLightCount; li++)
            {
                float p = 0.12f + 0.38f * ((float)li / Mathf.Max(originalLightCount - 1, 1));
                EditorUtility.DisplayProgressBar("Specular Auto-Assign",
                    "Matching lights to groups… (" + (li + 1) + " / " + originalLightCount + ")", p);

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
                    newBakedCol.Add(data.bakedColor);
                    newHalfExt.Add(data.halfExtents);
                    newIsRt.Add(data.isRealtime);
                    newDiff.Add(data.diffuse);
                    newSpec.Add(data.specular);
                    newSpecMax.Add(data.specularMaxDist);
                    newDiffMax.Add(data.diffuseMaxDist);
                    newAnim.Add(data.animated);
                    newAnimModel.Add(data.animModel);
                    newIsBroken.Add(data.isBroken);
                    newFailureRate.Add(data.failureRate);
                    newAudioOverride.Add(data.audioOverride);

                    orderedTextures.Add(rnm.X);
                    orderedTextures.Add(rnm.Y);
                    orderedTextures.Add(rnm.Z);
                    hasAnyGroup = true;
                    matchCount++;
                    report.AppendLine("  [ok]   " + lightName + "  group " + group + " -> slice slot " + sliceSlot + " (bit " + bit + ")");
                }

                if (!hasAnyGroup)
                {
                    newChildLights.Add(data.light);
                    newSlice.Add(-1);
                    newGroupMask.Add(~0);
                    newBakedCol.Add(data.bakedColor);
                    newHalfExt.Add(data.halfExtents);
                    newIsRt.Add(data.isRealtime);
                    newDiff.Add(data.diffuse);
                    newSpec.Add(data.specular);
                    newSpecMax.Add(data.specularMaxDist);
                    newDiffMax.Add(data.diffuseMaxDist);
                    newAnim.Add(data.animated);
                    newAnimModel.Add(data.animModel);
                    newIsBroken.Add(data.isBroken);
                    newFailureRate.Add(data.failureRate);
                    newAudioOverride.Add(data.audioOverride);
                    report.AppendLine("  [skip] " + lightName + " -> no group textures, default global light");
                }
            }

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Resolving base texture…", 0.51f);
            Texture2D baseTex = ResolveBaseTexture(texturesByName, orderedTextures, out bool basePlaceholder, report);
            if (baseTex == null)
            {
                Debug.LogError("[Specular World] Could not resolve base texture.\n" + report.ToString());
                return;
            }

            var finalTextureList = new List<Texture2D> { baseTex };
            finalTextureList.AddRange(orderedTextures);
            report.AppendLine("Total array depth: " + finalTextureList.Count + " slices (1 base + " + matchCount + " lights x 3)");

            Texture2DArray builtArray = BuildArray(finalTextureList, report);
            if (basePlaceholder) UnityEngine.Object.DestroyImmediate(baseTex);
            foreach (var tex in orderedTextures)
                if (tex != null && tex.name.StartsWith("BlackPlaceholder"))
                    UnityEngine.Object.DestroyImmediate(tex);

            if (builtArray == null)
            {
                Debug.LogError("[Specular World] Texture array build failed.\n" + report.ToString());
                return;
            }

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Saving texture array asset…", 0.91f);
            Texture2DArray savedArray = SaveArrayAsset(builtArray, mgr);
            mgr.lightLayerArray = savedArray;

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Writing manager arrays…", 0.94f);
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
            mgr.childLightIsAnimated = newAnim.ToArray();
            mgr.childLightAnimationModel = newAnimModel.ToArray();
            mgr.childLightIsBroken = newIsBroken.ToArray();
            mgr.childLightFailureRate = newFailureRate.ToArray();
            mgr.childLightAudioClipOverride = newAudioOverride.ToArray();

            EditorUtility.DisplayProgressBar("Specular Auto-Assign", "Assigning material group masks…", 0.97f);
            foreach (string group in groupNames)
            {
                int bit = 1 << groupNames.IndexOf(group);
                float matMask = (float)bit;
                foreach (Material mat in groupMaterials[group])
                {
                    mat.SetFloat("_LightGroupMask", matMask);
                    EditorUtility.SetDirty(mat);
                    report.AppendLine("  [mat]  " + mat.name + "  ->  _LightGroupMask = " + matMask + "  (group: " + group + ")");
                }
            }

            EditorUtility.SetDirty(mgr);
            AssetDatabase.SaveAssets();

            Debug.Log("[Specular World] Created " + matchCount + " per-group light slots across " + groupNames.Count + " groups. " +
                      "Array: " + savedArray.width + "x" + savedArray.height + ", " + savedArray.depth + " slices, " + ARRAY_FORMAT + ".\n" + report.ToString());
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }

    private static Dictionary<string, List<Material>> CollectSpecularMaterialGroups()
    {
        var result = new Dictionary<string, List<Material>>(StringComparer.OrdinalIgnoreCase);
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
            Debug.LogWarning("[Specular World] " + unparsed.Count + " material(s) contain dash but did not match: " +
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

    private static RNMSet FindRNMSet(string group, string lightName, Dictionary<string, string> texturesByName)
    {
        var rnm = new RNMSet();
        foreach (string sfx in new[] { DENOISED_INFIX, "" })
        {
            if (rnm.X == null && texturesByName.TryGetValue(group + "_" + lightName + RNM_X_SUFFIX + sfx, out string px))
                rnm.X = AssetDatabase.LoadAssetAtPath<Texture2D>(px);
            if (rnm.Y == null && texturesByName.TryGetValue(group + "_" + lightName + RNM_Y_SUFFIX + sfx, out string py))
                rnm.Y = AssetDatabase.LoadAssetAtPath<Texture2D>(py);
            if (rnm.Z == null && texturesByName.TryGetValue(group + "_" + lightName + RNM_Z_SUFFIX + sfx, out string pz))
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
                report.AppendLine("  [base] slice 0 <- " + basePath);
                return tex;
            }
        }

        foreach (var t in existingTextures)
        {
            if (t != null)
            {
                report.AppendLine("  [base] slice 0 <- black placeholder, sized to " + t.name + " (no Base_Lightmap found)");
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
            float p = 0.52f + 0.38f * ((float)i / Mathf.Max(textures.Count - 1, 1));
            EditorUtility.DisplayProgressBar("Specular Auto-Assign",
                "Building texture array… slice " + (i + 1) + " / " + textures.Count, p);

            Texture2D src = textures[i];
            if (src.width != sizeX || src.height != sizeY)
                report.AppendLine("  (note) " + src.name + " is " + src.width + "x" + src.height + ", resized to " + sizeX + "x" + sizeY);

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

    private static Texture2DArray SaveArrayAsset(Texture2DArray array, LayeredLightingManager mgr)
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

        string path = AssetDatabase.GenerateUniqueAssetPath(OUTPUT_FOLDER + "/" + OUTPUT_NAME + ".asset");
        AssetDatabase.CreateAsset(array, path);
        AssetDatabase.SaveAssets();
        EditorGUIUtility.PingObject(array);
        return array;
    }
}
#endif