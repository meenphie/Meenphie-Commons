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

        importer.generateSecondaryUV = false;
    }

    void OnPostprocessModel(GameObject gameObject)
    {
        foreach (MeshFilter filter in gameObject.GetComponentsInChildren<MeshFilter>())
        {
            Mesh mesh = filter.sharedMesh;
            ApplyPacking(mesh);
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();

        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        // Check if UV0 exists first
        if (uv0.Count == 0) return;

        // Fix: Check if uv1 has the SAME count as uv0
        if (uv1.Count != uv0.Count)
        {
            Debug.LogWarning($"{TAG} Skipping {mesh.name}: UV1 count ({uv1.Count}) does not match UV0 count ({uv0.Count}).");
            return;
        }

        // Use Vector4 to pack (U0, V0, U1, V1)
        List<Vector4> packedUVs = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
        {
            packedUVs.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));
        }

        // Set the packed data back to channel 0
        mesh.SetUVs(0, packedUVs);
    }

    // 3. Lights
    void OnPostprocessGameObjectWithUserProperties(GameObject g, string[] names, object[] values)
    {
        Light light = g.GetComponent<Light>();

        light.intensity *= 0.01f;
        light.lightmapBakeType = LightmapBakeType.Baked;
        light.range = 500f;

        for (int i = 0; i < names.Length; i++)
        {
            if (names[i] == "shadow_radius")
            {
                float radius = (float)values[i] * 0.1f;

                SetLightSize(light, radius);
            }
        }
    }

    private void SetLightSize(Light light, float size)
    {
        if (light.type == LightType.Directional)
        {
            light.shadowAngle = size;
        }
        else
        {
            light.shadowRadius = size;
        }
    }
}