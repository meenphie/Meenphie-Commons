using UnityEditor;
using UnityEngine;
using System.Linq;
using UnityEngine.Experimental.Rendering;
using Meenphie.Commons;

public class ReflectionProbeArrayBuilder : EditorWindow
{
    private const string OUTPUT_FOLDER = "Assets/ReflectionProbes/";
    private const string ARRAY_ASSET_NAME = "ReflectionProbeArray.asset";
    private const int MAX_PROBES = 16;

    [MenuItem("Meenphie/Reflection Probes/Build Array")]
    public static void Build()
    {
        // 0. Manager check
        LightingManager mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr == null)
        {
            Debug.LogError("[ReflectionProbeBuilder] Aucun LightingManager trouvé dans la scène.");
            return;
        }

        // 1. Gather probes (sorted by name for stable order)
#if UNITY_2023_1_OR_NEWER
        var probes = Object.FindObjectsByType<ReflectionProbe>(FindObjectsSortMode.InstanceID)
#else
        var probes = Object.FindObjectsOfType<ReflectionProbe>()
#endif
            .Where(p => p.bakedTexture != null || p.customBakedTexture != null)
            .OrderBy(p => p.name, System.StringComparer.OrdinalIgnoreCase)
            .ToArray();

        if (probes.Length == 0)
        {
            Debug.LogWarning("[ReflectionProbeBuilder] Aucune Reflection Probe bakée trouvée.");
            return;
        }

        if (probes.Length > MAX_PROBES)
        {
            Debug.LogError($"[ReflectionProbeBuilder] Trop de probes ({probes.Length}), max {MAX_PROBES}.");
            return;
        }

        // Warn on duplicates
        var dupes = probes.GroupBy(p => p.name, System.StringComparer.OrdinalIgnoreCase)
                           .Where(g => g.Count() > 1)
                           .Select(g => g.Key)
                           .ToList();
        if (dupes.Count > 0)
            Debug.LogWarning("[ReflectionProbeBuilder] Noms de probes en doublon (ambigu) : " + string.Join(", ", dupes));

        // 2. Validate cubemap format from first probe
        Cubemap firstCube = probes[0].bakedTexture as Cubemap ?? probes[0].customBakedTexture as Cubemap;
        if (firstCube == null)
        {
            Debug.LogError($"[ReflectionProbeBuilder] La première probe '{probes[0].name}' n'a pas un Cubemap valide.");
            return;
        }

        int res = firstCube.width;
        GraphicsFormat gFormat = firstCube.graphicsFormat;
        int mipCount = firstCube.mipmapCount;

        Debug.Log($"[ReflectionProbeBuilder] Format : {gFormat} | Res : {res}x{res} | MipLevels : {mipCount}");

        foreach (var p in probes)
        {
            Cubemap cube = p.bakedTexture as Cubemap ?? p.customBakedTexture as Cubemap;
            if (cube == null || cube.width != res || cube.graphicsFormat != gFormat)
            {
                Debug.LogError($"[ReflectionProbeBuilder] Probe '{p.name}' incohérente avec la première probe. Abandon.");
                return;
            }
        }

        // 3. Create a Texture2DArray (not CubemapArray) to match the shader's 2D array sampling
        //    Slices are arranged as: probe0_face0, probe0_face1, ..., probe0_face5,
        //                          probe1_face0, ...
        //    This matches _UdonSampleProbeFaceArray: slice = probeIndex * 6 + face.
        EnsureFolder(OUTPUT_FOLDER);
        string assetPath = OUTPUT_FOLDER + ARRAY_ASSET_NAME;
        AssetDatabase.DeleteAsset(assetPath);

        // MipChain flag is required if we need mipmaps
        TextureCreationFlags flags = mipCount > 1 ? TextureCreationFlags.MipChain : TextureCreationFlags.None;

        Texture2DArray texArray = new Texture2DArray(
            res,
            res,
            probes.Length * 6,   // each cubemap expands to 6 2D slices
            gFormat,
            flags,
            mipCount
        );

        texArray.wrapMode = TextureWrapMode.Clamp;
        texArray.filterMode = FilterMode.Trilinear;
        texArray.name = System.IO.Path.GetFileNameWithoutExtension(ARRAY_ASSET_NAME);

        AssetDatabase.CreateAsset(texArray, assetPath);

        // 4. Copy each face of each cubemap to its dedicated slice in the 2D array
        Vector4[] dataArray = new Vector4[MAX_PROBES * 3];
        Vector4[] hdrArray = new Vector4[MAX_PROBES];

        for (int i = 0; i < probes.Length; i++)
        {
            ReflectionProbe probe = probes[i];
            Cubemap sourceCube = probe.bakedTexture as Cubemap ?? probe.customBakedTexture as Cubemap;

            for (int face = 0; face < 6; face++)
            {
                // slice index = probeIndex * 6 + face
                int dstElement = i * 6 + face;

                for (int mip = 0; mip < mipCount; mip++)
                {
                    // Copy from cubemap face to 2D array slice
                    Graphics.CopyTexture(
                        sourceCube, face, mip,        // source cubemap face & mip
                        texArray, dstElement, mip     // destination slice & mip
                    );
                }
            }

            // Fill uniform arrays (unchanged)
            int b = i * 3;
            dataArray[b + 0] = new Vector4(probe.transform.position.x, probe.transform.position.y, probe.transform.position.z, 0f);
            dataArray[b + 1] = new Vector4(probe.bounds.min.x, probe.bounds.min.y, probe.bounds.min.z, probe.boxProjection ? 1f : 0f);
            dataArray[b + 2] = new Vector4(probe.bounds.max.x, probe.bounds.max.y, probe.bounds.max.z, 0f);

            Vector4 hdrDecode = probe.textureHDRDecodeValues;
            if (hdrDecode.x <= 0f) hdrDecode = new Vector4(1f, 1f, 0f, 0f);
            hdrArray[i] = hdrDecode;
        }

        EditorUtility.SetDirty(texArray);
        AssetDatabase.SaveAssets();

        // 5. Wire to LightingManager
        Undo.RecordObject(mgr, "Build Reflection Probe Array");
        mgr.reflectionProbeArray = texArray;   // now a Texture2DArray
        mgr.reflectionProbeData = dataArray;
        mgr.reflectionProbeHDR = hdrArray;
        mgr.reflectionProbeCount = probes.Length;
        EditorUtility.SetDirty(mgr);
        AssetDatabase.SaveAssets();

        // 6. Immediate editor preview
        Shader.SetGlobalTexture("_UdonReflectionProbeArray", texArray);
        Shader.SetGlobalFloat("_UdonReflectionProbeCount", probes.Length);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeData", dataArray);
        Shader.SetGlobalVectorArray("_UdonReflectionProbeHDR", hdrArray);

        Debug.Log($"[ReflectionProbeBuilder] Succès! Texture2DArray construit ({probes.Length} probes, {gFormat}, {res}x{res}, {mipCount} mips, slices total={probes.Length * 6}). Assigné à '{mgr.name}'.");
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