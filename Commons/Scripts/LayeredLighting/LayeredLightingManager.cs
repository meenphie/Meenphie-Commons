#if UDONSHARP
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

public enum LightFaultState { Normal, Broken, Panic, Off }

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class LayeredLightingManager : UdonSharpBehaviour
{
    [Header("Settings")]
    public float updateInterval = 0.025f;
    public float viewerUpdateInterval = 0.25f;
    [Range(1, MAX_LIGHTS)] public int activeSpecularCount = MAX_LIGHTS;
    [Tooltip("Global culling distance – lights beyond this are skipped on the CPU.")]
    public float rangeScale = 10f;

    [Header("Lightmap Layer")]
    public Texture2DArray lightLayerArray;
    public int lightmapGroupCount = 0;
    [Range(0f, 50f)] public float lodDistanceNear = 0f;
    [Range(0f, 80f)] public float lodDistanceFar = 70f;
    [Range(0f, 9f)] public float lodAtFar = 9f;

    [Header("Animation – Audio Clips")]
    public AudioClip faultAudioClip;
    [Range(0f, 1f)] public float audioMasterVolume = 0.8f;

#if UNITY_EDITOR
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
#endif

    public const int MAX_LIGHTS = 32;
    public const float MOTION_EPSILON_SQ = 0.000001f;
    public const float COLOR_EPSILON = 0.004f;
    public const float INTENSITY_EPSILON = 0.001f;

    [Header("Light Sources (auto-filled)")]
    public Light[] childLights;

    [HideInInspector] public Vector2[] childLightHalfExtents;
    [HideInInspector] public bool[] childLightIsRealtime;
    [HideInInspector] public Vector3[] childLightBakedColors;
    public int[] childLightLayerSlices;

    [HideInInspector] public bool[] childLightDiffuseEnabled;
    [HideInInspector] public bool[] childLightSpecularDistance;

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

    // Precalculated trig to avoid Acos/Cos in loops
    [HideInInspector] public float[] mergedCosInner;

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

    private int[] _indices = new int[MAX_LIGHTS];
    private float[] _distances = new float[MAX_LIGHTS];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[] _mergedToShader = new int[MAX_LIGHTS];
    private int _lastFinalCount = -1;
    private int _lastUploadedSlotCount;

    private bool[] _lastEnabledState;

    private Transform[] _childTransforms;
    private Transform _thisTransform;

    private int[] _mergedToChild;

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
    private float _viewerTickTimer;
    private bool _specularEnabled = true;
    private float[] _lastAnimatedIntensity = new float[MAX_LIGHTS];

    private const float FAULT_FADE_SPEED = 15.0f;

    private const float PANIC_ON_MEAN_SLOW = 0.30f;
    private const float PANIC_ON_MEAN_FAST = 0.01f;
    private const float PANIC_OFF_MEAN_SLOW = 0.80f;
    private const float PANIC_OFF_MEAN_FAST = 0.02f;

#if !COMPILER_UDONSHARP && UNITY_EDITOR
    private void OnValidate()
    {
        if (childLights == null) return;
        int cap = childLights.Length;

        ResizeBoolArray(ref childLightIsRealtime, cap, true);
        ResizeBoolArray(ref childLightDiffuseEnabled, cap, true);
        ResizeBoolArray(ref childLightSpecularDistance, cap, true);

        if (childLightFaultState == null || childLightFaultState.Length != cap)
            System.Array.Resize(ref childLightFaultState, cap);

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
            System.Array.Resize(ref childLightAudioClipOverride, cap);

        EnsureFloatArray(ref childLightBrokenOnMin, cap, 0.01f);
        EnsureFloatArray(ref childLightBrokenOnMax, cap, 1.5f);
        EnsureFloatArray(ref childLightBrokenOffMin, cap, 0.5f);
        EnsureFloatArray(ref childLightBrokenOffMax, cap, 2.0f);
        EnsureFloatArray(ref childLightBrokenOnIntensity, cap, 0.8f);
        EnsureFloatArray(ref childLightPanicSpeed, cap, 0.5f);
        EnsureFloatArray(ref childLightPanicIntensityMin, cap, 0.1f);
        EnsureFloatArray(ref childLightPanicIntensityMax, cap, 1.2f);
    }

    private static void ResizeBoolArray(ref bool[] arr, int cap, bool def)
    {
        if (arr != null && arr.Length == cap) return;
        bool[] r = new bool[cap];
        int c = (arr != null) ? Mathf.Min(arr.Length, cap) : 0;
        if (c > 0) System.Array.Copy(arr, r, c);
        for (int i = c; i < cap; i++) r[i] = def;
        arr = r;
    }

    private static void EnsureFloatArray(ref float[] arr, int cap, float def)
    {
        if (arr != null && arr.Length == cap) return;
        int oldLen = (arr != null) ? arr.Length : 0;
        System.Array.Resize(ref arr, cap);
        for (int i = oldLen; i < cap; i++) arr[i] = def;
    }
#endif

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

        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightLayerArrayValid"), lightLayerArray != null ? 1f : 0f);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLightmapSliceOffset"), (float)lightmapGroupCount);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceNear"), lodDistanceNear);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODDistanceFar"), lodDistanceFar);
        VRCShader.SetGlobalFloat(VRCShader.PropertyToID("_UdonLODMaxMip"), lodAtFar);

        ValidateChildArrays();
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

    private void ValidateChildArrays()
    {
        int cap = (childLights != null) ? childLights.Length : 0;
        childLightHalfExtents = ResizeOrDefault(childLightHalfExtents, cap, new Vector2(0.01f, 0.01f));
        childLightIsRealtime = ResizeOrDefault(childLightIsRealtime, cap, true);
        childLightBakedColors = ResizeOrDefault(childLightBakedColors, cap, Vector3.one);
        childLightLayerSlices = ResizeOrDefault(childLightLayerSlices, cap, -1);
        childLightDiffuseEnabled = ResizeOrDefault(childLightDiffuseEnabled, cap, true);
        childLightSpecularDistance = ResizeOrDefault(childLightSpecularDistance, cap, true);
        childLightFaultState = ResizeOrDefault(childLightFaultState, cap, LightFaultState.Normal);
        childLightGroupIndex = ResizeOrDefault(childLightGroupIndex, cap, ~0);

        childLightBrokenOnMin = ResizeOrDefault(childLightBrokenOnMin, cap, 0.01f);
        childLightBrokenOnMax = ResizeOrDefault(childLightBrokenOnMax, cap, 1.5f);
        childLightBrokenOffMin = ResizeOrDefault(childLightBrokenOffMin, cap, 0.5f);
        childLightBrokenOffMax = ResizeOrDefault(childLightBrokenOffMax, cap, 2.0f);
        childLightBrokenOnIntensity = ResizeOrDefault(childLightBrokenOnIntensity, cap, 0.8f);
        childLightPanicSpeed = ResizeOrDefault(childLightPanicSpeed, cap, 0.5f);
        childLightPanicIntensityMin = ResizeOrDefault(childLightPanicIntensityMin, cap, 0.1f);
        childLightPanicIntensityMax = ResizeOrDefault(childLightPanicIntensityMax, cap, 1.2f);

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
        _mergedAudioSources = new AudioSource[cap];
        _mergedBaseIntensity = new float[cap];
        _mergedLastAnimated = new float[cap];
        _mergedToChild = new int[cap];

        mergedCosInner = new float[cap];

        _mergedBrokenOnMin = new float[cap];
        _mergedBrokenOnMax = new float[cap];
        _mergedBrokenOffMin = new float[cap];
        _mergedBrokenOffMax = new float[cap];
        _mergedBrokenOnIntensity = new float[cap];
        _mergedPanicSpeed = new float[cap];
        _mergedPanicIntensityMin = new float[cap];
        _mergedPanicIntensityMax = new float[cap];

        for (int i = 0; i < cap; i++)
        {
            mergedLayerSlice[i] = -1;
            mergedDiffuseEnabled[i] = true;
            mergedSpecularEnabled[i] = true;
            mergedFaultState[i] = LightFaultState.Normal;
            mergedGroupMask[i] = ~0;
            _mergedBaseIntensity[i] = 1f;
            _mergedLastAnimated[i] = -1f;
            _mergedToChild[i] = -1;

            mergedCosInner[i] = -1f;

            _mergedBrokenOnMin[i] = 0.01f;
            _mergedBrokenOnMax[i] = 1.5f;
            _mergedBrokenOffMin[i] = 0.5f;
            _mergedBrokenOffMax[i] = 2.0f;
            _mergedBrokenOnIntensity[i] = 0.8f;
            _mergedPanicSpeed[i] = 0.5f;
            _mergedPanicIntensityMin[i] = 0.1f;
            _mergedPanicIntensityMax[i] = 1.2f;
        }

        _childTransforms = new Transform[cap];
        for (int i = 0; i < cap; i++)
            if (childLights != null && i < childLights.Length && childLights[i] != null)
                _childTransforms[i] = childLights[i].transform;

        ValidateChildArrays();
    }

    // ── ResizeOrDefault helpers ────────────────────────────────────────────
    private Vector2[] ResizeOrDefault(Vector2[] arr, int cap, Vector2 def)
    {
        if (arr != null && arr.Length == cap) return arr;
        Vector2[] r = new Vector2[cap];
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

    // ── Lifecycle ──────────────────────────────────────────────────────────
    void OnEnable()
    {
        if (_localPlayer == null) return;
        _lastFinalCount = -1;
        _viewerTickTimer = 0f;
        lastViewerPos = new Vector3(float.MaxValue, 0, 0);
        for (int i = 0; i < MAX_LIGHTS; i++) _lastAnimatedIntensity[i] = -1f;

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
        _shaderData[0] = Vector4.zero;
        for (int i = 1; i < _shaderData.Length; i++) _shaderData[i] = Vector4.zero;
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
        _lastFinalCount = 0;
#if UNITY_EDITOR
        currentStaticLights = 0;
        currentDynamicLights = 0;
        currentAnimatedLights = 0;
        currentSpecularsCount = 0;
        sampledLightmapsCount = 0;
        currentSlicesCount = 0;
#endif
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        if (_childAudioSources != null)
            for (int i = 0; i < _childAudioSources.Length; i++)
                if (_childAudioSources[i] != null) _childAudioSources[i].Stop();
    }

    // ── Update ─────────────────────────────────────────────────────────────
    public override void PostLateUpdate()
    {
#if UNITY_EDITOR
        shaderWasUpdated = false;
        shaderUpdatesThisFrame = 0;
#endif
        if (!_isReady || childLights == null || childLights.Length == 0) return;

        float dt = Time.deltaTime;

        bool lightsChanged = false;
        int childCount = childLights.Length;
        for (int i = 0; i < childCount; i++)
        {
            Light l = childLights[i];
            bool cur = l != null && l.enabled && l.gameObject.activeInHierarchy;
            if (cur != _lastEnabledState[i]) { lightsChanged = true; _lastEnabledState[i] = cur; }
        }
        if (lightsChanged) { ForceRefresh(); return; }

        _tickTimer += dt;
        if (_tickTimer >= updateInterval)
        {
            _tickTimer = 0f;

            bool hasAnimatedLights = _animatedMask != 0;
            bool needsResort = _viewerTickTimer + dt >= viewerUpdateInterval || _lastFinalCount < 0;

            if (!hasAnimatedLights && !needsResort)
            {
                TickAudio();
                bool liveChanged = UpdateLiveData(dt);
                if (liveChanged)
                {
                    VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
                    shaderWasUpdated = true;
                    shaderUpdatesThisFrame++;
#endif
                }
                return;
            }

            Tick();
        }
        else
        {
            bool liveChanged = UpdateLiveData(dt);
            bool animated = TickPhysicalAnimation(dt);
            if (liveChanged || animated)
            {
                VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
                shaderWasUpdated = true;
                shaderUpdatesThisFrame++;
#endif
            }
        }
    }

    public void ForceRefresh()
    {
        _lastFinalCount = -1;
        _viewerTickTimer = viewerUpdateInterval;
        Tick();
    }

    public void OnLightsChanged() => ForceRefresh();

    // ── Physical animation ─────────────────────────────────────────────────
    private bool TickPhysicalAnimation(float dt)
    {
        if (mergedCount == 0) return false;
        bool anyChanged = false;

        for (int mi = 0; mi < mergedCount; mi++)
        {
            if (mergedFaultState[mi] == LightFaultState.Off) continue;

            LightFaultState state = mergedFaultState[mi];
            int li = _mergedToChild[mi];
            if (li < 0) continue;

            bool isFaulted = state != LightFaultState.Normal;
            bool needsSettle = !isFaulted && Mathf.Abs(_faultIntensity[li] - 1f) > INTENSITY_EPSILON;
            if (!isFaulted && !needsSettle) continue;

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

    // ── Audio ──────────────────────────────────────────────────────────────
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

            float vol = (mergedFaultState[mi] == LightFaultState.Panic)
                ? 1f
                : Mathf.Clamp01(_faultIntensity[li]);
            src.volume = vol * audioMasterVolume;
        }
    }

    // ── Live data (realtime lights only) ───────────────────────────────────
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

                float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
                mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                mergedCosInner[mi] = ComputeCosInner(cosOuter);

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
                _mergedBaseIntensity[mi] = intensity;
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

    // ── Tick (full rebuild) ────────────────────────────────────────────────
    public void Tick()
    {
        if (!_isReady || childLights == null || childLights.Length == 0) return;
        float dt = Time.deltaTime;

        Vector3 viewerPos = _localPlayer != null
            ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position
            : _thisTransform.position;

        BuildMergedGroups();

        _viewerTickTimer += dt;
        bool viewerDue = _viewerTickTimer >= viewerUpdateInterval || _lastFinalCount < 0;
        int finalCount;
        if (viewerDue)
        {
            _viewerTickTimer = 0f;
            finalCount = SortNearest(viewerPos);
            lastViewerPos = viewerPos;
        }
        else
        {
            finalCount = _lastFinalCount;
        }

        for (int i = 0; i < mergedCount; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

        int dynCount = 0, statCount = 0, animCount = 0, specCount = 0, sliceCount = 0, sliceMask = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int mi = _indices[i];
            if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
            if (mergedFaultState[mi] == LightFaultState.Broken || mergedFaultState[mi] == LightFaultState.Panic) animCount++;
            if (mergedSpecularEnabled[mi]) specCount++;
            int sl = mergedLayerSlice[mi];
            if (sl >= 0 && sl < 32) { sliceCount++; sliceMask |= (1 << sl); }
        }
#if UNITY_EDITOR
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

        FillUploadBuffers(finalCount);
        bool liveChanged = UpdateLiveData(dt);
        bool animated = TickPhysicalAnimation(dt);
        TickAudio();

        if (isDirty || animated || liveChanged)
        {
            VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
            shaderWasUpdated = true;
            shaderUpdatesThisFrame++;
            updateReason = BuildTickReason(isDirty, animated, finalCount, animCount, viewerDue);
            if (liveChanged) updateReason += " +LiveData";
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
#else
    private string BuildTickReason(bool a, bool b, int c, int d, bool e) => "";
#endif

    // ── BuildMergedGroups ──────────────────────────────────────────────────
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

            // Force zero intensity for OFF lights
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

            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
            mergedDir[mi] = new Vector4(t.forward.x, t.forward.y, t.forward.z, cosOuter);
            mergedCosInner[mi] = ComputeCosInner(cosOuter);

            mergedBakedCol[mi] = new Vector4(
                childLightBakedColors[li].x, childLightBakedColors[li].y, childLightBakedColors[li].z,
                isRealtime ? 1f : 0f);
            mergedLayerSlice[mi] = childLightLayerSlices[li];
            mergedDiffuseEnabled[mi] = childLightDiffuseEnabled[li];
            mergedSpecularEnabled[mi] = childLightSpecularDistance[li];

            mergedFaultState[mi] = faultState;
            mergedGroupMask[mi] = childLightGroupIndex[li];

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

            _mergedAudioSources[mi] = (li < _childAudioSources.Length) ? _childAudioSources[li] : null;
            _lightToMerged[li] = mi;

            bool settling = Mathf.Abs(_faultIntensity[li] - 1f) > INTENSITY_EPSILON;
            // Off state is never animated
            if (faultState == LightFaultState.Broken || faultState == LightFaultState.Panic || settling)
                _animatedMask |= 1 << mi;

            mergedCount++;
        }
    }

    // ── SortNearest (global distance culling) ──────────────────────────────
    public int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        float maxDistSq = rangeScale * rangeScale;
        float vx = viewerPos.x, vy = viewerPos.y, vz = viewerPos.z;

        for (int i = 0; i < mergedCount; i++)
        {
            Vector4 mp = mergedPos[i];
            float dx = vx - mp.x, dy = vy - mp.y, dz = vz - mp.z;
            float distSq = dx * dx + dy * dy + dz * dz;

            if (distSq > maxDistSq) continue;

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

    // ── FillUploadBuffers ──────────────────────────────────────────────────
    private void FillUploadBuffers(int finalCount)
    {
        _shaderData[0] = new Vector4((float)finalCount, 0f, 0f, _specularEnabled ? 1f : 0f);

        for (int i = 0; i < finalCount; i++)
        {
            int idx = _indices[i];
            int baseIdx = i * 8 + 1;

            float cosInner = mergedCosInner[idx];
            float cosOuter = mergedDir[idx].w;
            int lightTypeInt = GetLightTypeInt(cosOuter);

            _shaderData[baseIdx + 0] = mergedPos[idx];
            _shaderData[baseIdx + 1] = mergedCol[idx];
            _shaderData[baseIdx + 2] = mergedDir[idx];
            _shaderData[baseIdx + 3] = mergedRight[idx];
            _shaderData[baseIdx + 4] = mergedUp[idx];
            _shaderData[baseIdx + 5] = mergedBakedCol[idx];
            _shaderData[baseIdx + 6] = PackLayerIndex(idx);
            _shaderData[baseIdx + 7] = new Vector4(0f, 0f, (float)lightTypeInt, cosInner);

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
            _shaderData[baseIdx + 7] = Vector4.zero;
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

    // ── Specular toggle ────────────────────────────────────────────────────
    public void ToggleSpecular() => SetSpecular(!_specularEnabled);

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;
        _shaderData[0] = new Vector4(_shaderData[0].x, _shaderData[0].y, _shaderData[0].z, enabled ? 1f : 0f);
        VRCShader.SetGlobalVectorArray(_lightDataID, _shaderData);
#if UNITY_EDITOR
        shaderWasUpdated = true;
        shaderUpdatesThisFrame++;
        updateReason = enabled ? "Manual[Specular:ON]" : "Manual[Specular:OFF]";
        Debug.Log("[LLM] " + updateReason);
#endif
        if (enabled) { _lastFinalCount = -1; Tick(); }
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

    public bool IsSpecularEnabled() => _specularEnabled;
}
#endif