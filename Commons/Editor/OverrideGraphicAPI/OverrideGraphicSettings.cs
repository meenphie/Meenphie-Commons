using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

[InitializeOnLoad]
[DefaultExecutionOrder(10000)]
public class OverrideGraphicSettings
{

    static OverrideGraphicSettings()
    {
        EditorApplication.update += EditorUpdate;
    }

    private static void EditorUpdate()
    {
        if (EditorApplication.isPlayingOrWillChangePlaymode || EditorApplication.isUpdating) return;

        if (PlayerSettings.GetUseDefaultGraphicsAPIs(BuildTarget.StandaloneLinux64) ||
            PlayerSettings.GetUseDefaultGraphicsAPIs(BuildTarget.Android))
        {
            //SetGraphicsAPI();

            EditorApplication.update -= EditorUpdate;
        }
    }

    private static void SetGraphicsAPI()
    {
        PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneLinux64, false);
        PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.Android, false);

        PlayerSettings.SetGraphicsAPIs(BuildTarget.StandaloneLinux64, new[] { GraphicsDeviceType.Vulkan });
        PlayerSettings.SetGraphicsAPIs(BuildTarget.Android, new[] { GraphicsDeviceType.Vulkan });
    }

}
