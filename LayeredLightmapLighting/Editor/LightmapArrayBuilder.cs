using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System;
using System.IO;
using System.Linq;
using Meenphie.Commons;

public static class LightmapArrayBuilder
{
    // ── Constants (unchanged) ─────────────────────────────────────────────────
    private const string LIGHTMAP_SEARCH_FOLDER = "Assets";
    // Was 3 suffixes (_RNMX/_RNMY/_RNMZ) — now a single baked-at-NdotL=1
    // transfer texture per light, reconstructed with the runtime normal in
    // the shader (see LayeredLightmapLighting.cginc / _UdonAccumulateLight).
    private const string LIGHTMAP_TEXTURE_SUFFIX = "_Lightmap";
    private const string DENOISED_INFIX = "_denoised";
    private const string MATERIAL_GROUP_DELIMITER = " - ";

    private const string OUTPUT_FOLDER = "Assets/Lightmaps/";
    private const string OUTPUT_NAME_PC = "LightmapLayerArray_PC";
    private const string OUTPUT_NAME_QUEST = "LightmapLayerArray_Quest";

    private const TextureFormat ARRAY_FORMAT = TextureFormat.BC6H;
    private const bool LINEAR = true;
    private static readonly bool MIPMAPS = true;
    private const int QUALITY = 100;
    private const TextureWrapMode WRAP = TextureWrapMode.Clamp;
    private const FilterMode FILTER = FilterMode.Trilinear;
    private const int ANISO = 1;
    private const int MAX_GROUPS = 20;
    private const string REQUIRED_PREFIX = "GI";

    private const string COOKIE_OUTPUT_NAME = "CookieArray";
    private const int COOKIE_SIZE = 256;
    private const TextureFormat COOKIE_ARRAY_FORMAT = TextureFormat.RFloat;
    private static readonly bool COOKIE_LINEAR = true;

    // Name of the headless denoise script, expected to sit next to this file
    // (see GetDenoiseScriptPath()).
    private const string DENOISE_SCRIPT_NAME = "denoise_batch_headless.sh";

    private static Material _blitCopyMat;

    private static readonly List<TextureFormat> UncompressedFormats = new List<TextureFormat>
    {
        TextureFormat.RGBAFloat, TextureFormat.RGBAHalf, TextureFormat.ARGB32,
        TextureFormat.RGBA32, TextureFormat.RGB24, TextureFormat.Alpha8
    };

    // One baked transfer texture per light (was X/Y/Z RNM basis triplet).
    private struct LightmapEntry
    {
        public Texture2D Texture;
        public bool IsValid => Texture != null;
    }

    private static Texture2D ResizeTexture(Texture2D source, int newWidth, int newHeight)
    {
        RenderTexture rt = RenderTexture.GetTemporary(newWidth, newHeight, 0, RenderTextureFormat.ARGBFloat, RenderTextureReadWrite.Linear);
        RenderTexture.active = rt;
        Graphics.Blit(source, rt);
        Texture2D result = new Texture2D(newWidth, newHeight, TextureFormat.RGBAFloat, false, true);
        result.ReadPixels(new Rect(0, 0, newWidth, newHeight), 0, 0);
        result.Apply();
        RenderTexture.active = null;
        RenderTexture.ReleaseTemporary(rt);
        return result;
    }

    private static void SaveOrReplaceArray(ref Texture2DArray newArray, Texture2DArray existing, string path)
    {
        if (existing != null)
        {
            EditorUtility.CopySerialized(newArray, existing);
            UnityEngine.Object.DestroyImmediate(newArray);
            newArray = existing;
        }
        else
        {
            AssetDatabase.CreateAsset(newArray, path);
        }
    }

