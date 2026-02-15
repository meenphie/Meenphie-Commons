using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    void OnPreprocessModel()
    {
        ModelImporter importer = (ModelImporter)assetImporter;
        if (importer == null) return;

        importer.useFileUnits = true; // Match Blender 1m = 1m
        importer.generateSecondaryUV = false; // Do NOT let Unity repack
        importer.optimizeMeshVertices = false;
        importer.meshCompression = ModelImporterMeshCompression.Off;
    }

    void OnPostprocessModel(GameObject gameObject)
    {
        // 1. Pack UVs and Reset Renderers
        foreach (MeshRenderer renderer in gameObject.GetComponentsInChildren<MeshRenderer>(true))
        {
            MeshFilter filter = renderer.GetComponent<MeshFilter>();
            if (filter != null && filter.sharedMesh != null)
            {
                ApplyPacking(filter.sharedMesh);
            }

            // --- THE FIX ---
            // This forces Unity to use your 0-1 layout as the FULL lightmap
            SerializedObject so = new SerializedObject(renderer);
            so.FindProperty("m_ScaleInLightmap").floatValue = 1.0f; 
            // We can't easily set the final atlas offset here because 
            // Unity calculates it during the Bake, but setting Scale to 1 
            // is the first step to preventing shrinking.
            so.ApplyModifiedProperties();
        }

        // 2. Handle Lights
        foreach (Light light in gameObject.GetComponentsInChildren<Light>(true))
        {
            ProcessLight(light);
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();
        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        if (uv0.Count == 0 || uv1.Count != uv0.Count) return;

        List<Vector4> packedUVs = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
        {
            packedUVs.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));
        }

        mesh.SetUVs(0, packedUVs);
        mesh.SetUVs(1, uv1); // Keep original UV1 for Unity's tools
    }

    private void ProcessLight(Light light)
    {
        light.intensity *= 0.01f;
        light.lightmapBakeType = LightmapBakeType.Baked;
        
        // Intensity-to-Range calculation
        float calculatedRange = Mathf.Sqrt(light.intensity / 0.0001f);
        light.range = Mathf.Clamp(calculatedRange, 1.0f, 100.0f);
    }
}