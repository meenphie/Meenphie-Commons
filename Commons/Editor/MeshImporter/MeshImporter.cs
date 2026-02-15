using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";
    
    // Adjust this to control how "far" the light travels before fading out.
    // Smaller value = Longer range.
    private const float RANGE_THRESHOLD = 0.0001f;

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
            if (mesh != null) ApplyPacking(mesh);
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();

        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        if (uv0.Count == 0) return;

        if (uv1.Count != uv0.Count)
        {
            // If UV1 is missing, we might want to just pack UV0 and zeros, 
            // but for now, we follow your logic to skip.
            return;
        }

        List<Vector4> packedUVs = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
        {
            packedUVs.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));
        }

        mesh.SetUVs(0, packedUVs);
    }

    // --- Dynamic Light Range Calculation ---
    void OnPostprocessGameObjectWithUserProperties(GameObject g, string[] names, object[] values)
    {
        Light light = g.GetComponent<Light>();
        if (light == null) return;

        // 1. Scale intensity from Blender's high values to Unity's range
        // Blender lights (Watts) are usually ~100x stronger than Unity intensity.
        light.intensity *= 0.01f;

        // 2. Set to Baked for your specular light system
        light.lightmapBakeType = LightmapBakeType.Baked;

        // 3. CALCULATE RANGE BASED ON INTENSITY
        // Range = Sqrt(Intensity / Threshold)
        // This ensures a 1000W light has a much larger range than a 10W light.
        float calculatedRange = Mathf.Sqrt(light.intensity / RANGE_THRESHOLD);
        
        // Clamp the range to reasonable values (e.g., minimum 1m, maximum 100m)
        light.range = Mathf.Clamp(calculatedRange, 1.0f, 100.0f);

        // 4. Handle Shadow Radius / Size
        for (int i = 0; i < names.Length; i++)
        {
            if (names[i] == "shadow_radius")
            {
                float radius = (float)values[i] * 0.1f;
                SetLightSize(light, radius);
            }
        }
        
        // Debugging to see your results in the console
        // Debug.Log($"{TAG} Light {g.name}: Intensity {light.intensity}, Calculated Range: {light.range}");
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