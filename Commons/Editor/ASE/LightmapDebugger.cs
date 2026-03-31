using UnityEditor;
using UnityEngine;
using System.Collections.Generic;

public static class LightmapDebugger
{
    private const string Keyword = "_LIGHTMAPDEBUG";
    private const string LIGHTMAPLERP = "_UdonLightmapLerp";

    [MenuItem("Meenphie/Lightmaps/Lightmaps Only")]
    public static void ToggleLightmapsOnly()
    {
        bool currentlyActive = Shader.IsKeywordEnabled(Keyword);

        if (currentlyActive)
        {
            Shader.DisableKeyword(Keyword);
            Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Only: <color=red>OFF</color>");
        }
        else
        {
            Shader.EnableKeyword(Keyword);
            Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Only: <color=green>ON</color>");
        }
    }

    [MenuItem("Meenphie/Lightmaps/Toggle Lightmaps Lerp")]
    public static void ToggleLightmapLerp()
    {
        MeshRenderer[] renderers = GameObject.FindObjectsOfType<MeshRenderer>();
        HashSet<Material> processedMaterials = new HashSet<Material>();

        float newValue = 0f;
        bool valueDetermined = false;

        // 1. Determine target value based on the first valid material found
        foreach (var renderer in renderers)
        {
            foreach (var mat in renderer.sharedMaterials)
            {
                if (mat != null && mat.HasProperty(LIGHTMAPLERP))
                {
                    newValue = (mat.GetFloat(LIGHTMAPLERP) > 0.5f) ? 0f : 1f;
                    valueDetermined = true;
                    break;
                }
            }
            if (valueDetermined) break;
        }

        if (!valueDetermined) return;

        // 2. Apply with Undo support and uniqueness check
        foreach (var renderer in renderers)
        {
            foreach (var mat in renderer.sharedMaterials)
            {
                if (mat != null && mat.HasProperty(LIGHTMAPLERP) && !processedMaterials.Contains(mat))
                {
                    Undo.RecordObject(mat, "Toggle Lightmap Lerp");
                    mat.SetFloat(LIGHTMAPLERP, newValue);
                    EditorUtility.SetDirty(mat);
                    processedMaterials.Add(mat);
                }
            }
        }

        AssetDatabase.SaveAssets();

        string state = (newValue > 0.5f) ? "<color=green>ON</color>" : "<color=red>OFF</color>";
        Debug.Log($"[<color=purple>Meenphie</color>] {processedMaterials.Count} unique materials updated. Lightmaps Lerp: {state}");
    }
}