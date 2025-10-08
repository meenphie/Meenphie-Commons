using UnityEditor;
using UnityEngine;

public static class LightmapDebugger
{
    private const string Keyword = "_LIGHTMAPDEBUG";
    private const string LIGHTMAPLERP = "_LIGHTMAPLERP";

    private static bool isEnabled = false;
    private static bool isLerpEnabled = false;

    // --- EXISTING MENU ---
    [MenuItem("Meenphie/Lightmaps/Lightmaps Only")]
    public static void ToggleLightmapsOnly()
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

    // --- NEW MENU ---
    [MenuItem("Meenphie/Lightmaps/Toggle Lightmaps Lerp")]
    public static void ToggleLightmapLerp()
    {
        // Get current value (default to 0 if not set)
        float current = Shader.GetGlobalFloat(LIGHTMAPLERP);

        // Toggle between 0 and 1
        float newValue = Mathf.Approximately(current, 0f) ? 1f : 0f;

        Shader.SetGlobalFloat(LIGHTMAPLERP, newValue);

        isLerpEnabled = !Mathf.Approximately(newValue, 0f);

        string state = isLerpEnabled ? "enabled" : "disabled";
        Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Lerp is {state} (value = {newValue})");
    }
}
