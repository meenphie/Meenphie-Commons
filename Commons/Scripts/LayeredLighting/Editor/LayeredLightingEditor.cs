#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[InitializeOnLoad]
public static class LayeredLightingEditor
{
    public const int MAX_LIGHTS = 32;
    private const int BUFFER_SIZE = MAX_LIGHTS * 8 + 1;

    private const float MOTION_EPSILON_SQ = 0.0001f;
    private const float COLOR_EPSILON = 0.004f;
    private const float INTENSITY_EPSILON = 0.001f;
    private const float DEFAULT_RANGE_SCALE = 10f;
    private const double RESCAN_DEBOUNCE_SECONDS = 0.25;

    // ── Fluorescent simplified constants (same as runtime) ─────────────────────
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

    // ── Physical animation state (editor preview) ─────────────────────────────
    private static float[] _fluorStateTimer;
    private static float[] _fluorFlickerPhase;
    private static float[] _fluorIntensity;
    private static int[] _fluorState;

    private static float[] _incandThermalMass;
    private static float[] _incandDriftVal;
    private static float[] _incandDriftTarget;
    private static float[] _incandDriftTimer;
    private static float[] _incandPhase;

    private static float[] _animatedIntensityPreview;

    // ── Editor state ──────────────────────────────────────────────────────────
    private static GameObject _worldRoot;
    private static Light[] _lights;
    private static Vector2[] _halfExtents;
    private static bool[] _isRealtime;
    private static bool[] _diffuseEnabled;
    private static bool[] _specularEnabled;
    private static float[] _specularMaxDistances;
    private static float[] _diffuseMaxDistances;
    private static bool[] _isAnimated;
    private static int[] _animationModels;
    private static bool[] _isBroken;
    private static float[] _failureRates;
    private static Vector3[] _bakedColors;
    private static int[] _layerSlices;
    private static int[] _groupMasks;
    private static float _rangeScale = DEFAULT_RANGE_SCALE;

    private static int _activeSpecularCount = MAX_LIGHTS;
    private static bool _previewEnabled = true;
    private static double _lastTick;
    private static double _lastPrevTime;
    private static double _lastHierarchyChangeRequest = double.NegativeInfinity;
    private static bool _rescanPending;

    private static Vector3[] _lastLightPositions;
    private static Quaternion[] _lastLightRotations;
    private static float[] _lastLightIntensities;
    private static Vector3[] _lastLightColors;

    private static readonly Vector4[] _shaderBuffer = new Vector4[BUFFER_SIZE];
    private static float[] _lastAnimatedIntensity = new float[MAX_LIGHTS];
    private static int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private static int _lastUploadedSlotCount = 0;

    private static int[] _indices = new int[MAX_LIGHTS];
    private static float[] _distances = new float[MAX_LIGHTS];
    private static int[] _lightToShader = new int[0];

    private static Texture2DArray _previewLayerArray;

