using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering.PostProcessing;

[InitializeOnLoad]
public class PostProcessingInitializer
{
    static PostProcessingInitializer()
    {
        UpdatePostProcessingSettings();
    }

    private static void UpdatePostProcessingSettings()
    {
        var postProcessLayers = Object.FindObjectsOfType<PostProcessLayer>(true);
        var postProcessVolumes = Object.FindObjectsOfType<PostProcessVolume>(true);

#if UNITY_ANDROID || UNITY_IOS
        SetPostProcessingSettings(false, "EditorOnly", postProcessLayers, postProcessVolumes);
        Debug.Log("Post-processing is: <color=red>Disabled</color>");
#else
        SetPostProcessingSettings(true, "Untagged", postProcessLayers, postProcessVolumes);
        Debug.Log("Post-processing is: <color=green>Enabled</color>");
#endif
    }

    private static void SetPostProcessingSettings(bool enable, string tag, PostProcessLayer[] layers, PostProcessVolume[] volumes)
    {
        foreach (var layer in layers)
        {
            if (layer.enabled != enable || layer.tag != tag)
            {
                layer.tag = tag;
                layer.enabled = enable;
            }
        }

        foreach (var volume in volumes)
        {
            if (volume.tag != tag)
            {
                volume.tag = tag;
            }
        }
    }
}
