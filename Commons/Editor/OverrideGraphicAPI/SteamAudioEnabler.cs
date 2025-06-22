using UnityEditor;
using UnityEngine;

[InitializeOnLoad]
public class SteamAudioEnabler
{
    static SteamAudioEnabler()
    {
        EditorApplication.update += EditorUpdate;
    }

    private static void EditorUpdate()
    {
        if(EditorApplication.isPlayingOrWillChangePlaymode || EditorApplication.isUpdating) return;
        
        if (AudioSettings.GetSpatializerPluginName() != "Steam Audio Spatializer")
        {
            //SetSpatializerPluginSettings();
            
            EditorApplication.update -= EditorUpdate;
        }
    }

    private static void SetSpatializerPluginSettings()
    {
        AudioSettings.SetSpatializerPluginName("Steam Audio Spatializer");
    }
}