    // ── Bootstrap ─────────────────────────────────────────────────────────────
    static LayeredLightingEditor()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
        SceneView.duringSceneGui -= OnSceneGui;
        SceneView.duringSceneGui += OnSceneGui;
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;
    }

    // ── Event hooks ───────────────────────────────────────────────────────────
    private static void OnHierarchyChanged()
    {
        if (Application.isPlaying) return;
        _rescanPending = true;
        _lastHierarchyChangeRequest = EditorApplication.timeSinceStartup;
    }

    private static void OnSceneGui(SceneView sv)
    {
        if (!_previewEnabled || Application.isPlaying) return;
        UploadToShader();
    }

    private static void OnEditorUpdate()
    {
        if (Application.isPlaying) return;
        if (!_previewEnabled) return;

        if (_worldRoot == null)
        {
            TryFindAndRescan();
            if (_worldRoot == null) return;
        }

        if (_lights == null || _lights.Length == 0)
        {
            if (_rescanPending && ShouldRescanNow())
            {
                _rescanPending = false;
                TryFindAndRescan();
            }
            return;
        }

        if (_rescanPending && ShouldRescanNow())
        {
            _rescanPending = false;
            LayeredLightingManager mgr = _worldRoot.GetComponent<LayeredLightingManager>();
            if (mgr != null) Rescan(mgr);
        }

        LayeredLightingManager liveMgr = _worldRoot.GetComponent<LayeredLightingManager>();
        if (liveMgr != null && HasExternalArrayEdits(liveMgr))
            Rescan(liveMgr);

        double now = EditorApplication.timeSinceStartup;
        float dt = (float)(now - _lastPrevTime);
        _lastPrevTime = now;
        dt = Mathf.Clamp(dt, 0f, 0.1f);

        bool tickThisFrame = now - _lastTick >= (liveMgr != null ? liveMgr.updateInterval : 0.02f);

        if (tickThisFrame)
        {
            _lastTick = now;
            Tick(dt);
        }
        else
        {
            UpdateLiveData();
            TickPhysicalAnimationPreview(dt);
        }
    }

    // ── Rescan ────────────────────────────────────────────────────────────────
    private static bool ShouldRescanNow()
    {
        double now = EditorApplication.timeSinceStartup;
        if (_lastHierarchyChangeRequest == double.NegativeInfinity)
        {
            _lastHierarchyChangeRequest = now;
            return false;
        }
        if (now - _lastHierarchyChangeRequest >= RESCAN_DEBOUNCE_SECONDS)
        {
            _lastHierarchyChangeRequest = double.NegativeInfinity;
            return true;
        }
        return false;
    }

    private static bool HasExternalArrayEdits(LayeredLightingManager mgr)
    {
        if (ArrayDiffers(mgr.childLightLayerSlices, _layerSlices)) return true;
        if (ArrayDiffers(mgr.childLightGroupIndex, _groupMasks)) return true;
        return false;
    }

    private static bool ArrayDiffers(int[] a, int[] b)
    {
        if (a == null || b == null) return a != b;
        if (a.Length != b.Length) return true;
        for (int i = 0; i < a.Length; i++)
            if (a[i] != b[i]) return true;
        return false;
    }

    private static void TryFindAndRescan()
    {
        LayeredLightingManager mgr = Object.FindObjectOfType<LayeredLightingManager>();
        if (mgr != null) Rescan(mgr);
    }

    private static void Rescan(LayeredLightingManager mgr)
    {
        _worldRoot = mgr.gameObject;
        _rangeScale = mgr.rangeScale;
        _activeSpecularCount = Mathf.Clamp(mgr.activeSpecularCount, 1, MAX_LIGHTS);

        Light[] previousLights = mgr.childLights;
        Light[] freshLights = Object.FindObjectsOfType<Light>(includeInactive: true);
        int count = freshLights.Length;

        // Dynamic mesh scan (mirrors runtime setup)
        int dynamicReceiverCount = 0;
        Renderer[] renderers = Object.FindObjectsOfType<Renderer>(includeInactive: false);
        Vector3 viewerPos = GetViewerPos();

        foreach (Renderer r in renderers)
        {
            if (!(r is MeshRenderer || r is SkinnedMeshRenderer))
                continue;
            if (!r.enabled || !r.gameObject.activeInHierarchy)
                continue;

            bool isDynamic = false;
            foreach (Material mat in r.sharedMaterials)
            {
                if (mat == null) continue;
                if (mat.HasProperty("_IsDynamicMesh") && mat.GetFloat("_IsDynamicMesh") > 0.5f)
                {
                    isDynamic = true;
                    break;
                }
            }
            if (!isDynamic) continue;

            float maxDistance = r.allowOcclusionWhenDynamic
                ? float.MaxValue
                : r.GetComponent<LODGroup>() != null
                    ? float.MaxValue
                    : QualitySettings.lodBias;

            if (Vector3.Distance(viewerPos, r.bounds.center) > maxDistance)
                continue;

            dynamicReceiverCount++;
        }
        mgr.dynamicMeshCount = dynamicReceiverCount;

        // Preserve previous settings by light reference
        var oldRealtimeByLight = new Dictionary<Light, bool>();
        var oldDiffuseByLight = new Dictionary<Light, bool>();
        var oldSpecularByLight = new Dictionary<Light, bool>();
        var oldMaxDistByLight = new Dictionary<Light, float>();
        var oldDiffuseMaxDistByLight = new Dictionary<Light, float>();
        var oldAnimatedByLight = new Dictionary<Light, bool>();
        var oldAnimModelByLight = new Dictionary<Light, int>();
        var oldBrokenByLight = new Dictionary<Light, bool>();
        var oldFailureRateByLight = new Dictionary<Light, float>();
        var oldSliceByLight = new Dictionary<Light, int>();
        var oldGroupMaskByLight = new Dictionary<Light, int>();
        var oldBakedColByLight = new Dictionary<Light, Vector3>();

        if (previousLights != null)
        {
            for (int i = 0; i < previousLights.Length; i++)
            {
                Light l = previousLights[i];
                if (l == null) continue;
                if (mgr.childLightIsRealtime != null && i < mgr.childLightIsRealtime.Length)
                    oldRealtimeByLight[l] = mgr.childLightIsRealtime[i];
                if (mgr.childLightDiffuseEnabled != null && i < mgr.childLightDiffuseEnabled.Length)
                    oldDiffuseByLight[l] = mgr.childLightDiffuseEnabled[i];
                if (mgr.childLightSpecularDistance != null && i < mgr.childLightSpecularDistance.Length)
                    oldSpecularByLight[l] = mgr.childLightSpecularDistance[i];
                if (mgr.childLightSpecularMaxDistance != null && i < mgr.childLightSpecularMaxDistance.Length)
                    oldMaxDistByLight[l] = mgr.childLightSpecularMaxDistance[i];
                if (mgr.childLightDiffuseMaxDistance != null && i < mgr.childLightDiffuseMaxDistance.Length)
                    oldDiffuseMaxDistByLight[l] = mgr.childLightDiffuseMaxDistance[i];
                if (mgr.childLightIsAnimated != null && i < mgr.childLightIsAnimated.Length)
                    oldAnimatedByLight[l] = mgr.childLightIsAnimated[i];
                if (mgr.childLightAnimationModel != null && i < mgr.childLightAnimationModel.Length)
                    oldAnimModelByLight[l] = mgr.childLightAnimationModel[i];
                if (mgr.childLightIsBroken != null && i < mgr.childLightIsBroken.Length)
                    oldBrokenByLight[l] = mgr.childLightIsBroken[i];
                if (mgr.childLightFailureRate != null && i < mgr.childLightFailureRate.Length)
                    oldFailureRateByLight[l] = mgr.childLightFailureRate[i];
                if (mgr.childLightLayerSlices != null && i < mgr.childLightLayerSlices.Length)
                    oldSliceByLight[l] = mgr.childLightLayerSlices[i];
                if (mgr.childLightGroupIndex != null && i < mgr.childLightGroupIndex.Length)
                    oldGroupMaskByLight[l] = mgr.childLightGroupIndex[i];
                if (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                    oldBakedColByLight[l] = mgr.childLightBakedColors[i];
            }
        }

        _halfExtents = new Vector2[count];
        _isRealtime = new bool[count];
        _diffuseEnabled = new bool[count];
        _specularEnabled = new bool[count];
        _specularMaxDistances = new float[count];
        _diffuseMaxDistances = new float[count];
        _isAnimated = new bool[count];
        _animationModels = new int[count];
        _isBroken = new bool[count];
        _failureRates = new float[count];
        _bakedColors = new Vector3[count];
        _layerSlices = new int[count];
        _groupMasks = new int[count];

        for (int i = 0; i < count; i++)
        {
            Light l = freshLights[i];
            _halfExtents[i] = (l.type == LightType.Area)
                ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                : new Vector2(0.01f, 0.01f);

            _isRealtime[i] = oldRealtimeByLight.TryGetValue(l, out bool prevRt) ? prevRt : false;
            _diffuseEnabled[i] = oldDiffuseByLight.TryGetValue(l, out bool prevDiff) ? prevDiff : true;
            _specularEnabled[i] = oldSpecularByLight.TryGetValue(l, out bool prevSpec) ? prevSpec : true;
            _specularMaxDistances[i] = oldMaxDistByLight.TryGetValue(l, out float prevMax) ? prevMax : 30f;
            _diffuseMaxDistances[i] = oldDiffuseMaxDistByLight.TryGetValue(l, out float prevDiffMax) ? prevDiffMax : 60f;
            _isAnimated[i] = oldAnimatedByLight.TryGetValue(l, out bool prevAnim) ? prevAnim : false;
            _animationModels[i] = oldAnimModelByLight.TryGetValue(l, out int prevModel) ? prevModel : 0;
            _isBroken[i] = oldBrokenByLight.TryGetValue(l, out bool prevBroken) ? prevBroken : false;
            _failureRates[i] = oldFailureRateByLight.TryGetValue(l, out float prevRate) ? prevRate : 0.5f;
            _layerSlices[i] = oldSliceByLight.TryGetValue(l, out int prevSlice) ? prevSlice : -1;
            _groupMasks[i] = oldGroupMaskByLight.TryGetValue(l, out int prevMask) ? prevMask : ~0;
            _bakedColors[i] = oldBakedColByLight.TryGetValue(l, out Vector3 prevCol) ? prevCol : new Vector3(l.color.r, l.color.g, l.color.b);
        }

        mgr.childLights = freshLights;
        mgr.childLightIsRealtime = _isRealtime;
        mgr.childLightDiffuseEnabled = _diffuseEnabled;
        mgr.childLightSpecularDistance = _specularEnabled;
        mgr.childLightSpecularMaxDistance = _specularMaxDistances;
        mgr.childLightDiffuseMaxDistance = _diffuseMaxDistances;
        mgr.childLightIsAnimated = _isAnimated;
        mgr.childLightAnimationModel = _animationModels;
        mgr.childLightIsBroken = _isBroken;
        mgr.childLightFailureRate = _failureRates;
        mgr.childLightHalfExtents = _halfExtents;
        mgr.childLightLayerSlices = _layerSlices;
        mgr.childLightGroupIndex = _groupMasks;
        mgr.childLightBakedColors = _bakedColors;

        EditorUtility.SetDirty(mgr);
        _lights = freshLights;

        if (mgr.lightLayerArray != null)
        {
            _previewLayerArray = mgr.lightLayerArray;
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        }

        for (int i = 0; i < MAX_LIGHTS; i++) _lastAnimatedIntensity[i] = -1f;
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        _lastUploadedSlotCount = 0;

        AllocPhysicalState(count);
        CacheLightStates();
        _lastTick = 0;
        _lastPrevTime = EditorApplication.timeSinceStartup;
        Tick(0f);
    }

    // ── Physical state allocation ──────────────────────────────────────────────
    private static void AllocPhysicalState(int count)
    {
        _fluorStateTimer = new float[count];
        _fluorFlickerPhase = new float[count];
        _fluorIntensity = new float[count];
        _fluorState = new int[count];

        _incandThermalMass = new float[count];
        _incandDriftVal = new float[count];
        _incandDriftTarget = new float[count];
        _incandDriftTimer = new float[count];
        _incandPhase = new float[count];

        _animatedIntensityPreview = new float[count];

        for (int i = 0; i < count; i++)
        {
            _incandThermalMass[i] = 1f;
            _incandDriftTarget[i] = 1f;
            _incandDriftVal[i] = 1f;

            _fluorStateTimer[i] = Random.Range(0f, 2f);
            _fluorFlickerPhase[i] = Random.Range(0f, Mathf.PI * 2f);
            _fluorIntensity[i] = 0f;
            _fluorState[i] = FLUOR_OFF;

            _animatedIntensityPreview[i] = 1f;
        }
    }

    // ── Tick ──────────────────────────────────────────────────────────────────
    private static void Tick(float dt)
    {
        if (_lights == null || _lights.Length == 0) return;

        int finalCount = SortNearest(GetViewerPos());

        if (_lightToShader == null || _lightToShader.Length != _lights.Length)
            _lightToShader = new int[_lights.Length];

        for (int i = 0; i < _lightToShader.Length; i++) _lightToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _lightToShader[_indices[i]] = i;

        int dynCount = 0, statCount = 0, animCount = 0;
        int specCount = 0, lmCount = 0;
        int sliceMask = 0;

        for (int i = 0; i < finalCount; i++)
        {
            int idx = _indices[i];
            if (_isRealtime[idx]) dynCount++; else statCount++;
            if (_isAnimated[idx]) animCount++;
            if (_specularEnabled[idx]) specCount++;
            int sl = (_layerSlices != null && idx < _layerSlices.Length) ? _layerSlices[idx] : -1;
            if (sl >= 0 && sl < 32)
            {
                lmCount++;
                sliceMask |= (1 << sl);
            }
        }

        LayeredLightingManager mgr = _worldRoot != null
            ? _worldRoot.GetComponent<LayeredLightingManager>() : null;
        if (mgr != null)
        {
            mgr.currentStaticLights = statCount;
            mgr.currentDynamicLights = dynCount;
            mgr.currentAnimatedLights = animCount;
            mgr.currentSpecularsCount = specCount;
            mgr.currentSlicesCount = lmCount;
            mgr.sampledLightmapsCount = CountBits(sliceMask);
            mgr.shaderWasUpdated = true;
            mgr.shaderUpdatesThisFrame = 1;
            mgr.updateReason = "Editor: Tick[" + finalCount + " lights]";
            EditorUtility.SetDirty(mgr);
        }

        CacheLightStates();
        FillUploadBuffers(finalCount);

        // Animation happens AFTER fill, exactly like runtime.
        // TickPhysicalAnimationPreview writes animated intensity directly into _shaderBuffer.
        TickPhysicalAnimationPreview(dt);

        UploadToShader();
        RepaintSceneViews();
    }

    // ── Physical animation preview ────────────────────────────────────────────
    private static bool TickPhysicalAnimationPreview(float dt)
    {
        if (_lights == null || _lights.Length == 0) return false;
        if (_fluorStateTimer == null || _fluorStateTimer.Length != _lights.Length)
            AllocPhysicalState(_lights.Length);

        bool anyChanged = false;

        for (int i = 0; i < _lights.Length; i++)
        {
            if (!_isAnimated[i]) continue;
            int si = (_lightToShader != null && i < _lightToShader.Length) ? _lightToShader[i] : -1;
            if (si < 0) continue;

            float newVal;
            int model = (_animationModels != null && i < _animationModels.Length) ? _animationModels[i] : 0;

            if (model == (int)LightAnimationModel.Fluorescent)
                newVal = TickFluorescentPreview(i, dt);
            else
                newVal = TickIncandescentPreview(i, dt);

            _animatedIntensityPreview[i] = newVal;

            float baseInt = (_lastLightIntensities != null && i < _lastLightIntensities.Length)
                ? _lastLightIntensities[i] : 1f;
            float animated = baseInt * newVal;

            int baseIdx = si * 8 + 1;
            float prev = _lastAnimatedIntensity[si];

            Vector4 cv = _shaderBuffer[baseIdx + 1];
            _shaderBuffer[baseIdx + 1] = new Vector4(cv.x, cv.y, cv.z, animated);
            _lastAnimatedIntensity[si] = animated;

            if (Mathf.Abs(animated - prev) > INTENSITY_EPSILON)
                anyChanged = true;
        }

        return anyChanged;
    }

    // ── Fluorescent preview (matches runtime simplified model) ──────────────
    private static float TickFluorescentPreview(int i, float dt)
    {
        if (_isBroken == null || i >= _isBroken.Length || !_isBroken[i])
        {
            _fluorIntensity[i] = 1f;
            return 1f;
        }

        float failureRate = (_failureRates != null && i < _failureRates.Length)
            ? Mathf.Clamp01(_failureRates[i]) : 0.5f;

        int state = _fluorState[i];
        _fluorStateTimer[i] -= dt;
        float t = _fluorStateTimer[i];

        switch (state)
        {
            case FLUOR_OFF:
                {
                    if (t <= 0f)
                    {
                        if (Random.value < 0.25f)
                        {
                            _fluorState[i] = FLUOR_FLASH;
                            _fluorStateTimer[i] = Random.Range(FLASH_MIN, FLASH_MAX);
                        }
                        else
                        {
                            _fluorState[i] = FLUOR_PREHEAT;
                            _fluorStateTimer[i] = Random.Range(PREHEAT_MIN, PREHEAT_MAX);
                        }
                    }
                    return SmoothIntensityPreview(i, 0f, dt);
                }

            case FLUOR_PREHEAT:
                {
                    float glow = 0.04f + 0.06f * Mathf.PingPong(Time.time * 3f + i, 1f);
                    if (t <= 0f)
                    {
                        _fluorState[i] = FLUOR_FLASH;
                        _fluorStateTimer[i] = Random.Range(FLASH_MIN, FLASH_MAX);
                    }
                    return SmoothIntensityPreview(i, glow, dt);
                }

            case FLUOR_FLASH:
                {
                    _fluorFlickerPhase[i] += dt * Random.Range(300f, 600f);
                    float flash = 0.7f + 0.3f * Mathf.PerlinNoise(_fluorFlickerPhase[i] * 0.3f, i * 7.3f);
                    flash = Mathf.Clamp01(flash);

                    if (t <= 0f)
                    {
                        bool tubeStillHot = _fluorIntensity[i] > 0.20f;
                        float chance = Mathf.Lerp(BASE_IGNITION_CHANCE, 0.05f, failureRate);
                        if (tubeStillHot) chance += 0.30f;

                        if (Random.value < chance)
                        {
                            _fluorState[i] = FLUOR_ON;
                            float onTime = Random.Range(ON_MIN, ON_MAX) * (1f - failureRate * 0.7f);
                            _fluorStateTimer[i] = Mathf.Max(0.4f, onTime);
                        }
                        else
                        {
                            if (Random.value < DOUBLE_FLASH_CHANCE)
                            {
                                _fluorState[i] = FLUOR_FLASH;
                                _fluorStateTimer[i] = Random.Range(0.02f, 0.06f);
                            }
                            else
                            {
                                _fluorState[i] = FLUOR_OFF;
                                _fluorStateTimer[i] = Random.Range(OFF_MIN, OFF_MAX)
                                                        * Mathf.Lerp(0.3f, 1.1f, failureRate);
                            }
                        }
                    }
                    return SmoothIntensityPreview(i, flash, dt);
                }

            case FLUOR_ON:
                {
                    _fluorFlickerPhase[i] += dt * 100f;
                    float flicker = 1f + Mathf.Sin(_fluorFlickerPhase[i]) * 0.008f;

                    if (Random.value < 0.005f + failureRate * 0.01f)
                        flicker *= Random.Range(0.75f, 0.95f);

                    if (t <= 0f)
                    {
                        if (Random.value < 0.35f)
                        {
                            _fluorState[i] = FLUOR_OFF;
                            _fluorStateTimer[i] = Random.Range(OFF_MIN, OFF_MAX);
                        }
                        else
                        {
                            _fluorState[i] = FLUOR_FLICKER;
                            _fluorStateTimer[i] = Random.Range(FLICKER_MIN, FLICKER_MAX);
                        }
                    }
                    return SmoothIntensityPreview(i, flicker, dt);
                }

            case FLUOR_FLICKER:
                {
                    if (Random.value < 0.15f)
                        _fluorFlickerPhase[i] += dt * Random.Range(10f, 80f);
                    else
                        _fluorFlickerPhase[i] += dt * Random.Range(30f, 60f);

                    float flicker = 0.30f + 0.45f * Mathf.Sin(_fluorFlickerPhase[i]);

                    if (Random.value < 0.08f + failureRate * 0.25f)
                        flicker *= Random.Range(0.0f, 0.40f);

                    flicker = Mathf.Max(0.0f, flicker);

                    if (t <= 0f)
                    {
                        _fluorState[i] = FLUOR_DYING;
                        _fluorStateTimer[i] = Random.Range(DYING_MIN, DYING_MAX);
                    }
                    return SmoothIntensityPreview(i, flicker, dt);
                }

            case FLUOR_DYING:
                {
                    float intensity = Mathf.Max(0f, t * 0.5f);

                    if (Random.value < 0.25f)
                        intensity += Random.value * 0.15f;
                    intensity = Mathf.Min(intensity, 0.35f);

                    if (t <= 0f)
                    {
                        _fluorState[i] = FLUOR_OFF;
                        _fluorStateTimer[i] = Random.Range(OFF_MIN, OFF_MAX);
                    }
                    return SmoothIntensityPreview(i, intensity, dt);
                }
        }

        _fluorState[i] = FLUOR_OFF;
        _fluorStateTimer[i] = Random.Range(0.2f, 1.0f);
        return SmoothIntensityPreview(i, 0f, dt);
    }

    private static float SmoothIntensityPreview(int i, float target, float dt)
    {
        float current = _fluorIntensity[i];
        if (target > current + 0.3f)
            _fluorIntensity[i] = Mathf.Lerp(current, target, dt * 40f);
        else
        {
            float speed = (target > current) ? 12f : 6f;
            _fluorIntensity[i] = Mathf.Lerp(current, target, dt * speed);
        }
        return _fluorIntensity[i];
    }

    // ── Incandescent preview ────────────────────────────────────────────────
    private static float TickIncandescentPreview(int i, float dt)
    {
        _incandDriftTimer[i] -= dt;
        if (_incandDriftTimer[i] <= 0f)
        {
            _incandDriftTimer[i] = Random.Range(INCAND_DRIFT_RATE_MIN, INCAND_DRIFT_RATE_MAX);
            _incandDriftTarget[i] = 1f + Random.Range(-INCAND_DRIFT_AMPLITUDE, INCAND_DRIFT_AMPLITUDE);
        }

        _incandDriftVal[i] = Mathf.Lerp(_incandDriftVal[i], _incandDriftTarget[i], dt * 0.8f);
        _incandThermalMass[i] = Mathf.Lerp(_incandThermalMass[i], _incandDriftVal[i], dt * INCAND_THERMAL_SPEED);
        _incandPhase[i] += dt * INCAND_WAVER_FREQ * Mathf.PI * 2f;
        float waver = Mathf.Sin(_incandPhase[i]) * INCAND_WAVER_AMPLITUDE;

        return Mathf.Clamp01(_incandThermalMass[i] + waver);
    }

    // ── Sort ──────────────────────────────────────────────────────────────────
    private static int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        int cap = Mathf.Clamp(_activeSpecularCount, 1, MAX_LIGHTS);

        for (int i = 0; i < _lights.Length; i++)
        {
            Light l = _lights[i];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy ||
                l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex)
                continue;

            float distSq = Vector3.SqrMagnitude(viewerPos - l.transform.position);
            float dist = Mathf.Sqrt(distSq);

            // Same dual-distance budget cull as runtime: only drop a light
            // entirely if it's out of range for BOTH specular and diffuse.
            float specLimit = (_specularMaxDistances != null && i < _specularMaxDistances.Length) ? _specularMaxDistances[i] : 0f;
            float diffLimit = (_diffuseMaxDistances != null && i < _diffuseMaxDistances.Length) ? _diffuseMaxDistances[i] : 0f;
            bool specInRange = specLimit <= 0f || dist <= specLimit;
            bool diffInRange = diffLimit <= 0f || dist <= diffLimit;

            if (!specInRange && !diffInRange)
                continue;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= cap) continue;

            int maxShift = Mathf.Min(count, cap - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j] = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }

            _indices[ins] = i;
            _distances[ins] = distSq;
            if (count < cap) count++;
        }
        return count;
    }

    // ── UpdateLiveData ────────────────────────────────────────────────────────
    private static bool UpdateLiveData()
    {
        if (_lightToShader == null || _lightToShader.Length != _lights.Length) return false;

        bool changed = false;

        for (int li = 0; li < _lights.Length; li++)
        {
            Light l = _lights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;

            Transform t = l.transform;
            Vector3 pos = t.position;
            Quaternion rot = t.rotation;
            float intensity = l.intensity;
            Vector3 col = new Vector3(l.color.r, l.color.g, l.color.b);

            bool posChanged = (pos - _lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
            bool rotChanged = Quaternion.Dot(rot, _lastLightRotations[li]) < 0.9999f;
            bool intChanged = Mathf.Abs(intensity - _lastLightIntensities[li]) > INTENSITY_EPSILON;
            bool colChanged = Mathf.Abs(col.x - _lastLightColors[li].x) > COLOR_EPSILON ||
                              Mathf.Abs(col.y - _lastLightColors[li].y) > COLOR_EPSILON ||
                              Mathf.Abs(col.z - _lastLightColors[li].z) > COLOR_EPSILON;

            if (!posChanged && !rotChanged && !intChanged && !colChanged) continue;

            changed = true;
            _lastLightPositions[li] = pos;
            _lastLightRotations[li] = rot;
            _lastLightIntensities[li] = intensity;
            _lastLightColors[li] = col;

            int si = _lightToShader[li];
            if (si < 0) continue;

            int baseIdx = si * 8 + 1;

            Vector3 bakedCol = (_bakedColors != null && li < _bakedColors.Length)
                ? _bakedColors[li] : col;
            float realtimeFlag = (_isRealtime != null && li < _isRealtime.Length && _isRealtime[li]) ? 1.0f : 0.0f;

            if (posChanged || intChanged)
                _shaderBuffer[baseIdx + 0] = new Vector4(pos.x, pos.y, pos.z, intensity);

            if (intChanged || colChanged)
            {
                _shaderBuffer[baseIdx + 1] = new Vector4(col.x, col.y, col.z, intensity);
                _shaderBuffer[baseIdx + 5] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
            }

            if (rotChanged)
            {
                Vector3 f = rot * Vector3.forward;
                Vector3 r = rot * Vector3.right;
                Vector3 u = rot * Vector3.up;

                float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
                float halfX = (_halfExtents != null && li < _halfExtents.Length) ? _halfExtents[li].x : 0.01f;
                float halfY = (_halfExtents != null && li < _halfExtents.Length) ? _halfExtents[li].y : 0.01f;

                _shaderBuffer[baseIdx + 2] = new Vector4(f.x, f.y, f.z, cosOuter);
                _shaderBuffer[baseIdx + 3] = new Vector4(r.x, r.y, r.z, halfX);
                _shaderBuffer[baseIdx + 4] = new Vector4(u.x, u.y, u.z, halfY);
            }
        }

        if (changed)
        {
            LayeredLightingManager mgr = _worldRoot != null
                ? _worldRoot.GetComponent<LayeredLightingManager>() : null;
            if (mgr != null)
            {
                mgr.shaderWasUpdated = true;
                mgr.shaderUpdatesThisFrame = 1;
                mgr.updateReason = "Editor: LiveData";
                EditorUtility.SetDirty(mgr);
            }
        }

        return changed;
    }

    // ── FillUploadBuffers ─────────────────────────────────────────────────────
    private static void FillUploadBuffers(int finalCount)
    {
        float lodBias = 0.3f;
        if (_worldRoot != null)
        {
            LayeredLightingManager mgr = _worldRoot.GetComponent<LayeredLightingManager>();
            if (mgr != null) lodBias = mgr.lightmapLODBias;
        }

        _shaderBuffer[0] = new Vector4((float)finalCount, _rangeScale, lodBias, 1f);
        for (int i = 0; i < finalCount; i++)
        {
            int li = _indices[i];
            Light l = _lights[li];
            int baseIdx = i * 8 + 1;

            Vector3 pos = l.transform.position;
            Vector3 rawColor = new Vector3(l.color.r, l.color.g, l.color.b);
            float intensity = l.intensity;

            Vector3 bakedCol = (_bakedColors != null && li < _bakedColors.Length)
                ? _bakedColors[li] : rawColor;
            float realtimeFlag = (_isRealtime != null && li < _isRealtime.Length && _isRealtime[li]) ? 1.0f : 0.0f;

            Vector3 fwd = l.transform.forward;
            Vector3 right = l.transform.right;
            Vector3 up = l.transform.up;
            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);

            float halfX = (_halfExtents != null && li < _halfExtents.Length) ? _halfExtents[li].x : 0.01f;
            float halfY = (_halfExtents != null && li < _halfExtents.Length) ? _halfExtents[li].y : 0.01f;

            int layerSlice = (_layerSlices != null && li < _layerSlices.Length) ? _layerSlices[li] : -1;
            bool diffuseOn = (_diffuseEnabled != null && li < _diffuseEnabled.Length) ? _diffuseEnabled[li] : true;
            bool specularOn = (_specularEnabled != null && li < _specularEnabled.Length) ? _specularEnabled[li] : true;
            int groupMask = (_groupMasks != null && li < _groupMasks.Length) ? _groupMasks[li] : ~0;

            float specMaxDist = (_specularMaxDistances != null && li < _specularMaxDistances.Length) ? _specularMaxDistances[li] : 0f;
            float diffMaxDist = (_diffuseMaxDistances != null && li < _diffuseMaxDistances.Length) ? _diffuseMaxDistances[li] : 0f;

            _shaderBuffer[baseIdx + 0] = new Vector4(pos.x, pos.y, pos.z, intensity);
            _shaderBuffer[baseIdx + 1] = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
            _shaderBuffer[baseIdx + 2] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
            _shaderBuffer[baseIdx + 3] = new Vector4(right.x, right.y, right.z, halfX);
            _shaderBuffer[baseIdx + 4] = new Vector4(up.x, up.y, up.z, halfY);
            _shaderBuffer[baseIdx + 5] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
            _shaderBuffer[baseIdx + 6] = new Vector4(layerSlice, diffuseOn ? 1f : 0f, specularOn ? 1f : 0f, groupMask);
            _shaderBuffer[baseIdx + 7] = new Vector4(specMaxDist, diffMaxDist, 0f, 0f);

            _lastIndicesSorted[i] = li;
        }

        // Clear remaining slots so stale lights don't persist
        int clearUpTo = Mathf.Max(finalCount, _lastUploadedSlotCount);
        for (int i = finalCount; i < clearUpTo; i++)
        {
            int baseIdx = i * 8 + 1;
            for (int j = 0; j < 8; j++)
                _shaderBuffer[baseIdx + j] = Vector4.zero;
            _shaderBuffer[baseIdx + 6] = new Vector4(-1f, 0f, 0f, 0f);
            _shaderBuffer[baseIdx + 7] = Vector4.zero;
            _lastIndicesSorted[i] = -1;
        }
        _lastUploadedSlotCount = finalCount;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private static void UploadToShader()
    {
        Shader.SetGlobalVectorArray("_UdonLightData", _shaderBuffer);
        if (_previewLayerArray != null)
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
    }

    private static Vector3 GetViewerPos()
    {
        SceneView sv = SceneView.lastActiveSceneView;
        return (sv != null && sv.camera != null) ? sv.camera.transform.position : Vector3.zero;
    }

    private static float ComputeCosOuter(LightType type, float spotAngleDegrees)
    {
        if (type == LightType.Spot) return Mathf.Cos(spotAngleDegrees * 0.5f * Mathf.Deg2Rad);
        if (type == LightType.Area) return 0.0f;
        return -1.0f;
    }

    private static int CountBits(int v)
    {
        int c = 0;
        while (v != 0) { v &= (v - 1); c++; }
        return c;
    }

    private static void RepaintSceneViews() => SceneView.RepaintAll();

    private static void CacheLightStates()
    {
        int n = _lights.Length;
        if (_lastLightPositions == null || _lastLightPositions.Length != n) _lastLightPositions = new Vector3[n];
        if (_lastLightRotations == null || _lastLightRotations.Length != n) _lastLightRotations = new Quaternion[n];
        if (_lastLightIntensities == null || _lastLightIntensities.Length != n) _lastLightIntensities = new float[n];
        if (_lastLightColors == null || _lastLightColors.Length != n) _lastLightColors = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = _lights[i];
            if (l == null) continue;
            _lastLightPositions[i] = l.transform.position;
            _lastLightRotations[i] = l.transform.rotation;
            _lastLightIntensities[i] = l.intensity;
            _lastLightColors[i] = new Vector3(l.color.r, l.color.g, l.color.b);
        }
    }

    // ── Menu items ────────────────────────────────────────────────────────────
    [MenuItem("Meenphie/Layered Lighting/Rebuild Light Data")]
    public static void RebuildLightData()
    {
        TryFindAndRescan();
        _previewEnabled = true;
        Debug.Log("[Layered Lighting] Light data rebuilt. Preview enabled.");
    }

    [MenuItem("Meenphie/Layered Lighting/Toggle Specular Preview")]
    public static void ToggleSpecularPreview()
    {
        _previewEnabled = !_previewEnabled;
        if (_previewEnabled)
        {
            TryFindAndRescan();
            Debug.Log("[Layered Lighting] Preview ON.");
        }
        else
        {
            ClearPreview();
            Debug.Log("[Layered Lighting] Preview OFF.");
        }
    }

    [MenuItem("Meenphie/Layered Lighting/Toggle Specular Preview", validate = true)]
    public static bool ToggleSpecularPreviewValidate()
    {
        Menu.SetChecked("Meenphie/Layered Lighting/Toggle Specular Preview", _previewEnabled);
        return true;
    }

    [MenuItem("Meenphie/Layered Lighting/Clear Preview")]
    public static void ClearPreview()
    {
        for (int i = 0; i < _shaderBuffer.Length; i++) _shaderBuffer[i] = Vector4.zero;
        Shader.SetGlobalVectorArray("_UdonLightData", _shaderBuffer);

        LayeredLightingManager mgr = _worldRoot != null
            ? _worldRoot.GetComponent<LayeredLightingManager>() : null;
        if (mgr != null)
        {
            mgr.shaderWasUpdated = false;
            mgr.shaderUpdatesThisFrame = 0;
            mgr.updateReason = "None";
            EditorUtility.SetDirty(mgr);
        }

        RepaintSceneViews();
        Debug.Log("[Layered Lighting] Preview cleared.");
    }
}
#endif