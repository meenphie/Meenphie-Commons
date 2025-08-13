using UnityEditor;
using UnityEngine;

public static class LightmapDebugger
{
    private const string Keyword = "_LIGHTMAP_DEBUG_MODE_ON"; // replace with your actual keyword

    private static bool isEnabled = false;

    [MenuItem("Meenphie/Toggle Lightmaps Only")]
    public static void Toggle()
    {
        isEnabled = !isEnabled;

        if (isEnabled)
        {
            Shader.EnableKeyword(Keyword);
        }
        else
        {
            Shader.DisableKeyword(Keyword);
        }
    }
}
