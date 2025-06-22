using UnityEditor;
using UnityEngine;

public static class LightmapDebugGlobalToggle
{
    private const string Keyword = "_LIGHTMAP_DEBUG_MODE_ON"; // replace with your actual keyword

    private static bool isEnabled = false;

    [MenuItem("Meenphie/Toggle Lightmap Debug Mode")]
    public static void Toggle()
    {
        isEnabled = !isEnabled;

        if (isEnabled)
        {
            Shader.EnableKeyword(Keyword);
            Debug.Log("[Meenphie] Enabled Lightmap Debug Mode");
        }
        else
        {
            Shader.DisableKeyword(Keyword);
            Debug.Log("[Meenphie] Disabled Lightmap Debug Mode");
        }
    }
}
