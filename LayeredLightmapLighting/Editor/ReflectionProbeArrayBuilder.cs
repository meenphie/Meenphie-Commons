using UnityEditor;
using UnityEngine;
using System.Linq;
using UnityEngine.Experimental.Rendering;
using Meenphie.Commons;

public class ReflectionProbeArrayBuilder : EditorWindow
{
    private const string OUTPUT_FOLDER = BakePaths.ReflectionProbes;
    private const string ARRAY_NAME_PC = "ReflectionProbeArray_PC";
    private const string ARRAY_NAME_QUEST = "ReflectionProbeArray_Quest";
    private const int MAX_PROBES = 16;
    private const string HotspotFilterEnabledKey = "Meenphie.ReflectionProbeHotspotFilter.Enabled";
    private const string HotspotThresholdKey = "Meenphie.ReflectionProbeHotspotFilter.Threshold";
    private const string HotspotFeatherKey = "Meenphie.ReflectionProbeHotspotFilter.Feather";
    private const string HotspotReplacementKey = "Meenphie.ReflectionProbeHotspotFilter.Replacement";

    private static Texture2D _tempSrcFace;
    private static Texture2D _tempTex;
    private static Texture2D _tempPcFace;
    private static Texture2D _tempPcCompressedFace;
    private static Texture2D _tempQuestCompressedFace;
    private static Material _hotspotFilterMaterial;

    public static bool RemoveBrightPixels
    {
        get => EditorPrefs.GetBool(HotspotFilterEnabledKey, false);
        set => EditorPrefs.SetBool(HotspotFilterEnabledKey, value);
    }

    public static float BrightPixelThreshold
    {
        get => Mathf.Clamp(EditorPrefs.GetFloat(HotspotThresholdKey, 1f), 0f, 1f);
        set => EditorPrefs.SetFloat(HotspotThresholdKey, Mathf.Clamp(value, 0f, 1f));
    }

    public static float BrightPixelFeather
    {
        get => Mathf.Clamp(EditorPrefs.GetFloat(HotspotFeatherKey, 0.1f), 0f, 0.5f);
        set => EditorPrefs.SetFloat(HotspotFeatherKey, Mathf.Clamp(value, 0f, 0.5f));
    }

    public static int BrightPixelReplacement
    {
        get => EditorPrefs.GetInt(HotspotReplacementKey, 1);
        set => EditorPrefs.SetInt(HotspotReplacementKey, Mathf.Clamp(value, 0, 1));
    }

    private static void ResetTempBuffers()
    {
        if (_tempSrcFace != null) { Object.DestroyImmediate(_tempSrcFace); _tempSrcFace = null; }
        if (_tempTex != null) { Object.DestroyImmediate(_tempTex); _tempTex = null; }
        if (_tempPcFace != null) { Object.DestroyImmediate(_tempPcFace); _tempPcFace = null; }
        if (_tempPcCompressedFace != null) { Object.DestroyImmediate(_tempPcCompressedFace); _tempPcCompressedFace = null; }
        if (_tempQuestCompressedFace != null) { Object.DestroyImmediate(_tempQuestCompressedFace); _tempQuestCompressedFace = null; }
        if (_hotspotFilterMaterial != null) { Object.DestroyImmediate(_hotspotFilterMaterial); _hotspotFilterMaterial = null; }
    }

    public static ReflectionProbe[] GetBakedProbes()
    {
        return MeshArrayBaker.CreateReflectionProbePlan().Probes;
    }

    public static ReflectionProbe[] GetAllBakedProbes()
    {
        return Object.FindObjectsOfType<ReflectionProbe>()
            .Where(p => p.bakedTexture != null || p.customBakedTexture != null)
            .OrderBy(p => p.name, System.StringComparer.OrdinalIgnoreCase)
            .ToArray();
    }

