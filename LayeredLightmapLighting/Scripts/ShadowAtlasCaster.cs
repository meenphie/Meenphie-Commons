#if UDONSHARP
using UdonSharp;
#endif
using UnityEngine;
using VRC.SDKBase;

namespace Meenphie.Commons
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class ShadowAtlasCaster : UdonSharpBehaviour
    {
        public LightingManager lightingManager;
        public Camera shadowCamera;
        public Shader ShadowDepth;

        private int _shadowMatrixID;
        private Matrix4x4 _shadowMatrix = Matrix4x4.identity;
        private Transform _currentParent;

        void Start()
        {
            _shadowMatrixID = VRCShader.PropertyToID("_UdonShadowMatrix");

            if (shadowCamera != null)
            {
                RenderTexture rt = shadowCamera.targetTexture;
                if (rt != null)
                    VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonShadowMap0"), rt);

                shadowCamera.clearFlags = CameraClearFlags.SolidColor;
                shadowCamera.backgroundColor = new Color(1f, 1f, 1f, 1f);
                shadowCamera.SetReplacementShader(ShadowDepth, "");
                shadowCamera.enabled = false;
            }

            VRCShader.SetGlobalMatrix(_shadowMatrixID, _shadowMatrix);
        }

        public void UpdateShadowCameras()
        {
            if (lightingManager == null || shadowCamera == null) return;

            Transform lightT = lightingManager.GetShadowSlotTransform(0);

            if (lightT == null)
            {
                shadowCamera.enabled = false;
                _currentParent = null;
                return;
            }

            if (lightT != _currentParent)
            {
                shadowCamera.transform.SetParent(lightT, false); // axes alignés -> rien à rotate
                shadowCamera.transform.localPosition = Vector3.zero;
                shadowCamera.transform.localRotation = Quaternion.identity;
                _currentParent = lightT;
            }

            shadowCamera.enabled = true;

            _shadowMatrix = shadowCamera.projectionMatrix * shadowCamera.worldToCameraMatrix;
            VRCShader.SetGlobalMatrix(_shadowMatrixID, _shadowMatrix);
        }
    }
}