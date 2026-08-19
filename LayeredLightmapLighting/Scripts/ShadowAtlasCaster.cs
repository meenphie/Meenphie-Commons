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

        [Header("Render Texture")]
        public RenderTexture shadowMap;

        [Header("Shader de Remplacement")]
        public Shader shadowCasterShader;

        private int _shadowViewMatrixID;
        private int _shadowProjectionMatrixID;
        private int _lightViewMatrixID;
        private int _lightNearID;
        private int _lightFarID;
        private int _shadowMap_ID;
        private bool _initialized = false;

        private Transform _currentParent;
        private bool _shadowRenderingEnabled = true;

        void OnDisable()
        {
            if (shadowMap != null)
                shadowMap.Release();
        }

        void Start()
        {
            _shadowViewMatrixID = VRCShader.PropertyToID("_UdonShadowViewMatrix");
            _shadowProjectionMatrixID = VRCShader.PropertyToID("_UdonShadowProjectionMatrix");
            _lightViewMatrixID = VRCShader.PropertyToID("_UdonLightViewMatrix");
            _lightNearID = VRCShader.PropertyToID("_Udon_LightNear");
            _lightFarID = VRCShader.PropertyToID("_Udon_LightFar");
            _shadowMap_ID = VRCShader.PropertyToID("_UdonShadowMap");

            _initialized = true;

            shadowCamera.depth = -100f;
            shadowCamera.SetReplacementShader(shadowCasterShader, "RenderType");

            shadowCamera.targetTexture = shadowMap;
            shadowCamera.enabled = true;

            VRCShader.SetGlobalTexture(_shadowMap_ID, shadowMap);
            VRCShader.SetGlobalMatrix(_shadowViewMatrixID, Matrix4x4.identity);
            VRCShader.SetGlobalMatrix(_shadowProjectionMatrixID, Matrix4x4.identity);
            VRCShader.SetGlobalMatrix(_lightViewMatrixID, Matrix4x4.identity);

            VRCShader.SetGlobalFloat(_lightNearID, shadowCamera.nearClipPlane);
            VRCShader.SetGlobalFloat(_lightFarID, shadowCamera.farClipPlane);

            UpdateShadowMatrices();
        }

        public void UpdateShadowMatrices()
        {
            if (!_initialized) return;
            if (lightingManager == null || shadowCamera == null || !_shadowRenderingEnabled)
                return;

            Transform lightT = lightingManager.GetShadowSlotTransform(0);
            if (lightT == null)
            {
                _currentParent = null;
                return;
            }

            if (lightT != _currentParent)
            {
                shadowCamera.transform.SetParent(lightT, false);
                shadowCamera.transform.localPosition = Vector3.zero;
                shadowCamera.transform.localRotation = Quaternion.identity;
                _currentParent = lightT;
            }

            Matrix4x4 viewMatrix = shadowCamera.worldToCameraMatrix;
            Matrix4x4 projMatrix = shadowCamera.projectionMatrix;

            VRCShader.SetGlobalMatrix(_shadowViewMatrixID, viewMatrix);
            VRCShader.SetGlobalMatrix(_shadowProjectionMatrixID, projMatrix);
            VRCShader.SetGlobalMatrix(_lightViewMatrixID, viewMatrix);
            VRCShader.SetGlobalFloat(_lightNearID, shadowCamera.nearClipPlane);
            VRCShader.SetGlobalFloat(_lightFarID, shadowCamera.farClipPlane);
        }
    }
}