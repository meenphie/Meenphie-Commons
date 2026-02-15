using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";
    private const float RANGE_THRESHOLD = 0.0001f;

    void OnPreprocessModel()
    {
        ModelImporter importer = (ModelImporter)assetImporter;
        if (importer == null) return;
        importer.generateSecondaryUV = false;
    }

    void OnPostprocessModel(GameObject gameObject)
    {
        // 1. Handle Mesh Packing
        foreach (MeshFilter filter in gameObject.GetComponentsInChildren<MeshFilter>())
        {
            Mesh mesh = filter.sharedMesh;
            if (mesh != null) ApplyPacking(mesh);
        }

        // 2. Handle Lights (Intensity to Range calculation)
        // We do this here because OnPostprocessGameObjectWithUserProperties 
        // only triggers for "Custom Properties", not standard Light data.
        foreach (Light light in gameObject.GetComponentsInChildren<Light>(true))
        {
            ProcessLight(light);
        }
    }

    private void ProcessLight(Light light)
    {
        // Adjust intensity: Blender (Watts) -> Unity scale
        // Unity usually imports 40W as 40 intensity; we scale to 0.4
        light.intensity *= 0.01f;

        light.lightmapBakeType = LightmapBakeType.Baked;

        // Calculate Range based on the scaled intensity
        // For 40W -> 0.4 intensity -> ~63.2m
        float calculatedRange = Mathf.Sqrt(light.intensity / RANGE_THRESHOLD);
        light.range = Mathf.Clamp(calculatedRange, 1.0f, 100.0f);

        // Optional: Force standard shadow settings for baked lights
        light.shadows = LightShadows.Soft;
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();

        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        // Check if both channels exist and match
        if (uv0.Count == 0 || uv1.Count != uv0.Count) return;

        // 1. Pack (UV0.x, UV0.y, UV1.x, UV1.y) into a Vector4
        List<Vector4> packedUVs = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
        {
            packedUVs.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));
        }

        // 2. Set the packed data to Channel 0 for your shader
        mesh.SetUVs(0, packedUVs);

        // 3. FORCE UV1 to remain a standard Vector2 list
        // This ensures Unity's Texel Density and Lightmapper see the original layout
        mesh.SetUVs(1, uv1);
    }

    // Still useful if you use Blender's "Custom Properties" panel for extra settings
    void OnPostprocessGameObjectWithUserProperties(GameObject g, string[] names, object[] values)
    {
        Light light = g.GetComponent<Light>();
        if (light == null) return;

        for (int i = 0; i < names.Length; i++)
        {
            if (names[i] == "shadow_radius" || names[i] == "radius")
            {
                float radius = (float)values[i] * 0.1f;
                if (light.type == LightType.Directional) light.shadowAngle = radius;
                else light.shadowRadius = radius;
            }
        }
    }
}