    public static void HandleLightmapChanged(string group, string lightName)
    {
        try
        {
            LightingManager mgr = UnityEngine.Object.FindObjectOfType<LightingManager>();
            if (mgr == null || mgr.lightLayerArrayPC == null)
            {
                Debug.Log("[Layered Lighting] '" + group + "_" + lightName +
                          "' changed, but no existing array to patch — run Build Array once first.");
                return;
            }

            Dictionary<string, string> texturesByName = CollectProjectTextures();
            var groupMaterials = CollectSpecularMaterialGroups();
            var allGroupNames = groupMaterials.Keys.OrderBy(g => g, StringComparer.OrdinalIgnoreCase).ToList();

            if (!allGroupNames.Contains(group))
            {
                Debug.LogWarning("[Layered Lighting] '" + group + "' isn't a known material group — skipping.");
                return;
            }

            var validGroups = new List<string>();
            foreach (string g in allGroupNames)
            {
                bool anyLight = false;
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    if (FindLightmapTexture(g, l.name, texturesByName).IsValid) { anyLight = true; break; }
                }
                if (anyLight) validGroups.Add(g);
            }

            if (validGroups.Count != mgr.lightmapGroupCount)
            {
                Debug.Log("[Layered Lighting] Group count changed (" + mgr.lightmapGroupCount + " -> " +
                          validGroups.Count + ") — falling back to full rebuild.");
                AutoAssignLightLayers();
                return;
            }

            int lightIndex = Array.FindIndex(mgr.childLights, l => l != null && l.name == lightName);
            if (lightIndex < 0 || mgr.childLightLayerSlices == null ||
                lightIndex >= mgr.childLightLayerSlices.Length || mgr.childLightLayerSlices[lightIndex] < 0)
            {
                Debug.Log("[Layered Lighting] '" + lightName +
                          "' has no existing slice (new light, or newly gaining a group) — falling back to full rebuild.");
                AutoAssignLightLayers();
                return;
            }

            // ── Safe to patch in place from here on ──
            string rawPath = OUTPUT_FOLDER + group + "_" + lightName + LIGHTMAP_TEXTURE_SUFFIX + ".exr";
            var rawFileNames = new List<string>();
            if (File.Exists(rawPath)) rawFileNames.Add(Path.GetFileName(rawPath));

            if (rawFileNames.Count == 0)
            {
                Debug.LogWarning("[Layered Lighting] No raw lightmap file on disk for '" + group + "_" + lightName + "'.");
                return;
            }

            string scriptPath = GetDenoiseScriptPath();
            string lightmapsDir = Path.GetFullPath(OUTPUT_FOLDER);

            var denoiseResult = DenoiseProcessRunner.Run(scriptPath, lightmapsDir, rawFileNames);
            if (!denoiseResult.Success)
            {
                Debug.LogWarning("[Layered Lighting] Denoise step failed/cancelled for '" + lightName +
                                  "' — aborting incremental update.");
                return;
            }

            string denoisedPath = rawPath.Replace(".exr", DENOISED_INFIX + ".exr");
            if (File.Exists(denoisedPath))
                AssetDatabase.ImportAsset(denoisedPath, ImportAssetOptions.ForceUpdate);
            AssetDatabase.Refresh();

            texturesByName = CollectProjectTextures();
            LightmapEntry entry = FindLightmapTexture(group, lightName, texturesByName);
            if (!entry.IsValid)
            {
                Debug.LogWarning("[Layered Lighting] Still no valid lightmap texture for '" + lightName +
                                  "' after denoising — aborting.");
                return;
            }

            Texture2DArray array = mgr.lightLayerArrayPC;
            int sizeX = array.width, sizeY = array.height;
            int groupIndex = validGroups.IndexOf(group);
            int sliceSlot = mgr.childLightLayerSlices[lightIndex];
            int baseArraySlice = sliceSlot + validGroups.Count;

            EditorUtility.DisplayProgressBar("Layered Lighting", "Updating slice for '" + lightName + "'…", 0.5f);

            WriteTextureIntoArraySlice(array, entry.Texture, baseArraySlice, sizeX, sizeY);

            // The group mask blends every light in the group, so it has to be
            // regenerated whenever any one of them changes — not just copied.
            var lightmapList = new List<Texture2D>();
            foreach (Light l in mgr.childLights)
            {
                if (l == null) continue;
                LightmapEntry e = FindLightmapTexture(group, l.name, texturesByName);
                if (!e.IsValid) continue;
                lightmapList.Add(e.Texture);
            }

            var report = new System.Text.StringBuilder();
            Texture2D mask = BuildMaskTexture(lightmapList, sizeX, sizeY, groupIndex, validGroups.Count, report);
            if (mask != null)
            {
                WriteTextureIntoArraySlice(array, mask, groupIndex, sizeX, sizeY);
                UnityEngine.Object.DestroyImmediate(mask);
            }

            array.Apply(false, false);
            EditorUtility.SetDirty(array);
            EditorUtility.SetDirty(mgr);
            AssetDatabase.SaveAssets();

            Debug.Log("[Layered Lighting] Patched '" + lightName + "' (group '" + group + "') in place — slice " +
                      baseArraySlice + ", mask slice " + groupIndex + ".");
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }


