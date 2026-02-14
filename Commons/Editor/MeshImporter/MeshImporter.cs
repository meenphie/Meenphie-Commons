using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    // 1. Configuration du Mesh (Tangentes + Optimisation)
    void OnPreprocessModel()
    {
        ModelImporter importer = (ModelImporter)assetImporter;
        if (importer == null) return;

        importer.importTangents = ModelImporterTangents.CalculateMikk;
        importer.generateSecondaryUV = false;
    }

    // 2. Packing UV (UV0.zw = UV1) tout en gardant UV1
    void OnPostprocessModel(GameObject g)
    {
        foreach (MeshFilter filter in g.GetComponentsInChildren<MeshFilter>())
        {
            Mesh mesh = filter.sharedMesh;
            if (mesh != null) ApplyPacking(mesh);
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        // Use lists to grab the data
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();

        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        // If UV1 is missing, we can't pack. 
        // If counts differ, the mesh was likely split/optimized during import.
        if (uv1.Count == 0 || uv0.Count != uv1.Count)
        {
            Debug.LogWarning($"{TAG} Skipping {mesh.name}: UV count mismatch ({uv0.Count} vs {uv1.Count})");
            return;
        }

        Vector4[] packedUVs = new Vector4[uv0.Count];
        for (int i = 0; i < uv0.Count; i++)
        {
            // Add a small bias or check if the scale is inverted (Blender Y is often 1-v)
            packedUVs[i] = new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y);
        }
        

        mesh.SetUVs(0, packedUVs);

    }

    // 3. Correction des Lumières (Trop fortes à l'import)
    void OnPostprocessGameObjectWithUserProperties(GameObject g, string[] names, object[] values)
    {
        Light light = g.GetComponent<Light>();
        if (light != null)
        {
            // 1. Correction de l'intensité (0.1f comme convenu)
            light.intensity *= 0.01f;
            light.lightmapBakeType = LightmapBakeType.Baked;
            light.range = 500f;

            // 2. Récupération du Shadow Radius (Custom Property de Blender)
            for (int i = 0; i < names.Length; i++)
            {
                if (names[i] == "shadow_radius")
                {
                    float radius = (float)values[i] * 0.1f;

                    // Dans Unity (Progressive CPU/GPU), cela correspond au "Light Size" 
                    // pour avoir des ombres douces (Soft Shadows) en baked.
                    // Attention: Propriété uniquement utilisée pour le baking.
                    // Note: shadowRadius n'existe pas directement en API simple hors SerializedObject
                    // mais on peut utiliser le "Baking Output" ou un SerializedObject.

                    SetLightSize(light, radius);
                    Debug.Log($"{TAG} Light <b>{light.name}</b> | Shadow Radius appliqué : {radius}");
                }
            }
        }
    }

    private void SetLightSize(Light light, float size)
    {
        if (light.type == LightType.Directional)
        {
            // Pour le soleil : on utilise l'angle (ex: 0.5)
            light.shadowAngle = size;
        }
        else
        {
            // Pour Point/Spot : on utilise le rayon (ex: 0.1)
            // C'est ce qui donnera des ombres douces en Baked
            light.shadowRadius = size;
        }
    }
}