    public static int SelectNearestProbeForRenderer(Renderer renderer, ReflectionProbe[] probes)
    {
        if (renderer == null || probes == null || probes.Length == 0)
            return -1;

        if (renderer.probeAnchor != null)
        {
            ReflectionProbe anchorProbe = renderer.probeAnchor.GetComponentInParent<ReflectionProbe>();
            if (anchorProbe != null)
            {
                for (int i = 0; i < probes.Length; i++)
                    if (probes[i] == anchorProbe)
                        return i;

                return -1;
            }
        }

        Vector3 pivot = renderer.transform.position;
        int bestIndex = -1;
        float bestDistanceSquared = float.PositiveInfinity;
        for (int i = 0; i < probes.Length; i++)
        {
            ReflectionProbe probe = probes[i];
            if (probe == null)
                continue;

            float distanceSquared = (probe.transform.position - pivot).sqrMagnitude;
            if (distanceSquared >= bestDistanceSquared)
                continue;

            bestIndex = i;
            bestDistanceSquared = distanceSquared;
        }

        return bestIndex;
    }

    [MenuItem("Meenphie/Layered Lighting/Build Reflection Probes Array")]
    public static void Build()
    {
        if (Object.FindObjectOfType<LightingManager>() == null)
        {
            Debug.LogError("Aucun LightingManager trouvé dans la scène.");
            return;
        }

        Build(MeshArrayBaker.CreateReflectionProbePlan());
    }

    public static void Build(MeshArrayBaker.ReflectionProbePlan probePlan)
    {
        if (probePlan == null) throw new System.ArgumentNullException(nameof(probePlan));
        ResetTempBuffers();
        LightingManager mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr == null) { Debug.LogError("Aucun LightingManager trouvé dans la scène."); return; }

        ReflectionProbe[] probes = probePlan.Probes;

        if (probes.Length == 0) { Debug.LogWarning("Aucune reflection probe bakée n'a été trouvée."); return; }
        if (probes.Length > MAX_PROBES) { Debug.LogError($"Trop de probes ({probes.Length}), la limite est fixée à {MAX_PROBES}."); return; }

        Cubemap firstCube = probes[0].bakedTexture as Cubemap ?? probes[0].customBakedTexture as Cubemap;
        if (firstCube == null) { Debug.LogError("La première probe est invalide."); return; }

        int pcRes = firstCube.width;
        if (pcRes < 4)
        {
            Debug.LogError($"Reflection probes must be at least 4x4 to use BC7/DXT5 compression (got {pcRes}x{pcRes}).");
            return;
        }

        const int SPECCUBE_LOD_STEPS = 6;
        int pcMipCount = Mathf.Min(firstCube.mipmapCount, SPECCUBE_LOD_STEPS + 1);
        while (pcMipCount > 0 && Mathf.Max(1, pcRes >> (pcMipCount - 1)) < 4)
            pcMipCount--;
        if (pcMipCount == 0)
        {
            Debug.LogError($"No BC7/DXT5-compatible mip levels found for {pcRes}x{pcRes} reflection probes.");
            return;
        }

        GraphicsFormat pcFormat = firstCube.graphicsFormat;
        if (!SystemInfo.IsFormatSupported(pcFormat, FormatUsage.Sample))
        {
            Debug.LogError($"Les cubemaps des probes sont en {pcFormat}, que le GPU de l'éditeur ne peut pas lire. " +
                           "Passe le Build Target sur la plateforme voulue (Windows pour PC), rebake les probes, puis relance.");
            ResetTempBuffers();
            return;
        }
        // PC : DXT5 uniquement
        TextureFormat pcTextureFormat = TextureFormat.DXT5;
        GraphicsFormat pcArrayFormat = GraphicsFormatUtility.GetGraphicsFormat(pcTextureFormat, false);

        if (!SystemInfo.IsFormatSupported(pcArrayFormat, FormatUsage.Sample))
        {
            Debug.LogError($"PC reflection probe array format {pcArrayFormat} is not supported for sampling.");
            ResetTempBuffers();
            return;
        }

        // Unity samples up to mip 6. Keep only complete compressed mip levels (minimum 4x4).
        int probeMaxMip = Mathf.Min(SPECCUBE_LOD_STEPS, pcMipCount - 1);

        Debug.Log($"Format PC source : {pcFormat} | Res : {pcRes} | Mips : {pcMipCount}");