    private static string GetDenoiseScriptPath(
        [System.Runtime.CompilerServices.CallerFilePath] string thisFilePath = "")
    {
        return Path.Combine(Path.GetDirectoryName(thisFilePath), DENOISE_SCRIPT_NAME);
    }


    private static bool WriteTextureIntoArraySlice(Texture2DArray target, Texture2D src,
        int sliceIndex, int sizeX, int sizeY)
    {
        EnsureBlitMat();
        if (_blitCopyMat == null) return false;
        if (src == null) src = CreateBlackPlaceholder(sizeX, sizeY);

        bool isCompressed = !UncompressedFormats.Contains(ARRAY_FORMAT);

        RenderTexture cache = RenderTexture.active;
        var rt = new RenderTexture(sizeX, sizeY, 0, RenderTextureFormat.ARGBFloat,
            LINEAR ? RenderTextureReadWrite.Linear : RenderTextureReadWrite.sRGB);
        rt.Create();

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
            CopyToArray(t2d, target, sliceIndex, mip, isCompressed);

        UnityEngine.Object.DestroyImmediate(t2d);
        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);
        RenderTexture.active = cache;
        return true;
    }

    // ── Main entry point (full rebuild) ───────────────────────────
    [MenuItem("Meenphie/Layered Lighting/Build Lightmap Array")]
    public static void AutoAssignLightLayers()
    {
        try
        {
            EditorUtility.DisplayProgressBar("Layered Lighting", "Initialising…", 0.0f);

            LightingManager mgr = UnityEngine.Object.FindObjectOfType<LightingManager>();
            if (mgr == null) { Debug.LogError("[Layered Lighting] No LightingManager found."); return; }

            LightingEditorScene.RebuildLightData();

            if (mgr.childLights == null || mgr.childLights.Length == 0)
            { Debug.LogError("[Layered Lighting] No lights found in the scene."); return; }

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

            // ── Detailed scan: show every light & whether it has a texture ──
            report.AppendLine("=== Scanning all " + mgr.childLights.Length + " lights in the scene ===");
            foreach (Light l in mgr.childLights)
            {
                if (l == null) { report.AppendLine("  [null] light entry"); continue; }
                string ln = l.name;
                bool foundAny = false;
                foreach (string group in allGroupNames)
                {
                    LightmapEntry entry = FindLightmapTexture(group, ln, texturesByName);
                    if (entry.IsValid)
                    {
                        foundAny = true;
                        report.AppendLine($"  [texture] {ln} -> group '{group}'");
                        break;
                    }
                }
                if (!foundAny)
                    report.AppendLine($"  [missing] {ln} -> no lightmap texture found for any group");
            }
            report.AppendLine("=== End light scan ===");

            // Determine which groups have actual lightmap textures and count lights per group
            EditorUtility.DisplayProgressBar("Layered Lighting", "Checking lightmap availability…", 0.15f);
            var validGroups = new List<string>();
            var lightCountPerGroup = new Dictionary<string, int>();
            bool anyGroupHasTextures = false;

            foreach (string group in allGroupNames)
            {
                int lightsWithTextures = 0;
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    LightmapEntry entry = FindLightmapTexture(group, l.name, texturesByName);
                    if (entry.IsValid) lightsWithTextures++;
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

            // Quick pre-scan of cookies for the confirmation dialog
            int cookieCount = 0;
            if (mgr.childLightCookieTexture != null)
            {
                foreach (var tex in mgr.childLightCookieTexture)
                    if (tex != null) cookieCount++;
            }

            // Show confirmation dialog BEFORE any mask generation
            EditorUtility.ClearProgressBar();
            string groupInfo = "";
            foreach (string g in validGroups)
                groupInfo += $"\n• {g} ({lightCountPerGroup[g]} lights)";

            int totalLights = lightCountPerGroup.Values.Sum();
            string message = validGroups.Count + " zone(s) with lightmaps:" + groupInfo +
                             "\n\n" + totalLights + " lights = " + totalLights +
                             " slices, plus " + validGroups.Count + " mask slices = " +
                             (totalLights + validGroups.Count) + " total slices." +
                             "\n\nCookies found: " + cookieCount + " lights with a cookie assigned." +
                             "\n\nBuild array?";

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
                    LightmapEntry entry = FindLightmapTexture(group, l.name, texturesByName);
                    if (entry.IsValid)
                    {
                        dimRef = entry.Texture;
                        break;
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

                List<Texture2D> lightmapList = new List<Texture2D>();
                foreach (Light l in mgr.childLights)
                {
                    if (l == null) continue;
                    LightmapEntry entry = FindLightmapTexture(group, l.name, texturesByName);
                    if (entry.IsValid) lightmapList.Add(entry.Texture);
                }

                Texture2D maskTex = BuildMaskTexture(lightmapList, sizeX, sizeY, gi, validGroups.Count, report);
                if (maskTex == null)
                {
                    Debug.LogError("[Layered Lighting] Mask generation failed for group '" + group + "'.\n" + report);
                    return;
                }
                maskTex.hideFlags = HideFlags.DontSave;
                maskTextures.Add(maskTex);
                report.AppendLine("  [mask] Group='" + group + "' -> slice " + gi);
            }

            // Match lights to groups and assign slice indices (1 slice per light now)
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

                string matchedGroup = null;
                LightmapEntry matchedEntry = default;
                var conflictingGroups = new List<string>();

                foreach (string group in validGroups)
                {
                    LightmapEntry entry = FindLightmapTexture(group, lightName, texturesByName);
                    if (!entry.IsValid) continue;

                    if (matchedGroup == null)
                    {
                        matchedGroup = group;
                        matchedEntry = entry;
                    }
                    else
                    {
                        conflictingGroups.Add(group);
                    }
                }

                if (conflictingGroups.Count > 0)
                {
                    report.AppendLine("  [warn] " + lightName + " matched multiple groups: " +
                                      matchedGroup + " (used), " + string.Join(", ", conflictingGroups) +
                                      " (ignored) — a light can only belong to one group.");
                }

                if (matchedGroup != null)
                {
                    int sliceSlot = orderedTextures.Count;
                    int bit = 1 << validGroups.IndexOf(matchedGroup);

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

                    orderedTextures.Add(matchedEntry.Texture);

                    hasAnyGroup = true;
                    report.AppendLine("  [ok]   " + lightName + "  group=" + matchedGroup +
                                      "  sliceSlot=" + sliceSlot +
                                      "  arraySlice=" + (sliceSlot + validGroups.Count) +
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

            // ── Build PC array (original resolution) ──
            EditorUtility.DisplayProgressBar("Layered Lighting", "Building PC texture array…", 0.75f);
            var finalTextureListPC = new List<Texture2D>();
            finalTextureListPC.AddRange(maskTextures);
            finalTextureListPC.AddRange(orderedTextures);

            Texture2DArray builtArrayPC = BuildArray(finalTextureListPC, sizeX, sizeY, report);
            if (builtArrayPC == null)
            {
                Debug.LogError("[Layered Lighting] PC texture array build failed.\n" + report);
                return;
            }
            builtArrayPC.name = OUTPUT_NAME_PC;

            // ── Build Quest array (half resolution) ──
            int questSizeX = Mathf.Max(1, sizeX / 2);
            int questSizeY = Mathf.Max(1, sizeY / 2);
            EditorUtility.DisplayProgressBar("Layered Lighting", "Building Quest texture array (half res)…", 0.85f);

            var questTextures = new List<Texture2D>();
            foreach (var tex in finalTextureListPC)
            {
                if (tex == null) continue;
                Texture2D resized = ResizeTexture(tex, questSizeX, questSizeY);
                questTextures.Add(resized);
            }

            Texture2DArray builtArrayQuest = BuildArray(questTextures, questSizeX, questSizeY, report);
            if (builtArrayQuest == null)
            {
                Debug.LogError("[Layered Lighting] Quest texture array build failed.\n" + report);
                return;
            }
            builtArrayQuest.name = OUTPUT_NAME_QUEST;

            // Nettoyage des textures temporaires Quest
            foreach (var tex in questTextures)
                UnityEngine.Object.DestroyImmediate(tex);

            // Nettoyage des masques et placeholder
            foreach (var tex in maskTextures) if (tex != null) UnityEngine.Object.DestroyImmediate(tex);
            foreach (var tex in orderedTextures)
                if (tex != null && tex.name.StartsWith("BlackPlaceholder"))
                    UnityEngine.Object.DestroyImmediate(tex);

            // Sauvegarde des deux assets
            EnsureFolder(OUTPUT_FOLDER);
            string assetPathPC = OUTPUT_FOLDER + OUTPUT_NAME_PC + ".asset";
            string assetPathQuest = OUTPUT_FOLDER + OUTPUT_NAME_QUEST + ".asset";

            Texture2DArray existingPC = AssetDatabase.LoadAssetAtPath<Texture2DArray>(assetPathPC);
            Texture2DArray existingQuest = AssetDatabase.LoadAssetAtPath<Texture2DArray>(assetPathQuest);

            SaveOrReplaceArray(ref builtArrayPC, existingPC, assetPathPC);
            SaveOrReplaceArray(ref builtArrayQuest, existingQuest, assetPathQuest);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            // Assignation aux champs PC/Quest du manager
            Undo.RecordObject(mgr, "Layered Lighting Build Array");
            mgr.lightLayerArrayPC = builtArrayPC;
            mgr.lightLayerArrayQuest = builtArrayQuest;
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

            // Assign material group masks
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

            // ── Build Cookie Array ─────────────────────────────────────────────
            EditorUtility.DisplayProgressBar("Layered Lighting", "Building cookie array…", 0.90f);

            var cookieSlices = new List<int>();
            var uniqueCookies = new List<Texture2D>();
            var cookieMap = new Dictionary<Texture, int>();

            int lightCount = newChildLights.Count;
            for (int i = 0; i < lightCount; i++)
            {
                Light l = newChildLights[i];
                Texture cookieTex = (mgr.childLightCookieTexture != null && i < mgr.childLightCookieTexture.Length)
                    ? mgr.childLightCookieTexture[i] : null;
                if (cookieTex != null && cookieTex is Texture2D)
                {
                    if (!cookieMap.TryGetValue(cookieTex, out int slice))
                    {
                        slice = uniqueCookies.Count;
                        cookieMap[cookieTex] = slice;
                        Texture2D processed = ProcessCookieTexture((Texture2D)cookieTex);
                        uniqueCookies.Add(processed);
                    }
                    cookieSlices.Add(slice);
                }
                else
                {
                    cookieSlices.Add(-1);
                }
            }

            Texture2DArray cookieArrayAsset = null;
            if (uniqueCookies.Count > 0)
            {
                cookieArrayAsset = BuildCookieArray(uniqueCookies, COOKIE_SIZE, COOKIE_SIZE);
                if (cookieArrayAsset == null)
                {
                    Debug.LogError("[Layered Lighting] Failed to build cookie array.");
                    foreach (var t in uniqueCookies) UnityEngine.Object.DestroyImmediate(t);
                    return;
                }
                cookieArrayAsset.name = COOKIE_OUTPUT_NAME;

                string cookieAssetPath = OUTPUT_FOLDER + COOKIE_OUTPUT_NAME + ".asset";
                Texture2DArray existingCookieAsset = AssetDatabase.LoadAssetAtPath<Texture2DArray>(cookieAssetPath);
                if (existingCookieAsset != null)
                {
                    EditorUtility.CopySerialized(cookieArrayAsset, existingCookieAsset);
                    UnityEngine.Object.DestroyImmediate(cookieArrayAsset);
                    cookieArrayAsset = existingCookieAsset;
                }
                else
                {
                    AssetDatabase.CreateAsset(cookieArrayAsset, cookieAssetPath);
                }
                AssetDatabase.SaveAssets();
            }

            mgr.cookieArray = cookieArrayAsset;
            mgr.childLightCookieSlice = cookieSlices.ToArray();

            if (cookieArrayAsset != null)
                Shader.SetGlobalTexture("_UdonCookieArray", cookieArrayAsset);

            foreach (var t in uniqueCookies)
                UnityEngine.Object.DestroyImmediate(t);

        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }

    // ── Per-group mask generation ─────────────────────────────────────────────
    private static Texture2D BuildMaskTexture(List<Texture2D> lightmapTextures,
        int sizeX, int sizeY, int groupIndex, int totalGroups,
        System.Text.StringBuilder report)
    {
        if (lightmapTextures == null || lightmapTextures.Count == 0) return null;

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

        for (int i = 0; i < lightmapTextures.Count; i++)
        {
            Texture2D src = lightmapTextures[i];
            if (src == null) continue;

            float globalMin = (float)groupIndex / Mathf.Max(totalGroups, 1);
            float globalMax = (float)(groupIndex + 1) / Mathf.Max(totalGroups, 1);
            float p = Mathf.Lerp(globalMin, globalMax,
                (float)i / Mathf.Max(lightmapTextures.Count - 1, 1));
            EditorUtility.DisplayProgressBar("Layered Lighting",
                "Generating mask… " + (i + 1) + "/" + lightmapTextures.Count +
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

        // NOTE: each light now contributes exactly 1 texture to this sum instead
        // of 3 (X+Y+Z RNM basis), so the accumulated magnitude here is roughly
        // 1/3 of what it was pre-refactor for an equivalent scene. The shader's
        // DIFFUSE_MASK_THRESHOLD (5.0h) was calibrated against the old 3x
        // magnitude — you'll likely want to retune it empirically in-editor
        // after the first rebuild with real content.
        report.AppendLine("  [mask] BC6H " + sizeX + "x" + sizeY +
                          " from " + lightmapTextures.Count + " lightmap textures.");
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

    // Was FindRNMSet (3 lookups for X/Y/Z). Now a single lookup, tries the
    // denoised variant first and falls back to the raw bake.
    private static LightmapEntry FindLightmapTexture(string group, string lightName,
        Dictionary<string, string> texturesByName)
    {
        var entry = new LightmapEntry();
        string[] suffixes = { LIGHTMAP_TEXTURE_SUFFIX + DENOISED_INFIX, LIGHTMAP_TEXTURE_SUFFIX };
        foreach (string s in suffixes)
        {
            entry.Texture = FindTextureForGroupAndLight(group, lightName, s, texturesByName);
            if (entry.Texture != null) break;
        }
        return entry;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private static Texture2DArray BuildCookieArray(List<Texture2D> textures, int width, int height)
    {
        if (textures.Count == 0) return null;

        var array = new Texture2DArray(width, height, textures.Count, COOKIE_ARRAY_FORMAT, true, COOKIE_LINEAR)
        {
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Trilinear,  // ← was Bilinear
        };

        for (int i = 0; i < textures.Count; i++)
        {
            Texture2D src = textures[i];
            if (src == null)
            {
                src = new Texture2D(width, height, COOKIE_ARRAY_FORMAT, true, COOKIE_LINEAR);
                var black = new Color[width * height];
                src.SetPixels(black);
                src.Apply(true);
            }

            // Copy base level only — Apply(true) below will generate the mip chain
            array.SetPixels(src.GetPixels(), i, 0);
        }

        array.Apply(true, false);
        return array;
    }

    private static Texture2D ProcessCookieTexture(Texture2D source)
    {
        // Use ARGB32 to preserve the alpha channel during the blit
        var rt = new RenderTexture(COOKIE_SIZE, COOKIE_SIZE, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
        rt.Create();

        RenderTexture.active = rt;
        GL.sRGBWrite = false;
        Graphics.Blit(source, rt);
        GL.sRGBWrite = true;

        // Read into a CPU-accessible texture
        var temp = new Texture2D(COOKIE_SIZE, COOKIE_SIZE, TextureFormat.RGBA32, false, true);
        temp.ReadPixels(new Rect(0, 0, COOKIE_SIZE, COOKIE_SIZE), 0, 0, false);
        temp.Apply();
        RenderTexture.active = null;
        rt.Release();
        UnityEngine.Object.DestroyImmediate(rt);

        // Convert to single-channel RFloat, handling both colored cookies and alpha-only cookies
        Color[] srcPixels = temp.GetPixels();
        Color[] dstPixels = new Color[srcPixels.Length];
        for (int i = 0; i < srcPixels.Length; i++)
        {
            Color c = srcPixels[i];
            float lum = c.r * 0.299f + c.g * 0.587f + c.b * 0.114f;
            float val = (c.a < 1.0f) ? c.a * lum : lum;
            dstPixels[i] = new Color(val, val, val, 1f);
        }

        var processed = new Texture2D(COOKIE_SIZE, COOKIE_SIZE, TextureFormat.RFloat, true, true);
        processed.SetPixels(dstPixels);
        processed.Apply(true);

        UnityEngine.Object.DestroyImmediate(temp);
        return processed;
    }

    private static Texture2D FindTextureForGroupAndLight(
        string group, string lightName, string suffix,
        Dictionary<string, string> texturesByName)
    {
        string expected = group + "_" + lightName + suffix;

        foreach (var kvp in texturesByName)
        {
            if (kvp.Key.Equals(expected, StringComparison.OrdinalIgnoreCase))
                return AssetDatabase.LoadAssetAtPath<Texture2D>(kvp.Value);
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