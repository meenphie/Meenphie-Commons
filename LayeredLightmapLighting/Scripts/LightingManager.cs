#if UDONSHARP
using UdonSharp;
#endif
using UnityEngine;
using VRC.SDKBase;

public enum LightFaultState { Normal, Broken, Panic, Off }

/// <summary>
/// Choisit les MAX_LIGHTS lights les plus pertinentes autour du joueur et les envoie au shader
/// dans le tableau global _UdonLightData :
///
///   [0]              nbLights, 0, reflectionOn, specularOn
///   [1 + 8*slot + 0] pos.xyz, intensité au merge
///              + 1   couleur live.rgb, intensité live (animée par les pannes)
///              + 2   forward.xyz, cosOuter
///              + 3   right.xyz, demi-largeur (area)
///              + 4   up.xyz, demi-hauteur (area)
///              + 5   couleur bakée.rgb, flag realtime
///              + 6   slice lightmap, diffuse on, specular on, group mask
///              + 7   slice cookie, slot shadow (-1 = aucun), type (0 point / 1 spot / 2 area), cosInner
///
/// Vocabulaire : "child" = index dans childLights (stable) ; "merged" = index compacté des lights
/// actives (change à chaque rebuild) ; "slot" = position dans le tableau envoyé au shader (trié par distance).
/// </summary>
[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class LightingManager : UdonSharpBehaviour
{
    // =================================================================
    //  CONSTANTES
    // =================================================================
    private const int MAX_LIGHTS = 32;          // doit rester cohérent avec _UdonLightData[MAX_LIGHTS * 8 + 1] côté shader
    private const int SLOT_STRIDE = 8;
    private const int MAX_SHADOW_SLOTS = 1;

    private const float MOTION_EPSILON_SQ = 0.000001f;      // 1 mm
    private const float ROTATION_EPSILON_DOT = 0.9998477f;  // ~2° d'écart
    private const float COLOR_EPSILON = 0.004f;
    private const float INTENSITY_EPSILON = 0.001f;
    private const float SMOOTHING_HALF_LIFE = 0.5f;

    private const float FAULT_FADE_SPEED = 15.0f;
    private const float PANIC_ON_MEAN_SLOW = 0.30f;
    private const float PANIC_ON_MEAN_FAST = 0.01f;
    private const float PANIC_OFF_MEAN_SLOW = 0.80f;
    private const float PANIC_OFF_MEAN_FAST = 0.02f;

    public const float UPDATE_INTERVAL = 1f / 90f;          // intervalle mini entre deux passes d'upload
    public const float VIEWER_UPDATE_INTERVAL = 1f / 10f;   // fréquence du re-tri par distance

    // =================================================================
    //  INSPECTOR
    // =================================================================
    [Header("1. Paramètres Globaux (Distance & Perf)")]
    [Tooltip("Distance globale (m) de chargement des lumières autour du joueur.")]
    public float rangeScale = 50f;
    [Tooltip("Intervalle (s) entre deux vérifications des lumières. 0 = chaque frame.")]
    public float enabledPollInterval = 0.1f;
    [Tooltip("Distance minimum avant d'appliquer le culling par angle (évite de faire disparaître les lumières trop proches).")]
    public float coneCullMinDistance = 15f;

    [Header("2. Culling Diffus (Lumière / Ombres)")]
    [Tooltip("Angle de vue (degrés) pour garder les lumières qui font du DIFFUS. 360 = pas de culling.")]
    public float fovCullAngle = 240f;

    [Header("3. Culling Spéculaire (Reflets)")]
    [Tooltip("Limite max de slots pour le spéculaire.")]
    [Range(1, MAX_LIGHTS)] public int activeSpecularCount = MAX_LIGHTS;
    [Tooltip("Distance max (m) où le reflet spéculaire est calculé par le GPU.")]
    public float specCameraFadeEnd = 20f;
    [Tooltip("Marge de sécurité CPU (m) pour éviter que le reflet ne clignote (popping) quand le joueur recule.")]
    public float specCullMargin = 0f;
    [Tooltip("Angle de vue (degrés) pour garder les lumières qui ne font QUE du SPÉCULAIRE. Attention : trop bas crée du popping quand on tourne la tête.")]
    public float specularFovCullAngle = 90f;

    [Header("4. Lightmaps & Mesh Data")]
    public Texture2D materialTable;
    public int lightmapGroupCount = 0;
    [Range(0f, 50f)] public float lodDistanceNear = 5f;
    [Range(0f, 80f)] public float lodDistanceFar = 35f;
    [Range(0f, 9f)] public float lodAtFar = 2f;


    [Header("5. Platform Texture Arrays")]
#if UNITY_ANDROID && !UNITY_EDITOR
        public Texture2DArray lightLayerArrayQuest;
        public Texture2DArray diffuseArrayQuest;
        public Texture2DArray normalArrayQuest;
        public Texture2DArray metallicArrayQuest;
        public Texture2DArray roughnessArrayQuest;
        public Texture2DArray emissionArrayQuest;
#elif !UNITY_ANDROID && !UNITY_EDITOR
    public Texture2DArray lightLayerArrayPC;
    public Texture2DArray diffuseArrayPC;
    public Texture2DArray normalArrayPC;
    public Texture2DArray metallicArrayPC;
    public Texture2DArray roughnessArrayPC;
    public Texture2DArray emissionArrayPC;
#else
        public Texture2DArray lightLayerArrayPC;
        public Texture2DArray lightLayerArrayQuest;
        public Texture2DArray diffuseArrayPC;
        public Texture2DArray diffuseArrayQuest;
        public Texture2DArray normalArrayPC;
        public Texture2DArray normalArrayQuest;
        public Texture2DArray metallicArrayPC;
        public Texture2DArray metallicArrayQuest;
        public Texture2DArray roughnessArrayPC;
        public Texture2DArray roughnessArrayQuest;
        public Texture2DArray emissionArrayPC;
        public Texture2DArray emissionArrayQuest;
#endif

    [Header("6. Cookies & Reflections")]
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
    [HideInInspector] public float reflectionProbeMaxMip;

    [Header("7. Shadows")]
    public ShadowAtlasCaster shadowAtlasCaster;
    [Range(0, MAX_SHADOW_SLOTS)] public int activeShadowSlots = 1;
    [HideInInspector] public int[] shadowSlotToMerged = new int[MAX_SHADOW_SLOTS];
    [HideInInspector] public int[] mergedToShadowSlot;
    [HideInInspector] public int activeShadowChildIndex = -1;

    [Header("8. Animation & Audio")]
    public AudioClip faultAudioClip;
    [Range(0f, 1f)] public float audioMasterVolume = 1.0f;

    [Header("9. Performance Metrics")]
    [Tooltip("Décocher pour couper les mesures une fois le réglage terminé.")]
    public bool collectMetrics = true;
    public float avgShaderUpdatesPerSecond;
    public float avgUdonMsPerFrame;

    [Header("10. Light Sources (Auto-filled)")]
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

    // Paramètres d'animation (Broken / Panic)
    [HideInInspector] public float[] childLightBrokenOnMin;
    [HideInInspector] public float[] childLightBrokenOnMax;
    [HideInInspector] public float[] childLightBrokenOffMin;
    [HideInInspector] public float[] childLightBrokenOffMax;
    [HideInInspector] public float[] childLightBrokenOnIntensity;
    [HideInInspector] public float[] childLightBrokenNoiseAmount;
    [HideInInspector] public float[] childLightBrokenEmber;
    [HideInInspector] public float[] childLightBrokenSputter;
    [HideInInspector] public float[] childLightBrokenFadeSpeed;
    [HideInInspector] public float[] childLightPanicSpeed;
    [HideInInspector] public float[] childLightPanicIntensityMin;
    [HideInInspector] public float[] childLightPanicIntensityMax;
    [HideInInspector] public float[] childLightPanicNoiseAmount;
    [HideInInspector] public float[] childLightPanicGhostRate;
    [HideInInspector] public float[] childLightPanicEmber;

    [Header("10. Merged & Internal States")]
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
    [HideInInspector] public bool[] mergedCastShadow;
    [HideInInspector] public float[] _faultIntensity;

    [HideInInspector] public Vector3[] lastLightPositions;
    [HideInInspector] public Quaternion[] lastLightRotations;
    [HideInInspector] public float[] lastLightIntensities;
    [HideInInspector] public Vector3[] lastLightColors;
    [HideInInspector] public Vector3 lastViewerPos = new Vector3(float.MaxValue, 0, 0);

#if UNITY_EDITOR
        [Header("11. Debug (Editor only)")]
        public int currentStaticLights;
        public int currentDynamicLights;
        public int currentAnimatedLights;
        public int currentSpecularsCount;
        public int sampledLightmapsCount;
        public int currentSlicesCount;
        public int currentProbesCount;
        public bool shaderWasUpdated;
        public int shaderUpdatesThisFrame;
        public int totalShaderUpdates;
        public float shaderUpdatesPerSecond;
        private float _debugTimer;
        private int _debugUpdateCount;
#endif

    // =================================================================
    //  ÉTAT INTERNE  <--- C'EST ICI QU'IL FAUT LE COLLER
    // =================================================================
    // ----- cache par child (rempli une fois dans Start) -----
    private int _childCount;
    private bool[] _childValid;             // childLights[i] != null
    private GameObject[] _childObjects;     // évite l.gameObject à chaque poll
    private Transform[] _childTransforms;
    private bool[] _childEligible;          // ni directionnelle ni ForceVertex
    private float[] _childCosOuter;
    private float[] _childCosInner;
    private AudioSource[] _childAudioSources;
    private bool[] _lastEnabledState;       // enabled && activeInHierarchy vu au dernier poll/rebuild

    // ----- fusion (indexé par merged) -----
    private int[] _lightToMerged = new int[0];
    private int[] _mergedToChild;
    private int[] _mergedToShader;          // merged -> slot shader (-1 = non envoyé)
    private float[] _mergedBaseIntensity;
    private float[] _mergedLastAnimated;

    // ----- tri et slots -----
    private int[] _indices = new int[MAX_LIGHTS];           // slot -> merged
    private int[] _sortBaked;
    private int[] _sortRealtime;
    private float[] _sortBakedDist;
    private float[] _sortRealtimeDist;
    private int[] _slotMerged = new int[MAX_LIGHTS];        // merged réellement présent dans chaque slot...
    private int[] _slotShadow = new int[MAX_LIGHTS];        // ... et son slot shadow (fait partie de l'identité du slot)
    private int _lastFinalCount = -1;
    private int _lastUploadedSlotCount;

    // ----- lights realtime présentes dans un slot, suivies à chaque passe -----
    private int _liveCount;
    private int[] _liveChild = new int[MAX_LIGHTS];
    private int[] _liveMerged = new int[MAX_LIGHTS];
    private int[] _liveSlot = new int[MAX_LIGHTS];

    // ----- animation des pannes -----
    private int[] _animList;                // merged à animer, ordre croissant
    private int _animCount;
    private float[] _faultStateTimer;
    private bool[] _faultIsOn;
    private float[] _panicTargetIntensity;
    private float[] _panicPhase;
    private float[] _brokenSinceToggle;

    // ----- audio -----
    private int[] _audioChildren;           // children qui ont un AudioSource
    private int _audioCount;
    private int _audioPlayingCount;

    // ----- upload shader -----
    private Vector4[] _shaderData = new Vector4[MAX_LIGHTS * SLOT_STRIDE + 1];
    private int _lightDataID;
    private int _diffuseStaticEnabledID;
    private int _diffuseRealtimeEnabledID;
    private int _directionalEnabledID;
    private int _realtimeShadowsEnabledID;
    private int _sssEnabledID;

    // ----- temps / joueur -----
    private VRCPlayerApi _localPlayer;
    private Transform _thisTransform;
    private Vector3 _viewForward;
    private float _tickAccumDt;
    private float _pollAccumDt;
    private float _viewerTickTimer;
    private bool _isReady;
    private bool _mergedDirty = true;
    private bool _forceAllLightsRealtime;

    // ----- toggles -----
    private bool _diffuseStaticEnabled = true;
    private bool _diffuseRealtimeEnabled = true;
    private bool _specularEnabled = true;
    private bool _reflectionEnabled = true;
    private bool _directionalEnabled = true;    // N·L analytique sur le transfert lightmap (voir cginc)
    private bool _realtimeShadowsEnabled = true;
    private bool _sssEnabled = true;

    // ----- métriques -----
    private float _emaShaderUpdatesPerSecond;
    private float _emaUdonMs;
    private float _lastRateUpdateTime;
    private int _shaderUpdateCounter;


    // =================================================================
    //  INITIALISATION
    // =================================================================
    public void MarkDirty()
    {
        _mergedDirty = true;
        _lastFinalCount = -1;
    }

#if !COMPILER_UDONSHARP && UNITY_EDITOR
        public static event System.Action EditorPreviewRefreshRequested;

        private void OnValidate()
        {
            if (childLights == null) return;
            ValidateChildArrays();
            QueuePreviewRefresh();
            LightingManagerEvents.RaisePreviewRefresh();
        }
#endif

    void Start()
    {
        _localPlayer = Networking.LocalPlayer;
        _thisTransform = transform;

        _lightDataID = VRCShader.PropertyToID("_UdonLightData");
        _directionalEnabledID = VRCShader.PropertyToID("_UdonDirectionalEnabled");
        _diffuseStaticEnabledID = VRCShader.PropertyToID("_UdonDiffuseStaticEnabled");
        _diffuseRealtimeEnabledID = VRCShader.PropertyToID("_UdonDiffuseRealtimeEnabled");
        _realtimeShadowsEnabledID = VRCShader.PropertyToID("_UdonRealtimeShadowsEnabled");
        _sssEnabledID = VRCShader.PropertyToID("_UdonSSSEnabled");

        for (int i = 0; i < MAX_LIGHTS; i++) { _slotMerged[i] = -1; _slotShadow[i] = -1; }
        for (int i = 0; i < MAX_SHADOW_SLOTS; i++) shadowSlotToMerged[i] = -1;

        UploadStaticGlobals();

        ValidateChildArrays();
        _childCount = (childLights != null) ? childLights.Length : 0;
        CacheChildData();
        AllocateMergeBuffers();
        AllocatePhysicalAnimState();

        _lastRateUpdateTime = Time.realtimeSinceStartup;

#if UNITY_EDITOR
            LogSetupSummary();
#endif

        // Premier caster d'ombre : la première light active qui projette des ombres
        if (activeShadowChildIndex < 0)
        {
            for (int i = 0; i < _childCount; i++)
            {
                if (_lastEnabledState[i] && childLightCastsShadow[i])
                {
                    activeShadowChildIndex = i;
                    break;
                }
            }
            if (activeShadowChildIndex >= 0)
            {
                ForceRefresh();
                if (shadowAtlasCaster != null) shadowAtlasCaster.UpdateShadowMatrices();
            }
        }
    }

    // Globals qui ne changent pas pendant la partie (envoyés une seule fois)
    private void UploadStaticGlobals()
    {
        int layerArrayID = VRCShader.PropertyToID("_UdonLightmapArray");
        int cookieArrayID = VRCShader.PropertyToID("_UdonCookieArray");
        int reflectionArrayID = VRCShader.PropertyToID("_UdonReflectionProbeArray");
        int reflectionValidID = VRCShader.PropertyToID("_UdonReflectionArrayValid");

#if UNITY_ANDROID
            Texture2DArray layerArray = lightLayerArrayQuest;
#else
        Texture2DArray layerArray = lightLayerArrayPC;
#endif
        _forceAllLightsRealtime = layerArray == null;
        if (layerArray != null)
        {
            VRCShader.SetGlobalTexture(layerArrayID, layerArray);
            VRCShader.SetGlobalVector(VRCShader.PropertyToID("_UdonLightmapArray_TexelSize"),
                new Vector4(1f / layerArray.width, 1f / layerArray.height, layerArray.width, layerArray.height));
        }
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightmapArrayValid"), layerArray != null ? 1f : 0f);

        if (cookieArray != null) VRCShader.SetGlobalTexture(cookieArrayID, cookieArray);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonCookieArrayValid"), cookieArray != null ? 1f : 0f);

#if UNITY_ANDROID
            VRCShader.SetGlobalTexture(reflectionArrayID, reflectionProbeArrayQuest);
            VRCShader.SetGlobalFloat(reflectionValidID, reflectionProbeArrayQuest != null ? 1f : 0f);
#else
        VRCShader.SetGlobalTexture(reflectionArrayID, reflectionProbeArrayPC);
        VRCShader.SetGlobalFloat(reflectionValidID, reflectionProbeArrayPC != null ? 1f : 0f);
#endif
        if (reflectionProbeData != null && reflectionProbeData.Length > 0)
            VRCShader.SetGlobalVectorArray(VRCShader.PropertyToID("_UdonReflectionProbeData"), reflectionProbeData);
        if (reflectionProbeHDR != null && reflectionProbeHDR.Length > 0)
            VRCShader.SetGlobalVectorArray(VRCShader.PropertyToID("_UdonReflectionProbeHDR"), reflectionProbeHDR);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonReflectionProbeCount"), (float)reflectionProbeCount);
#if UNITY_EDITOR
            currentProbesCount = reflectionProbeCount;
#endif
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonReflectionProbeMaxMip"), reflectionProbeMaxMip);

        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightmapSliceOffset"), (float)lightmapGroupCount);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceNear"), lodDistanceNear);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceFar"), lodDistanceFar);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODMaxMip"), lodAtFar);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonSpecCameraFadeEnd"), specCameraFadeEnd);

        VRCShader.SetGlobalFloat(_diffuseStaticEnabledID, _diffuseStaticEnabled ? 1f : 0f);
        VRCShader.SetGlobalFloat(_diffuseRealtimeEnabledID, _diffuseRealtimeEnabled ? 1f : 0f);
        VRCShader.SetGlobalFloat(_directionalEnabledID, _directionalEnabled ? 1f : 0f);
        VRCShader.SetGlobalFloat(_realtimeShadowsEnabledID, _realtimeShadowsEnabled ? 1f : 0f);
        VRCShader.SetGlobalFloat(_sssEnabledID, _sssEnabled ? 1f : 0f);

        PushMeshArrayGlobals();
    }

    private bool IsEffectivelyRealtime(int childIndex)
    {
        return _forceAllLightsRealtime || childLightIsRealtime[childIndex];
    }

    // Globals des mesh arrays + material table. Posés une fois au Start, jamais réécrits en jeu.
    private void PushMeshArrayGlobals()
    {
#if UNITY_ANDROID
    Texture2DArray meshDiffuse    = diffuseArrayQuest;
    Texture2DArray meshNormal    = normalArrayQuest;
    Texture2DArray meshMetallic  = metallicArrayQuest;
    Texture2DArray meshRoughness = roughnessArrayQuest;
    Texture2DArray meshEmission  = emissionArrayQuest;
#else
        Texture2DArray meshDiffuse = diffuseArrayPC;
        Texture2DArray meshNormal = normalArrayPC;
        Texture2DArray meshMetallic = metallicArrayPC;
        Texture2DArray meshRoughness = roughnessArrayPC;
        Texture2DArray meshEmission = emissionArrayPC;
#endif

        Debug.Log($"[ID] Diffuse={VRCShader.PropertyToID("_UdonDiffuseArray")} " +
                  $"Normal={VRCShader.PropertyToID("_UdonNormalArray")} " +
                  $"Metallic={VRCShader.PropertyToID("_UdonMetallicArray")} " +
                  $"Roughness={VRCShader.PropertyToID("_UdonRoughnessArray")} " +
                  $"Emission={VRCShader.PropertyToID("_UdonEmissionArray")} " +
                  $"Table={VRCShader.PropertyToID("_UdonMaterialTable")}");

        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonDiffuseArray"), meshDiffuse);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonNormalArray"), meshNormal);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonMetallicArray"), meshMetallic);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonRoughnessArray"), meshRoughness);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonEmissionArray"), meshEmission);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonMaterialTable"), materialTable);
        // Unity ne renseigne pas _TexelSize pour une texture globale : sans ça, _UdonMaterialRow lit toujours la colonne 0.
        if (materialTable != null)
            VRCShader.SetGlobalVector(VRCShader.PropertyToID("_UdonMaterialTable_TexelSize"),
                new Vector4(1f / materialTable.width, 1f / materialTable.height, materialTable.width, materialTable.height));
    }

    private void ClearMeshArrayGlobals()
    {
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonDiffuseArray"), null);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonNormalArray"), null);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonMetallicArray"), null);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonRoughnessArray"), null);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonEmissionArray"), null);
        VRCShader.SetGlobalTexture(VRCShader.PropertyToID("_UdonMaterialTable"), null);
    }

    // Tout ce qui est calculé une fois par child : références, éligibilité, angles, audio, état de référence.
    private void CacheChildData()
    {
        int n = _childCount;
        _childValid = new bool[n];
        _childObjects = new GameObject[n];
        _childTransforms = new Transform[n];
        _childEligible = new bool[n];
        _childCosOuter = new float[n];
        _childCosInner = new float[n];
        _childAudioSources = new AudioSource[n];
        _lastEnabledState = new bool[n];
        _audioChildren = new int[n];
        _audioCount = 0;

        lastLightPositions = new Vector3[n];
        lastLightRotations = new Quaternion[n];
        lastLightIntensities = new float[n];
        lastLightColors = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = childLights[i];
            if (l == null) continue;

            GameObject go = l.gameObject;
            Transform t = l.transform;
            _childValid[i] = true;
            _childObjects[i] = go;
            _childTransforms[i] = t;
            _childEligible[i] = !(l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex);

            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
            _childCosOuter[i] = cosOuter;
            _childCosInner[i] = ComputeCosInner(cosOuter);

            AudioSource src = l.GetComponent<AudioSource>();
            _childAudioSources[i] = src;
            if (src != null) { _audioChildren[_audioCount] = i; _audioCount++; }

            _lastEnabledState[i] = l.enabled && go.activeInHierarchy;

            lastLightPositions[i] = t.position;
            lastLightRotations[i] = t.rotation;
            lastLightIntensities[i] = l.intensity;
            Color c = l.color;
            lastLightColors[i] = new Vector3(c.r, c.g, c.b);
        }
    }

    private void AllocateMergeBuffers()
    {
        int cap = _childCount;

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
        mergedCookieSlice = new int[cap];
        mergedCosInner = new float[cap];
        mergedToShadowSlot = new int[cap];

        _lightToMerged = new int[cap];
        _mergedToChild = new int[cap];
        _mergedToShader = new int[cap];
        _mergedBaseIntensity = new float[cap];
        _mergedLastAnimated = new float[cap];

        // Dimensionnés sur le nombre de lights (et plus sur MAX_LIGHTS) : pas de dépassement si > 32 lights
        _animList = new int[cap];
        _sortBaked = new int[cap];
        _sortRealtime = new int[cap];
        _sortBakedDist = new float[cap];
        _sortRealtimeDist = new float[cap];

        for (int i = 0; i < cap; i++)
        {
            mergedLayerSlice[i] = -1;
            mergedDiffuseEnabled[i] = true;
            mergedSpecularEnabled[i] = true;
            mergedFaultState[i] = LightFaultState.Normal;
            mergedGroupMask[i] = ~0;
            mergedCastShadow[i] = false;
            mergedCookieSlice[i] = -1;
            mergedCosInner[i] = -1f;
            mergedToShadowSlot[i] = -1;

            _lightToMerged[i] = -1;
            _mergedToChild[i] = -1;
            _mergedToShader[i] = -1;
            _mergedBaseIntensity[i] = 1f;
            _mergedLastAnimated[i] = -1f;
        }
    }

    private void AllocatePhysicalAnimState()
    {
        int cap = _childCount;
        _faultStateTimer = new float[cap];
        _faultIsOn = new bool[cap];
        _faultIntensity = new float[cap];
        _panicTargetIntensity = new float[cap];
        _panicPhase = new float[cap];
        _brokenSinceToggle = new float[cap];

        for (int i = 0; i < cap; i++)
        {
            _faultStateTimer[i] = Random.Range(0f, 1f);
            _faultIsOn[i] = true;
            _faultIntensity[i] = 1f;
            _panicTargetIntensity[i] = (childLightPanicIntensityMax != null && i < childLightPanicIntensityMax.Length)
                ? childLightPanicIntensityMax[i] : 1.2f;
            _panicPhase[i] = Random.Range(0f, Mathf.PI * 2f);
            _brokenSinceToggle[i] = 999f;
        }
    }

    // ----- redimensionnement des tableaux inspector (un overload par type : pas de génériques en U#) -----
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

        childLightBrokenOnMin = ResizeOrDefault(childLightBrokenOnMin, cap, 0.01f);
        childLightBrokenOnMax = ResizeOrDefault(childLightBrokenOnMax, cap, 1.5f);
        childLightBrokenOffMin = ResizeOrDefault(childLightBrokenOffMin, cap, 0.5f);
        childLightBrokenOffMax = ResizeOrDefault(childLightBrokenOffMax, cap, 2.0f);
        childLightBrokenOnIntensity = ResizeOrDefault(childLightBrokenOnIntensity, cap, 0.8f);
        childLightBrokenNoiseAmount = ResizeOrDefault(childLightBrokenNoiseAmount, cap, 0.4f);
        childLightBrokenEmber = ResizeOrDefault(childLightBrokenEmber, cap, 0.02f);
        childLightBrokenSputter = ResizeOrDefault(childLightBrokenSputter, cap, 0.7f);
        childLightBrokenFadeSpeed = ResizeOrDefault(childLightBrokenFadeSpeed, cap, 6f);
        childLightPanicSpeed = ResizeOrDefault(childLightPanicSpeed, cap, 0.5f);
        childLightPanicIntensityMin = ResizeOrDefault(childLightPanicIntensityMin, cap, 0.1f);
        childLightPanicIntensityMax = ResizeOrDefault(childLightPanicIntensityMax, cap, 1.2f);

        childLightPanicNoiseAmount = ResizeOrDefault(childLightPanicNoiseAmount, cap, 0.7f);
        childLightPanicGhostRate = ResizeOrDefault(childLightPanicGhostRate, cap, 0.5f);
        childLightPanicEmber = ResizeOrDefault(childLightPanicEmber, cap, 0.03f);

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

    // =================================================================
    //  CYCLE DE VIE
    // =================================================================
    void OnEnable()
    {
        if (_isReady) PushMeshArrayGlobals();
        if (_localPlayer == null) return;
        // Des lights ont pu changer pendant que le manager était désactivé : on reconstruit tout.
        _mergedDirty = true;
        _lastFinalCount = -1;
        _viewerTickTimer = 0f;
        lastViewerPos = new Vector3(float.MaxValue, 0, 0);
        for (int i = 0; i < MAX_SHADOW_SLOTS; i++) shadowSlotToMerged[i] = -1;
    }

    void OnDisable()
    {
        _shaderData[0] = new Vector4(0f, 0f, _reflectionEnabled ? 1f : 0f, _specularEnabled ? 1f : 0f);
        for (int i = 1; i < _shaderData.Length; i++) _shaderData[i] = Vector4.zero;
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
        _lastFinalCount = 0;
        for (int i = 0; i < MAX_LIGHTS; i++) { _slotMerged[i] = -1; _slotShadow[i] = -1; }

        if (_childAudioSources != null)
            for (int k = 0; k < _audioCount; k++)
                _childAudioSources[_audioChildren[k]].Stop();
        _audioPlayingCount = 0;
    }

    // Re-tri immédiat (sans rebuild) : à appeler après un changement de réglage global.
    public void ForceRefresh()
    {
        _lastFinalCount = -1;
        _viewerTickTimer = VIEWER_UPDATE_INTERVAL;
        Tick(UPDATE_INTERVAL);
        _tickAccumDt = 0f;
    }

    // Rebuild + re-tri immédiats : à appeler après avoir activé/désactivé une light.
    public void OnLightsChanged()
    {
        _mergedDirty = true;
        ForceRefresh();
    }

    private void RefreshRealtimeMergedTransforms()
    {
        for (int i = 0; i < mergedCount; i++)
        {
            int li = _mergedToChild[i];
            if (!IsEffectivelyRealtime(li)) continue;

            Transform t = _childTransforms[li];
            Vector3 pos = t.position;
            Vector3 fwd = t.forward;
            Vector3 right = t.right;
            Vector3 up = t.up;

            mergedPos[i] = new Vector4(pos.x, pos.y, pos.z, mergedPos[i].w);
            mergedDir[i] = new Vector4(fwd.x, fwd.y, fwd.z, mergedDir[i].w);
            mergedRight[i] = new Vector4(right.x, right.y, right.z, mergedRight[i].w);
            mergedUp[i] = new Vector4(up.x, up.y, up.z, mergedUp[i].w);
        }
    }

    // =================================================================
    //  BOUCLE PRINCIPALE
    // =================================================================
    public override void PostLateUpdate()
    {
        float startTime = collectMetrics ? Time.realtimeSinceStartup : 0f;

#if UNITY_EDITOR
            shaderWasUpdated = false;
            shaderUpdatesThisFrame = 0;
#endif
        if (!_isReady) return;

        float dt = Time.deltaTime;
        _tickAccumDt += dt;
        _viewerTickTimer += dt;

        bool lightsChanged = false;
        _pollAccumDt += dt;
        if (_pollAccumDt >= enabledPollInterval)
        {
            _pollAccumDt = 0f;
            lightsChanged = PollEnabledStates();
        }

        if (lightsChanged)
        {
            _mergedDirty = true;
            ForceRefresh();
        }
        else
        {
            bool needsResort = _viewerTickTimer >= VIEWER_UPDATE_INTERVAL || _lastFinalCount < 0;
            bool intervalElapsed = _tickAccumDt >= UPDATE_INTERVAL;

            if (_mergedDirty || _animCount > 0 || needsResort)
            {
                if (intervalElapsed || needsResort)
                {
                    Tick(_tickAccumDt);
                    _tickAccumDt = 0f;
                }
            }
            else if (intervalElapsed)
            {
                // Chemin rapide : seules les lights realtime présentes dans un slot sont relues
                if (UpdateLiveData()) UploadLightData();
                _tickAccumDt = 0f;
            }
        }

        if (shadowAtlasCaster != null && shadowAtlasCaster.enabled)
            shadowAtlasCaster.UpdateShadowMatrices();

        if (collectMetrics) UpdateMetrics(startTime, dt);
    }

    // true dès qu'une light a changé d'état actif depuis le dernier rebuild.
    // Le rebuild resynchronise _lastEnabledState pour toutes les lights, inutile de continuer la boucle.
    private bool PollEnabledStates()
    {
        for (int i = 0; i < _childCount; i++)
        {
            if (!_childValid[i]) continue;
            bool cur = childLights[i].enabled && _childObjects[i].activeInHierarchy;
            if (cur != _lastEnabledState[i]) return true;
        }
        return false;
    }

    private void UploadLightData()
    {
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
        _shaderUpdateCounter++;
#if UNITY_EDITOR
            shaderWasUpdated = true;
            shaderUpdatesThisFrame++;
            totalShaderUpdates++;
            _debugUpdateCount++;
#endif
    }

    private void UpdateMetrics(float startTime, float dt)
    {
        float now = Time.realtimeSinceStartup;
        float decay = 1f - Mathf.Exp(-dt / SMOOTHING_HALF_LIFE);

        _emaUdonMs += ((now - startTime) * 1000f - _emaUdonMs) * decay;
        avgUdonMsPerFrame = _emaUdonMs;

        float rateInterval = now - _lastRateUpdateTime;
        if (rateInterval > 0.5f)
        {
            float rate = _shaderUpdateCounter / rateInterval;
            _shaderUpdateCounter = 0;
            _lastRateUpdateTime = now;

            _emaShaderUpdatesPerSecond += (rate - _emaShaderUpdatesPerSecond) * decay;
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

    public void Tick(float dt)
    {
        if (!_isReady) return;

        bool mergedRebuilt = false;
        if (_mergedDirty) { BuildMergedGroups(); _mergedDirty = false; mergedRebuilt = true; }

        // Le tri (et tout ce qui en dépend) n'est refait que toutes les VIEWER_UPDATE_INTERVAL
        // ou après un rebuild ; entre-temps _indices et les maps slot restent valides.
        bool viewerDue = mergedRebuilt || _viewerTickTimer >= VIEWER_UPDATE_INTERVAL || _lastFinalCount < 0;
        int finalCount = _lastFinalCount;
        if (viewerDue)
        {
            _viewerTickTimer = 0f;

            Vector3 viewerPos;
            if (_localPlayer != null)
            {
                VRCPlayerApi.TrackingData head = _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head);
                viewerPos = head.position;
                _viewForward = (head.rotation * Vector3.forward).normalized;
            }
            else
            {
                viewerPos = _thisTransform.position;
                _viewForward = _thisTransform.forward;
            }

            finalCount = SortNearest(viewerPos);
            lastViewerPos = viewerPos;
            RebuildSlotMaps(finalCount);
#if UNITY_EDITOR
                UpdateEditorStats(finalCount, viewerPos);
#endif
        }

        bool isDirty = mergedRebuilt || finalCount != _lastFinalCount;
        if (!isDirty && viewerDue)
        {
            for (int i = 0; i < finalCount; i++)
                if (_indices[i] != _slotMerged[i]) { isDirty = true; break; }
        }

        if (isDirty)
        {
            AssignShadowSlots();
            FillUploadBuffers(finalCount);
        }

        bool liveChanged = UpdateLiveData();
        bool animated = TickPhysicalAnimation(dt);
        if (mergedRebuilt || _animCount > 0 || _audioPlayingCount > 0) TickAudio();

        if (isDirty || animated || liveChanged) UploadLightData();

        _lastFinalCount = finalCount;
    }

    // =================================================================
    //  FUSION / TRI / UPLOAD
    // =================================================================
    public void BuildMergedGroups()
    {
        if (!_isReady || mergedPos == null) return;

        mergedCount = 0;
        _animCount = 0;
        _liveCount = 0;
        _lastFinalCount = -1;   // les index merged viennent de changer : le prochain Tick doit re-trier
                                // Les index merged sont recompactés : le cache "ce que contient chaque slot" est périmé.
        for (int i = 0; i < MAX_LIGHTS; i++) { _slotMerged[i] = -1; _slotShadow[i] = -1; }

        for (int li = 0; li < _childCount; li++)
        {
            _lightToMerged[li] = -1;
            if (!_childValid[li]) continue;

            Light l = childLights[li];
            bool active = l.enabled && _childObjects[li].activeInHierarchy;
            _lastEnabledState[li] = active;
            if (!active || !_childEligible[li]) continue;

            int mi = mergedCount;
            Transform t = _childTransforms[li];
            bool isRealtime = IsEffectivelyRealtime(li);
            LightFaultState faultState = childLightFaultState[li];

            // Une seule lecture par propriété (chaque appel Unity coûte cher en Udon)
            Vector3 pos = t.position;
            Vector3 right = t.right;
            Vector3 up = t.up;
            Vector3 fwd = t.forward;
            float liveIntensity = l.intensity;
            Color lColor = l.color;
            float intensity = (faultState == LightFaultState.Off) ? 0f : liveIntensity;
            Vector2 half = childLightHalfExtents[li];
            Vector3 bakedColor = childLightBakedColors[li];

            if (isRealtime)
            {
                // Aligne l'état de référence : UpdateLiveData ne ré-écrira pas ce qu'on vient de lire
                lastLightPositions[li] = pos;
                lastLightRotations[li] = t.rotation;
                lastLightIntensities[li] = liveIntensity;
                lastLightColors[li] = new Vector3(lColor.r, lColor.g, lColor.b);
            }

            mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, intensity);
            mergedCol[mi] = new Vector4(lColor.r, lColor.g, lColor.b, intensity);
            mergedRight[mi] = new Vector4(right.x, right.y, right.z, half.x);
            mergedUp[mi] = new Vector4(up.x, up.y, up.z, half.y);
            mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, _childCosOuter[li]);
            mergedCosInner[mi] = _childCosInner[li];
            mergedBakedCol[mi] = new Vector4(bakedColor.x, bakedColor.y, bakedColor.z, isRealtime ? 1f : 0f);

            mergedLayerSlice[mi] = childLightLayerSlices[li];
            mergedDiffuseEnabled[mi] = childLightDiffuseEnabled[li];
            mergedSpecularEnabled[mi] = childLightSpecularDistance[li];
            mergedFaultState[mi] = faultState;
            mergedGroupMask[mi] = childLightGroupIndex[li];
            mergedCastShadow[mi] = childLightCastsShadow[li];
            mergedCookieSlice[mi] = childLightCookieSlice[li];

            _mergedBaseIntensity[mi] = intensity;
            _mergedToChild[mi] = li;
            _mergedToShader[mi] = -1;
            _lightToMerged[li] = mi;

            // À animer : pannes actives, ou retour progressif à 1 après une panne.
            // Une light Off n'est jamais animée (sinon elle forcerait un Tick complet à chaque frame).
            if (faultState != LightFaultState.Off
                && (faultState != LightFaultState.Normal || Mathf.Abs(_faultIntensity[li] - 1f) > INTENSITY_EPSILON))
            {
                _animList[_animCount] = mi;
                _animCount++;
            }

            mergedCount++;
        }
    }

    // Candidats : baked d'abord (triés par distance), puis realtime (triés par distance), dans la limite de MAX_LIGHTS.
    // Les distances sont calculées une seule fois et l'insertion triée est faite au fil de l'eau.
    public int SortNearest(Vector3 viewerPos)
    {
        RefreshRealtimeMergedTransforms();

        float maxDistSq = rangeScale * rangeScale;
        float specCullDistSq = Sq(specCameraFadeEnd + specCullMargin);
        bool diffuseGloballyOn = _diffuseStaticEnabled || _diffuseRealtimeEnabled;

        float cosHalfFovGeneral = Mathf.Cos(fovCullAngle * 0.5f * Mathf.Deg2Rad);
        float cosHalfFovSpecular = Mathf.Cos(specularFovCullAngle * 0.5f * Mathf.Deg2Rad);
        float minDistSqForCone = coneCullMinDistance * coneCullMinDistance;

        float vx = viewerPos.x, vy = viewerPos.y, vz = viewerPos.z;
        float fx = _viewForward.x, fy = _viewForward.y, fz = _viewForward.z;

        int bakedCount = 0, realtimeCount = 0;

        for (int i = 0; i < mergedCount; i++)
        {
            bool canDiffuse = mergedDiffuseEnabled[i] && diffuseGloballyOn;
            bool specAllowed = mergedSpecularEnabled[i] && _specularEnabled;
            if (!canDiffuse && !specAllowed) continue;

            Vector4 mp = mergedPos[i];
            float dx = vx - mp.x, dy = vy - mp.y, dz = vz - mp.z;
            float distSq = dx * dx + dy * dy + dz * dz;
            if (distSq > maxDistSq) continue;
            if (!canDiffuse && distSq > specCullDistSq) continue;   // spéculaire seul : hors portée caméra

            // Culling conique, seulement au-delà de coneCullMinDistance (évite le popping des lights proches)
            if (distSq > minDistSqForCone)
            {
                float dist = Mathf.Sqrt(distSq);
                float cosAngle = ((mp.x - vx) * fx + (mp.y - vy) * fy + (mp.z - vz) * fz) / dist;
                if (cosAngle < (canDiffuse ? cosHalfFovGeneral : cosHalfFovSpecular)) continue;
            }

            // Insertion triée (stable : à distance égale, l'ordre merged est conservé)
            if (IsEffectivelyRealtime(_mergedToChild[i]))
            {
                int j = realtimeCount - 1;
                while (j >= 0 && _sortRealtimeDist[j] > distSq)
                {
                    _sortRealtime[j + 1] = _sortRealtime[j];
                    _sortRealtimeDist[j + 1] = _sortRealtimeDist[j];
                    j--;
                }
                _sortRealtime[j + 1] = i;
                _sortRealtimeDist[j + 1] = distSq;
                realtimeCount++;
            }
            else
            {
                int j = bakedCount - 1;
                while (j >= 0 && _sortBakedDist[j] > distSq)
                {
                    _sortBaked[j + 1] = _sortBaked[j];
                    _sortBakedDist[j + 1] = _sortBakedDist[j];
                    j--;
                }
                _sortBaked[j + 1] = i;
                _sortBakedDist[j + 1] = distSq;
                bakedCount++;
            }
        }

        int count = 0;
        for (int i = 0; i < bakedCount && count < MAX_LIGHTS; i++)
        {
            _indices[count] = _sortBaked[i];
            count++;
        }
        for (int i = 0; i < realtimeCount && count < MAX_LIGHTS; i++)
        {
            _indices[count] = _sortRealtime[i];
            count++;
        }
        return count;
    }

    // merged -> slot, et liste compacte des lights realtime à suivre (hors Off : leur intensité est forcée à 0)
    private void RebuildSlotMaps(int finalCount)
    {
        for (int i = 0; i < mergedCount; i++) _mergedToShader[i] = -1;

        _liveCount = 0;
        for (int s = 0; s < finalCount; s++)
        {
            int mi = _indices[s];
            _mergedToShader[mi] = s;

            int li = _mergedToChild[mi];
            if (IsEffectivelyRealtime(li) && mergedFaultState[mi] != LightFaultState.Off)
            {
                _liveChild[_liveCount] = li;
                _liveMerged[_liveCount] = mi;
                _liveSlot[_liveCount] = s;
                _liveCount++;
            }
        }
    }

    public void SetShadowCasterLight(int childLightIndex)
    {
        if (childLightIndex == activeShadowChildIndex) return;
        activeShadowChildIndex = childLightIndex;
        ForceRefresh();
    }

    // Pratique si le script de pickup ne connaît pas son propre index
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

    private void AssignShadowSlots()
    {
        for (int s = 0; s < MAX_SHADOW_SLOTS; s++) shadowSlotToMerged[s] = -1;
        for (int i = 0; i < mergedCount; i++) mergedToShadowSlot[i] = -1;

        if (activeShadowChildIndex < 0 || _lightToMerged == null || activeShadowChildIndex >= _lightToMerged.Length)
            return;

        int mi = _lightToMerged[activeShadowChildIndex];
        if (mi < 0) return;                                          // light désactivée / hors merge
        if (!mergedCastShadow[mi]) return;                           // Shadow Type = None
        if (mergedFaultState[mi] == LightFaultState.Off) return;

        shadowSlotToMerged[0] = mi;
        mergedToShadowSlot[mi] = 0;
    }

    // Quel transform le composant qui rend les shadow cameras doit-il utiliser pour ce slot ? (null = slot libre)
    public Transform GetShadowSlotTransform(int slot)
    {
        if (slot < 0 || slot >= MAX_SHADOW_SLOTS) return null;
        int mi = shadowSlotToMerged[slot];
        if (mi < 0) return null;
        int li = _mergedToChild[mi];
        if (li < 0 || li >= _childCount) return null;
        return _childTransforms[li];
    }

    // Ne réécrit que les slots dont le contenu a changé. L'identité d'un slot = (merged, slot shadow) :
    // changer de caster d'ombre doit ré-uploader l'ancien et le nouveau même si leur index n'a pas bougé.
    private void FillUploadBuffers(int finalCount)
    {
        _shaderData[0] = new Vector4((float)finalCount, 0f, _reflectionEnabled ? 1f : 0f, _specularEnabled ? 1f : 0f);

        for (int i = 0; i < finalCount; i++)
        {
            int idx = _indices[i];
            int shadowSlot = mergedToShadowSlot[idx];
            if (_slotMerged[i] == idx && _slotShadow[i] == shadowSlot) continue;

            int b = i * SLOT_STRIDE + 1;
            Vector4 dir = mergedDir[idx];

            _shaderData[b + 0] = mergedPos[idx];
            _shaderData[b + 1] = mergedCol[idx];
            _shaderData[b + 2] = dir;
            _shaderData[b + 3] = mergedRight[idx];
            _shaderData[b + 4] = mergedUp[idx];
            _shaderData[b + 5] = mergedBakedCol[idx];
            _shaderData[b + 6] = new Vector4(
                mergedLayerSlice[idx],
                mergedDiffuseEnabled[idx] ? 1f : 0f,
                mergedSpecularEnabled[idx] ? 1f : 0f,
                (float)mergedGroupMask[idx]);
            _shaderData[b + 7] = new Vector4(
                (float)mergedCookieSlice[idx], (float)shadowSlot, (float)GetLightTypeInt(dir.w), mergedCosInner[idx]);

            _slotMerged[i] = idx;
            _slotShadow[i] = shadowSlot;
            _mergedLastAnimated[idx] = -1f;     // force la ré-écriture de l'intensité animée
        }

        // Slots qui viennent de se libérer
        int clearUpTo = Mathf.Max(finalCount, _lastUploadedSlotCount);
        for (int i = finalCount; i < clearUpTo; i++)
        {
            int b = i * SLOT_STRIDE + 1;
            for (int k = 0; k < 6; k++) _shaderData[b + k] = Vector4.zero;
            _shaderData[b + 6] = new Vector4(-1f, 0f, 0f, 0f);
            _shaderData[b + 7] = new Vector4(0f, -1f, 0f, 0f);
            _slotMerged[i] = -1;
            _slotShadow[i] = -1;
        }
        _lastUploadedSlotCount = finalCount;
    }

    // =================================================================
    //  LIGHTS REALTIME (suivi par frame)
    // =================================================================
    // Ne parcourt que les lights realtime présentes dans un slot, et ne ré-écrit que ce qui a changé.
    private bool UpdateLiveData()
    {
        bool changed = false;
        for (int k = 0; k < _liveCount; k++)
        {
            int li = _liveChild[k];
            Transform t = _childTransforms[li];
            Light l = childLights[li];

            Vector3 pos = t.position;
            Quaternion rot = t.rotation;
            float intensity = l.intensity;
            Color lColor = l.color;
            Vector3 lastCol = lastLightColors[li];

            bool posChanged = (pos - lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
            bool rotChanged = Quaternion.Dot(rot, lastLightRotations[li]) < ROTATION_EPSILON_DOT;
            bool intChanged = Mathf.Abs(intensity - lastLightIntensities[li]) > INTENSITY_EPSILON;
            bool colChanged = Mathf.Abs(lColor.r - lastCol.x) > COLOR_EPSILON ||
                              Mathf.Abs(lColor.g - lastCol.y) > COLOR_EPSILON ||
                              Mathf.Abs(lColor.b - lastCol.z) > COLOR_EPSILON;

            if (!posChanged && !rotChanged && !intChanged && !colChanged) continue;

            changed = true;
            int mi = _liveMerged[k];
            int baseIdx = _liveSlot[k] * SLOT_STRIDE + 1;

            if (posChanged || rotChanged)
            {
                Vector3 fwd = t.forward;
                Vector3 right = t.right;
                Vector3 up = t.up;
                Vector4 oldRight = mergedRight[mi];
                Vector4 oldUp = mergedUp[mi];

                Vector4 vPos = new Vector4(pos.x, pos.y, pos.z, intensity);
                Vector4 vDir = new Vector4(fwd.x, fwd.y, fwd.z, _childCosOuter[li]);
                Vector4 vRight = new Vector4(right.x, right.y, right.z, oldRight.w);
                Vector4 vUp = new Vector4(up.x, up.y, up.z, oldUp.w);

                mergedPos[mi] = vPos;
                mergedDir[mi] = vDir;
                mergedRight[mi] = vRight;
                mergedUp[mi] = vUp;
                lastLightPositions[li] = pos;
                lastLightRotations[li] = rot;

                _shaderData[baseIdx + 0] = vPos;
                _shaderData[baseIdx + 2] = vDir;
                _shaderData[baseIdx + 3] = vRight;
                _shaderData[baseIdx + 4] = vUp;
            }

            if (intChanged || colChanged)
            {
                Vector4 vCol = new Vector4(lColor.r, lColor.g, lColor.b, intensity);
                mergedCol[mi] = vCol;
                _mergedBaseIntensity[mi] = intensity;
                lastLightIntensities[li] = intensity;
                lastLightColors[li] = new Vector3(lColor.r, lColor.g, lColor.b);

                _shaderData[baseIdx + 1] = vCol;
                // Si la light est en panne, l'animation doit re-poser son intensité animée juste après
                _mergedLastAnimated[mi] = -1f;
            }
        }
        return changed;
    }

    // =================================================================
    //  PANNES (Broken / Panic) ET AUDIO
    // =================================================================
    // Ne parcourt que _animList ; une light en sort dès qu'elle est stabilisée à 1.
    private bool TickPhysicalAnimation(float dt)
    {
        if (_animCount == 0) return false;

        bool anyChanged = false;
        int keep = 0;
        for (int k = 0; k < _animCount; k++)
        {
            int mi = _animList[k];
            int li = _mergedToChild[mi];
            LightFaultState state = mergedFaultState[mi];

            bool isFaulted = state != LightFaultState.Normal;
            if (!isFaulted && Mathf.Abs(_faultIntensity[li] - 1f) <= INTENSITY_EPSILON) continue;  // stabilisée

            _animList[keep] = mi;
            keep++;

            float newIntensity = isFaulted ? TickFault(li, state, dt) : SettleFault(li, dt);
            float animated = _mergedBaseIntensity[mi] * newIntensity;

            int si = _mergedToShader[mi];
            if (si < 0) continue;   // la panne continue de tourner même si la light n'est pas envoyée
            if (Mathf.Abs(animated - _mergedLastAnimated[mi]) <= INTENSITY_EPSILON) continue;

            _mergedLastAnimated[mi] = animated;
            anyChanged = true;

            Vector4 c = mergedCol[mi];
            _shaderData[si * SLOT_STRIDE + 2] = new Vector4(c.x, c.y, c.z, animated);
        }
        _animCount = keep;
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

    // state vaut Broken ou Panic (les lights Off ne sont jamais animées). Les paramètres sont lus
    // directement dans les tableaux child : une modification en inspector est prise en compte tout de suite.
    private float TickFault(int li, LightFaultState state, float dt)
    {
        if (state == LightFaultState.Panic)
        {
            float onMean, offMean;
            SpeedToMeans(childLightPanicSpeed[li], out onMean, out offMean);

            _faultStateTimer[li] -= dt;
            while (_faultStateTimer[li] <= 0f)
            {
                _faultIsOn[li] = !_faultIsOn[li];
                float mean = _faultIsOn[li] ? onMean : offMean;
                float u = 1f - Random.value;
                if (u <= 0.0001f) u = 0.0001f;
                _faultStateTimer[li] += -mean * Mathf.Log(u);
                if (_faultIsOn[li])
                    _panicTargetIntensity[li] = Random.Range(childLightPanicIntensityMin[li], childLightPanicIntensityMax[li]);
            }

            float baseIntensity;
            if (_faultIsOn[li])
            {
                baseIntensity = _panicTargetIntensity[li];

                // ── Bruit organique : 2 sinus à ratio irrationnel → non périodique
                float noiseAmount = childLightPanicNoiseAmount[li];
                if (noiseAmount > 0.0001f)
                {
                    float phase = Time.time * 11.3f + _panicPhase[li];
                    float n1 = Mathf.Sin(phase) * 0.5f + 0.5f;
                    float n2 = Mathf.Sin(phase * 2.71f + 1.3f + _panicPhase[li]) * 0.5f + 0.5f;
                    float noise = n1 * 0.6f + n2 * 0.4f;
                    // noise=1 → pleine intensité ; noise=0 → (1 - noiseAmount) minimum
                    baseIntensity *= 1f - noiseAmount * (1f - noise);
                }

                // ── Ghost spike : effondrement bref et imprévisible
                float ghostRate = childLightPanicGhostRate[li];
                if (ghostRate > 0f && Random.value < ghostRate * dt)
                    baseIntensity *= Random.Range(0.03f, 0.15f);
            }
            else
            {
                // ── Ember : filament encore chaud qui pulse faiblement dans le noir
                float ember = childLightPanicEmber[li];
                if (ember > 0.0001f)
                {
                    float phase = Time.time * 4.7f + _panicPhase[li] * 1.9f;
                    float flicker = Mathf.Sin(phase) * 0.5f + 0.5f;
                    baseIntensity = ember * flicker * flicker;   // carré → surtout 0, éclairs rares
                }
                else
                {
                    baseIntensity = 0f;
                }
            }

            _faultIntensity[li] = baseIntensity;
            return _faultIntensity[li];
        }

        // ── Broken — the lamp is dying and it knows it ────────────────────
        float fadeSpeed = childLightBrokenFadeSpeed[li];
        float sputterAmount = childLightBrokenSputter[li];

        _brokenSinceToggle[li] += dt;
        _faultStateTimer[li] -= dt;

        if (_faultStateTimer[li] <= 0f)
        {
            _faultIsOn[li] = !_faultIsOn[li];
            _faultStateTimer[li] = _faultIsOn[li]
                ? Random.Range(childLightBrokenOnMin[li], childLightBrokenOnMax[li])
                : Random.Range(childLightBrokenOffMin[li], childLightBrokenOffMax[li]);
            _brokenSinceToggle[li] = 0f;
        }

        float brokenPhase = Time.time * 5.1f + _panicPhase[li] * 1.7f;
        float target;

        if (_faultIsOn[li])
        {
            target = childLightBrokenOnIntensity[li];

            // 1) Sputter au turn-on : le filament essaie de "prendre"
            if (sputterAmount > 0.0001f && _brokenSinceToggle[li] < 0.35f)
            {
                float catchT = _brokenSinceToggle[li] / 0.35f;
                float catchEnv = 1f - Mathf.SmoothStep(0f, 1f, catchT);
                float osc = Mathf.Sin(_brokenSinceToggle[li] * 87f) * 0.5f + 0.5f;
                target *= 1f - sputterAmount * catchEnv * (1f - osc);
            }

            // 2) Respiration organique pendant le ON stable
            float noiseAmount = childLightBrokenNoiseAmount[li];
            if (noiseAmount > 0.0001f)
            {
                float n1 = Mathf.Sin(brokenPhase) * 0.5f + 0.5f;
                float n2 = Mathf.Sin(brokenPhase * 2.37f + 1.7f) * 0.5f + 0.5f;
                float noise = n1 * 0.65f + n2 * 0.35f;
                target *= 1f - noiseAmount * (1f - noise);
            }

            // 3) Dying flicker sur les 0.4 dernières secondes du ON
            if (sputterAmount > 0.0001f && _faultStateTimer[li] < 0.4f)
            {
                float dieT = 1f - (_faultStateTimer[li] / 0.4f);
                float dieEnv = Mathf.SmoothStep(0f, 1f, dieT);
                float osc = Mathf.Sin(_faultStateTimer[li] * -73f) * 0.5f + 0.5f;
                target *= 1f - sputterAmount * dieEnv * (1f - osc);
            }
        }
        else
        {
            // 4) Braise résiduelle dans le OFF — le filament reste chaud
            float ember = childLightBrokenEmber[li];
            if (ember > 0.0001f)
            {
                float slowPhase = Time.time * 2.3f + _panicPhase[li] * 2.1f;
                float slow = Mathf.Sin(slowPhase) * 0.5f + 0.5f;
                float pulse = Mathf.Sin(slowPhase * 4.7f + 0.9f) * 0.5f + 0.5f;
                float warmth = slow * slow * (0.7f + 0.3f * pulse);
                target = ember * warmth;
            }
            else
            {
                target = 0f;
            }
        }

        _faultIntensity[li] = Mathf.MoveTowards(_faultIntensity[li], target, fadeSpeed * dt);
        return _faultIntensity[li];
    }

    // Appelé seulement après un rebuild, pendant qu'une panne est animée, ou tant qu'un son joue :
    // sinon rien ne peut avoir changé côté audio.
    private void TickAudio()
    {
        int playing = 0;
        for (int k = 0; k < _audioCount; k++)
        {
            int li = _audioChildren[k];
            AudioSource src = _childAudioSources[li];

            int mi = _lightToMerged[li];
            bool faulted = false;
            if (mi >= 0)
            {
                LightFaultState fs = mergedFaultState[mi];
                faulted = fs == LightFaultState.Broken || fs == LightFaultState.Panic;
            }

            if (!faulted)
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
            playing++;
        }
        _audioPlayingCount = playing;
    }

    // Pousse tout de suite l'intensité courante d'une light qu'on vient de réparer
    public void FlushRestoredLight(int li)
    {
        if (_lightToMerged == null || li < 0 || li >= _lightToMerged.Length) return;
        int mi = _lightToMerged[li];
        if (mi < 0) return;
        int si = _mergedToShader[mi];
        if (si < 0) return;

        Vector4 c = mergedCol[mi];
        _shaderData[si * SLOT_STRIDE + 2] = c;
        _mergedLastAnimated[mi] = c.w;
    }

    // =================================================================
    //  UTILITAIRES
    // =================================================================
    private static float Sq(float x) => x * x;

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

    // 0 = point, 1 = spot, 2 = area (déduit de cosOuter, voir ComputeCosOuter)
    private static int GetLightTypeInt(float cosOuter)
    {
        if (cosOuter < -0.9f) return 0;
        if (cosOuter <= 0.0f) return 2;
        return 1;
    }

    // =================================================================
    //  TOGGLES (Diffuse static / realtime, Specular, Reflection, Directional, SSS, Shadows)
    // =================================================================
    public void ToggleDiffuseStatic() => SetDiffuseStatic(!_diffuseStaticEnabled);

    public void SetDiffuseStatic(bool enabled)
    {
        _diffuseStaticEnabled = enabled;
        VRCShader.SetGlobalFloat(_diffuseStaticEnabledID, enabled ? 1f : 0f);
        ForceRefresh();     // change l'éligibilité dans SortNearest : re-tri immédiat
    }

    public void ToggleDiffuseRealtime() => SetDiffuseRealtime(!_diffuseRealtimeEnabled);

    public void SetDiffuseRealtime(bool enabled)
    {
        _diffuseRealtimeEnabled = enabled;
        VRCShader.SetGlobalFloat(_diffuseRealtimeEnabledID, enabled ? 1f : 0f);
        ForceRefresh();
    }

    public void ToggleSpecular() => SetSpecular(!_specularEnabled);

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;
        _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, _shaderData[0].z, enabled ? 1f : 0f);
        UploadLightData();
        // Dans les deux sens : couper le spéculaire libère les slots des lights qui ne servaient qu'à ça
        ForceRefresh();
    }

    public void ToggleReflection() => SetReflection(!_reflectionEnabled);

    public void SetReflection(bool enabled)
    {
        _reflectionEnabled = enabled;
        _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, enabled ? 1f : 0f, _shaderData[0].w);
        UploadLightData();
    }

    // N·L analytique appliqué au transfert lightmap baké (voir LayeredLightmapLighting.cginc)
    public void ToggleDirectional() => SetDirectional(!_directionalEnabled);

    public void SetDirectional(bool enabled)
    {
        _directionalEnabled = enabled;
        VRCShader.SetGlobalFloat(_directionalEnabledID, enabled ? 1f : 0f);
    }

    public void ToggleSSS() => SetSSS(!_sssEnabled);

    public void SetSSS(bool enabled)
    {
        _sssEnabled = enabled;
        VRCShader.SetGlobalFloat(_sssEnabledID, enabled ? 1f : 0f);
    }

    public void ToggleRealtimeShadows() => SetRealtimeShadows(!_realtimeShadowsEnabled);

    // Coupe le sample de la shadow map ET le rendu de la shadow cam (n'affecte pas l'éligibilité des lights)
    public void SetRealtimeShadows(bool enabled)
    {
        _realtimeShadowsEnabled = enabled;
        VRCShader.SetGlobalFloat(_realtimeShadowsEnabledID, enabled ? 1f : 0f);

        if (shadowAtlasCaster != null)
            shadowAtlasCaster.enabled = enabled;
    }

    public void SetActiveShadowSlots(int count)
    {
        activeShadowSlots = Mathf.Clamp(count, 0, MAX_SHADOW_SLOTS);
        ForceRefresh();
    }

    public bool IsDiffuseStaticEnabled() => _diffuseStaticEnabled;
    public bool IsDiffuseRealtimeEnabled() => _diffuseRealtimeEnabled;
    public bool IsSpecularEnabled() => _specularEnabled;
    public bool IsReflectionEnabled() => _reflectionEnabled;
    public bool IsDirectionalEnabled() => _directionalEnabled;
    public bool IsRealtimeShadowsEnabled() => _realtimeShadowsEnabled;
    public bool IsSSSEnabled() => _sssEnabled;

    // =================================================================
    //  DEBUG (éditeur uniquement)
    // =================================================================
