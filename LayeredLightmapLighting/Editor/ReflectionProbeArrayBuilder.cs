using UnityEditor;
using UnityEngine;
using System.Linq;
using UnityEngine.Experimental.Rendering;
using Meenphie.Commons;

public class ReflectionProbeArrayBuilder : EditorWindow
{
    private const string OUTPUT_FOLDER = "Assets/Lighting/";
    private const string ARRAY_NAME_PC = "ReflectionProbeArray_PC";
    private const string ARRAY_NAME_QUEST = "ReflectionProbeArray_Quest";
    private const int MAX_PROBES = 16;

    private static Texture2D _tempSrcFace;
    private static Texture2D _tempTex;

    private static void ResetTempBuffers()
    {
        if (_tempSrcFace != null) { Object.DestroyImmediate(_tempSrcFace); _tempSrcFace = null; }
        if (_tempTex != null) { Object.DestroyImmediate(_tempTex); _tempTex = null; }
    }

    [MenuItem("Meenphie/Layered Lighting/Build Reflection Probes Array")]
    public static void Build()
    {
        ResetTempBuffers();
        LightingManager mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr == null) { Debug.LogError("Aucun LightingManager trouvé dans la scène."); return; }

        var probes = Object.FindObjectsOfType<ReflectionProbe>()
            .Where(p => p.bakedTexture != null || p.customBakedTexture != null)
            .OrderBy(p => p.name, System.StringComparer.OrdinalIgnoreCase)
            .ToArray();

        if (probes.Length == 0) { Debug.LogWarning("Aucune reflection probe bakée n'a été trouvée."); return; }
        if (probes.Length > MAX_PROBES) { Debug.LogError($"Trop de probes ({probes.Length}), la limite est fixée à {MAX_PROBES}."); return; }

        Cubemap firstCube = probes[0].bakedTexture as Cubemap ?? probes[0].customBakedTexture as Cubemap;
        if (firstCube == null) { Debug.LogError("La première probe est invalide."); return; }

        int pcRes = firstCube.width;
        int pcMipCount = firstCube.mipmapCount;

        GraphicsFormat pcFormat = firstCube.graphicsFormat;
        Debug.Log($"Format PC source : {pcFormat} | Res : {pcRes} | Mips : {pcMipCount}");

        for (int i = 1; i < probes.Length; i++)
        {
            var p = probes[i];
            Cubemap cube = p.bakedTexture as Cubemap ?? p.customBakedTexture as Cubemap;
            if (cube == null) { Debug.LogError($"Probe '{p.name}' invalide."); return; }
            if (cube.width != pcRes) { Debug.LogError($"Probe '{p.name}' résolution incompatible."); return; }
            if (cube.mipmapCount > pcMipCount) { Debug.LogError($"Probe '{p.name}' possède trop de mips."); return; }
            if (cube.graphicsFormat != pcFormat) { Debug.LogError($"Probe '{p.name}' format différent ({cube.graphicsFormat} au lieu de {pcFormat})."); return; }
        }

        int questRes = Mathf.Max(1, pcRes / 2);
        GraphicsFormat questFormat;
        TextureFormat questTexFormat;

        if (SystemInfo.SupportsTextureFormat(TextureFormat.BC7))
        {
            questFormat = GraphicsFormat.RGBA_BC7_UNorm;
            questTexFormat = TextureFormat.BC7;
        }
        else
        {
            questFormat = GraphicsFormat.RGBA_DXT5_SRGB;
            questTexFormat = TextureFormat.DXT5;
            Debug.LogWarning("Quest : Format BC7 non supporté par la plateforme actuelle, utilisation de DXT5.");
        }

        // Un seul Vector4 par probe : position monde (xyz), w inutilisé.
        // La sélection est faite per-pixel dans le shader par distance au centre.
        Vector4[] dataArray = new Vector4[MAX_PROBES * 3];
        Vector4[] hdrArray = new Vector4[MAX_PROBES];

