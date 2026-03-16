using UnityEngine;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine.Rendering.PostProcessing;
using VRC.SDK3.Components;
using VRC.SDKBase;

namespace Meenphie.Commons
{
    public class PostProcessingInitializer : IActiveBuildTargetChanged
    {
        // Required by IActiveBuildTargetChanged
        public int callbackOrder => 0;

        // Called whenever the active build target changes
        public void OnActiveBuildTargetChanged(BuildTarget previousTarget, BuildTarget newTarget)
        {
            UpdatePostProcessingSettings();
        }

        private static void UpdatePostProcessingSettings()
        {
            var sceneDescriptor = Object.FindObjectOfType<VRCSceneDescriptor>(true);
            var refCam = sceneDescriptor.ReferenceCamera;
            var postProcessLayer = refCam.GetComponent<PostProcessLayer>();
            var postProcessVolumes = Object.FindObjectsOfType<PostProcessVolume>(true);

#if UNITY_ANDROID
        SetPostProcessingSettings(false, "EditorOnly", postProcessLayer, postProcessVolumes);
        Debug.Log($"[<color=purple>Meenphie</color>] Post-processing Disabled");
#else
            SetPostProcessingSettings(true, "Untagged", postProcessLayer, postProcessVolumes);
            Debug.Log($"[<color=purple>Meenphie</color>] Post-processing Enabled");
#endif
        }

        private static void SetPostProcessingSettings(bool enable, string tag, PostProcessLayer layer, PostProcessVolume[] volumes)
        {
            if (layer != null)
            {
                layer.tag = tag;
                layer.enabled = enable;
            }

            foreach (var volume in volumes)
            {
                if (volume != null && volume.tag != tag)
                {
                    volume.tag = tag;
                }
            }
        }
    }
}