#if UNITY_EDITOR
        // Résumé de configuration au Start. Repère les causes classiques d'une scène noire : pas de Light Layer Array
        // pour la plateforme courante (UNITY_ANDROID est défini dans l'éditeur quand le build target est Android),
        // lights baked sans lightmap slice, références manquantes, aucune light.
        private void LogSetupSummary()
        {
#if UNITY_ANDROID
            bool layerArrayOk = lightLayerArrayQuest != null;
            string platform = "Quest/Android";
#else
            bool layerArrayOk = lightLayerArrayPC != null;
            string platform = "PC";
#endif
            int realtime = 0, baked = 0, bakedNoSlice = 0, missing = 0;
            for (int i = 0; i < _childCount; i++)
            {
                if (!_childValid[i]) { missing++; continue; }
                if (IsEffectivelyRealtime(i))
                {
                    realtime++;
                }
                else
                {
                    baked++;
                    if (childLightLayerSlices[i] < 0) bakedNoSlice++;
                }
            }

            Debug.Log("[LightingManager] " + _childCount + " lights (" + realtime + " realtime, " + baked
                      + " baked) - Light Layer Array " + platform + " : " + (layerArrayOk ? "OK" : "MANQUANTE"));
            Debug.Log("[LightingManager] " + reflectionProbeCount + " probe(s) réflexion envoyée(s) au shader.");
            if (reflectionProbeCount == 0)
                Debug.LogWarning("[LightingManager] Aucune reflection probe envoyée au shader : les reflets seront noirs.");
            if (_forceAllLightsRealtime)
                Debug.LogWarning("[LightingManager] Aucune Light Layer Array pour " + platform
                                 + " : toutes les lights sont traitées comme realtime jusqu'au prochain bake.");

            if (_childCount == 0)
                Debug.LogWarning("[LightingManager] childLights est vide : aucune light ne sera envoyée au shader (scène noire).");
            if (!layerArrayOk && baked > 0)
                Debug.LogWarning("[LightingManager] Pas de Light Layer Array pour " + platform
                                 + " : le diffus baké est désactivé, seules les lights realtime éclairent.");
            if (bakedNoSlice > 0)
                Debug.LogWarning("[LightingManager] " + bakedNoSlice
                                 + " light(s) baked sans lightmap slice (-1) : aucun diffus pour elles.");
            if (missing > 0)
                Debug.LogWarning("[LightingManager] " + missing + " référence(s) manquante(s) dans childLights.");
        }

        private void UpdateEditorStats(int finalCount, Vector3 viewerPos)
        {
            int dynCount = 0, statCount = 0, animCount = 0, specCount = 0, sliceCount = 0, sliceMask = 0;
            float specCullDistSq = Sq(specCameraFadeEnd + specCullMargin);

            for (int i = 0; i < finalCount; i++)
            {
                int mi = _indices[i];
                if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;

                LightFaultState fs = mergedFaultState[mi];
                if (fs == LightFaultState.Broken || fs == LightFaultState.Panic) animCount++;

                Vector4 mp = mergedPos[mi];
                float dx = viewerPos.x - mp.x, dy = viewerPos.y - mp.y, dz = viewerPos.z - mp.z;
                if (mergedSpecularEnabled[mi] && _specularEnabled && dx * dx + dy * dy + dz * dz <= specCullDistSq) specCount++;

                int sl = mergedLayerSlice[mi];
                if (sl >= 0 && sl < 32) { sliceCount++; sliceMask |= (1 << sl); }
            }

            currentStaticLights = statCount;
            currentDynamicLights = dynCount;
            currentAnimatedLights = animCount;
            currentSpecularsCount = specCount;
            currentSlicesCount = sliceCount;
            sampledLightmapsCount = CountBits(sliceMask);
        }

        private static int CountBits(int v) { int c = 0; while (v != 0) { v &= (v - 1); c++; } return c; }