        for (int i = 1; i < probes.Length; i++)
        {
            var p = probes[i];
            Cubemap cube = p.bakedTexture as Cubemap ?? p.customBakedTexture as Cubemap;
            if (cube == null) { Debug.LogError($"Probe '{p.name}' invalide."); return; }
            if (cube.width != pcRes) { Debug.LogError($"Probe '{p.name}' résolution incompatible."); return; }
            if (cube.mipmapCount < pcMipCount) { Debug.LogError($"Probe '{p.name}' n'a que {cube.mipmapCount} mip(s), {pcMipCount} sont nécessaires."); return; }
            if (cube.graphicsFormat != pcFormat) { Debug.LogError($"Probe '{p.name}' format différent ({cube.graphicsFormat} au lieu de {pcFormat})."); return; }
        }

        Shader filterShader = Shader.Find("Hidden/Meenphie/ReflectionProbeHotspotFilter");
        if (filterShader == null)
        {
            Debug.LogError("Reflection probe conversion shader is missing; probe arrays were not rebuilt.");
            return;
        }

        _hotspotFilterMaterial = new Material(filterShader)
        {
            hideFlags = HideFlags.HideAndDontSave
        };
        _hotspotFilterMaterial.SetFloat("_HotspotEnabled", RemoveBrightPixels ? 1f : 0f);
        _hotspotFilterMaterial.SetFloat("_HotspotThreshold", BrightPixelThreshold);
        _hotspotFilterMaterial.SetFloat("_HotspotFeather", BrightPixelFeather);
        _hotspotFilterMaterial.SetFloat("_HotspotReplacement", BrightPixelReplacement);

        int questRes = Mathf.Max(4, pcRes / 2);
        GraphicsFormat questFormat;
        TextureFormat questTexFormat;

        // On vérifie si la plateforme ACTUELLE supporte l'ASTC (pas le BC7 !)
        if (SystemInfo.SupportsTextureFormat(TextureFormat.ASTC_6x6))
        {
            questTexFormat = TextureFormat.ASTC_6x6;
            questFormat = GraphicsFormatUtility.GetGraphicsFormat(questTexFormat, false);

            // Vérification ultime de sécurité
            if (!SystemInfo.IsFormatSupported(questFormat, FormatUsage.Sample))
            {
                Debug.LogWarning("[ReflectionProbeBuilder] ASTC is reported as supported but cannot be sampled. Falling back to DXT5.");
                questTexFormat = TextureFormat.DXT5;
                questFormat = GraphicsFormatUtility.GetGraphicsFormat(questTexFormat, false);
            }
        }
        else
        {
            questTexFormat = TextureFormat.DXT5;
            questFormat = GraphicsFormatUtility.GetGraphicsFormat(questTexFormat, false);
            Debug.LogWarning("[ReflectionProbeBuilder] ASTC_6x6 non supporté par l'éditeur. Le tableau Quest est généré en DXT5 pour éviter un crash.");
        }

