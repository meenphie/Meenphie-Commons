using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

// ─────────────────────────────────────────────────────────────────────────────
//  Enums
// ─────────────────────────────────────────────────────────────────────────────

public enum AnimationInterpolationMode
{
    Smooth,
    Step
}

public enum LightAnimationModel
{
    Fluorescent,
    Incandescent
}

// ─────────────────────────────────────────────────────────────────────────────
//  Manager
// ─────────────────────────────────────────────────────────────────────────────

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class LayeredLightingManager : UdonSharpBehaviour
{
    // ── Inspector ─────────────────────────────────────────────────────────────

    [Header("Settings")]
    public float updateInterval = 0.01f;
    [Range(1, MAX_LIGHTS)] public int activeSpecularCount = MAX_LIGHTS;
    public float rangeScale = 10f;

    [Header("Lightmap Layer")]
    public Texture2DArray lightLayerArray;
    [Range(0.05f, 2.0f)] public float lightmapLODBias = 0.3f;
    [Header("Animation – Physical Models")]
    public AnimationInterpolationMode animationInterpolation = AnimationInterpolationMode.Smooth;

    [Header("Animation – Audio Clips")]
    public AudioClip fluorescentAudioClip;
    public AudioClip incandescentAudioClip;
    [Range(0f, 1f)] public float audioMasterVolume = 0.8f;

    [Header("Debug (read-only)")]
    public int currentStaticLights;
    public int currentDynamicLights;
    public int currentAnimatedLights;
    public int currentSpecularsCount;
    public int sampledLightmapsCount;
    public int currentSlicesCount;
    public bool shaderWasUpdated;
    public int shaderUpdatesThisFrame;
    public string updateReason = "None";

    // Number of renderers in the scene currently flagged as dynamic mesh
    // receivers (_IsDynamicMesh = 1 on their shared material). Populated by
    // LayeredLightingDynamicMeshEditor when it scans the scene; this is a
    // mesh-receiver stat, not a light stat, so it isn't computed at runtime.
    [Tooltip("Renderers flagged as dynamic mesh receivers (_IsDynamicMesh=1). Updated by the dynamic mesh scan in the editor.")]
    public int dynamicMeshCount;

    // ── Constants ─────────────────────────────────────────────────────────────
    public const int MAX_LIGHTS = 32;
    public const float MOTION_EPSILON_SQ = 0.0001f;
    public const float COLOR_EPSILON = 0.004f;
    public const float INTENSITY_EPSILON = 0.001f;
    private const float VIEWER_MOVE_EPSILON_SQ = 0.25f;

    // ── Child light arrays (auto-filled by editor tool) ───────────────────────
    [Header("Light Sources (auto-filled)")]
    public Light[] childLights;

    [HideInInspector] public Vector2[] childLightHalfExtents;
    [HideInInspector] public bool[] childLightIsRealtime;
    [HideInInspector] public Vector3[] childLightBakedColors;
    public int[] childLightLayerSlices;

    [HideInInspector] public bool[] childLightDiffuseEnabled;
    [HideInInspector] public bool[] childLightSpecularDistance;
    [HideInInspector] public float[] childLightSpecularMaxDistance;
    [HideInInspector] public float[] childLightDiffuseMaxDistance;

    [HideInInspector] public bool[] childLightIsAnimated;
    [HideInInspector] public int[] childLightAnimationModel;
    [HideInInspector] public bool[] childLightIsBroken;
    [HideInInspector] public float[] childLightFailureRate;
    [HideInInspector] public int[] childLightGroupIndex;

    [HideInInspector] public AudioClip[] childLightAudioClipOverride;

    // ── Merged / GPU buffers ──────────────────────────────────────────────────
    [HideInInspector] public Vector4[] mergedPos;
    [HideInInspector] public Vector4[] mergedCol;
    [HideInInspector] public Vector4[] mergedRight;
    [HideInInspector] public Vector4[] mergedUp;
    [HideInInspector] public Vector4[] mergedDir;
    [HideInInspector] public Vector4[] mergedBakedCol;
    [HideInInspector] public int[] mergedLayerSlice;
    [HideInInspector] public bool[] mergedDiffuseEnabled;
    [HideInInspector] public bool[] mergedSpecularEnabled;
    [HideInInspector] public float[] mergedSpecularMaxDistance;
    [HideInInspector] public float[] mergedDiffuseMaxDistance;
    [HideInInspector] public bool[] mergedIsAnimated;
    [HideInInspector] public int[] mergedAnimationModel;
    [HideInInspector] public bool[] mergedIsBroken;
    [HideInInspector] public float[] mergedFailureRate;
    [HideInInspector] public int[] mergedGroupMask;
    [HideInInspector] public int mergedCount;

    // ── Physical animation state ──────────────────────────────────────────────
    // Fluorescent simplified
    private float[] _fluorStateTimer;
    private float[] _fluorFlickerPhase;
    private float[] _fluorIntensity;
    private int[] _fluorState;

    // Incandescent
    private float[] _incandThermalMass;
    private float[] _incandDriftVal;
    private float[] _incandDriftTarget;
    private float[] _incandDriftTimer;
    private float[] _incandPhase;
    private float[] _animatedIntensity;

    // ── Audio ─────────────────────────────────────────────────────────────────
    private AudioSource[] _mergedAudioSources;
    private float[] _audioSmoothVol;
    private AudioSource[] _childAudioSources;

    // ── Internal bookkeeping ──────────────────────────────────────────────────
    private Vector4[] _shaderData = new Vector4[MAX_LIGHTS * 8 + 1];
    private int _lightDataID;
    private int _layerArrayID;

    private int[] _indices = new int[MAX_LIGHTS];
    private float[] _distances = new float[MAX_LIGHTS];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[] _mergedToShader = new int[MAX_LIGHTS];
    private int _lastFinalCount = -1;
    private int _lastUploadedSlotCount;



    private Transform[] _childTransforms;
    private Transform _thisTransform;

    [HideInInspector] public Vector3[] lastLightPositions;
    [HideInInspector] public Quaternion[] lastLightRotations;
    [HideInInspector] public float[] lastLightIntensities;
    [HideInInspector] public Vector3[] lastLightColors;
    [HideInInspector] public Vector3 lastViewerPos = new Vector3(float.MaxValue, 0, 0);

    private int[] _lightToMerged = new int[0];
    private bool _isReady;
    private int _animatedMask;

    private VRCPlayerApi _localPlayer;
    private float _tickTimer;
    private bool _specularEnabled = true;

    private float[] _lastAnimatedIntensity = new float[MAX_LIGHTS];

    // ═══════════════════════════════════════════════════════════════════════
    // FLUORESCENT SIMPLIFIED CONSTANTS
    // ═══════════════════════════════════════════════════════════════════════

    private const int FLUOR_OFF = 0;
    private const int FLUOR_PREHEAT = 1;
    private const int FLUOR_FLASH = 2;
    private const int FLUOR_ON = 3;
    private const int FLUOR_FLICKER = 4;
    private const int FLUOR_DYING = 5;

    private const float OFF_MIN = 0.3f;
    private const float OFF_MAX = 2.0f;
    private const float PREHEAT_MIN = 0.2f;
    private const float PREHEAT_MAX = 0.8f;
    private const float FLASH_MIN = 0.03f;
    private const float FLASH_MAX = 0.12f;
    private const float ON_MIN = 0.5f;
    private const float ON_MAX = 6.0f;
    private const float FLICKER_MIN = 0.3f;
    private const float FLICKER_MAX = 2.0f;
    private const float DYING_MIN = 0.15f;
    private const float DYING_MAX = 0.5f;
    private const float BASE_IGNITION_CHANCE = 0.50f;
    private const float DOUBLE_FLASH_CHANCE = 0.20f;

    // Incandescent tuning
    private const float INCAND_THERMAL_SPEED = 4f;
    private const float INCAND_DRIFT_RATE_MIN = 0.8f;
    private const float INCAND_DRIFT_RATE_MAX = 2.5f;
    private const float INCAND_DRIFT_AMPLITUDE = 0.03f;
    private const float INCAND_WAVER_FREQ = 0.4f;
    private const float INCAND_WAVER_AMPLITUDE = 0.01f;


    // ── Editor-only validation ────────────────────────────────────────────────
#if !COMPILER_UDONSHARP && UNITY_EDITOR
    private void OnValidate()
    {
        if (childLights == null) return;
        int cap = childLights.Length;

        if (childLightIsRealtime == null || childLightIsRealtime.Length != cap)
            childLightIsRealtime = new bool[cap];
        if (childLightDiffuseEnabled == null || childLightDiffuseEnabled.Length != cap)
            childLightDiffuseEnabled = new bool[cap];
        if (childLightSpecularDistance == null || childLightSpecularDistance.Length != cap)
            childLightSpecularDistance = new bool[cap];
        if (childLightSpecularMaxDistance == null || childLightSpecularMaxDistance.Length != cap)
            childLightSpecularMaxDistance = new float[cap];
        if (childLightDiffuseMaxDistance == null || childLightDiffuseMaxDistance.Length != cap)
            childLightDiffuseMaxDistance = new float[cap];
        if (childLightIsAnimated == null || childLightIsAnimated.Length != cap)
            childLightIsAnimated = new bool[cap];
        if (childLightAnimationModel == null || childLightAnimationModel.Length != cap)
            childLightAnimationModel = new int[cap];

        if (childLightIsBroken == null || childLightIsBroken.Length != cap)
            childLightIsBroken = new bool[cap];

        if (childLightFailureRate == null || childLightFailureRate.Length != cap)
        {
            childLightFailureRate = new float[cap];
            for (int i = 0; i < cap; i++)
                if (childLightFailureRate[i] <= 0f) childLightFailureRate[i] = 0.5f;
        }

        if (childLightGroupIndex == null)
        {
            childLightGroupIndex = new int[cap];
            for (int i = 0; i < cap; i++) childLightGroupIndex[i] = ~0;
        }
        else if (childLightGroupIndex.Length != cap)
        {
            int oldLen = childLightGroupIndex.Length;
            System.Array.Resize(ref childLightGroupIndex, cap);
            for (int i = oldLen; i < cap; i++) childLightGroupIndex[i] = ~0;
        }
        if (childLightAudioClipOverride == null || childLightAudioClipOverride.Length != cap)
        {
            System.Array.Resize(ref childLightAudioClipOverride, cap);
        }
    }
#endif

    // ── Start ─────────────────────────────────────────────────────────────────
    void Start()
    {
        _localPlayer = Networking.LocalPlayer;
        _thisTransform = transform;
        _lightDataID = VRCShader.PropertyToID("_UdonLightData");
        _layerArrayID = VRCShader.PropertyToID("_UdonLightLayerArray");


        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            _lastIndicesSorted[i] = -1;
            _lastAnimatedIntensity[i] = -1f;
        }

        if (lightLayerArray != null)
            VRCShader.SetGlobalTexture(_layerArrayID, lightLayerArray);

        ValidateChildArrays();
        AllocateMergeBuffers();
        AllocatePhysicalAnimState();
        CacheChildAudioSources();

        int n = (childLights != null) ? childLights.Length : 0;
        lastLightPositions = new Vector3[n];
        lastLightRotations = new Quaternion[n];
        lastLightIntensities = new float[n];
        lastLightColors = new Vector3[n];

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
    }

    // ── Allocation helpers ────────────────────────────────────────────────────
    private void AllocatePhysicalAnimState()
    {
        int cap = (childLights != null) ? childLights.Length : MAX_LIGHTS;

        _fluorStateTimer = new float[cap];
        _fluorFlickerPhase = new float[cap];
        _fluorIntensity = new float[cap];
        _fluorState = new int[cap];

        _incandThermalMass = new float[cap];
        _incandDriftVal = new float[cap];
        _incandDriftTarget = new float[cap];
        _incandDriftTimer = new float[cap];
        _incandPhase = new float[cap];

        _animatedIntensity = new float[cap];
        _audioSmoothVol = new float[cap];

        for (int i = 0; i < cap; i++)
        {
            _incandThermalMass[i] = 1f;
            _incandDriftTarget[i] = 1f;
            _incandDriftVal[i] = 1f;
            _animatedIntensity[i] = 1f;
            _audioSmoothVol[i] = 0f;

            _fluorStateTimer[i] = Random.Range(0f, 2f);
            _fluorFlickerPhase[i] = Random.Range(0f, Mathf.PI * 2f);
            _fluorIntensity[i] = 0f;
            _fluorState[i] = FLUOR_OFF;
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

    private void ValidateChildArrays()
    {
        int cap = (childLights != null) ? childLights.Length : 0;
        childLightHalfExtents = ResizeOrDefault(childLightHalfExtents, cap, new Vector2(0.01f, 0.01f));
        childLightIsRealtime = ResizeOrDefault(childLightIsRealtime, cap, true);
        childLightBakedColors = ResizeOrDefault(childLightBakedColors, cap, Vector3.one);
        childLightLayerSlices = ResizeOrDefault(childLightLayerSlices, cap, -1);
        childLightDiffuseEnabled = ResizeOrDefault(childLightDiffuseEnabled, cap, true);
        childLightSpecularDistance = ResizeOrDefault(childLightSpecularDistance, cap, true);
        childLightSpecularMaxDistance = ResizeOrDefault(childLightSpecularMaxDistance, cap, 30f);
        childLightDiffuseMaxDistance = ResizeOrDefault(childLightDiffuseMaxDistance, cap, 60f);
        childLightIsAnimated = ResizeOrDefault(childLightIsAnimated, cap, false);
        childLightAnimationModel = ResizeOrDefault(childLightAnimationModel, cap, 0);
        childLightIsBroken = ResizeOrDefault(childLightIsBroken, cap, false);
        childLightFailureRate = ResizeOrDefault(childLightFailureRate, cap, 0.5f);
        childLightGroupIndex = ResizeOrDefault(childLightGroupIndex, cap, ~0);

        if (childLightAudioClipOverride == null || childLightAudioClipOverride.Length != cap)
        {
            AudioClip[] tmp = new AudioClip[cap];
            int copyLen = (childLightAudioClipOverride != null) ? Mathf.Min(childLightAudioClipOverride.Length, cap) : 0;
            for (int i = 0; i < copyLen; i++) tmp[i] = childLightAudioClipOverride[i];
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
        mergedSpecularMaxDistance = new float[cap];
        mergedDiffuseMaxDistance = new float[cap];
        mergedIsAnimated = new bool[cap];
        mergedAnimationModel = new int[cap];
        mergedIsBroken = new bool[cap];
        mergedFailureRate = new float[cap];
        mergedGroupMask = new int[cap];

        _mergedAudioSources = new AudioSource[cap];

        for (int i = 0; i < cap; i++)
        {
            mergedLayerSlice[i] = -1;
            mergedDiffuseEnabled[i] = true;
            mergedSpecularEnabled[i] = true;
            mergedSpecularMaxDistance[i] = 0f;
            mergedDiffuseMaxDistance[i] = 0f;
            mergedIsAnimated[i] = false;
            mergedAnimationModel[i] = 0;
            mergedIsBroken[i] = false;
            mergedFailureRate[i] = 0f;
            mergedGroupMask[i] = ~0;
        }

        _childTransforms = new Transform[cap];
        for (int i = 0; i < cap; i++)
        {
            if (childLights != null && i < childLights.Length && childLights[i] != null)
                _childTransforms[i] = childLights[i].transform;
        }

        ValidateChildArrays();
    }

    // ── ResizeOrDefault overloads ─────────────────────────────────────────────
    private bool[] ResizeOrDefault(bool[] arr, int cap, bool def)
    {
        if (arr != null && arr.Length == cap) return arr;
        bool[] r = new bool[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        for (int i = 0; i < c; i++) r[i] = arr[i];
        for (int i = c; i < cap; i++) r[i] = def;
        return r;
    }
    private int[] ResizeOrDefault(int[] arr, int cap, int def)
    {
        if (arr != null && arr.Length == cap) return arr;
        int[] r = new int[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        for (int i = 0; i < c; i++) r[i] = arr[i];
        for (int i = c; i < cap; i++) r[i] = def;
        return r;
    }
    private float[] ResizeOrDefault(float[] arr, int cap, float def)
    {
        if (arr != null && arr.Length == cap) return arr;
        float[] r = new float[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        for (int i = 0; i < c; i++) r[i] = arr[i];
        for (int i = c; i < cap; i++) r[i] = def;
        return r;
    }
    private Vector2[] ResizeOrDefault(Vector2[] arr, int cap, Vector2 def)
    {
        if (arr != null && arr.Length == cap) return arr;
        Vector2[] r = new Vector2[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        for (int i = 0; i < c; i++) r[i] = arr[i];
        for (int i = c; i < cap; i++) r[i] = def;
        return r;
    }
    private Vector3[] ResizeOrDefault(Vector3[] arr, int cap, Vector3 def)
    {
        if (arr != null && arr.Length == cap) return arr;
        Vector3[] r = new Vector3[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        for (int i = 0; i < c; i++) r[i] = arr[i];
        for (int i = c; i < cap; i++) r[i] = def;
        return r;
    }

    // ── OnEnable / OnDisable ──────────────────────────────────────────────────
    void OnEnable()
    {
        if (_localPlayer == null) return;
        _lastFinalCount = -1;
        lastViewerPos = new Vector3(float.MaxValue, 0, 0);
        for (int i = 0; i < MAX_LIGHTS; i++) _lastAnimatedIntensity[i] = -1f;
    }
    void OnDisable()
    {
        _shaderData[0] = Vector4.zero;
        for (int i = 1; i < _shaderData.Length; i++) _shaderData[i] = Vector4.zero;
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
        _lastFinalCount = 0;
        currentStaticLights = 0;
        currentDynamicLights = 0;
        currentAnimatedLights = 0;
        currentSpecularsCount = 0;
        sampledLightmapsCount = 0;
        currentSlicesCount = 0;
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        if (_childAudioSources != null)
            for (int i = 0; i < _childAudioSources.Length; i++)
                if (_childAudioSources[i] != null) _childAudioSources[i].Stop();
    }

    // ── Update ────────────────────────────────────────────────────────────────
    void Update()
    {
        shaderWasUpdated = false;
        shaderUpdatesThisFrame = 0;
        if (!_isReady || childLights == null || childLights.Length == 0) return;

        float dt = Time.deltaTime;
        _tickTimer += dt;
        bool dueForTick = _tickTimer >= updateInterval;

        if (dueForTick)
        {
            _tickTimer = 0f;
            Tick(); // Tick() fait déjà son propre SetGlobalVectorArray si isDirty || animated
        }
        else
        {
            // on garde les calculs à jour en interne (pour ne pas perdre d'état),
            // mais on n'uploade RIEN au shader hors tick
            UpdateLiveData(dt);
            TickPhysicalAnimation(dt);
        }
    }

    // ── TickPhysicalAnimation ─────────────────────────────────────────────────
    private bool TickPhysicalAnimation(float dt)
    {
        if (mergedCount == 0 || _animatedMask == 0) return false;
        bool anyChanged = false;
        for (int mi = 0; mi < mergedCount; mi++)
        {
            if (!mergedIsAnimated[mi]) continue;
            int si = _mergedToShader[mi];
            if (si < 0) continue;

            float newIntensity;
            int model = mergedAnimationModel[mi];
            if (model == (int)LightAnimationModel.Fluorescent)
            {
                newIntensity = TickFluorescentRealistic(mi, dt);
            }
            else
            {
                newIntensity = TickIncandescent(mi, dt);
            }

            _animatedIntensity[mi] = newIntensity;
            float baseIntensity = mergedCol[mi].w;
            float animated = baseIntensity * newIntensity;

            float prev = _lastAnimatedIntensity[si];
            int baseIdx = si * 8 + 1;
            Vector4 c = mergedCol[mi];
            _shaderData[baseIdx + 1] = new Vector4(c.x, c.y, c.z, animated);
            _lastAnimatedIntensity[si] = animated;
            if (Mathf.Abs(animated - prev) > INTENSITY_EPSILON) anyChanged = true;
        }
        return anyChanged;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // FLUORESCENT SIMPLIFIED STATE MACHINE
    // ═══════════════════════════════════════════════════════════════════════

    private float TickFluorescentRealistic(int mi, float dt)
    {
        bool isBroken = mergedIsBroken[mi];
        float failureRate = Mathf.Clamp01(mergedFailureRate[mi]);

        // Néon neuf : constant, zéro update GPU
        if (!isBroken)
        {
            _fluorIntensity[mi] = 1f;
            return 1f;
        }

        int state = _fluorState[mi];
        _fluorStateTimer[mi] -= dt;
        float t = _fluorStateTimer[mi];

        switch (state)
        {
            // ── ÉTEINT : attente courte, parfois saute le préchauffage ──
            case FLUOR_OFF:
                {
                    if (t <= 0f)
                    {
                        if (Random.value < 0.25f)
                        {
                            _fluorState[mi] = FLUOR_FLASH;
                            _fluorStateTimer[mi] = Random.Range(FLASH_MIN, FLASH_MAX);
                        }
                        else
                        {
                            _fluorState[mi] = FLUOR_PREHEAT;
                            _fluorStateTimer[mi] = Random.Range(PREHEAT_MIN, PREHEAT_MAX);
                        }
                    }
                    return SmoothIntensity(mi, 0f, dt);
                }

            // ── PRÉCHAUFFAGE : cathodes rougeoyent faiblement ───────────
            case FLUOR_PREHEAT:
                {
                    float glow = 0.04f + 0.06f * Mathf.PingPong(Time.time * 3f + mi, 1f);

                    if (t <= 0f)
                    {
                        _fluorState[mi] = FLUOR_FLASH;
                        _fluorStateTimer[mi] = Random.Range(FLASH_MIN, FLASH_MAX);
                    }
                    return SmoothIntensity(mi, glow, dt);
                }

            // ── FLASH D'ARC : arc électrique très bref et brillant ─────
            case FLUOR_FLASH:
                {
                    _fluorFlickerPhase[mi] += dt * Random.Range(300f, 600f);
                    float flash = 0.7f + 0.3f * Mathf.PerlinNoise(_fluorFlickerPhase[mi] * 0.3f, mi * 7.3f);
                    flash = Mathf.Clamp01(flash);

                    if (t <= 0f)
                    {
                        bool tubeStillHot = _fluorIntensity[mi] > 0.20f;
                        float chance = Mathf.Lerp(BASE_IGNITION_CHANCE, 0.05f, failureRate);
                        if (tubeStillHot) chance += 0.30f;

                        if (Random.value < chance)
                        {
                            _fluorState[mi] = FLUOR_ON;
                            float onTime = Random.Range(ON_MIN, ON_MAX) * (1f - failureRate * 0.7f);
                            _fluorStateTimer[mi] = Mathf.Max(0.4f, onTime);
                        }
                        else
                        {
                            // Double-flash parfois (starter qui clique 2x)
                            if (Random.value < DOUBLE_FLASH_CHANCE)
                            {
                                _fluorState[mi] = FLUOR_FLASH;
                                _fluorStateTimer[mi] = Random.Range(0.02f, 0.06f);
                            }
                            else
                            {
                                _fluorState[mi] = FLUOR_OFF;
                                _fluorStateTimer[mi] = Random.Range(OFF_MIN, OFF_MAX)
                                                        * Mathf.Lerp(0.3f, 1.1f, failureRate);
                            }
                        }
                    }
                    return SmoothIntensity(mi, flash, dt);
                }

            // ── ALLUMÉ : stable, micro-drops aléatoires ─────────────────
            case FLUOR_ON:
                {
                    _fluorFlickerPhase[mi] += dt * 100f;
                    float flicker = 1f + Mathf.Sin(_fluorFlickerPhase[mi]) * 0.008f;

                    if (Random.value < 0.005f + failureRate * 0.01f)
                        flicker *= Random.Range(0.75f, 0.95f);

                    if (t <= 0f)
                    {
                        // Extinction soudaine ou dégradation
                        if (Random.value < 0.35f)
                        {
                            _fluorState[mi] = FLUOR_OFF;
                            _fluorStateTimer[mi] = Random.Range(OFF_MIN, OFF_MAX);
                        }
                        else
                        {
                            _fluorState[mi] = FLUOR_FLICKER;
                            _fluorStateTimer[mi] = Random.Range(FLICKER_MIN, FLICKER_MAX);
                        }
                    }
                    return SmoothIntensity(mi, flicker, dt);
                }

            // ── CLIGNOTEMENT : fréquence instable, drops profonds ──────
            case FLUOR_FLICKER:
                {
                    if (Random.value < 0.15f)
                        _fluorFlickerPhase[mi] += dt * Random.Range(10f, 80f);
                    else
                        _fluorFlickerPhase[mi] += dt * Random.Range(30f, 60f);

                    float flicker = 0.30f + 0.45f * Mathf.Sin(_fluorFlickerPhase[mi]);

                    if (Random.value < 0.08f + failureRate * 0.25f)
                        flicker *= Random.Range(0.0f, 0.40f);

                    flicker = Mathf.Max(0.0f, flicker);

                    if (t <= 0f)
                    {
                        _fluorState[mi] = FLUOR_DYING;
                        _fluorStateTimer[mi] = Random.Range(DYING_MIN, DYING_MAX);
                    }
                    return SmoothIntensity(mi, flicker, dt);
                }

            // ── EXTINCTION : s'éteint vite, derniers flashs ─────────────
            case FLUOR_DYING:
                {
                    float intensity = Mathf.Max(0f, t * 0.5f);

                    if (Random.value < 0.25f)
                        intensity += Random.value * 0.15f;
                    intensity = Mathf.Min(intensity, 0.35f);

                    if (t <= 0f)
                    {
                        _fluorState[mi] = FLUOR_OFF;
                        _fluorStateTimer[mi] = Random.Range(OFF_MIN, OFF_MAX);
                    }
                    return SmoothIntensity(mi, intensity, dt);
                }
        }

        _fluorState[mi] = FLUOR_OFF;
        _fluorStateTimer[mi] = Random.Range(0.2f, 1.0f);
        return SmoothIntensity(mi, 0f, dt);
    }

    private float SmoothIntensity(int mi, float target, float dt)
    {
        float current = _fluorIntensity[mi];
        if (target > current + 0.3f)
            _fluorIntensity[mi] = Mathf.Lerp(current, target, dt * 40f);
        else
        {
            float speed = (target > current) ? 12f : 6f;
            _fluorIntensity[mi] = Mathf.Lerp(current, target, dt * speed);
        }
        return _fluorIntensity[mi];
    }

    // ── Incandescent model ────────────────────────────────────────────────────
    private float TickIncandescent(int mi, float dt)
    {
        _incandDriftTimer[mi] -= dt;
        if (_incandDriftTimer[mi] <= 0f)
        {
            _incandDriftTimer[mi] = Random.Range(INCAND_DRIFT_RATE_MIN, INCAND_DRIFT_RATE_MAX);
            _incandDriftTarget[mi] = 1f + Random.Range(-INCAND_DRIFT_AMPLITUDE, INCAND_DRIFT_AMPLITUDE);
        }
        _incandDriftVal[mi] = Mathf.Lerp(_incandDriftVal[mi], _incandDriftTarget[mi], dt * 0.8f);
        _incandThermalMass[mi] = Mathf.Lerp(_incandThermalMass[mi], _incandDriftVal[mi], dt * INCAND_THERMAL_SPEED);
        _incandPhase[mi] += dt * INCAND_WAVER_FREQ * Mathf.PI * 2f;
        float waver = Mathf.Sin(_incandPhase[mi]) * INCAND_WAVER_AMPLITUDE;
        return Mathf.Clamp01(_incandThermalMass[mi] + waver);
    }

    // ── Audio ─────────────────────────────────────────────────────────────────
    private void TickAudio(float dt)
    {
        if (_childAudioSources == null) return;
        int childCount = (childLights != null) ? childLights.Length : 0;
        for (int li = 0; li < childCount; li++)
        {
            AudioSource src = _childAudioSources[li];
            if (src == null) continue;
            int mi = (_lightToMerged != null && li < _lightToMerged.Length) ? _lightToMerged[li] : -1;
            if (mi < 0 || !mergedIsAnimated[mi])
            {
                if (src.isPlaying)
                {
                    int volIdx = li < _audioSmoothVol.Length ? li : 0;
                    _audioSmoothVol[volIdx] = Mathf.MoveTowards(_audioSmoothVol[volIdx], 0f, dt * 2f);
                    src.volume = _audioSmoothVol[volIdx] * audioMasterVolume;
                    if (src.volume < 0.001f) src.Stop();
                }
                continue;
            }
            AudioClip targetClip;
            if (childLightAudioClipOverride != null && li < childLightAudioClipOverride.Length && childLightAudioClipOverride[li] != null)
                targetClip = childLightAudioClipOverride[li];
            else
                targetClip = (mergedAnimationModel[mi] == (int)LightAnimationModel.Fluorescent) ? fluorescentAudioClip : incandescentAudioClip;
            if (targetClip == null)
            {
                if (src.isPlaying) src.Stop();
                continue;
            }
            if (!src.isPlaying || src.clip != targetClip)
            {
                src.clip = targetClip;
                src.loop = true;
                src.Play();
            }
            float targetVol = _animatedIntensity[mi];
            int volIdx2 = li < _audioSmoothVol.Length ? li : 0;
            _audioSmoothVol[volIdx2] = Mathf.Lerp(_audioSmoothVol[volIdx2], targetVol, dt * 8f);
            src.volume = _audioSmoothVol[volIdx2] * audioMasterVolume;
        }
    }

    // ── UpdateLiveData ────────────────────────────────────────────────────────
    private bool UpdateLiveData(float dt)
    {
        if (!_isReady || _lightToMerged == null || _lightToMerged.Length != childLights.Length) return false;
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

            bool posChanged = (pos - lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
            bool rotChanged = Quaternion.Dot(rot, lastLightRotations[li]) < 0.9999f;
            bool intChanged = Mathf.Abs(intensity - lastLightIntensities[li]) > INTENSITY_EPSILON;
            bool colChanged = Mathf.Abs(lColor.r - lastLightColors[li].x) > COLOR_EPSILON ||
                              Mathf.Abs(lColor.g - lastLightColors[li].y) > COLOR_EPSILON ||
                              Mathf.Abs(lColor.b - lastLightColors[li].z) > COLOR_EPSILON;
            if (!posChanged && !rotChanged && !intChanged && !colChanged) continue;

            changed = true;
            int baseIdx = si * 8 + 1;

            if (posChanged)
            {
                Vector4 p = mergedPos[mi];
                mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, p.w);
                _shaderData[baseIdx + 0] = mergedPos[mi];
                lastLightPositions[li] = pos;
            }
            if (rotChanged)
            {
                Vector3 fwd = rot * Vector3.forward;
                Vector3 right = rot * Vector3.right;
                Vector3 up = rot * Vector3.up;
                mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, mergedDir[mi].w);
                mergedRight[mi] = new Vector4(right.x, right.y, right.z, mergedRight[mi].w);
                mergedUp[mi] = new Vector4(up.x, up.y, up.z, mergedUp[mi].w);
                _shaderData[baseIdx + 2] = mergedDir[mi];
                _shaderData[baseIdx + 3] = mergedRight[mi];
                _shaderData[baseIdx + 4] = mergedUp[mi];
                lastLightRotations[li] = rot;
            }
            if (intChanged || colChanged)
            {
                Vector3 col = new Vector3(lColor.r, lColor.g, lColor.b);
                mergedCol[mi] = new Vector4(col.x, col.y, col.z, intensity);
                Vector4 mp = mergedPos[mi];
                mergedPos[mi] = new Vector4(mp.x, mp.y, mp.z, intensity);
                _shaderData[baseIdx + 0] = mergedPos[mi];
                _shaderData[baseIdx + 1] = mergedCol[mi];
                lastLightIntensities[li] = intensity;
                lastLightColors[li] = col;
            }
        }
        return changed;
    }

    // ── Tick ──────────────────────────────────────────────────────────────────
    public void Tick()
    {
        if (!_isReady || childLights == null || childLights.Length == 0) return;
        float dt = Time.deltaTime;
        Vector3 viewerPos = _localPlayer != null ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position : _thisTransform.position;
        BuildMergedGroups();

        bool viewerMoved = (viewerPos - lastViewerPos).sqrMagnitude > VIEWER_MOVE_EPSILON_SQ;
        int finalCount;
        if (viewerMoved) { finalCount = SortNearest(viewerPos); lastViewerPos = viewerPos; }
        else finalCount = _lastFinalCount >= 0 ? _lastFinalCount : SortNearest(viewerPos);

        int dynCount = 0, statCount = 0, animCount = 0, specCount = 0, sliceCount = 0;
        int sliceMask = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int mi = _indices[i];
            if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
            if (mergedIsAnimated[mi]) animCount++;
            if (mergedSpecularEnabled[mi]) specCount++;
            int sl = mergedLayerSlice[mi];
            if (sl >= 0 && sl < 32) { sliceCount++; sliceMask |= (1 << sl); }
        }
        currentStaticLights = statCount;
        currentDynamicLights = dynCount;
        currentAnimatedLights = animCount;
        currentSpecularsCount = specCount;
        currentSlicesCount = sliceCount;
        sampledLightmapsCount = CountBits(sliceMask);

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

        bool isDirty = finalCount != _lastFinalCount;
        if (!isDirty)
            for (int i = 0; i < finalCount; i++)
                if (_indices[i] != _lastIndicesSorted[i]) { isDirty = true; break; }

        FillUploadBuffers(finalCount);
        bool animated = TickPhysicalAnimation(dt);
        TickAudio(dt);

        if (isDirty || animated)
        {
            VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
            shaderWasUpdated = true;
            shaderUpdatesThisFrame++;
#if UNITY_EDITOR
            updateReason = BuildTickReason(isDirty, animated, finalCount, animCount, viewerMoved);
            Debug.Log("[LLM] " + updateReason);
#endif
        }
        CacheLightStates();
        _lastFinalCount = finalCount;
    }

#if UNITY_EDITOR
    private string BuildTickReason(bool resort, bool animated, int total, int animCount, bool moved)
    {
        string s = "Tick[" + total.ToString() + " lights";
        if (resort && moved) s += ", resort(viewer moved)";
        else if (resort) s += ", resort(count changed)";
        if (animated) s += ", anim(" + animCount.ToString() + " lights)";
        s += "]";
        return s;
    }
    private string BuildRuntimeReason(bool live, bool animated)
    {
        string s = "Runtime[";
        if (live) s += "LiveData";
        if (animated)
        {
            if (live) s += " ";
            int ac = 0;
            for (int mi = 0; mi < mergedCount; mi++)
                if (mergedIsAnimated[mi] && _mergedToShader[mi] >= 0) ac++;
            s += "Anim(" + ac.ToString() + " lights)";
        }
        s += "]";
        return s;
    }
#else
    private string BuildTickReason(bool a, bool b, int c, int d, bool e) => "";
    private string BuildRuntimeReason(bool a, bool b) => "";
#endif

    // ── BuildMergedGroups ─────────────────────────────────────────────────────
    public void BuildMergedGroups()
    {
        if (!_isReady) return;
        if (mergedPos == null || mergedPos.Length < childLights.Length) AllocateMergeBuffers();
        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length) _lightToMerged = new int[childLights.Length];

        mergedCount = 0;
        _animatedMask = 0;
        int childCount = childLights.Length;

        for (int li = 0; li < childCount; li++)
        {
            _lightToMerged[li] = -1;
            Light l = childLights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
            if (l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex) continue;

            Transform t = _childTransforms[li];
            Vector3 pos = t.position;
            float intensity = l.intensity;
            Color lColor = l.color;
            Vector3 rawColor = new Vector3(lColor.r, lColor.g, lColor.b);
            Vector3 fwd = t.forward;

            float width = childLightHalfExtents[li].x;
            float height = childLightHalfExtents[li].y;
            float bakedInt = intensity;
            Vector3 bakedCol = childLightBakedColors[li];
            int layerSlice = childLightLayerSlices[li];
            bool isRt = childLightIsRealtime[li];
            float realtimeFlag = isRt ? 1f : 0f;
            bool diffuseOn = childLightDiffuseEnabled[li];
            bool specularOn = childLightSpecularDistance[li];
            float specularMaxDist = childLightSpecularMaxDistance[li];
            float diffuseMaxDist = childLightDiffuseMaxDistance[li];
            bool isAnimated = childLightIsAnimated[li];
            int animModel = childLightAnimationModel[li];
            bool isBroken = childLightIsBroken[li];
            float failureRate = childLightFailureRate[li];
            int groupMask = childLightGroupIndex[li];

            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
            if (mergedCount >= mergedPos.Length) continue;
            int mi = mergedCount;

            mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, bakedInt);
            mergedCol[mi] = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
            mergedRight[mi] = new Vector4(t.right.x, t.right.y, t.right.z, width);
            mergedUp[mi] = new Vector4(t.up.x, t.up.y, t.up.z, height);
            mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
            mergedBakedCol[mi] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
            mergedLayerSlice[mi] = layerSlice;
            mergedDiffuseEnabled[mi] = diffuseOn;
            mergedSpecularEnabled[mi] = specularOn;
            mergedSpecularMaxDistance[mi] = specularMaxDist;
            mergedDiffuseMaxDistance[mi] = diffuseMaxDist;
            mergedIsAnimated[mi] = isAnimated;
            mergedAnimationModel[mi] = animModel;
            mergedIsBroken[mi] = isBroken;
            mergedFailureRate[mi] = failureRate;
            mergedGroupMask[mi] = groupMask;

            _mergedAudioSources[mi] = (li < _childAudioSources.Length) ? _childAudioSources[li] : null;
            _lightToMerged[li] = mi;
            if (isAnimated) _animatedMask |= (1 << mi);
            mergedCount++;
        }
    }

    // ── SortNearest / FillUploadBuffers / Helpers ────────────────────────────
    public int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        float vx = viewerPos.x, vy = viewerPos.y, vz = viewerPos.z;
        for (int i = 0; i < mergedCount; i++)
        {
            Vector4 mp = mergedPos[i];
            float dx = vx - mp.x, dy = vy - mp.y, dz = vz - mp.z;
            float distSq = dx * dx + dy * dy + dz * dz;
            float dist = Mathf.Sqrt(distSq);

            // Coarse CPU-side budget cull: a light only gets dropped from the
            // GPU upload entirely if it's out of range for BOTH specular and
            // diffuse. "Unlimited" (<= 0) always counts as in-range for that
            // system, so a light still contributing diffuse at range isn't
            // dropped just because it's past its (possibly shorter) specular
            // cutoff, and vice versa.
            float specLimit = mergedSpecularMaxDistance[i];
            float diffLimit = mergedDiffuseMaxDistance[i];
            bool specInRange = specLimit <= 0f || dist <= specLimit;
            bool diffInRange = diffLimit <= 0f || dist <= diffLimit;

            if (!specInRange && !diffInRange)
                continue;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= activeSpecularCount) continue;

            int maxShift = Mathf.Min(count, activeSpecularCount - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j] = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }
            _indices[ins] = i;
            _distances[ins] = distSq;
            if (count < activeSpecularCount) count++;
        }
        return count;
    }

    private void FillUploadBuffers(int finalCount)
    {
        _shaderData[0] = new Vector4((float)finalCount, rangeScale, lightmapLODBias, _specularEnabled ? 1f : 0f);
        for (int i = 0; i < finalCount; i++)
        {
            int idx = _indices[i];
            int baseIdx = i * 8 + 1;
            _shaderData[baseIdx + 0] = mergedPos[idx];
            _shaderData[baseIdx + 1] = mergedCol[idx];
            _shaderData[baseIdx + 2] = mergedDir[idx];
            _shaderData[baseIdx + 3] = mergedRight[idx];
            _shaderData[baseIdx + 4] = mergedUp[idx];
            _shaderData[baseIdx + 5] = mergedBakedCol[idx];
            _shaderData[baseIdx + 6] = PackLayerIndex(idx);
            _shaderData[baseIdx + 7] = new Vector4(mergedSpecularMaxDistance[idx], mergedDiffuseMaxDistance[idx], 0f, 0f);
            _lastIndicesSorted[i] = idx;
        }
        int clearUpTo = Mathf.Max(finalCount, _lastUploadedSlotCount);
        for (int i = finalCount; i < clearUpTo; i++)
        {
            int baseIdx = i * 8 + 1;
            _shaderData[baseIdx] = _shaderData[baseIdx + 1] = _shaderData[baseIdx + 2] =
            _shaderData[baseIdx + 3] = _shaderData[baseIdx + 4] = _shaderData[baseIdx + 5] = Vector4.zero;
            _shaderData[baseIdx + 6] = new Vector4(-1f, 0f, 0f, 0f);
            _shaderData[baseIdx + 7] = Vector4.zero;
            _lastIndicesSorted[i] = -1;
        }
        _lastUploadedSlotCount = finalCount;
    }

    private Vector4 PackLayerIndex(int mi)
    {
        float diffuseFlag = mergedDiffuseEnabled[mi] ? 1f : 0f;
        float specularFlag = mergedSpecularEnabled[mi] ? 1f : 0f;
        return new Vector4(mergedLayerSlice[mi], diffuseFlag, specularFlag, (float)mergedGroupMask[mi]);
    }

    private static float ComputeCosOuter(LightType type, float spotAngleDegrees)
    {
        if (type == LightType.Spot) return Mathf.Cos(spotAngleDegrees * 0.5f * Mathf.Deg2Rad);
        if (type == LightType.Area) return 0.0f;
        return -1.0f;
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

    // ── Public API ────────────────────────────────────────────────────────────
    public void ToggleSpecular() => SetSpecular(!_specularEnabled);

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;
        _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, _shaderData[0].z, enabled ? 1f : 0f);
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
        shaderWasUpdated = true;
        shaderUpdatesThisFrame++;
#if UNITY_EDITOR
        updateReason = enabled ? "Manual[Specular:ON]" : "Manual[Specular:OFF]";
        Debug.Log("[LLM] " + updateReason);
#endif
        if (enabled) { _lastFinalCount = -1; Tick(); }
    }
    public bool IsSpecularEnabled() => _specularEnabled;
}