        for (int i = 0; i < probes.Length; i++)
        {
            var probe = probes[i];
            int b = i * 3;
            dataArray[b + 0] = new Vector4(probe.transform.position.x, probe.transform.position.y, probe.transform.position.z, 0f);
            dataArray[b + 1] = new Vector4(probe.bounds.min.x, probe.bounds.min.y, probe.bounds.min.z, probe.boxProjection ? 1f : 0f);
            dataArray[b + 2] = new Vector4(probe.bounds.max.x, probe.bounds.max.y, probe.bounds.max.z, 0f);

            Vector4 hdr = probe.textureHDRDecodeValues;
            if (hdr.x <= 0f) hdr = new Vector4(1f, 1f, 0f, 0f);
            hdrArray[i] = hdr;
        }

        EnsureFolder(OUTPUT_FOLDER);
        string pathPC = OUTPUT_FOLDER + ARRAY_NAME_PC + ".asset";
        string pathQuest = OUTPUT_FOLDER + ARRAY_NAME_QUEST + ".asset";

        AssetDatabase.DeleteAsset(pathPC);
        AssetDatabase.DeleteAsset(pathQuest);

        CubemapArray arrayPC = new CubemapArray(pcRes, probes.Length, pcFormat, TextureCreationFlags.MipChain, pcMipCount)
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

            for (int face = 0; face < 6; face++)
            {
                // PC : copie directe avec chaîne de mips complète
                for (int mip = 0; mip < pcMipCount; mip++)
                {
                    Graphics.CopyTexture(
                        sourceCube,
                        face,
                        mip,
                        arrayPC,
                        (i * 6) + face,
                        mip
                    );
                }

                // Quest : downsampled, un seul mip
                WriteDownsampledFace(sourceCube, face, pcRes, questRes, arrayQuest, (i * 6) + face, questFormat, questTexFormat);
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
        mgr.reflectionProbeMaxMip = pcMipCount - 1;
        EditorUtility.SetDirty(mgr);
        AssetDatabase.SaveAssets();

        // Uploads globaux (fallback pour les shaders qui ne passent pas par LightingManager)
        Shader.SetGlobalTexture("_UdonReflectionProbeArray", arrayPC);
        Shader.SetGlobalFloat("_UdonReflectionProbeCount", probes.Length);
        Shader.SetGlobalFloat("_UdonReflectionProbeMaxMip", pcMipCount - 1);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeData", dataArray);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeHDR", hdrArray);

        Debug.Log($"[ReflectionProbeBuilder] Success – PC {pcRes}px, Quest {questRes}px, {probes.Length} probes dans {OUTPUT_FOLDER}.");
        ResetTempBuffers();
    }

    private static void WriteDownsampledFace(Cubemap source, int face, int srcRes, int destRes,
        Texture2DArray destination, int dstElement, GraphicsFormat targetFormat, TextureFormat questTexFormat)
    {
        if (_tempSrcFace == null || _tempSrcFace.width != srcRes)
        {
            if (_tempSrcFace != null) Object.DestroyImmediate(_tempSrcFace);
            _tempSrcFace = new Texture2D(srcRes, srcRes, source.graphicsFormat, TextureCreationFlags.None);
        }

        Graphics.CopyTexture(source, face, 0, _tempSrcFace, 0, 0);

        RenderTexture destRT = RenderTexture.GetTemporary(destRes, destRes, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear);
        Graphics.Blit(_tempSrcFace, destRT);

        if (_tempTex == null || _tempTex.width != destRes)
        {
            if (_tempTex != null) Object.DestroyImmediate(_tempTex);
            _tempTex = new Texture2D(destRes, destRes, TextureFormat.RGBAHalf, false, true);
        }

        RenderTexture.active = destRT;
        _tempTex.ReadPixels(new Rect(0, 0, destRes, destRes), 0, 0);
        _tempTex.Apply(false);
        RenderTexture.active = null;
        RenderTexture.ReleaseTemporary(destRT);

        if (GraphicsFormatUtility.IsCompressedFormat(targetFormat))
        {
            EditorUtility.CompressTexture(_tempTex, questTexFormat, TextureCompressionQuality.Best);
            _tempTex.Apply(false);
        }

        Graphics.CopyTexture(_tempTex, 0, 0, destination, dstElement, 0);
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