#endif

#if !COMPILER_UDONSHARP && UNITY_EDITOR
        // =================================================================
        //  APERÇU EN MODE ÉDITION (C# seulement : jamais compilé par U#)
        // =================================================================
        // Hors Play, le programme Udon ne tourne pas : personne n'envoie _UdonLightData ni les globals au shader,
        // qui lit des zéros (loopCount = 0, toggles à 0) et rend noir. On les pousse donc ici, depuis OnValidate
        // (appelé au chargement de la scène, à la sortie du Play et à chaque modification du manager), depuis le
        // LightInspector et depuis le menu contextuel du composant.
        // Tout passe par des tampons statiques privés : aucun champ sérialisé du manager n'est modifié.
        // Aperçu simplifié : pas de culling conique, pas d'animation de pannes, pas de shadow map.
        private static readonly Vector4[] _previewData = new Vector4[MAX_LIGHTS * SLOT_STRIDE + 1];
        private static bool _previewQueued;
        private static bool _previewWarnedLayerMissing;

        // Repoussé à la fin de la frame d'éditeur (au chargement de la scène, les autres objets ne sont pas
        // forcément prêts pendant OnValidate) et dédoublonné.
        public void QueuePreviewRefresh()
        {
            if (Application.isPlaying || _previewQueued || !gameObject.scene.IsValid()) return;
            _previewQueued = true;
            UnityEditor.EditorApplication.delayCall += () =>
            {
                _previewQueued = false;
                if (this != null && !Application.isPlaying) PushPreview();
            };
        }

        [ContextMenu("Refresh edit-mode lighting preview")]
        public void RefreshPreviewNow()
        {
            if (!Application.isPlaying) PushPreview();
        }

        private void PushPreview()
        {
            if (childLights == null) return;

            ApplyPreviewGlobals();

            if (isActiveAndEnabled)
                BuildPreviewData(PreviewViewerPosition(), _previewData, !HasPlatformLightLayerArray());
            else
                _previewData[0] = new Vector4(0f, 0f, 1f, 1f);   // manager désactivé : aucune light, comme en jeu

            Shader.SetGlobalVectorArray("_UdonLightData", _previewData);
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }

        private Vector3 PreviewViewerPosition()
        {
            UnityEditor.SceneView view = UnityEditor.SceneView.lastActiveSceneView;
            if (view != null && view.camera != null) return view.camera.transform.position;
            if (Camera.main != null) return Camera.main.transform.position;
            return transform.position;
        }

        // Mêmes noms et mêmes valeurs par défaut que UploadStaticGlobals + l'état initial des toggles.
        private void ApplyPreviewGlobals()
        {
#if UNITY_ANDROID
            Texture2DArray layerArray = lightLayerArrayQuest;
            Texture reflectionArray = reflectionProbeArrayQuest;
            string platform = "Quest/Android";
#else
            Texture2DArray layerArray = lightLayerArrayPC;
            Texture reflectionArray = reflectionProbeArrayPC;
            string platform = "PC";
#endif
            bool layerMissing = layerArray == null;
            if (layerMissing != _previewWarnedLayerMissing)
            {
                _previewWarnedLayerMissing = layerMissing;
                if (layerMissing)
                    Debug.LogWarning("[LightingManager] Aperçu Édition : pas de Light Layer Array pour " + platform
                                     + ", le diffus baké restera noir.");
            }

            Shader.SetGlobalTexture("_UdonLightmapArray", layerArray);
            if (layerArray != null)
                Shader.SetGlobalVector("_UdonLightmapArray_TexelSize",
                    new Vector4(1f / layerArray.width, 1f / layerArray.height, layerArray.width, layerArray.height));
            Shader.SetGlobalFloat("_UdonLightmapArrayValid", layerArray != null ? 1f : 0f);
            Shader.SetGlobalFloat("_UdonLightmapSliceOffset", (float)lightmapGroupCount);

            Shader.SetGlobalTexture("_UdonCookieArray", cookieArray);
            Shader.SetGlobalFloat("_UdonCookieArrayValid", cookieArray != null ? 1f : 0f);

            Shader.SetGlobalTexture("_UdonReflectionProbeArray", reflectionArray);
            Shader.SetGlobalFloat("_UdonReflectionArrayValid", reflectionArray != null ? 1f : 0f);
            if (reflectionProbeData != null && reflectionProbeData.Length > 0)
                Shader.SetGlobalVectorArray("_UdonReflectionProbeData", reflectionProbeData);
            if (reflectionProbeHDR != null && reflectionProbeHDR.Length > 0)
                Shader.SetGlobalVectorArray("_UdonReflectionProbeHDR", reflectionProbeHDR);
            Shader.SetGlobalFloat("_UdonReflectionProbeCount", (float)reflectionProbeCount);
            Shader.SetGlobalFloat("_UdonReflectionProbeMaxMip", reflectionProbeMaxMip);

            Shader.SetGlobalFloat("_UdonLODDistanceNear", lodDistanceNear);
            Shader.SetGlobalFloat("_UdonLODDistanceFar", lodDistanceFar);
            Shader.SetGlobalFloat("_UdonLODMaxMip", lodAtFar);
            Shader.SetGlobalFloat("_UdonSpecCameraFadeEnd", specCameraFadeEnd);
            Shader.SetGlobalFloat("_UdonDiffuseStaticEnabled", _diffuseStaticEnabled ? 1f : 0f);
            Shader.SetGlobalFloat("_UdonDiffuseRealtimeEnabled", _diffuseRealtimeEnabled ? 1f : 0f);
            Shader.SetGlobalFloat("_UdonDirectionalEnabled", _directionalEnabled ? 1f : 0f);
            Shader.SetGlobalFloat("_UdonSSSEnabled", _sssEnabled ? 1f : 0f);
            Shader.SetGlobalFloat("_UdonRealtimeShadowsEnabled", _realtimeShadowsEnabled ? 1f : 0f);
        }

        private bool HasPlatformLightLayerArray()
        {
#if UNITY_ANDROID
            return lightLayerArrayQuest != null;
#else
            return lightLayerArrayPC != null;
#endif
        }

        // Même disposition et mêmes règles de tri que BuildMergedGroups / SortNearest / FillUploadBuffers.
        // Éligibles : actives, ni directionnelles ni "Not Important", diffuse ou spéculaire activé, dans rangeScale.
        // Ordre : baked d'abord (par distance), puis realtime (par distance), dans la limite de MAX_LIGHTS.
        private int BuildPreviewData(Vector3 viewer, Vector4[] dest, bool forceAllRealtime)
        {
            int n = childLights.Length;
            int[] bakedIdx = new int[n];
            float[] bakedDist = new float[n];
            int[] realtimeIdx = new int[n];
            float[] realtimeDist = new float[n];
            float maxDistSq = rangeScale * rangeScale;
            int bakedCount = 0, realtimeCount = 0;

            for (int li = 0; li < n; li++)
            {
                Light l = childLights[li];
                if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
                if (l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex) continue;
                if (!PreviewAt(childLightDiffuseEnabled, li, true) && !PreviewAt(childLightSpecularDistance, li, true)) continue;

                Vector3 p = l.transform.position;
                float dx = viewer.x - p.x, dy = viewer.y - p.y, dz = viewer.z - p.z;
                float distSq = dx * dx + dy * dy + dz * dz;
                if (distSq > maxDistSq) continue;

                // insertion triée stable, comme SortNearest
                if (forceAllRealtime || PreviewAt(childLightIsRealtime, li, true))
                {
                    int j = realtimeCount - 1;
                    while (j >= 0 && realtimeDist[j] > distSq)
                    {
                        realtimeIdx[j + 1] = realtimeIdx[j];
                        realtimeDist[j + 1] = realtimeDist[j];
                        j--;
                    }
                    realtimeIdx[j + 1] = li;
                    realtimeDist[j + 1] = distSq;
                    realtimeCount++;
                }
                else
                {
                    int j = bakedCount - 1;
                    while (j >= 0 && bakedDist[j] > distSq)
                    {
                        bakedIdx[j + 1] = bakedIdx[j];
                        bakedDist[j + 1] = bakedDist[j];
                        j--;
                    }
                    bakedIdx[j + 1] = li;
                    bakedDist[j + 1] = distSq;
                    bakedCount++;
                }
            }

            int count = Mathf.Min(bakedCount + realtimeCount, MAX_LIGHTS);
            dest[0] = new Vector4((float)count, 0f, 1f, 1f);   // nb lights, -, reflections on, specular on

            for (int slot = 0; slot < count; slot++)
            {
                int li = slot < bakedCount ? bakedIdx[slot] : realtimeIdx[slot - bakedCount];
                WritePreviewSlot(childLights[li], li, dest, 1 + slot * SLOT_STRIDE, forceAllRealtime);
            }

            for (int slot = count; slot < MAX_LIGHTS; slot++)
            {
                int b = 1 + slot * SLOT_STRIDE;
                for (int k = 0; k < 6; k++) dest[b + k] = Vector4.zero;
                dest[b + 6] = new Vector4(-1f, 0f, 0f, 0f);
                dest[b + 7] = new Vector4(0f, -1f, 0f, 0f);
            }

            return count;
        }

        private void WritePreviewSlot(Light l, int li, Vector4[] dest, int b, bool forceAllRealtime)
        {
            Transform t = l.transform;
            Vector3 pos = t.position, fwd = t.forward, right = t.right, up = t.up;
            Color c = l.color;

            bool realtime = forceAllRealtime || PreviewAt(childLightIsRealtime, li, true);
            float intensity = PreviewAt(childLightFaultState, li, LightFaultState.Normal) == LightFaultState.Off ? 0f : l.intensity;
            Vector2 half = PreviewAt(childLightHalfExtents, li, new Vector2(0.01f, 0.01f));
            Vector3 baked = PreviewAt(childLightBakedColors, li, Vector3.one);

            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
            float cosInner = ComputeCosInner(cosOuter);

            dest[b + 0] = new Vector4(pos.x, pos.y, pos.z, intensity);
            dest[b + 1] = new Vector4(c.r, c.g, c.b, intensity);
            dest[b + 2] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
            dest[b + 3] = new Vector4(right.x, right.y, right.z, half.x);
            dest[b + 4] = new Vector4(up.x, up.y, up.z, half.y);
            dest[b + 5] = new Vector4(baked.x, baked.y, baked.z, realtime ? 1f : 0f);
            dest[b + 6] = new Vector4(
                (float)PreviewAt(childLightLayerSlices, li, -1),
                PreviewAt(childLightDiffuseEnabled, li, true) ? 1f : 0f,
                PreviewAt(childLightSpecularDistance, li, true) ? 1f : 0f,
                (float)PreviewAt(childLightGroupIndex, li, ~0));
            dest[b + 7] = new Vector4(
                (float)PreviewAt(childLightCookieSlice, li, -1), -1f, (float)GetLightTypeInt(cosOuter), cosInner);
        }

        private static T PreviewAt<T>(T[] arr, int index, T fallback)
        {
            return (arr != null && index >= 0 && index < arr.Length) ? arr[index] : fallback;
        }
#endif
}