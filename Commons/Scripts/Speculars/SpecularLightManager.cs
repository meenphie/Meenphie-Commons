using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

public enum AnimationInterpolationMode
{
    Smooth,
    Step
}

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    [Header("Settings")]
    [Tooltip("Seconds between sort/upload ticks (~20 Hz = 0.05).")]
    public float updateInterval = 0.05f;

    [Range(1, MAX_LIGHTS)]
    public int activeLightCount = MAX_LIGHTS;

    [Tooltip("Multiplier for derived light range: range = sqrt(bakedIntensity) * rangeScale.")]
    public float rangeScale = 10f;

    [Header("Lightmap Layer")]
    [Tooltip("Texture2DArray (up to 32 slices).")]
    public Texture2DArray lightLayerArray;

    [Header("Animation")]
    [Tooltip("How style brightness steps blend. Smooth = linear interpolation; Step = original hard snap.")]
    public AnimationInterpolationMode animationInterpolation = AnimationInterpolationMode.Smooth;

    [Header("Debug Info (read-only)")]
    public int currentDynamicLights;
    public int currentStaticLights;
    public int currentActiveCount;
    public bool shaderWasUpdated;

    public const int MAX_LIGHTS = 32;

    [Header("Light Sources (auto-filled)")]
    public Light[] childLights;

    [HideInInspector] public Vector2[] childLightHalfExtents;
    [HideInInspector] public bool[] childLightIsRealtime;
    [HideInInspector] public float[] childLightBakedIntensities;
    [HideInInspector] public Vector3[] childLightBakedColors;
    public int[] childLightLayerSlices;

    [HideInInspector] public bool[] childLightDiffuseEnabled;
    [HideInInspector] public bool[] childLightSpecularEnabled;

    [HideInInspector] public bool[] childLightIsAnimated;
    [HideInInspector] public int[] childLightStyleIndex;
    [HideInInspector] public float[] childLightAnimationSpeed;

    [HideInInspector] public Vector4[] mergedPos;
    [HideInInspector] public Vector4[] mergedCol;
    [HideInInspector] public Vector4[] mergedRight;
    [HideInInspector] public Vector4[] mergedUp;
    [HideInInspector] public Vector4[] mergedDir;
    [HideInInspector] public Vector4[] mergedBakedCol;
    [HideInInspector] public float[] mergedMaxInt;
    [HideInInspector] public int[] mergedLayerSlice;
    [HideInInspector] public bool[] mergedDiffuseEnabled;
    [HideInInspector] public bool[] mergedSpecularEnabled;
    [HideInInspector] public bool[] mergedIsAnimated;
    [HideInInspector] public int[] mergedStyleIndex;
    [HideInInspector] public float[] mergedAnimationSpeed;       // merged copy of per-light speed
    [HideInInspector] public int mergedCount;

    private Vector4[] _shaderPos = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderCol = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRight = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUp = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderDir = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderBakedCol = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderLayerIndex = new Vector4[MAX_LIGHTS];

    private int[] _indices = new int[MAX_LIGHTS];
    private float[] _distances = new float[MAX_LIGHTS];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[] _mergedToShader = new int[MAX_LIGHTS];
    private int _lastFinalCount = -1;

    private Transform[] _childTransforms;
    private Transform _thisTransform;

    private int _dataID, _posID, _colID, _rightID, _upID, _dirID, _bakedColID, _layerIndexID, _layerArrayID;

    [HideInInspector] public Vector3[] lastLightPositions;
    [HideInInspector] public Quaternion[] lastLightRotations;
    [HideInInspector] public float[] lastLightIntensities;
    [HideInInspector] public Vector3[] lastLightColors;
    [HideInInspector] public Vector3 lastViewerPos = new Vector3(float.MaxValue, 0, 0);

    private int[] _lightToMerged = new int[0];

    public readonly string[] LightStyles = new string[]
    {
        "m",                                                                    // 0  Normal
        "mmnmmommommnonmmonqnmmo",                                              // 1  Flicker A
        "abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba",                  // 2  Slow, strong pulse
        "mmnmmommommnonmmonqnmmo",                                              // 3  Candle A
        "mamamamamama",                                                         // 4  Fast strobe
        "jklmnopqrstuvwxyzyxwvutsrqponmlkj",                                    // 5  Gentle pulse
        "nmonqnmomnmomomno",                                                    // 6  Flicker B
        "mmmaaaabcdefgmmmmaaaammmaaamammmmabcdefgmmmmaaaammmmabcdefmmm",        // 7  Candle B
        "mmmaaammmaaammmabcdefaaaammmmmaaaaabcdefmmmmaaaaaaaammmmabcdefmmmmaaaammmmaaa", // 8  Candle C
        "aaaaaaaazzzzzzzz",                                                     // 9  Slow strobe
        "mmamammmmammamamaaamammma",                                           // 10 Fluorescent flicker
        "aaaaaaaaaabcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba",         // 11 Slow pulse, no black
    };

    public const int LIGHT_STYLE_COUNT = 12;
    private const float STYLE_STEPS_PER_SECOND = 10f;
    private float _styleClock;

    public const float MOTION_EPSILON_SQ = 0.0001f;
    public const float COLOR_EPSILON = 0.004f;
    public const float INTENSITY_EPSILON = 0.001f;

    private VRCPlayerApi _localPlayer;
    private float _tickTimer;
    private bool _specularEnabled = true;

    void Start()
    {
        _localPlayer = Networking.LocalPlayer;
        _thisTransform = transform;

        _dataID = VRCShader.PropertyToID("_UdonSpecularLightData");
        _posID = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID = VRCShader.PropertyToID("_UdonSpecularLightRight");
        _upID = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _dirID = VRCShader.PropertyToID("_UdonSpecularLightDir");
        _bakedColID = VRCShader.PropertyToID("_UdonSpecularLightBakedCol");
        _layerIndexID = VRCShader.PropertyToID("_UdonLightLayerIndex");
        _layerArrayID = VRCShader.PropertyToID("_UdonLightLayerArray");

        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            _lastIndicesSorted[i] = -1;
            _mergedToShader[i] = -1;
        }

        if (lightLayerArray != null)
            VRCShader.SetGlobalTexture(_layerArrayID, lightLayerArray);

        AllocateMergeBuffers();
    }

    void OnEnable()
    {
        if (_localPlayer == null) return;
        _lastFinalCount = -1;
        lastViewerPos = new Vector3(float.MaxValue, 0, 0);
    }

    void OnDisable()
    {
        UploadToShader(0);
        _lastFinalCount = 0;
        currentActiveCount = 0;
        currentDynamicLights = 0;
        currentStaticLights = 0;
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
    }

    void Update()
    {
        if (!_specularEnabled || childLights == null || childLights.Length == 0) return;

        _styleClock += Time.deltaTime;
        _tickTimer += Time.deltaTime;

        if (_tickTimer >= updateInterval)
        {
            _tickTimer = 0f;
            Tick(); // Rebuilds groups, sorts, applies animations, and uploads
        }
        else
        {
            // On non-tick frames, track moving/changing lights natively and update animations
            bool anyChanged = UpdateLiveData();
            bool anyAnimated = ApplyLightStyles();

            if (anyChanged || anyAnimated)
            {
                UploadAllBuffers();
                shaderWasUpdated = true;
            }
        }
    }

    private bool ApplyLightStyles()
    {
        if (mergedIsAnimated == null || mergedCount == 0) return false;

        bool anyApplied = false;

        for (int mi = 0; mi < mergedCount; mi++)
        {
            if (!mergedIsAnimated[mi]) continue;

            int si = _mergedToShader[mi];
            if (si < 0) continue;

            int styleIdx = (mergedStyleIndex != null && mi < mergedStyleIndex.Length) ? mergedStyleIndex[mi] : 0;
            float speed = (mergedAnimationSpeed != null && mi < mergedAnimationSpeed.Length) ? mergedAnimationSpeed[mi] : 1.0f;
            float styleValue = SampleLightStyle(styleIdx, _styleClock, speed);

            float baseIntensity = mergedMaxInt[mi];
            float animatedIntensity = baseIntensity * styleValue;

            Vector4 c = mergedCol[mi];
            mergedCol[mi] = new Vector4(c.x, c.y, c.z, animatedIntensity);
            _shaderCol[si] = mergedCol[mi];

            anyApplied = true;
        }

        return anyApplied;
    }

    // Samples a classic light‑style string with per‑light speed multiplier
    // and global interpolation mode (Smooth / Step).
    private float SampleLightStyle(int styleIndex, float time, float speedMultiplier = 1.0f)
    {
        if (styleIndex < 0 || styleIndex >= LIGHT_STYLE_COUNT) return 1f;

        string style = LightStyles[styleIndex];
        if (string.IsNullOrEmpty(style)) return 1f;

        int stepCount = style.Length;

        // Single‑step styles never change – no interpolation needed.
        if (stepCount == 1)
            return CharToBrightness(style[0]);

        float scaledTime = time * speedMultiplier;

        // --- Step mode (original hard snap) ---
        if (animationInterpolation == AnimationInterpolationMode.Step)
        {
            int step = (int)(scaledTime * STYLE_STEPS_PER_SECOND) % stepCount;
            if (step < 0) step += stepCount;
            return CharToBrightness(style[step]);
        }

        // --- Smooth mode (linear interpolation between steps) ---
        float position = scaledTime * STYLE_STEPS_PER_SECOND;
        while (position < 0f) position += stepCount;

        int i0 = Mathf.FloorToInt(position) % stepCount;
        int i1 = (i0 + 1) % stepCount;
        float t = position - Mathf.Floor(position);

        float v0 = CharToBrightness(style[i0]);
        float v1 = CharToBrightness(style[i1]);

        return Mathf.Lerp(v0, v1, t);
    }

    private static float CharToBrightness(char c)
    {
        if (c < 'a') c = 'a';
        if (c > 'z') c = 'z';
        return (float)(c - 'a') / 25f;
    }

    private bool UpdateLiveData()
    {
        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length) return false;

        bool changed = false;

        for (int li = 0; li < childLights.Length; li++)
        {
            if (childLightIsRealtime != null && li < childLightIsRealtime.Length && !childLightIsRealtime[li])
                continue;

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

            if (posChanged)
            {
                Vector4 p = mergedPos[mi];
                mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, p.w);
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
                lastLightRotations[li] = rot;
            }

            if (intChanged || colChanged)
            {
                Vector3 col = new Vector3(lColor.r, lColor.g, lColor.b);
                mergedCol[mi] = new Vector4(col.x, col.y, col.z, intensity);
                lastLightIntensities[li] = intensity;
                lastLightColors[li] = col;
            }

            _shaderPos[si] = mergedPos[mi];
            _shaderCol[si] = mergedCol[mi];
            _shaderRight[si] = mergedRight[mi];
            _shaderUp[si] = mergedUp[mi];
            _shaderDir[si] = mergedDir[mi];
            _shaderBakedCol[si] = mergedBakedCol[mi];
            _shaderLayerIndex[si] = PackLayerIndex(mi);
        }

        return changed;
    }

    public void Tick()
    {
        if (childLights == null || childLights.Length == 0) return;

        Vector3 viewerPos = _localPlayer != null
            ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position
            : _thisTransform.position;

        BuildMergedGroups(); // Resets mergedCol to base light intensities
        int finalCount = SortNearest(viewerPos);
        currentActiveCount = finalCount;

        int dynCount = 0, statCount = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int mi = _indices[i];
            if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
        }
        currentDynamicLights = dynCount;
        currentStaticLights = statCount;

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

        // === FIX: Apply animations BEFORE filling buffers and uploading to GPU ===
        ApplyLightStyles();

        bool isDirty = finalCount != _lastFinalCount;
        if (!isDirty)
        {
            for (int i = 0; i < finalCount; i++)
            {
                if (_indices[i] != _lastIndicesSorted[i]) { isDirty = true; break; }
            }
        }

        CacheLightStates();
        lastViewerPos = viewerPos;

        FillUploadBuffers(finalCount);
        UploadToShader(finalCount);
        _lastFinalCount = finalCount;
        shaderWasUpdated = isDirty;
    }

    public void BuildMergedGroups()
    {
        if (mergedPos == null || mergedPos.Length < childLights.Length)
            AllocateMergeBuffers();

        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length)
            _lightToMerged = new int[childLights.Length];

        mergedCount = 0;

        for (int li = 0; li < childLights.Length; li++)
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

            float width = 0.01f;
            float height = 0.01f;
            if (childLightHalfExtents != null && li < childLightHalfExtents.Length)
            {
                width = childLightHalfExtents[li].x;
                height = childLightHalfExtents[li].y;
            }

            float bakedInt = (childLightBakedIntensities != null && li < childLightBakedIntensities.Length
                              && childLightBakedIntensities[li] > 0f)
                ? childLightBakedIntensities[li]
                : intensity;

            Vector3 bakedCol = (childLightBakedColors != null && li < childLightBakedColors.Length)
                ? childLightBakedColors[li]
                : rawColor;

            int layerSlice = (childLightLayerSlices != null && li < childLightLayerSlices.Length)
                ? childLightLayerSlices[li]
                : -1;

            bool isRt = (childLightIsRealtime != null && li < childLightIsRealtime.Length)
                ? childLightIsRealtime[li] : true;
            float realtimeFlag = isRt ? 1f : 0f;

            bool diffuseOn = (childLightDiffuseEnabled != null && li < childLightDiffuseEnabled.Length)
                ? childLightDiffuseEnabled[li] : true;
            bool specularOn = (childLightSpecularEnabled != null && li < childLightSpecularEnabled.Length)
                ? childLightSpecularEnabled[li] : true;

            bool isAnimated = (childLightIsAnimated != null && li < childLightIsAnimated.Length)
                ? childLightIsAnimated[li] : false;
            int styleIndex = (childLightStyleIndex != null && li < childLightStyleIndex.Length)
                ? childLightStyleIndex[li] : 0;
            float animSpeed = (childLightAnimationSpeed != null && li < childLightAnimationSpeed.Length)
                ? childLightAnimationSpeed[li] : 1.0f;

            float cosOuter = (l.type == LightType.Spot) ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                : (l.type == LightType.Area) ? 0.0f
                : -1.0f;

            if (mergedCount < mergedPos.Length)
            {
                int mi = mergedCount;
                mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                mergedCol[mi] = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                mergedRight[mi] = new Vector4(t.right.x, t.right.y, t.right.z, width);
                mergedUp[mi] = new Vector4(t.up.x, t.up.y, t.up.z, height);
                mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                mergedBakedCol[mi] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                mergedMaxInt[mi] = intensity;
                mergedLayerSlice[mi] = layerSlice;
                mergedDiffuseEnabled[mi] = diffuseOn;
                mergedSpecularEnabled[mi] = specularOn;
                mergedIsAnimated[mi] = isAnimated;
                mergedStyleIndex[mi] = styleIndex;
                mergedAnimationSpeed[mi] = animSpeed;
                _lightToMerged[li] = mi;
                mergedCount++;
            }
        }
    }

    public int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        for (int i = 0; i < mergedCount; i++)
        {
            float distSq = (viewerPos - (Vector3)mergedPos[i]).sqrMagnitude;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= activeLightCount) continue;

            int maxShift = Mathf.Min(count, activeLightCount - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j] = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }
            _indices[ins] = i;
            _distances[ins] = distSq;
            if (count < activeLightCount) count++;
        }
        return count;
    }

    private void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx = _indices[i];
                _shaderPos[i] = mergedPos[idx];
                _shaderCol[i] = mergedCol[idx];
                _shaderRight[i] = mergedRight[idx];
                _shaderUp[i] = mergedUp[idx];
                _shaderDir[i] = mergedDir[idx];
                _shaderBakedCol[i] = mergedBakedCol[idx];
                _shaderLayerIndex[i] = PackLayerIndex(idx);
                _lastIndicesSorted[i] = idx;
            }
            else
            {
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] =
                _shaderUp[i] = _shaderDir[i] = _shaderBakedCol[i] = Vector4.zero;
                _shaderLayerIndex[i] = new Vector4(-1f, 0f, 0f, 0f);
                _lastIndicesSorted[i] = -1;
            }
        }
    }

    private Vector4 PackLayerIndex(int mi)
    {
        float diffuseFlag = (mergedDiffuseEnabled != null && mi < mergedDiffuseEnabled.Length && mergedDiffuseEnabled[mi]) ? 1f : 0f;
        float specularFlag = (mergedSpecularEnabled != null && mi < mergedSpecularEnabled.Length && mergedSpecularEnabled[mi]) ? 1f : 0f;
        return new Vector4(mergedLayerSlice[mi], diffuseFlag, specularFlag, 0f);
    }

    private void UploadToShader(int count)
    {
        UploadAllBuffers();
        VRCShader.SetGlobalVector(_dataID, new Vector4((float)count, rangeScale, 0f, 0f));
    }

    private void UploadAllBuffers()
    {
        VRCShader.SetGlobalVectorArray(_posID, _shaderPos);
        VRCShader.SetGlobalVectorArray(_colID, _shaderCol);
        VRCShader.SetGlobalVectorArray(_dirID, _shaderDir);
        VRCShader.SetGlobalVectorArray(_rightID, _shaderRight);
        VRCShader.SetGlobalVectorArray(_upID, _shaderUp);
        VRCShader.SetGlobalVectorArray(_bakedColID, _shaderBakedCol);
        VRCShader.SetGlobalVectorArray(_layerIndexID, _shaderLayerIndex);
    }

    private void CacheLightStates()
    {
        int n = childLights.Length;
        if (lastLightPositions == null || lastLightPositions.Length != n) lastLightPositions = new Vector3[n];
        if (lastLightRotations == null || lastLightRotations.Length != n) lastLightRotations = new Quaternion[n];
        if (lastLightIntensities == null || lastLightIntensities.Length != n) lastLightIntensities = new float[n];
        if (lastLightColors == null || lastLightColors.Length != n) lastLightColors = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = childLights[i];
            if (l == null) continue;
            Transform t = _childTransforms[i];
            lastLightPositions[i] = t.position;
            lastLightRotations[i] = t.rotation;
            lastLightIntensities[i] = l.intensity;
            Color c = l.color;
            lastLightColors[i] = new Vector3(c.r, c.g, c.b);
        }
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
        mergedMaxInt = new float[cap];
        mergedLayerSlice = new int[cap];
        mergedDiffuseEnabled = new bool[cap];
        mergedSpecularEnabled = new bool[cap];
        mergedIsAnimated = new bool[cap];
        mergedStyleIndex = new int[cap];
        mergedAnimationSpeed = new float[cap];

        for (int i = 0; i < cap; i++)
        {
            mergedLayerSlice[i] = -1;
            mergedDiffuseEnabled[i] = true;
            mergedSpecularEnabled[i] = true;
            mergedIsAnimated[i] = false;
            mergedStyleIndex[i] = 0;
            mergedAnimationSpeed[i] = 1.0f;
        }

        _childTransforms = new Transform[cap];
        for (int i = 0; i < cap; i++)
        {
            if (childLights != null && i < childLights.Length && childLights[i] != null)
                _childTransforms[i] = childLights[i].transform;
        }
    }

    public void ToggleSpecular() => SetSpecular(!_specularEnabled);

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;

        if (!enabled)
        {
            for (int i = 0; i < MAX_LIGHTS; i++)
            {
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] =
                _shaderUp[i] = _shaderDir[i] = _shaderBakedCol[i] = Vector4.zero;
                _shaderLayerIndex[i] = new Vector4(-1f, 0f, 0f, 0f);
            }
            UploadAllBuffers();
            VRCShader.SetGlobalVector(_dataID, new Vector4(0f, rangeScale, 0f, 0f));
            currentActiveCount = 0;
            currentDynamicLights = 0;
            currentStaticLights = 0;
            shaderWasUpdated = true;
        }
        else
        {
            _lastFinalCount = -1;
            Tick();
        }
    }

    public bool IsSpecularEnabled() => _specularEnabled;
}