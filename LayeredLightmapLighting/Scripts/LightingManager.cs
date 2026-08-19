#if UDONSHARP
using UdonSharp;
#endif
using UnityEngine;
using VRC.SDKBase;

namespace Meenphie.Commons
{
    public enum LightFaultState { Normal, Broken, Panic, Off }

    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class LightingManager : UdonSharpBehaviour
    {
        [Range(1, MAX_LIGHTS)] public int activeSpecularCount = MAX_LIGHTS;
        [Tooltip("Global culling distance – lights beyond this are skipped on the CPU.")]
        public float rangeScale = 50f;

#if UNITY_ANDROID && !UNITY_EDITOR
        public Texture2DArray lightLayerArrayQuest;
#elif !UNITY_ANDROID && !UNITY_EDITOR
        public Texture2DArray lightLayerArrayPC;
#else
        public Texture2DArray lightLayerArrayPC;
        public Texture2DArray lightLayerArrayQuest;
#endif

        private Texture2DArray _lightLayerArray;
        public int lightmapGroupCount = 0;
        [Range(0f, 50f)] public float lodDistanceNear = 5f;
        [Range(0f, 80f)] public float lodDistanceFar = 35f;
        [Range(0f, 9f)] public float lodAtFar = 2f;

        [Header("Cookies")]
        public Texture2DArray cookieArray;
        [HideInInspector] public Texture2D[] childLightCookieTexture;
        [HideInInspector] public int[] childLightCookieSlice;
        [HideInInspector] public int[] mergedCookieSlice;

#if UNITY_ANDROID && !UNITY_EDITOR
        public Texture2DArray reflectionProbeArrayQuest;
#elif !UNITY_ANDROID && !UNITY_EDITOR
        public CubemapArray reflectionProbeArrayPC;
#else
        public CubemapArray reflectionProbeArrayPC;
        public Texture2DArray reflectionProbeArrayQuest;
#endif

        [HideInInspector] public Vector4[] reflectionProbeData;
        [HideInInspector] public Vector4[] reflectionProbeHDR;
        public int reflectionProbeCount;
        // Highest valid mip index in reflectionProbeArrayPC (pcMipCount - 1), set by
        // ReflectionProbeArrayBuilder at bake time. Drives roughness->mip selection
        // in _UdonComputeReflectionArray; must be uploaded at runtime or the shader
        // falls back to a hardcoded default (see Start()).
        [HideInInspector] public float reflectionProbeMaxMip;


        [Header("Animation – Audio Clips")]
        public AudioClip faultAudioClip;
        [Range(0f, 1f)] public float audioMasterVolume = 1.0f;

        [Header("Performance")]
        [Tooltip("Minimum time (seconds) between shader uploads.")]
        public const float UPDATE_INTERVAL = 1f / 90f;
        public const float VIEWER_UPDATE_INTERVAL = 1f / 10f;
        private float _lastUploadTime = -1f;
        private float _tickAccumDt = 0f;
        public float specCameraFadeEnd = 20f;
        public float specCullMargin = 0f;
        private int _specCameraFadeEndID;

        [Header("View Cone Culling")]
        public float fovCullAngle = 240;
        public float specularFovCullAngle = 90f;
        public float coneCullMinDistance = 15f;

        public ShadowAtlasCaster shadowAtlasCaster;
        [Header("Shadow Map Atlas")]
        [Tooltip("How many lights can hold a real-time shadow-map slot at once. Must not exceed MAX_SHADOW_SLOTS declared in the shader.")]
        [Range(0, MAX_SHADOW_SLOTS)] public int activeShadowSlots = 1;
        // slot -> merged-light index currently occupying that slice of the atlas this frame, -1 if empty.
        [HideInInspector] public int[] shadowSlotToMerged = new int[MAX_SHADOW_SLOTS];
        // merged-light index -> slot it currently owns, -1 if none. Mirror of the array above for O(1) lookup during upload.
        [HideInInspector] public int[] mergedToShadowSlot;
        [HideInInspector] public int activeShadowChildIndex = -1;


        private const int MAX_LIGHTS = 32;
        private const int MAX_SHADOW_SLOTS = 1;
        private const float MOTION_EPSILON_SQ = 0.000001f;
        private const float ROTATION_EPSILON_DOT = 0.9998477f;
        private const float COLOR_EPSILON = 0.004f;
        private const float INTENSITY_EPSILON = 0.001f;

        [Header("Performance Metrics")]
        public float avgShaderUpdatesPerSecond;
        public float avgUdonMsPerFrame;

        private float _emaShaderUpdatesPerSecond;
        private float _emaUdonMs;
        private float _lastRateUpdateTime;
        private int _shaderUpdateCounter;
        private float _instantRate;
        private const float SMOOTHING_HALF_LIFE = 0.5f;

        [Header("Light Sources (auto-filled)")]
        public Light[] childLights;

        [HideInInspector] public Vector2[] childLightHalfExtents;
        [HideInInspector] public bool[] childLightIsRealtime;
        [HideInInspector] public Vector3[] childLightBakedColors;
        public int[] childLightLayerSlices;

        [HideInInspector] public bool[] childLightDiffuseEnabled;
        [HideInInspector] public bool[] childLightSpecularDistance;
        [HideInInspector] public bool[] childLightCastsShadow;
        [HideInInspector] public LightFaultState[] childLightFaultState;
        [HideInInspector] public int[] childLightGroupIndex;
        [HideInInspector] public AudioClip[] childLightAudioClipOverride;

        [HideInInspector] public float[] childLightBrokenOnMin;
        [HideInInspector] public float[] childLightBrokenOnMax;
        [HideInInspector] public float[] childLightBrokenOffMin;
        [HideInInspector] public float[] childLightBrokenOffMax;
        [HideInInspector] public float[] childLightBrokenOnIntensity;
        [HideInInspector] public float[] childLightPanicSpeed;
        [HideInInspector] public float[] childLightPanicIntensityMin;
        [HideInInspector] public float[] childLightPanicIntensityMax;

        [HideInInspector] public Vector4[] mergedPos;
        [HideInInspector] public Vector4[] mergedCol;
        [HideInInspector] public Vector4[] mergedRight;
        [HideInInspector] public Vector4[] mergedUp;
        [HideInInspector] public Vector4[] mergedDir;
        [HideInInspector] public Vector4[] mergedBakedCol;
        [HideInInspector] public int[] mergedLayerSlice;
        [HideInInspector] public bool[] mergedDiffuseEnabled;
        [HideInInspector] public bool[] mergedSpecularEnabled;
        [HideInInspector] public LightFaultState[] mergedFaultState;
        [HideInInspector] public int[] mergedGroupMask;
        [HideInInspector] public int mergedCount;
        [HideInInspector] public float[] mergedCosInner;

        // ----- per‑merged‑light shadow casting flag -----
        [HideInInspector] public bool[] mergedCastShadow;

        private float[] _faultStateTimer;
        private bool[] _faultIsOn;
        [HideInInspector] public float[] _faultIntensity;
        private float[] _panicTargetIntensity;

        private float[] _mergedBaseIntensity;
        private float[] _mergedLastAnimated;

        private float[] _mergedBrokenOnMin;
        private float[] _mergedBrokenOnMax;
        private float[] _mergedBrokenOffMin;
        private float[] _mergedBrokenOffMax;
        private float[] _mergedBrokenOnIntensity;
        private float[] _mergedPanicSpeed;
        private float[] _mergedPanicIntensityMin;
        private float[] _mergedPanicIntensityMax;

        private AudioSource[] _mergedAudioSources;
        private float[] _audioSmoothVol;
        private AudioSource[] _childAudioSources;

        private Vector4[] _shaderData = new Vector4[MAX_LIGHTS * 8 + 1];
        private int _lightDataID;
        private int _layerArrayID;
        private int _reflectionArrayValidID;
        private int _reflectionProbeArrayID;
        private int _reflectionProbeDataID;
        private int _reflectionProbeHDRID;
        private int _reflectionProbeCountID;
        private int _reflectionProbeMaxMipID;

        private int[] _indices = new int[MAX_LIGHTS];
        private float[] _distances = new float[MAX_LIGHTS];
        private int[] _lastIndicesSorted = new int[MAX_LIGHTS];
        private int[] _mergedToShader = new int[MAX_LIGHTS];
        private int _lastFinalCount = -1;
        private int _lastUploadedSlotCount;

        private bool[] _lastEnabledState;

        private Transform[] _childTransforms;
        private Transform _thisTransform;
        private float[] childLightCosOuter, childLightCosInner;
        private int[] _mergedToChild;

        [HideInInspector] public Vector3[] lastLightPositions;
        [HideInInspector] public Quaternion[] lastLightRotations;
        [HideInInspector] public float[] lastLightIntensities;
        [HideInInspector] public Vector3[] lastLightColors;
        [HideInInspector] public Vector3 lastViewerPos = new Vector3(float.MaxValue, 0, 0);

        private int[] _lightToMerged = new int[0];
        private bool _isReady;
        private int _animatedMask;
        private int _cookieArrayID;

        private VRCPlayerApi _localPlayer;
        private float _viewerTickTimer;
        private float[] _lastAnimatedIntensity = new float[MAX_LIGHTS];
        private Vector3 _viewForward;

        private bool _diffuseStaticEnabled = true;
        private bool _diffuseRealtimeEnabled = true;
        private bool _specularEnabled = true;
        private bool _reflectionEnabled = true;
        // Toggles the analytical N·L multiply applied to the baked per-light
        // lightmap transfer texture at runtime (see LayeredLightmapLighting.cginc).
        // Was previously "_rnmEnabled" back when the light layer array stored 3
        // RNM basis textures per light instead of 1.
        private bool _directionalEnabled = true;
        // Coupe le rendu + le sample de la shadow map temps réel (optimisation).
        // Contrairement aux toggles ci-dessus, ça n'affecte pas l'éligibilité
        // dans SortNearest : ce n'est qu'un uniform shader + un flag côté
        // ShadowAtlasCaster pour arrêter de re-render la shadow cam.
        private bool _realtimeShadowsEnabled = true;

        private int _diffuseStaticEnabledID;
        private int _diffuseRealtimeEnabledID;
        private int _directionalEnabledID;
        private int _realtimeShadowsEnabledID;

        private bool _mergedDirty = true;

        private const float FAULT_FADE_SPEED = 15.0f;
        private const float PANIC_ON_MEAN_SLOW = 0.30f;
        private const float PANIC_ON_MEAN_FAST = 0.01f;
        private const float PANIC_OFF_MEAN_SLOW = 0.80f;
        private const float PANIC_OFF_MEAN_FAST = 0.02f;

        // Nouveaux tableaux persistants pour le tri (alloués une seule fois)
        private int[] _sortBakedCandidates;
        private int[] _sortRealtimeCandidates;

#if UNITY_EDITOR
        [Header("Debug (Editor only)")]
        public int currentStaticLights;
        public int currentDynamicLights;
        public int currentAnimatedLights;
        public int currentSpecularsCount;
        public int sampledLightmapsCount;
        public int currentSlicesCount;
        public bool shaderWasUpdated;
        public int shaderUpdatesThisFrame;
        public int totalShaderUpdates;
        public float shaderUpdatesPerSecond;
        private float _debugTimer;
        private int _debugUpdateCount;
#endif

        public void MarkDirty()
        {
            _mergedDirty = true;
            _lastFinalCount = -1;
        }

#if !COMPILER_UDONSHARP && UNITY_EDITOR
        private void OnValidate()
        {
            if (childLights == null) return;
            ValidateChildArrays();
        }
#endif

        void Start()
        {
            _localPlayer = Networking.LocalPlayer;
            _thisTransform = transform;
            _lightDataID = VRCShader.PropertyToID("_UdonLightData");
            _layerArrayID = VRCShader.PropertyToID("_UdonLightLayerArray");
            _cookieArrayID = VRCShader.PropertyToID("_UdonCookieArray");
            _directionalEnabledID = VRCShader.PropertyToID("_UdonDirectionalEnabled");
            _diffuseStaticEnabledID = VRCShader.PropertyToID("_UdonDiffuseStaticEnabled");
            _diffuseRealtimeEnabledID = VRCShader.PropertyToID("_UdonDiffuseRealtimeEnabled");
            _realtimeShadowsEnabledID = VRCShader.PropertyToID("_UdonRealtimeShadowsEnabled");
            _specCameraFadeEndID = VRCShader.PropertyToID("_UdonSpecCameraFadeEnd");
            _reflectionArrayValidID = VRCShader.PropertyToID("_UdonReflectionArrayValid");
            _reflectionProbeArrayID = VRCShader.PropertyToID("_UdonReflectionProbeArray");
            _reflectionProbeDataID = VRCShader.PropertyToID("_UdonReflectionProbeData");
            _reflectionProbeHDRID = VRCShader.PropertyToID("_UdonReflectionProbeHDR");
            _reflectionProbeCountID = VRCShader.PropertyToID("_UdonReflectionProbeCount");
            _reflectionProbeMaxMipID = VRCShader.PropertyToID("_UdonReflectionProbeMaxMip");

            for (int i = 0; i < MAX_LIGHTS; i++)
            {
                _lastIndicesSorted[i] = -1;
                _lastAnimatedIntensity[i] = -1f;
            }
            for (int i = 0; i < MAX_SHADOW_SLOTS; i++) shadowSlotToMerged[i] = -1;

#if UNITY_ANDROID
            _lightLayerArray = lightLayerArrayQuest;
#else
            _lightLayerArray = lightLayerArrayPC;
#endif

            if (_lightLayerArray != null)
                VRCShader.SetGlobalTexture(_layerArrayID, _lightLayerArray);

            // Validation de la validité
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightLayerArrayValid"), _lightLayerArray != null ? 1f : 0f);

            if (cookieArray != null) VRCShader.SetGlobalTexture(_cookieArrayID, cookieArray);

#if UNITY_ANDROID
            VRCShader.SetGlobalTexture(_reflectionProbeArrayID, reflectionProbeArrayQuest);
            VRCShader.SetGlobalFloat(_reflectionArrayValidID, reflectionProbeArrayQuest != null ? 1f : 0f);
#else
            VRCShader.SetGlobalTexture(_reflectionProbeArrayID, reflectionProbeArrayPC);
            VRCShader.SetGlobalFloat(_reflectionArrayValidID, reflectionProbeArrayPC != null ? 1f : 0f);
#endif
            VRCShader.SetGlobalVectorArray(_reflectionProbeDataID, reflectionProbeData);
            VRCShader.SetGlobalVectorArray(_reflectionProbeHDRID, reflectionProbeHDR);
            VRCShader.SetGlobalFloat(_reflectionProbeCountID, (float)reflectionProbeCount);
            VRCShader.SetGlobalFloat(_reflectionProbeMaxMipID, reflectionProbeMaxMip);
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonCookieArrayValid"), cookieArray != null ? 1f : 0f);
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightmapSliceOffset"), (float)lightmapGroupCount);
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceNear"), lodDistanceNear);
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceFar"), lodDistanceFar);
            VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODMaxMip"), lodAtFar);
            VRCShader.SetGlobalFloat(_diffuseStaticEnabledID, _diffuseStaticEnabled ? 1f : 0f);
            VRCShader.SetGlobalFloat(_diffuseRealtimeEnabledID, _diffuseRealtimeEnabled ? 1f : 0f);
            VRCShader.SetGlobalFloat(_directionalEnabledID, _directionalEnabled ? 1f : 0f);
            VRCShader.SetGlobalFloat(_realtimeShadowsEnabledID, _realtimeShadowsEnabled ? 1f : 0f);
            VRCShader.SetGlobalFloat(_specCameraFadeEndID, specCameraFadeEnd);

            ValidateChildArrays();

            int cap = (childLights != null) ? childLights.Length : 0;
            childLightCosOuter = new float[cap];
            childLightCosInner = new float[cap];
            for (int i = 0; i < cap; i++)
            {
                Light l = childLights[i];
                if (l == null) continue;
                float c = ComputeCosOuter(l.type, l.spotAngle);
                childLightCosOuter[i] = c;
                childLightCosInner[i] = ComputeCosInner(c);
            }

            AllocateMergeBuffers();
            AllocatePhysicalAnimState();
            CacheChildAudioSources();

            int n = (childLights != null) ? childLights.Length : 0;
            lastLightPositions = new Vector3[n];
            lastLightRotations = new Quaternion[n];
            lastLightIntensities = new float[n];
            lastLightColors = new Vector3[n];

            _lastEnabledState = new bool[n];
            for (int i = 0; i < n; i++)
            {
                Light l = childLights[i];
                _lastEnabledState[i] = l != null && l.enabled && l.gameObject.activeInHierarchy;
            }
            for (int i = 0; i < n; i++)
            {
                Light l = childLights[i];
                if (l == null) continue;
                Transform t = _childTransforms[i];
                if (t != null) lastLightPositions[i] = t.position;
                lastLightRotations[i] = l.transform.rotation;
                lastLightIntensities[i] = l.intensity;
                Color c = l.color;
                lastLightColors[i] = new Vector3(c.r, c.g, c.b);
            }

            // Allocation des tableaux persistants pour le tri
            _sortBakedCandidates = new int[MAX_LIGHTS];
            _sortRealtimeCandidates = new int[MAX_LIGHTS];

            _lastRateUpdateTime = Time.realtimeSinceStartup;

            if (activeShadowChildIndex < 0)
            {
                for (int i = 0; i < childLights.Length; i++)
                {
                    Light l = childLights[i];
                    if (l != null && l.enabled && l.gameObject.activeInHierarchy && childLightCastsShadow[i])
                    {
                        activeShadowChildIndex = i;
                        break;
                    }
                }
                if (activeShadowChildIndex >= 0)
                {
                    ForceRefresh();
                    shadowAtlasCaster.UpdateShadowMatrices();
                }
            }
        }

        private void AllocatePhysicalAnimState()
        {
            int cap = (childLights != null) ? childLights.Length : MAX_LIGHTS;
            _faultStateTimer = new float[cap];
            _faultIsOn = new bool[cap];
            _faultIntensity = new float[cap];
            _panicTargetIntensity = new float[cap];
            _audioSmoothVol = new float[cap];

            for (int i = 0; i < cap; i++)
            {
                _faultStateTimer[i] = Random.Range(0f, 1f);
                _faultIsOn[i] = true;
                _faultIntensity[i] = 1f;
                _panicTargetIntensity[i] = (childLightPanicIntensityMax != null && i < childLightPanicIntensityMax.Length)
                    ? childLightPanicIntensityMax[i] : 1.2f;
                _audioSmoothVol[i] = 0f;
            }
        }

        private void CacheChildAudioSources()
        {
            int n = (childLights != null) ? childLights.Length : 0;
            _childAudioSources = new AudioSource[n];
            for (int i = 0; i < n; i++)
            {
                Light l = childLights[i];
                if (l == null) continue;
                _childAudioSources[i] = l.GetComponent<AudioSource>();
            }
        }

        // ResizeOrDefault helpers (unchanged)
        private Texture2D[] ResizeOrDefault(Texture2D[] arr, int cap, Texture2D def)
        {
            if (arr != null && arr.Length == cap) return arr;
            Texture2D[] r = new Texture2D[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private bool[] ResizeOrDefault(bool[] arr, int cap, bool def)
        {
            if (arr != null && arr.Length == cap) return arr;
            bool[] r = new bool[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private Vector3[] ResizeOrDefault(Vector3[] arr, int cap, Vector3 def)
        {
            if (arr != null && arr.Length == cap) return arr;
            Vector3[] r = new Vector3[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private int[] ResizeOrDefault(int[] arr, int cap, int def)
        {
            if (arr != null && arr.Length == cap) return arr;
            int[] r = new int[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private float[] ResizeOrDefault(float[] arr, int cap, float def)
        {
            if (arr != null && arr.Length == cap) return arr;
            float[] r = new float[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private LightFaultState[] ResizeOrDefault(LightFaultState[] arr, int cap, LightFaultState def)
        {
            if (arr != null && arr.Length == cap) return arr;
            LightFaultState[] r = new LightFaultState[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }
        private Vector2[] ResizeOrDefault(Vector2[] arr, int cap, Vector2 def)
        {
            if (arr != null && arr.Length == cap) return arr;
            Vector2[] r = new Vector2[cap];
            int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
            if (c > 0) System.Array.Copy(arr, r, c);
            for (int i = c; i < cap; i++) r[i] = def;
            return r;
        }

        private void ValidateChildArrays()
        {

            int cap = (childLights != null) ? childLights.Length : 0;
            childLightHalfExtents = ResizeOrDefault(childLightHalfExtents, cap, new Vector2(0.01f, 0.01f));
            childLightIsRealtime = ResizeOrDefault(childLightIsRealtime, cap, true);
            childLightBakedColors = ResizeOrDefault(childLightBakedColors, cap, Vector3.one);
            childLightLayerSlices = ResizeOrDefault(childLightLayerSlices, cap, -1);
            childLightDiffuseEnabled = ResizeOrDefault(childLightDiffuseEnabled, cap, true);
            childLightSpecularDistance = ResizeOrDefault(childLightSpecularDistance, cap, true);

            if (childLightCastsShadow == null || childLightCastsShadow.Length != cap)
            {
                bool[] resized = new bool[cap];
                int copyLen = (childLightCastsShadow != null) ? Mathf.Min(childLightCastsShadow.Length, cap) : 0;
                if (copyLen > 0) System.Array.Copy(childLightCastsShadow, resized, copyLen);
                for (int i = copyLen; i < cap; i++)
                    resized[i] = (childLights[i] != null) && (childLights[i].shadows != LightShadows.None);
                childLightCastsShadow = resized;
            }

            childLightFaultState = ResizeOrDefault(childLightFaultState, cap, LightFaultState.Normal);
            childLightGroupIndex = ResizeOrDefault(childLightGroupIndex, cap, ~0);

            childLightGroupIndex = ResizeOrDefault(childLightGroupIndex, cap, ~0);

            childLightBrokenOnMin = ResizeOrDefault(childLightBrokenOnMin, cap, 0.01f);
            childLightBrokenOnMax = ResizeOrDefault(childLightBrokenOnMax, cap, 1.5f);
            childLightBrokenOffMin = ResizeOrDefault(childLightBrokenOffMin, cap, 0.5f);
            childLightBrokenOffMax = ResizeOrDefault(childLightBrokenOffMax, cap, 2.0f);
            childLightBrokenOnIntensity = ResizeOrDefault(childLightBrokenOnIntensity, cap, 0.8f);
            childLightPanicSpeed = ResizeOrDefault(childLightPanicSpeed, cap, 0.5f);
            childLightPanicIntensityMin = ResizeOrDefault(childLightPanicIntensityMin, cap, 0.1f);
            childLightPanicIntensityMax = ResizeOrDefault(childLightPanicIntensityMax, cap, 1.2f);

            childLightCookieTexture = ResizeOrDefault(childLightCookieTexture, cap, null);
            childLightCookieSlice = ResizeOrDefault(childLightCookieSlice, cap, -1);

            if (childLightAudioClipOverride == null || childLightAudioClipOverride.Length != cap)
            {
                AudioClip[] tmp = new AudioClip[cap];
                int copyLen = (childLightAudioClipOverride != null)
                    ? Mathf.Min(childLightAudioClipOverride.Length, cap) : 0;
                if (copyLen > 0) System.Array.Copy(childLightAudioClipOverride, tmp, copyLen);
                childLightAudioClipOverride = tmp;
            }
            _isReady = cap > 0;
        }

        private void AllocateMergeBuffers()
        {
            int cap = (childLights != null) ? childLights.Length : MAX_LIGHTS;

            mergedPos = new Vector4[cap];
            mergedCol = new Vector4[cap];
            mergedRight = new Vector4[cap];
            mergedUp = new Vector4[cap];
            mergedDir = new Vector4[cap];
            mergedBakedCol = new Vector4[cap];
            mergedLayerSlice = new int[cap];
            mergedDiffuseEnabled = new bool[cap];
            mergedSpecularEnabled = new bool[cap];
            mergedFaultState = new LightFaultState[cap];
            mergedGroupMask = new int[cap];
            mergedCastShadow = new bool[cap];

            _mergedAudioSources = new AudioSource[cap];
            _mergedBaseIntensity = new float[cap];
            _mergedLastAnimated = new float[cap];
            _mergedToChild = new int[cap];
            mergedToShadowSlot = new int[cap];

            mergedCosInner = new float[cap];

            _mergedBrokenOnMin = new float[cap];
            _mergedBrokenOnMax = new float[cap];
            _mergedBrokenOffMin = new float[cap];
            _mergedBrokenOffMax = new float[cap];
            _mergedBrokenOnIntensity = new float[cap];
            _mergedPanicSpeed = new float[cap];
            _mergedPanicIntensityMin = new float[cap];
            _mergedPanicIntensityMax = new float[cap];

            mergedCookieSlice = new int[cap];

            for (int i = 0; i < cap; i++)
            {
                mergedLayerSlice[i] = -1;
                mergedDiffuseEnabled[i] = true;
                mergedSpecularEnabled[i] = true;
                mergedFaultState[i] = LightFaultState.Normal;
                mergedGroupMask[i] = ~0;
                mergedCastShadow[i] = false;
                _mergedBaseIntensity[i] = 1f;
                _mergedLastAnimated[i] = -1f;
                _mergedToChild[i] = -1;
                mergedToShadowSlot[i] = -1;

                mergedCosInner[i] = -1f;

                _mergedBrokenOnMin[i] = 0.01f;
                _mergedBrokenOnMax[i] = 1.5f;
                _mergedBrokenOffMin[i] = 0.5f;
                _mergedBrokenOffMax[i] = 2.0f;
                _mergedBrokenOnIntensity[i] = 0.8f;
                _mergedPanicSpeed[i] = 0.5f;
                _mergedPanicIntensityMin[i] = 0.1f;
                _mergedPanicIntensityMax[i] = 1.2f;

                mergedCookieSlice[i] = -1;
            }

            _childTransforms = new Transform[cap];
            for (int i = 0; i < cap; i++)
                if (childLights != null && i < childLights.Length && childLights[i] != null)
                    _childTransforms[i] = childLights[i].transform;

            ValidateChildArrays();
        }

        // =================================================================
        //  LIFECYCLE
        // =================================================================
        void OnEnable()
        {
            if (_localPlayer == null) return;
            _lastFinalCount = -1;
            _viewerTickTimer = 0f;
            lastViewerPos = new Vector3(float.MaxValue, 0, 0);
            for (int i = 0; i < MAX_LIGHTS; i++) _lastAnimatedIntensity[i] = -1f;
            for (int i = 0; i < MAX_SHADOW_SLOTS; i++) shadowSlotToMerged[i] = -1;

            if (childLights != null && _lastEnabledState != null)
            {
                int n = Mathf.Min(childLights.Length, _lastEnabledState.Length);
                for (int i = 0; i < n; i++)
                {
                    Light l = childLights[i];
                    _lastEnabledState[i] = l != null && l.enabled && l.gameObject.activeInHierarchy;
                }
            }
        }

        void OnDisable()
        {
            _shaderData[0] = new Vector4(0f, 0f, _reflectionEnabled ? 1f : 0f, _specularEnabled ? 1f : 0f);
            for (int i = 1; i < _shaderData.Length; i++) _shaderData[i] = Vector4.zero;
            VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
            _lastFinalCount = 0;
            for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
            if (_childAudioSources != null)
                for (int i = 0; i < _childAudioSources.Length; i++)
                    if (_childAudioSources[i] != null) _childAudioSources[i].Stop();
        }

        public void ForceRefresh()
        {
            _lastFinalCount = -1;
            _viewerTickTimer = VIEWER_UPDATE_INTERVAL;
            Tick(UPDATE_INTERVAL);
            _tickAccumDt = 0f;
        }

        // =================================================================
        //  UPDATES
        // =================================================================
        public override void PostLateUpdate()
        {
            float startTime = Time.realtimeSinceStartup;

#if UNITY_EDITOR
            shaderWasUpdated = false;
            shaderUpdatesThisFrame = 0;
#endif
            if (!_isReady || childLights == null || childLights.Length == 0) return;

            float dt = Time.deltaTime;
            _tickAccumDt += dt;
            _viewerTickTimer += dt;

            bool lightsChanged = false;
            int childCount = childLights.Length;
            for (int i = 0; i < childCount; i++)
            {
                Light l = childLights[i];
                bool cur = l != null && l.enabled && l.gameObject.activeInHierarchy;
                if (cur != _lastEnabledState[i]) { lightsChanged = true; _lastEnabledState[i] = cur; }
            }
            if (lightsChanged)
            {
                _mergedDirty = true;
                ForceRefresh();
                return;
            }

            bool hasAnimatedLights = _animatedMask != 0;
            bool needsResort = _viewerTickTimer >= VIEWER_UPDATE_INTERVAL || _lastFinalCount < 0;
            bool intervalElapsed = _tickAccumDt >= UPDATE_INTERVAL;

            if (!_mergedDirty && !hasAnimatedLights && !needsResort)
            {
                if (intervalElapsed)
                {
                    // Fast path — only spend CPU/GPU work once the interval has actually elapsed
                    TickAudio();
                    bool liveChanged = UpdateLiveData(_tickAccumDt);
                    if (liveChanged)
                    {
                        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
                        _lastUploadTime = Time.time;
                        _shaderUpdateCounter++;
#if UNITY_EDITOR
                        shaderWasUpdated = true;
                        shaderUpdatesThisFrame++;
                        totalShaderUpdates++;
#endif
                    }
                    _tickAccumDt = 0f;
                }
            }
            else if (intervalElapsed || needsResort)
            {
                Tick(_tickAccumDt);
                _tickAccumDt = 0f;
            }

            if (shadowAtlasCaster != null && shadowAtlasCaster.enabled)
                shadowAtlasCaster.UpdateShadowMatrices();

            // ---- Per-frame performance metrics ----
            float elapsedMs = (Time.realtimeSinceStartup - startTime) * 1000f;
            float decay = 1f - Mathf.Exp(-Time.deltaTime / SMOOTHING_HALF_LIFE);
            _emaUdonMs += (elapsedMs - _emaUdonMs) * decay;
            avgUdonMsPerFrame = _emaUdonMs;

            // Update smoothed upload rate every ~0.5s
            float now = Time.realtimeSinceStartup;
            float rateInterval = now - _lastRateUpdateTime;
            if (rateInterval > 0.5f)
            {
                _instantRate = _shaderUpdateCounter / rateInterval;
                _shaderUpdateCounter = 0;
                _lastRateUpdateTime = now;

                _emaShaderUpdatesPerSecond += (_instantRate - _emaShaderUpdatesPerSecond) * decay;
                avgShaderUpdatesPerSecond = _emaShaderUpdatesPerSecond;
            }

#if UNITY_EDITOR
            _debugTimer += dt;
            if (_debugTimer >= 1.0f)
            {
                float currentRate = _debugUpdateCount / _debugTimer;
                shaderUpdatesPerSecond = Mathf.Lerp(shaderUpdatesPerSecond, currentRate, 0.1f);
                _debugTimer = 0f;
                _debugUpdateCount = 0;
            }
#endif
        }

        public void OnLightsChanged() => ForceRefresh();

        // Physical animation (unchanged)
        private bool TickPhysicalAnimation(float dt)
        {
            if (mergedCount == 0 || _animatedMask == 0) return false;
            bool anyChanged = false;

            for (int mi = 0; mi < mergedCount; mi++)
            {
                if (mergedFaultState[mi] == LightFaultState.Off) continue;

                LightFaultState state = mergedFaultState[mi];
                int li = _mergedToChild[mi];
                if (li < 0) continue;

                bool isFaulted = state != LightFaultState.Normal;
                bool needsSettle = !isFaulted && Mathf.Abs(_faultIntensity[li] - 1f) > INTENSITY_EPSILON;
                if (!isFaulted && !needsSettle) { _animatedMask &= ~(1 << mi); continue; }

                float newIntensity = isFaulted
                    ? TickFault(li, mi, state, dt)
                    : SettleFault(li, dt);

                float animated = _mergedBaseIntensity[mi] * newIntensity;
                int si = _mergedToShader[mi];
                if (si < 0) continue;

                if (Mathf.Abs(animated - _mergedLastAnimated[mi]) <= INTENSITY_EPSILON) continue;

                _mergedLastAnimated[mi] = animated;
                anyChanged = true;

                Vector4 c = mergedCol[mi];
                _shaderData[si * 8 + 1 + 1] = new Vector4(c.x, c.y, c.z, animated);
            }
            return anyChanged;
        }

        private float SettleFault(int li, float dt)
        {
            _faultIntensity[li] = Mathf.MoveTowards(_faultIntensity[li], 1f, FAULT_FADE_SPEED * dt);
            return _faultIntensity[li];
        }

        private static void SpeedToMeans(float speed, out float onMean, out float offMean)
        {
            float t = speed * speed;
            onMean = Mathf.Lerp(PANIC_ON_MEAN_SLOW, PANIC_ON_MEAN_FAST, t);
            offMean = Mathf.Lerp(PANIC_OFF_MEAN_SLOW, PANIC_OFF_MEAN_FAST, t);
        }

        private float TickFault(int li, int mi, LightFaultState state, float dt)
        {
            if (state == LightFaultState.Off)
            {
                _faultIntensity[li] = 0f;
                return 0f;
            }
            if (state == LightFaultState.Panic)
            {
                float onMean, offMean;
                SpeedToMeans(_mergedPanicSpeed[mi], out onMean, out offMean);

                _faultStateTimer[li] -= dt;
                while (_faultStateTimer[li] <= 0f)
                {
                    _faultIsOn[li] = !_faultIsOn[li];
                    float mean = _faultIsOn[li] ? onMean : offMean;
                    float u = 1f - Random.value;
                    if (u <= 0.0001f) u = 0.0001f;
                    _faultStateTimer[li] += -mean * Mathf.Log(u);
                    if (_faultIsOn[li])
                        _panicTargetIntensity[li] = Random.Range(
                            _mergedPanicIntensityMin[mi], _mergedPanicIntensityMax[mi]);
                }
                _faultIntensity[li] = _faultIsOn[li] ? _panicTargetIntensity[li] : 0f;
                return _faultIntensity[li];
            }
            else
            {
                _faultStateTimer[li] -= dt;
                if (_faultStateTimer[li] <= 0f)
                {
                    _faultIsOn[li] = !_faultIsOn[li];
                    _faultStateTimer[li] = _faultIsOn[li]
                        ? Random.Range(_mergedBrokenOnMin[mi], _mergedBrokenOnMax[mi])
                        : Random.Range(_mergedBrokenOffMin[mi], _mergedBrokenOffMax[mi]);
                }
                float target = _faultIsOn[li] ? _mergedBrokenOnIntensity[mi] : 0f;
                _faultIntensity[li] = Mathf.MoveTowards(
                    _faultIntensity[li], target, FAULT_FADE_SPEED * dt);
                return _faultIntensity[li];
            }
        }

        private void TickAudio()
        {
            if (_childAudioSources == null) return;
            int childCount = (childLights != null) ? childLights.Length : 0;

            for (int li = 0; li < childCount; li++)
            {
                AudioSource src = _childAudioSources[li];
                if (src == null) continue;

                int mi = (_lightToMerged != null && li < _lightToMerged.Length) ? _lightToMerged[li] : -1;
                bool isFaulted = (mi >= 0) && mergedFaultState[mi] != LightFaultState.Normal;
                bool isOff = (mi >= 0) && mergedFaultState[mi] == LightFaultState.Off;

                if (!isFaulted || isOff)
                {
                    if (src.isPlaying) src.Stop();
                    continue;
                }

                if (!src.isPlaying)
                {
                    AudioClip clip = (childLightAudioClipOverride != null
                                     && li < childLightAudioClipOverride.Length
                                     && childLightAudioClipOverride[li] != null)
                        ? childLightAudioClipOverride[li]
                        : faultAudioClip;

                    if (clip == null) continue;

                    src.clip = clip;
                    src.loop = true;
                    src.time = Random.Range(0f, clip.length);
                    src.Play();
                }

                float vol = (mergedFaultState[mi] == LightFaultState.Panic) ? 1f : Mathf.Clamp01(_faultIntensity[li]);
                src.volume = vol * audioMasterVolume;
            }
        }

        // Live data update (unchanged except it now respects epsilons correctly)
        // Live data update
        private bool UpdateLiveData(float dt)
        {
            if (!_isReady || _lightToMerged == null || _lightToMerged.Length != childLights.Length)
                return false;

            bool changed = false;
            int childCount = childLights.Length;
            for (int li = 0; li < childCount; li++)
            {
                if (!childLightIsRealtime[li]) continue;
                Light l = childLights[li];
                if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
                int mi = _lightToMerged[li];
                if (mi < 0) continue;
                int si = _mergedToShader[mi];
                if (si < 0) continue;

                Transform t = _childTransforms[li];
                Vector3 pos = t.position;
                Quaternion rot = t.rotation;
                float intensity = l.intensity;
                Color lColor = l.color;

                // Check changes using the defined constants
                bool posChanged = (pos - lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
                bool rotChanged = Quaternion.Dot(rot, lastLightRotations[li]) < ROTATION_EPSILON_DOT;
                bool intChanged = Mathf.Abs(intensity - lastLightIntensities[li]) > INTENSITY_EPSILON;
                bool colChanged = Mathf.Abs(lColor.r - lastLightColors[li].x) > COLOR_EPSILON ||
                                  Mathf.Abs(lColor.g - lastLightColors[li].y) > COLOR_EPSILON ||
                                  Mathf.Abs(lColor.b - lastLightColors[li].z) > COLOR_EPSILON;

                // If nothing changed at all, skip to the next light
                if (!posChanged && !rotChanged && !intChanged && !colChanged) continue;

                changed = true;
                int baseIdx = si * 8 + 1;

                // Update Position and Rotation if they changed
                if (posChanged || rotChanged)
                {
                    Vector4 p = mergedPos[mi];
                    mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, intensity);
                    lastLightPositions[li] = pos;
                    _shaderData[baseIdx + 0] = mergedPos[mi];

                    Vector3 fwd = rot * Vector3.forward;
                    Vector3 right = rot * Vector3.right;
                    Vector3 up = rot * Vector3.up;
                    float cosOuter = childLightCosOuter[li];
                    mergedCosInner[mi] = childLightCosInner[li];
                    mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                    mergedRight[mi] = new Vector4(right.x, right.y, right.z, mergedRight[mi].w);
                    mergedUp[mi] = new Vector4(up.x, up.y, up.z, mergedUp[mi].w);
                    lastLightRotations[li] = rot;

                    _shaderData[baseIdx + 2] = mergedDir[mi];
                    _shaderData[baseIdx + 3] = mergedRight[mi];
                    _shaderData[baseIdx + 4] = mergedUp[mi];
                }

                // Update Color and Intensity if they changed
                if (intChanged || colChanged)
                {
                    Vector3 col = new Vector3(lColor.r, lColor.g, lColor.b);
                    mergedCol[mi] = new Vector4(col.x, col.y, col.z, intensity);
                    _mergedBaseIntensity[mi] = intensity;
                    lastLightIntensities[li] = intensity;
                    lastLightColors[li] = col;

                    _shaderData[baseIdx + 1] = mergedCol[mi];
                }
            }
            return changed;
        }

        public void Tick(float dt)
        {
            bool mergedRebuilt = false;
            if (_mergedDirty) { BuildMergedGroups(); _mergedDirty = false; mergedRebuilt = true; }
            if (!_isReady || childLights == null || childLights.Length == 0) return;

            Vector3 viewerPos = _localPlayer != null ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position : _thisTransform.position;

            if (_localPlayer != null)
            {
                _viewForward = (_localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).rotation * Vector3.forward).normalized;
            }
            else
            {
                _viewForward = _thisTransform.forward;
            }

            bool viewerDue = mergedRebuilt || _viewerTickTimer >= VIEWER_UPDATE_INTERVAL || _lastFinalCount < 0;
            int finalCount;
            if (viewerDue)
            {
                _viewerTickTimer = 0f;
                finalCount = SortNearest(viewerPos);
                lastViewerPos = viewerPos;
            }
            else finalCount = _lastFinalCount;

            for (int i = 0; i < mergedCount; i++) _mergedToShader[i] = -1;
            for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

#if UNITY_EDITOR
            int dynCount = 0, statCount = 0, animCount = 0, specCount = 0, sliceCount = 0, sliceMask = 0;
            float specCullDistSq = Sq(specCameraFadeEnd + specCullMargin);
            for (int i = 0; i < finalCount; i++)
            {
                int mi = _indices[i];
                if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
                if (mergedFaultState[mi] == LightFaultState.Broken || mergedFaultState[mi] == LightFaultState.Panic) animCount++;
                if (IsSpecularActive(mi, viewerPos, specCullDistSq)) specCount++;
                int sl = mergedLayerSlice[mi];
                if (sl >= 0 && sl < 32) { sliceCount++; sliceMask |= (1 << sl); }
            }
            currentStaticLights = statCount;
            currentDynamicLights = dynCount;
            currentAnimatedLights = animCount;
            currentSpecularsCount = specCount;
            currentSlicesCount = sliceCount;
            sampledLightmapsCount = CountBits(sliceMask);
#endif

            bool isDirty = finalCount != _lastFinalCount;
            if (!isDirty)
                for (int i = 0; i < finalCount; i++)
                    if (_indices[i] != _lastIndicesSorted[i]) { isDirty = true; break; }

            if (isDirty) AssignShadowSlots(finalCount);
            FillUploadBuffers(finalCount, isDirty);
            bool liveChanged = UpdateLiveData(dt);
            bool animated = TickPhysicalAnimation(dt);
            TickAudio();

            if (isDirty || animated || liveChanged)
            {
                VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
                _lastUploadTime = Time.time;
                _shaderUpdateCounter++;
#if UNITY_EDITOR
                shaderWasUpdated = true;
                shaderUpdatesThisFrame++;
                totalShaderUpdates++;
                _debugUpdateCount++;
#endif
            }

            CacheLightStates();
            _lastFinalCount = finalCount;
        }

        // =================================================================
        //  DATA BUILDING & SORTING
        // =================================================================
        public void BuildMergedGroups()
        {
            if (!_isReady) return;
            if (mergedPos == null || mergedPos.Length < childLights.Length) AllocateMergeBuffers();
            if (_lightToMerged == null || _lightToMerged.Length != childLights.Length)
                _lightToMerged = new int[childLights.Length];

            mergedCount = 0;
            _animatedMask = 0;
            int childCount = childLights.Length;

            for (int li = 0; li < childCount; li++)
            {
                _lightToMerged[li] = -1;
                Light l = childLights[li];
                if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
                if (l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex) continue;
                if (mergedCount >= mergedPos.Length) continue;

                Transform t = _childTransforms[li];

                bool isRealtime = childLightIsRealtime[li];
                Vector3 pos;
                float intensity;
                Color lColor;

                if (isRealtime)
                {
                    pos = t.position;
                    intensity = l.intensity;
                    lColor = l.color;
                }
                else
                {
                    pos = lastLightPositions[li];
                    intensity = lastLightIntensities[li];
                    lColor = new Color(lastLightColors[li].x, lastLightColors[li].y, lastLightColors[li].z, 1f);
                }

                LightFaultState faultState = childLightFaultState[li];

                if (faultState == LightFaultState.Off)
                {
                    intensity = 0f;
                    lColor = isRealtime ? l.color : new Color(lastLightColors[li].x, lastLightColors[li].y, lastLightColors[li].z);
                }

                int mi = mergedCount;

                mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, intensity);
                mergedCol[mi] = new Vector4(lColor.r, lColor.g, lColor.b, intensity);
                mergedRight[mi] = new Vector4(t.right.x, t.right.y, t.right.z, childLightHalfExtents[li].x);
                mergedUp[mi] = new Vector4(t.up.x, t.up.y, t.up.z, childLightHalfExtents[li].y);

                float cosOuter = childLightCosOuter[li];
                mergedCosInner[mi] = childLightCosInner[li];
                mergedDir[mi] = new Vector4(t.forward.x, t.forward.y, t.forward.z, cosOuter);

                mergedBakedCol[mi] = new Vector4(
                    childLightBakedColors[li].x, childLightBakedColors[li].y, childLightBakedColors[li].z,
                    isRealtime ? 1f : 0f);
                mergedLayerSlice[mi] = childLightLayerSlices[li];
                mergedDiffuseEnabled[mi] = childLightDiffuseEnabled[li];
                mergedSpecularEnabled[mi] = childLightSpecularDistance[li];

                mergedFaultState[mi] = faultState;
                mergedGroupMask[mi] = childLightGroupIndex[li];

                mergedCastShadow[mi] = childLightCastsShadow[li];

                _mergedBaseIntensity[mi] = intensity;
                _mergedToChild[mi] = li;

                _mergedBrokenOnMin[mi] = childLightBrokenOnMin[li];
                _mergedBrokenOnMax[mi] = childLightBrokenOnMax[li];
                _mergedBrokenOffMin[mi] = childLightBrokenOffMin[li];
                _mergedBrokenOffMax[mi] = childLightBrokenOffMax[li];
                _mergedBrokenOnIntensity[mi] = childLightBrokenOnIntensity[li];
                _mergedPanicSpeed[mi] = childLightPanicSpeed[li];
                _mergedPanicIntensityMin[mi] = childLightPanicIntensityMin[li];
                _mergedPanicIntensityMax[mi] = childLightPanicIntensityMax[li];

                mergedCookieSlice[mi] = childLightCookieSlice[li];

                _mergedAudioSources[mi] = (li < _childAudioSources.Length) ? _childAudioSources[li] : null;
                _lightToMerged[li] = mi;

                bool settling = Mathf.Abs(_faultIntensity[li] - 1f) > INTENSITY_EPSILON;
                if (faultState == LightFaultState.Broken || faultState == LightFaultState.Panic || settling)
                    _animatedMask |= 1 << mi;

                mergedCount++;
            }
        }

        // Single source of truth for specular eligibility: disabled flag, global toggle,
        // or beyond the camera fade distance all disqualify a light from specular.
        private bool IsSpecularActive(int mi, Vector3 viewerPos, float specCullDistSq)
        {
            if (!mergedSpecularEnabled[mi] || !_specularEnabled) return false;
            Vector4 mp = mergedPos[mi];
            float dx = viewerPos.x - mp.x, dy = viewerPos.y - mp.y, dz = viewerPos.z - mp.z;
            float distSq = dx * dx + dy * dy + dz * dz;
            return distSq <= specCullDistSq;
        }

        private static float Sq(float x) => x * x;

        public int SortNearest(Vector3 viewerPos)
        {
            float maxDistSq = rangeScale * rangeScale;
            float specCullDistSq = Sq(specCameraFadeEnd + specCullMargin);
            bool diffuseGloballyOn = _diffuseStaticEnabled || _diffuseRealtimeEnabled;

            int bakedCount = 0, realtimeCount = 0;

            // Culling conique : précalcul des cosinus des demi‑angles
            float cosHalfFovGeneral = Mathf.Cos(fovCullAngle * 0.5f * Mathf.Deg2Rad);
            float cosHalfFovSpecular = Mathf.Cos(specularFovCullAngle * 0.5f * Mathf.Deg2Rad);
            float minDistSqForCone = coneCullMinDistance * coneCullMinDistance;

            for (int i = 0; i < mergedCount; i++)
            {
                int li = _mergedToChild[i];
                if (li < 0) continue;

                bool isRealtime = childLightIsRealtime[li];
                bool canDiffuse = mergedDiffuseEnabled[i] && diffuseGloballyOn;
                bool canSpecular = IsSpecularActive(i, viewerPos, specCullDistSq);
                if (!canDiffuse && !canSpecular) continue;

                Vector4 mp = mergedPos[i];
                float dx = viewerPos.x - mp.x, dy = viewerPos.y - mp.y, dz = viewerPos.z - mp.z;
                float distSq = dx * dx + dy * dy + dz * dz;
                if (distSq > maxDistSq) continue;

                // --- Culling conique ---
                // Uniquement si la light est assez loin pour éviter le popping des proches.
                if (distSq > minDistSqForCone)
                {
                    float dist = Mathf.Sqrt(distSq);
                    Vector3 toLight = new Vector3(mp.x - viewerPos.x, mp.y - viewerPos.y, mp.z - viewerPos.z);
                    float cosAngle = (toLight.x * _viewForward.x + toLight.y * _viewForward.y + toLight.z * _viewForward.z) / dist;

                    if (canDiffuse)
                    {
                        // Contribution diffuse : cône large
                        if (cosAngle < cosHalfFovGeneral) continue;
                    }
                    else
                    {
                        // Spéculaire seulement : cône plus strict
                        if (cosAngle < cosHalfFovSpecular) continue;
                    }
                }
                // ---------------------

                if (!isRealtime)
                {
                    _sortBakedCandidates[bakedCount] = i;
                    bakedCount++;
                }
                else
                {
                    _sortRealtimeCandidates[realtimeCount] = i;
                    realtimeCount++;
                }
            }

            // Tri par insertion des baked
            for (int i = 1; i < bakedCount; i++)
            {
                int key = _sortBakedCandidates[i];
                float keyDist = Sq(viewerPos.x - mergedPos[key].x) + Sq(viewerPos.y - mergedPos[key].y) + Sq(viewerPos.z - mergedPos[key].z);
                int j = i - 1;
                while (j >= 0)
                {
                    float dist = Sq(viewerPos.x - mergedPos[_sortBakedCandidates[j]].x) + Sq(viewerPos.y - mergedPos[_sortBakedCandidates[j]].y) + Sq(viewerPos.z - mergedPos[_sortBakedCandidates[j]].z);
                    if (dist > keyDist)
                    {
                        _sortBakedCandidates[j + 1] = _sortBakedCandidates[j];
                        j--;
                    }
                    else break;
                }
                _sortBakedCandidates[j + 1] = key;
            }

            // Tri par insertion des realtime
            for (int i = 1; i < realtimeCount; i++)
            {
                int key = _sortRealtimeCandidates[i];
                float keyDist = Sq(viewerPos.x - mergedPos[key].x) + Sq(viewerPos.y - mergedPos[key].y) + Sq(viewerPos.z - mergedPos[key].z);
                int j = i - 1;
                while (j >= 0)
                {
                    float dist = Sq(viewerPos.x - mergedPos[_sortRealtimeCandidates[j]].x) + Sq(viewerPos.y - mergedPos[_sortRealtimeCandidates[j]].y) + Sq(viewerPos.z - mergedPos[_sortRealtimeCandidates[j]].z);
                    if (dist > keyDist)
                    {
                        _sortRealtimeCandidates[j + 1] = _sortRealtimeCandidates[j];
                        j--;
                    }
                    else break;
                }
                _sortRealtimeCandidates[j + 1] = key;
            }

            int count = 0;
            for (int i = 0; i < bakedCount && count < MAX_LIGHTS; i++)
            {
                int idx = _sortBakedCandidates[i];
                _indices[count] = idx;
                _distances[count] = Sq(viewerPos.x - mergedPos[idx].x) + Sq(viewerPos.y - mergedPos[idx].y) + Sq(viewerPos.z - mergedPos[idx].z);
                count++;
            }

            // Realtime dans les places restantes
            for (int i = 0; i < realtimeCount && count < MAX_LIGHTS; i++)
            {
                int idx = _sortRealtimeCandidates[i];
                _indices[count] = idx;
                _distances[count] = Sq(viewerPos.x - mergedPos[idx].x) + Sq(viewerPos.y - mergedPos[idx].y) + Sq(viewerPos.z - mergedPos[idx].z);
                count++;
            }

            return count;
        }

        public void SetShadowCasterLight(int childLightIndex)
        {
            if (childLightIndex == activeShadowChildIndex) return;
            activeShadowChildIndex = childLightIndex;
            ForceRefresh();
        }

        // Pratique si ton script de pickup n'a pas envie de connaître son propre index
        public void SetShadowCasterLightByLight(Light targetLight)
        {
            if (childLights == null) return;
            for (int i = 0; i < childLights.Length; i++)
            {
                if (childLights[i] == targetLight)
                {
                    SetShadowCasterLight(i);
                    return;
                }
            }
        }
        private void AssignShadowSlots(int finalCount)
        {
            for (int s = 0; s < MAX_SHADOW_SLOTS; s++) shadowSlotToMerged[s] = -1;
            for (int i = 0; i < mergedCount; i++) mergedToShadowSlot[i] = -1;

            if (activeShadowChildIndex < 0 || _lightToMerged == null || activeShadowChildIndex >= _lightToMerged.Length)
                return;

            int mi = _lightToMerged[activeShadowChildIndex];
            if (mi < 0) return;                                   // torche désactivée / hors merge
            if (!mergedCastShadow[mi]) return;                     // Shadow Type = None sur ce Light
            if (mergedFaultState[mi] == LightFaultState.Off) return;

            shadowSlotToMerged[0] = mi;
            mergedToShadowSlot[mi] = 0;
        }

        // Convenience lookup for the component that actually renders the shadow
        // cameras: which transform should shadow-atlas slot `slot` look from
        // this frame? Returns null if the slot is currently unused.
        public Transform GetShadowSlotTransform(int slot)
        {
            if (slot < 0 || slot >= MAX_SHADOW_SLOTS) return null;
            int mi = shadowSlotToMerged[slot];
            if (mi < 0) return null;
            int li = _mergedToChild[mi];
            if (li < 0 || childLights == null || li >= childLights.Length) return null;
            return _childTransforms[li];
        }

        private void FillUploadBuffers(int finalCount, bool isDirty)
        {
            _shaderData[0] = new Vector4((float)finalCount, 0f, _reflectionEnabled ? 1f : 0f, _specularEnabled ? 1f : 0f);

            if (!isDirty) return;

            for (int i = 0; i < finalCount; i++)
            {
                int idx = _indices[i];
                if (_lastIndicesSorted[i] == idx) continue;

                int baseIdx = i * 8 + 1;

                float cosInner = mergedCosInner[idx];
                float cosOuter = mergedDir[idx].w;
                int lightTypeInt = GetLightTypeInt(cosOuter);
                int cookieSlice = mergedCookieSlice[idx];

                _shaderData[baseIdx + 0] = mergedPos[idx];
                _shaderData[baseIdx + 1] = mergedCol[idx];
                _shaderData[baseIdx + 2] = mergedDir[idx];
                _shaderData[baseIdx + 3] = mergedRight[idx];
                _shaderData[baseIdx + 4] = mergedUp[idx];
                _shaderData[baseIdx + 5] = mergedBakedCol[idx];
                _shaderData[baseIdx + 6] = PackLayerIndex(idx);

                // ----- Encode shadow atlas slot into rangesAndType.y (-1 = no shadow) -----
                float shadowSlot = (float)mergedToShadowSlot[idx];
                _shaderData[baseIdx + 7] = new Vector4((float)cookieSlice, shadowSlot, (float)lightTypeInt, cosInner);

                _lastIndicesSorted[i] = idx;
                _mergedLastAnimated[idx] = -1f;
            }

            int clearUpTo = Mathf.Max(finalCount, _lastUploadedSlotCount);
            for (int i = finalCount; i < clearUpTo; i++)
            {
                int baseIdx = i * 8 + 1;
                _shaderData[baseIdx] = _shaderData[baseIdx + 1] = _shaderData[baseIdx + 2] =
                _shaderData[baseIdx + 3] = _shaderData[baseIdx + 4] = _shaderData[baseIdx + 5] = Vector4.zero;
                _shaderData[baseIdx + 6] = new Vector4(-1f, 0f, 0f, 0f);
                _shaderData[baseIdx + 7] = new Vector4(0f, -1f, 0f, 0f); // shadow slot -1 = none
                _lastIndicesSorted[i] = -1;
            }
            _lastUploadedSlotCount = finalCount;
        }

        private Vector4 PackLayerIndex(int mi)
        {
            return new Vector4(
                mergedLayerSlice[mi],
                mergedDiffuseEnabled[mi] ? 1f : 0f,
                mergedSpecularEnabled[mi] ? 1f : 0f,
                (float)mergedGroupMask[mi]);
        }

        // =================================================================
        //  UTILITIES
        // =================================================================
        private static float ComputeCosOuter(LightType type, float spotAngleDegrees)
        {
            if (type == LightType.Spot) return Mathf.Cos(spotAngleDegrees * 0.5f * Mathf.Deg2Rad);
            if (type == LightType.Area) return 0.0f;
            return -1.0f;
        }

        private static float ComputeCosInner(float cosOuter)
        {
            if (cosOuter < -0.9f) return -1.0f;
            if (cosOuter <= 0.0f) return 0.0f;
            float angleOuter = Mathf.Acos(cosOuter);
            float angleInner = angleOuter * 0.85f;
            return Mathf.Cos(angleInner);
        }

        private static int CountBits(int v) { int c = 0; while (v != 0) { v &= (v - 1); c++; } return c; }

        private void CacheLightStates()
        {
            int n = childLights.Length;
            if (lastLightPositions == null || lastLightPositions.Length != n)
            {
                lastLightPositions = new Vector3[n];
                lastLightRotations = new Quaternion[n];
                lastLightIntensities = new float[n];
                lastLightColors = new Vector3[n];
            }
            for (int i = 0; i < n; i++)
            {
                if (childLightIsRealtime[i]) continue;
                Light l = childLights[i];
                if (l == null) continue;
                Transform t = _childTransforms[i];
                if (t != null) lastLightPositions[i] = t.position;
                lastLightRotations[i] = l.transform.rotation;
                lastLightIntensities[i] = l.intensity;
                Color c = l.color;
                lastLightColors[i] = new Vector3(c.r, c.g, c.b);
            }
        }

        public void FlushRestoredLight(int li)
        {
            if (_lightToMerged == null || li >= _lightToMerged.Length) return;
            int mi = _lightToMerged[li];
            if (mi < 0) return;
            int si = _mergedToShader[mi];
            if (si < 0) return;

            Vector4 c = mergedCol[mi];
            int baseIdx = si * 8 + 1;
            _shaderData[baseIdx + 1] = c;
            _mergedLastAnimated[mi] = c.w;
        }

        private static int GetLightTypeInt(float cosOuter)
        {
            if (cosOuter < -0.9f) return 0;
            if (cosOuter <= 0.0f) return 2;
            return 1;
        }


        // =================================================================
        //  LIGHTING TOGGLES (Diffuse Static / Diffuse Realtime / Specular / Reflection / Directionals)
        // =================================================================
        public void ToggleDiffuseStatic() => SetDiffuseStatic(!_diffuseStaticEnabled);

        public void SetDiffuseStatic(bool enabled)
        {
            _diffuseStaticEnabled = enabled;
            VRCShader.SetGlobalFloat(_diffuseStaticEnabledID, enabled ? 1f : 0f);
            // This changes SortNearest's eligibility test — re-sort now instead of waiting
            // up to VIEWER_UPDATE_INTERVAL for the effect to show up.
            ForceRefresh();
        }

        public void ToggleDiffuseRealtime() => SetDiffuseRealtime(!_diffuseRealtimeEnabled);

        public void SetDiffuseRealtime(bool enabled)
        {
            _diffuseRealtimeEnabled = enabled;
            VRCShader.SetGlobalFloat(_diffuseRealtimeEnabledID, enabled ? 1f : 0f);
            // Same reasoning as SetDiffuseStatic: re-sort immediately.
            ForceRefresh();
        }

        public void ToggleSpecular() => SetSpecular(!_specularEnabled);

        public void SetSpecular(bool enabled)
        {
            _specularEnabled = enabled;
            _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, _shaderData[0].z, enabled ? 1f : 0f);
            VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
            shaderWasUpdated = true;
            shaderUpdatesThisFrame++;
            totalShaderUpdates++;
#endif
            // Re-sort in BOTH directions now (previously only on enable): disabling specular
            // frees the slots held by lights whose only contribution was specular.
            ForceRefresh();
        }

        public void ToggleReflection() => SetReflection(!_reflectionEnabled);

        public void SetReflection(bool enabled)
        {
            _reflectionEnabled = enabled;
            _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, enabled ? 1f : 0f, _shaderData[0].w);
            VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
            shaderWasUpdated = true;
            shaderUpdatesThisFrame++;
            totalShaderUpdates++;
#endif
        }

        // Toggles the analytical N·L multiply applied to baked lightmap
        // transfer textures at runtime (see LayeredLightmapLighting.cginc).
        public void ToggleDirectional() => SetDirectional(!_directionalEnabled);

        public void SetDirectional(bool enabled)
        {
            _directionalEnabled = enabled;
            VRCShader.SetGlobalFloat(_directionalEnabledID, enabled ? 1f : 0f);
        }


        public void ToggleRealtimeShadows() => SetRealtimeShadows(!_realtimeShadowsEnabled);

        public void SetRealtimeShadows(bool enabled)
        {
            _realtimeShadowsEnabled = enabled;
            VRCShader.SetGlobalFloat(_realtimeShadowsEnabledID, enabled ? 1f : 0f);

            if (shadowAtlasCaster != null)
                shadowAtlasCaster.enabled = enabled;
        }

        // Runtime control over the shadow-atlas budget (e.g. a quality setting).
        // Clamped to MAX_SHADOW_SLOTS since that's the array size the shader
        // and the external shadow-camera pool were both built against.
        public void SetActiveShadowSlots(int count)
        {
            activeShadowSlots = Mathf.Clamp(count, 0, MAX_SHADOW_SLOTS);
            // Same reasoning as SetDiffuseStatic/SetSpecular: the budget change
            // affects AssignShadowSlots' eligibility, re-sort now rather than
            // waiting up to VIEWER_UPDATE_INTERVAL for it to show up.
            ForceRefresh();
        }

        public bool IsDiffuseStaticEnabled() => _diffuseStaticEnabled;
        public bool IsDiffuseRealtimeEnabled() => _diffuseRealtimeEnabled;
        public bool IsSpecularEnabled() => _specularEnabled;
        public bool IsReflectionEnabled() => _reflectionEnabled;
        public bool IsDirectionalEnabled() => _directionalEnabled;
        public bool IsRealtimeShadowsEnabled() => _realtimeShadowsEnabled;
    }
}