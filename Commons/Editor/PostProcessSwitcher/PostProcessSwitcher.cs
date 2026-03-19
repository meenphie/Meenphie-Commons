using UnityEngine;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine.Rendering.PostProcessing;
using VRC.SDK3.Components;

public class PostProcessingInitializer : IActiveBuildTargetChanged
{
    public int callbackOrder => 0;

    public void OnActiveBuildTargetChanged(BuildTarget previousTarget, BuildTarget newTarget)
    {
        // On vérifie la nouvelle cible de build via l'argument 'newTarget'
        bool isAndroid = (newTarget == BuildTarget.Android);
        UpdatePostProcessingSettings(isAndroid);
    }

    private static void UpdatePostProcessingSettings(bool toAndroid)
    {
        var sceneDescriptor = Object.FindObjectOfType<VRCSceneDescriptor>(true);
        if (sceneDescriptor == null || sceneDescriptor.ReferenceCamera == null) return;

        var refCam = sceneDescriptor.ReferenceCamera;
        var postProcessLayer = refCam.GetComponent<PostProcessLayer>();
        var postProcessVolumes = Object.FindObjectsOfType<PostProcessVolume>(true);

        if (toAndroid)
        {
            // Paramètres pour Android (Désactivé)
            SetPostProcessingSettings(false, "EditorOnly", postProcessLayer, postProcessVolumes);
            Debug.Log("[<color=purple>Meenphie</color>] Switch to Android: Post-processing Disabled");
        }
        else
        {
            // Paramètres pour PC / Autres (Activé)
            SetPostProcessingSettings(true, "Untagged", postProcessLayer, postProcessVolumes);
            Debug.Log("[<color=purple>Meenphie</color>] Switch to PC: Post-processing Enabled");
        }
    }

    private static void SetPostProcessingSettings(bool enable, string tag, PostProcessLayer layer, PostProcessVolume[] volumes)
    {
        if (layer != null)
        {
            layer.gameObject.tag = tag; // On change le tag du GameObject
            layer.enabled = enable;
        }

        foreach (var volume in volumes)
        {
            if (volume != null)
            {
                volume.gameObject.tag = tag;
                volume.enabled = enable; // Optionnel : désactive aussi le composant volume
            }
        }
    }
}