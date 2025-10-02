using UnityEditor;
using UnityEngine;

public static class LightmapDebugger
{
    private const string Keyword = "_LIGHTMAPDEBUG";

    private static bool isEnabled = false;

    [MenuItem("Meenphie/Lightmaps/Lightmaps Only")]
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

        string state = isEnabled ? "enabled" : "disabled";
        Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Only is {state}");
    }
}