        if (!SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.ARGBHalf))
        {
            Debug.LogError("Reflection probe conversion requires ARGBHalf render texture support; probe arrays were not rebuilt.");
            ResetTempBuffers();
            return;
        }

        // Trois Vector4 par probe :
        //   [b+0] position de capture (xyz)
        //   [b+1] bounds.min (xyz)          | box projection 0/1 (w)
        //   [b+2] bounds.max (xyz)          | importance (w)
        // Les meshes bakés stockent l'index de leur probe assignée dans UV8.
        Vector4[] dataArray = new Vector4[MAX_PROBES * 3];
        Vector4[] hdrArray = new Vector4[MAX_PROBES];

        for (int i = 0; i < probes.Length; i++)
        {
            var probe = probes[i];
            int b = i * 3;
            dataArray[b + 0] = new Vector4(probe.transform.position.x, probe.transform.position.y, probe.transform.position.z, 0f);
            dataArray[b + 1] = new Vector4(probe.bounds.min.x, probe.bounds.min.y, probe.bounds.min.z, probe.boxProjection ? 1f : 0f);
            dataArray[b + 2] = new Vector4(probe.bounds.max.x, probe.bounds.max.y, probe.bounds.max.z, probe.importance);

            hdrArray[i] = new Vector4(1f, 1f, 0f, 0f);
        }

        BakePaths.Ensure(OUTPUT_FOLDER);
        string pathPC = OUTPUT_FOLDER + ARRAY_NAME_PC + ".asset";
        string pathQuest = OUTPUT_FOLDER + ARRAY_NAME_QUEST + ".asset";

        AssetDatabase.DeleteAsset(pathPC);
        AssetDatabase.DeleteAsset(pathQuest);

        CubemapArray arrayPC = new CubemapArray(pcRes, probes.Length, pcArrayFormat, TextureCreationFlags.MipChain, pcMipCount)
        {
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Trilinear,
            name = ARRAY_NAME_PC
        };
        AssetDatabase.CreateAsset(arrayPC, pathPC);

        Texture2DArray arrayQuest = new Texture2DArray(questRes, questRes, probes.Length * 6, questFormat, TextureCreationFlags.None, 1)
        {
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Trilinear,
            name = ARRAY_NAME_QUEST
        };
        AssetDatabase.CreateAsset(arrayQuest, pathQuest);

        // Remplissage
        for (int i = 0; i < probes.Length; i++)
        {
            ReflectionProbe probe = probes[i];
            Cubemap sourceCube = probe.bakedTexture as Cubemap ?? probe.customBakedTexture as Cubemap;
            Vector4 sourceHdr = probe.textureHDRDecodeValues;
            if (sourceHdr.x <= 0f) sourceHdr = new Vector4(1f, 1f, 0f, 0f);
            _hotspotFilterMaterial.SetVector("_SourceHDRDecode", sourceHdr);

            for (int face = 0; face < 6; face++)
            {
                // PC : convert each source mip to linear SDR, compress it, then transfer the cubemap face.
                for (int mip = 0; mip < pcMipCount; mip++)
                {
                    WritePcFace(sourceCube, face, mip, arrayPC, (i * 6) + face, pcTextureFormat);
                }

                // Quest : downsampled, un seul mip
                WriteDownsampledFace(sourceCube, face, pcRes, questRes, arrayQuest, (i * 6) + face, questTexFormat,
                    _hotspotFilterMaterial);
            }
        }

        EditorUtility.SetDirty(arrayPC);
        EditorUtility.SetDirty(arrayQuest);
        AssetDatabase.SaveAssets();

        // Assignation au manager
        Undo.RecordObject(mgr, "Build Reflection Probe Arrays");
        mgr.reflectionProbeArrayPC = arrayPC;
        mgr.reflectionProbeArrayQuest = arrayQuest;
        mgr.reflectionProbeData = dataArray;
        mgr.reflectionProbeHDR = hdrArray;
        mgr.reflectionProbeCount = probes.Length;
        mgr.reflectionProbeMaxMip = probeMaxMip;
        EditorUtility.SetDirty(mgr);
        AssetDatabase.SaveAssets();

        // Uploads globaux (fallback pour les shaders qui ne passent pas par LightingManager)
        Shader.SetGlobalTexture("_UdonReflectionProbeArray", arrayPC);
        Shader.SetGlobalFloat("_UdonReflectionProbeCount", probes.Length);
        Shader.SetGlobalFloat("_UdonReflectionProbeMaxMip", probeMaxMip);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeData", dataArray);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeHDR", hdrArray);

        Debug.Log($"[ReflectionProbeBuilder] Success – PC {pcRes}px, Quest {questRes}px, {probes.Length} probes dans {OUTPUT_FOLDER}.");
        ResetTempBuffers();
        ReflectionProbeAssignmentPreview.Refresh();
    }

    private static void WritePcFace(
        Cubemap source, int face, int mip, CubemapArray destination, int dstElement, TextureFormat compressionFormat)
    {
        int resolution = Mathf.Max(1, source.width >> mip);
        EnsureSourceFace(source, resolution);
        Graphics.CopyTexture(source, face, mip, _tempSrcFace, 0, 0);

        RenderTexture output = RenderTexture.GetTemporary(
            resolution, resolution, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear);
        RenderTexture previousActive = RenderTexture.active;
        try
        {
            Graphics.Blit(_tempSrcFace, output, _hotspotFilterMaterial);

            if (_tempPcFace == null || _tempPcFace.width != resolution)
            {
                if (_tempPcFace != null) Object.DestroyImmediate(_tempPcFace);
                _tempPcFace = new Texture2D(resolution, resolution, TextureFormat.RGBA32, false, true);
            }

            RenderTexture.active = output;
            _tempPcFace.ReadPixels(new Rect(0, 0, resolution, resolution), 0, 0, false);
            _tempPcFace.Apply(false, false);

            if (_tempPcCompressedFace != null)
                Object.DestroyImmediate(_tempPcCompressedFace);
            _tempPcCompressedFace = new Texture2D(resolution, resolution, TextureFormat.RGBA32, false, true);
            Graphics.CopyTexture(_tempPcFace, _tempPcCompressedFace);
            EditorUtility.CompressTexture(_tempPcCompressedFace, compressionFormat, TextureCompressionQuality.Best);
            _tempPcCompressedFace.Apply(false, false);

            Graphics.CopyTexture(_tempPcCompressedFace, 0, 0, destination, dstElement, mip);
        }
        finally
        {
            RenderTexture.active = previousActive;
            RenderTexture.ReleaseTemporary(output);
        }
    }

    private static void EnsureSourceFace(Cubemap source, int resolution)
    {
        if (_tempSrcFace != null && _tempSrcFace.width == resolution &&
            _tempSrcFace.graphicsFormat == source.graphicsFormat)
            return;

        if (_tempSrcFace != null) Object.DestroyImmediate(_tempSrcFace);
        _tempSrcFace = new Texture2D(resolution, resolution, source.graphicsFormat, TextureCreationFlags.None);
        _tempSrcFace.wrapMode = TextureWrapMode.Clamp;
    }

    private static void WriteDownsampledFace(Cubemap source, int face, int srcRes, int destRes,
        Texture2DArray destination, int dstElement, TextureFormat questTexFormat,
        Material filterMaterial)
    {
        EnsureSourceFace(source, srcRes);

        Graphics.CopyTexture(source, face, 0, _tempSrcFace, 0, 0);

        RenderTexture destRT = RenderTexture.GetTemporary(destRes, destRes, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear);
        RenderTexture previousActive = RenderTexture.active;
        try
        {
            Graphics.Blit(_tempSrcFace, destRT, filterMaterial);

            if (_tempTex == null || _tempTex.width != destRes)
            {
                if (_tempTex != null) Object.DestroyImmediate(_tempTex);
                _tempTex = new Texture2D(destRes, destRes, TextureFormat.RGBAHalf, false, true);
            }

            RenderTexture.active = destRT;
            _tempTex.ReadPixels(new Rect(0, 0, destRes, destRes), 0, 0);
            _tempTex.Apply(false);
        }
        finally
        {
            RenderTexture.active = previousActive;
            RenderTexture.ReleaseTemporary(destRT);
        }

        if (_tempQuestCompressedFace != null)
            Object.DestroyImmediate(_tempQuestCompressedFace);
        _tempQuestCompressedFace = new Texture2D(destRes, destRes, TextureFormat.RGBAHalf, false, true);
        Graphics.CopyTexture(_tempTex, _tempQuestCompressedFace);
        EditorUtility.CompressTexture(_tempQuestCompressedFace, questTexFormat, TextureCompressionQuality.Best);
        _tempQuestCompressedFace.Apply(false);
        Graphics.CopyTexture(_tempQuestCompressedFace, 0, 0, destination, dstElement, 0);
        Object.DestroyImmediate(_tempQuestCompressedFace);
        _tempQuestCompressedFace = null;
    }

    private static void EnsureFolder(string path)
    {
        string trimmed = path.TrimEnd('/');
        if (!AssetDatabase.IsValidFolder(trimmed))
        {
            string parent = System.IO.Path.GetDirectoryName(trimmed);
            string leaf = System.IO.Path.GetFileName(trimmed);
            AssetDatabase.CreateFolder(parent, leaf);
        }
    }
}