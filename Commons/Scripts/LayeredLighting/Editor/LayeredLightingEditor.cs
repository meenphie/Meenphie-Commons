#if UNITY_EDITOR && UDONSHARP
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditorInternal;

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

    // ── Fault animation constants (identical to runtime) ────────────────────
    private const float FAULT_FADE_SPEED = 15.0f;

    private const float PANIC_ON_MEAN_SLOW = 0.30f;
    private const float PANIC_ON_MEAN_FAST = 0.01f;
    private const float PANIC_OFF_MEAN_SLOW = 0.80f;
    private const float PANIC_OFF_MEAN_FAST = 0.02f;

    // Defaults used when a light has no previously-stored per-light fault settings
    // (mirrors LayeredLightingManager.OnValidate defaults)
    private const float DEFAULT_BROKEN_ON_MIN = 0.01f;
    private const float DEFAULT_BROKEN_ON_MAX = 1.5f;
    private const float DEFAULT_BROKEN_OFF_MIN = 0.5f;
    private const float DEFAULT_BROKEN_OFF_MAX = 2.0f;
    private const float DEFAULT_BROKEN_ON_INTENSITY = 0.8f;
    private const float DEFAULT_PANIC_SPEED = 0.5f;
    private const float DEFAULT_PANIC_INTENSITY_MIN = 0.1f;
    private const float DEFAULT_PANIC_INTENSITY_MAX = 1.2f;

    // ── Physical animation state (editor preview) ──────────────────────────
    private static float[] _faultStateTimer;
    private static bool[] _faultIsOn;
    private static float[] _faultIntensity;
    private static float[] _panicTargetIntensity;
    private static float[] _animatedIntensityPreview;

    // Per-light fault timing, preserved across rescans by Light reference
    private static float[] _brokenOnMin;
    private static float[] _brokenOnMax;
    private static float[] _brokenOffMin;
    private static float[] _brokenOffMax;
    private static float[] _brokenOnIntensity;
    private static float[] _panicSpeed;
    private static float[] _panicIntensityMin;
    private static float[] _panicIntensityMax;

    // ── Editor state ───────────────────────────────────────────────────────
    private static GameObject _worldRoot;
    private static Light[] _lights;
    private static Vector2[] _halfExtents;
    private static bool[] _isRealtime;
    private static bool[] _diffuseEnabled;
    private static bool[] _specularEnabled;
    private static float[] _specularMaxDistances;
    private static float[] _diffuseMaxDistances;
    private static LightFaultState[] _faultStates;
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

    private static double _lastViewerTick;
    private static int _lastFinalCount = -1;

    // Tracks whether the Scene view is actually being drawn. OnSceneGui only fires
    // while its tab is visible, and (when "Always Refresh" / Animated Materials is
    // off) only on interaction rather than continuously — so this timestamp doubles
    // as our signal for "is there any point computing right now".
    private static double _lastSceneGuiTime = double.NegativeInfinity;
    private const double SCENE_VISIBLE_TIMEOUT = 0.5;

    // Real "Always Refresh" (Animated Materials) flag read off the SceneView, via
    // reflection since the backing field/property name has changed across Unity
    // versions (showMaterialUpdate / materialUpdate / animateMaterials / alwaysRefresh).
    private static bool _lastKnownAlwaysRefresh = true;
    private static bool _alwaysRefreshKnown = false;
    private static bool _alwaysRefreshFieldMissingLogged = false;

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

    // ── Bootstrap ──────────────────────────────────────────────────────────
    static LayeredLightingEditor()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
        SceneView.duringSceneGui -= OnSceneGui;
        SceneView.duringSceneGui += OnSceneGui;
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;
    }

    private static void OnHierarchyChanged()
    {
        if (Application.isPlaying) return;
        _rescanPending = true;
        _lastHierarchyChangeRequest = EditorApplication.timeSinceStartup;
    }

    private static void OnSceneGui(SceneView sv)
    {
        _lastSceneGuiTime = EditorApplication.timeSinceStartup;
        if (!_previewEnabled || Application.isPlaying) return;
        UploadToShader();
    }

    // Reads the real "Always Refresh" (a.k.a. Animated Materials) toggle off the
    // active SceneView. Field name has changed across Unity versions, so this
    // tries several known names via reflection rather than hardcoding one that
    // might not compile/exist on the user's Unity version.
    private static readonly string[] _alwaysRefreshFieldNames =
        { "alwaysRefresh", "showMaterialUpdate", "materialUpdate", "animateMaterials" };

    private static bool TryGetAlwaysRefresh(out bool value)
    {
        value = true;
        SceneView sv = SceneView.lastActiveSceneView;
        if (sv == null) return false;

        var stateProp = typeof(SceneView).GetProperty("sceneViewState",
            System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
        object state = stateProp != null ? stateProp.GetValue(sv) : null;
        if (state == null) return false;

        var stateType = state.GetType();
        foreach (var name in _alwaysRefreshFieldNames)
        {
            var f = stateType.GetField(name, System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
            if (f != null && f.FieldType == typeof(bool))
            {
                value = (bool)f.GetValue(state);
                return true;
            }
            var p = stateType.GetProperty(name, System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
            if (p != null && p.PropertyType == typeof(bool))
            {
                value = (bool)p.GetValue(state);
                return true;
            }
        }
        return false;
    }

    // Polls the real Always Refresh flag, logs it whenever it changes (so you can
    // actually see it doing something), and resets lights to their default,
    // non-animated intensity the moment it gets switched off.
    private static void PollAlwaysRefresh()
    {
        bool found = TryGetAlwaysRefresh(out bool current);
        if (!found)
        {
            if (!_alwaysRefreshFieldMissingLogged)
            {
                Debug.LogWarning("[LayeredLightingEditor] Could not read the Always Refresh flag on this Unity version (reflection lookup failed). Falling back to repaint-timing heuristic only.");
                _alwaysRefreshFieldMissingLogged = true;
            }
            return;
        }

        if (!_alwaysRefreshKnown || current != _lastKnownAlwaysRefresh)
        {
            Debug.Log("[LayeredLightingEditor] Always Refresh (Animated Materials) = " + current);
            if (_alwaysRefreshKnown && _lastKnownAlwaysRefresh && !current)
                ResetToDefaults();
            _lastKnownAlwaysRefresh = current;
            _alwaysRefreshKnown = true;
        }
    }

    // Called when Always Refresh flips from ON to OFF: snaps every light back to
    // its clean, non-faulted intensity instead of leaving it frozen mid-flicker.
    private static void ResetToDefaults()
    {
        if (_lights == null) return;

        for (int i = 0; i < _lights.Length; i++)
        {
            _faultIntensity[i] = 1f;
            _faultIsOn[i] = true;
            if (_animatedIntensityPreview != null && i < _animatedIntensityPreview.Length)
                _animatedIntensityPreview[i] = 1f;
            if (_panicTargetIntensity != null && i < _panicTargetIntensity.Length &&
                _panicIntensityMax != null && i < _panicIntensityMax.Length)
                _panicTargetIntensity[i] = _panicIntensityMax[i];
        }

        for (int i = 0; i < _lastFinalCount && i < _lastIndicesSorted.Length; i++)
        {
            int li = _lastIndicesSorted[i];
            if (li < 0) continue;
            int baseIdx = i * 8 + 1;
            Vector4 cv = _shaderBuffer[baseIdx + 1];
            float baseInt = (_lastLightIntensities != null && li < _lastLightIntensities.Length)
                ? _lastLightIntensities[li] : cv.w;
            _shaderBuffer[baseIdx + 1] = new Vector4(cv.x, cv.y, cv.z, baseInt);
            if (i < _lastAnimatedIntensity.Length) _lastAnimatedIntensity[i] = baseInt;
        }

        UploadToShader();
        RepaintSceneViews();
        Debug.Log("[LayeredLightingEditor] Always Refresh disabled — lights reset to default intensity.");
    }

    private static void OnEditorUpdate()
    {
        if (Application.isPlaying) return;
        if (!_previewEnabled) return;

        double now = EditorApplication.timeSinceStartup;

        PollAlwaysRefresh();

        // Stop everything if: the Unity application is minimized / not the active
        // OS window, OR the Scene view tab isn't currently being drawn (user
        // switched to another tab, or "Always Refresh" is off and nothing is
        // triggering a repaint), OR Always Refresh is explicitly off. Update
        // _lastPrevTime AND _lastTick regardless, so we don't get a giant dt spike
        // or an artificial "catch-up" Tick (which was reshuffling light slots and
        // looked like random blinking) once things resume.
        bool editorActive = InternalEditorUtility.isApplicationActive;
        bool sceneVisible = (now - _lastSceneGuiTime) < SCENE_VISIBLE_TIMEOUT;
        bool refreshAllowed = !_alwaysRefreshKnown || _lastKnownAlwaysRefresh;
        if (!editorActive || !sceneVisible || !refreshAllowed)
        {
            _lastPrevTime = now;
            _lastTick = now;
            return;
        }

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
        if (liveMgr != null && ShouldCheckExternalEditsNow() && HasExternalArrayEdits(liveMgr))
            Rescan(liveMgr);

        float dt = (float)(now - _lastPrevTime);
        _lastPrevTime = now;
        dt = Mathf.Clamp(dt, 0f, 0.1f);

        bool tickThisFrame = now - _lastTick >= (liveMgr != null ? liveMgr.updateInterval : 0.02f);

        if (tickThisFrame)
        {
            _lastTick = now;
            Tick(dt, liveMgr);
        }
        else
        {
            UpdateLiveData();
            TickPhysicalAnimationPreview(dt);
        }
    }

    // ── Rescan ─────────────────────────────────────────────────────────────
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

    private static double _lastExternalEditsCheck = 0;
    private const double EXTERNAL_EDITS_CHECK_INTERVAL = 0.25;

    private static bool ShouldCheckExternalEditsNow()
    {
        double now = EditorApplication.timeSinceStartup;
        if (now - _lastExternalEditsCheck < EXTERNAL_EDITS_CHECK_INTERVAL) return false;
        _lastExternalEditsCheck = now;
        return true;
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

        // Preserve previous settings by light reference
        var oldRealtimeByLight = new Dictionary<Light, bool>();
        var oldDiffuseByLight = new Dictionary<Light, bool>();
        var oldSpecularByLight = new Dictionary<Light, bool>();
        var oldMaxDistByLight = new Dictionary<Light, float>();
        var oldDiffuseMaxDistByLight = new Dictionary<Light, float>();
        var oldFaultStateByLight = new Dictionary<Light, LightFaultState>();
        var oldSliceByLight = new Dictionary<Light, int>();
        var oldGroupMaskByLight = new Dictionary<Light, int>();
        var oldBakedColByLight = new Dictionary<Light, Vector3>();

        // Per-light fault timing (mirrors the fields edited via the Light inspector)
        var oldBrokenOnMinByLight = new Dictionary<Light, float>();
        var oldBrokenOnMaxByLight = new Dictionary<Light, float>();
        var oldBrokenOffMinByLight = new Dictionary<Light, float>();
        var oldBrokenOffMaxByLight = new Dictionary<Light, float>();
        var oldBrokenOnIntensityByLight = new Dictionary<Light, float>();
        var oldPanicSpeedByLight = new Dictionary<Light, float>();
        var oldPanicIntensityMinByLight = new Dictionary<Light, float>();
        var oldPanicIntensityMaxByLight = new Dictionary<Light, float>();

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
                if (mgr.childLightFaultState != null && i < mgr.childLightFaultState.Length)
                    oldFaultStateByLight[l] = mgr.childLightFaultState[i];
                if (mgr.childLightLayerSlices != null && i < mgr.childLightLayerSlices.Length)
                    oldSliceByLight[l] = mgr.childLightLayerSlices[i];
                if (mgr.childLightGroupIndex != null && i < mgr.childLightGroupIndex.Length)
                    oldGroupMaskByLight[l] = mgr.childLightGroupIndex[i];
                if (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                    oldBakedColByLight[l] = mgr.childLightBakedColors[i];

                if (mgr.childLightBrokenOnMin != null && i < mgr.childLightBrokenOnMin.Length)
                    oldBrokenOnMinByLight[l] = mgr.childLightBrokenOnMin[i];
                if (mgr.childLightBrokenOnMax != null && i < mgr.childLightBrokenOnMax.Length)
                    oldBrokenOnMaxByLight[l] = mgr.childLightBrokenOnMax[i];
                if (mgr.childLightBrokenOffMin != null && i < mgr.childLightBrokenOffMin.Length)
                    oldBrokenOffMinByLight[l] = mgr.childLightBrokenOffMin[i];
                if (mgr.childLightBrokenOffMax != null && i < mgr.childLightBrokenOffMax.Length)
                    oldBrokenOffMaxByLight[l] = mgr.childLightBrokenOffMax[i];
                if (mgr.childLightBrokenOnIntensity != null && i < mgr.childLightBrokenOnIntensity.Length)
                    oldBrokenOnIntensityByLight[l] = mgr.childLightBrokenOnIntensity[i];
                if (mgr.childLightPanicSpeed != null && i < mgr.childLightPanicSpeed.Length)
                    oldPanicSpeedByLight[l] = mgr.childLightPanicSpeed[i];
                if (mgr.childLightPanicIntensityMin != null && i < mgr.childLightPanicIntensityMin.Length)
                    oldPanicIntensityMinByLight[l] = mgr.childLightPanicIntensityMin[i];
                if (mgr.childLightPanicIntensityMax != null && i < mgr.childLightPanicIntensityMax.Length)
                    oldPanicIntensityMaxByLight[l] = mgr.childLightPanicIntensityMax[i];
            }
        }

        _halfExtents = new Vector2[count];
        _isRealtime = new bool[count];
        _diffuseEnabled = new bool[count];
        _specularEnabled = new bool[count];
        _specularMaxDistances = new float[count];
        _diffuseMaxDistances = new float[count];
        _faultStates = new LightFaultState[count];
        _bakedColors = new Vector3[count];
        _layerSlices = new int[count];
        _groupMasks = new int[count];

        _brokenOnMin = new float[count];
        _brokenOnMax = new float[count];
        _brokenOffMin = new float[count];
        _brokenOffMax = new float[count];
        _brokenOnIntensity = new float[count];
        _panicSpeed = new float[count];
        _panicIntensityMin = new float[count];
        _panicIntensityMax = new float[count];

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
            _faultStates[i] = oldFaultStateByLight.TryGetValue(l, out LightFaultState prevFault) ? prevFault : LightFaultState.Normal;
            _layerSlices[i] = oldSliceByLight.TryGetValue(l, out int prevSlice) ? prevSlice : -1;
            _groupMasks[i] = oldGroupMaskByLight.TryGetValue(l, out int prevMask) ? prevMask : ~0;
            _bakedColors[i] = oldBakedColByLight.TryGetValue(l, out Vector3 prevCol) ? prevCol : new Vector3(l.color.r, l.color.g, l.color.b);

            _brokenOnMin[i] = oldBrokenOnMinByLight.TryGetValue(l, out float bMin) ? bMin : DEFAULT_BROKEN_ON_MIN;
            _brokenOnMax[i] = oldBrokenOnMaxByLight.TryGetValue(l, out float bMax) ? bMax : DEFAULT_BROKEN_ON_MAX;
            _brokenOffMin[i] = oldBrokenOffMinByLight.TryGetValue(l, out float bOffMin) ? bOffMin : DEFAULT_BROKEN_OFF_MIN;
            _brokenOffMax[i] = oldBrokenOffMaxByLight.TryGetValue(l, out float bOffMax) ? bOffMax : DEFAULT_BROKEN_OFF_MAX;
            _brokenOnIntensity[i] = oldBrokenOnIntensityByLight.TryGetValue(l, out float bOnInt) ? bOnInt : DEFAULT_BROKEN_ON_INTENSITY;
            _panicSpeed[i] = oldPanicSpeedByLight.TryGetValue(l, out float pSpeed) ? pSpeed : DEFAULT_PANIC_SPEED;
            _panicIntensityMin[i] = oldPanicIntensityMinByLight.TryGetValue(l, out float pMin) ? pMin : DEFAULT_PANIC_INTENSITY_MIN;
            _panicIntensityMax[i] = oldPanicIntensityMaxByLight.TryGetValue(l, out float pMax) ? pMax : DEFAULT_PANIC_INTENSITY_MAX;
        }

        mgr.childLights = freshLights;
        mgr.childLightIsRealtime = _isRealtime;
        mgr.childLightDiffuseEnabled = _diffuseEnabled;
        mgr.childLightSpecularDistance = _specularEnabled;
        mgr.childLightSpecularMaxDistance = _specularMaxDistances;
        mgr.childLightDiffuseMaxDistance = _diffuseMaxDistances;
        mgr.childLightFaultState = _faultStates;
        mgr.childLightHalfExtents = _halfExtents;
        mgr.childLightLayerSlices = _layerSlices;
        mgr.childLightGroupIndex = _groupMasks;
        mgr.childLightBakedColors = _bakedColors;

        mgr.childLightBrokenOnMin = _brokenOnMin;
        mgr.childLightBrokenOnMax = _brokenOnMax;
        mgr.childLightBrokenOffMin = _brokenOffMin;
        mgr.childLightBrokenOffMax = _brokenOffMax;
        mgr.childLightBrokenOnIntensity = _brokenOnIntensity;
        mgr.childLightPanicSpeed = _panicSpeed;
        mgr.childLightPanicIntensityMin = _panicIntensityMin;
        mgr.childLightPanicIntensityMax = _panicIntensityMax;

        EditorUtility.SetDirty(mgr);
        _lights = freshLights;

        if (mgr.lightLayerArray != null)
        {
            _previewLayerArray = mgr.lightLayerArray;
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        }
        Shader.SetGlobalFloat("_UdonLightLayerArrayValid", _previewLayerArray != null ? 1f : 0f);
        int groupCount = mgr.lightmapGroupCount;
        Shader.SetGlobalFloat("_UdonLightmapSliceOffset", (float)groupCount);

        for (int i = 0; i < MAX_LIGHTS; i++) _lastAnimatedIntensity[i] = -1f;
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        _lastUploadedSlotCount = 0;

        _lastFinalCount = -1;
        _lastViewerTick = 0;

        AllocPhysicalState(count);
        CacheLightStates();
        _lastTick = 0;
        _lastPrevTime = EditorApplication.timeSinceStartup;
        Tick(0f, mgr);
    }

    private static void AllocPhysicalState(int count)
    {
        _faultStateTimer = new float[count];
        _faultIsOn = new bool[count];
        _faultIntensity = new float[count];
        _panicTargetIntensity = new float[count];
        _animatedIntensityPreview = new float[count];

        for (int i = 0; i < count; i++)
        {
            _faultStateTimer[i] = Random.Range(0f, 1f);
            _faultIsOn[i] = true;
            _faultIntensity[i] = 1f;
            _panicTargetIntensity[i] = (_panicIntensityMax != null && i < _panicIntensityMax.Length)
                ? _panicIntensityMax[i] : DEFAULT_PANIC_INTENSITY_MAX;
            _animatedIntensityPreview[i] = 1f;
        }
    }

    private static void Tick(float dt, LayeredLightingManager mgr)
    {
        if (_lights == null || _lights.Length == 0) return;

        double now = EditorApplication.timeSinceStartup;
        float viewerInterval = (mgr != null) ? mgr.viewerUpdateInterval : 1.0f;

        bool viewerDue = (now - _lastViewerTick) >= viewerInterval || _lastFinalCount < 0;

        int finalCount;
        if (viewerDue)
        {
            _lastViewerTick = now;
            finalCount = SortNearest(GetViewerPos());
        }
        else
        {
            finalCount = _lastFinalCount;
        }

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
            if (_faultStates[idx] != LightFaultState.Normal) animCount++;
            if (_specularEnabled[idx]) specCount++;
            int sl = (_layerSlices != null && idx < _layerSlices.Length) ? _layerSlices[idx] : -1;
            if (sl >= 0 && sl < 32) { lmCount++; sliceMask |= (1 << sl); }
        }

        if (mgr != null)
        {
            bool wasDirty = EditorUtility.IsDirty(mgr);

            mgr.currentStaticLights = statCount;
            mgr.currentDynamicLights = dynCount;
            mgr.currentAnimatedLights = animCount;
            mgr.currentSpecularsCount = specCount;
            mgr.currentSlicesCount = lmCount;
            mgr.sampledLightmapsCount = CountBits(sliceMask);
            mgr.shaderWasUpdated = true;
            mgr.shaderUpdatesThisFrame = 1;
            mgr.updateReason = viewerDue
                ? "Editor: Tick[" + finalCount + " lights, resort]"
                : "Editor: Tick[" + finalCount + " lights]";

            // Robust safety net: these are transient debug/preview fields recomputed
            // every tick, never meant to require saving. If the object was clean
            // before this script touched it, force it back to clean afterward so
            // this script's own writes can never be the reason the scene shows
            // unsaved changes. A genuine unsaved edit (wasDirty == true already)
            // is left alone.
            if (!wasDirty) EditorUtility.ClearDirty(mgr);
        }

        CacheLightStates();
        FillUploadBuffers(finalCount);

        TickPhysicalAnimationPreview(dt);

        UploadToShader();
        RepaintSceneViews();

        _lastFinalCount = finalCount;
    }

    // ── Fault animation preview (identical logic to runtime Broken/Panic) ──
    // Converts a 0-1 speed value into on/off means using exponential curves,
    // matching LayeredLightingManager.SpeedToMeans exactly.
    private static void SpeedToMeans(float speed, out float onMean, out float offMean)
    {
        float t = speed * speed; // slight ease-in so low values stay sparse longer
        onMean = Mathf.Lerp(PANIC_ON_MEAN_SLOW, PANIC_ON_MEAN_FAST, t);
        offMean = Mathf.Lerp(PANIC_OFF_MEAN_SLOW, PANIC_OFF_MEAN_FAST, t);
    }

    private static bool TickPhysicalAnimationPreview(float dt)
    {
        if (_lights == null || _lights.Length == 0) return false;
        bool anyChanged = false;

        for (int i = 0; i < _lights.Length; i++)
        {
            if (_faultStates[i] == LightFaultState.Normal) continue;
            int si = (_lightToShader != null && i < _lightToShader.Length) ? _lightToShader[i] : -1;
            if (si < 0) continue;

            float newVal = TickFaultPreview(i, _faultStates[i], dt);
            _animatedIntensityPreview[i] = newVal;

            float baseInt = _lastLightIntensities[i];
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

    // Mirrors LayeredLightingManager.TickFault exactly: per-light Broken timing
    // arrays, and Panic driven by SpeedToMeans + exponential-distributed timer
    // with a randomized on-intensity target each cycle.
    private static float TickFaultPreview(int i, LightFaultState state, float dt)
    {
        if (state == LightFaultState.Panic)
        {
            float onMean, offMean;
            SpeedToMeans(_panicSpeed[i], out onMean, out offMean);

            _faultStateTimer[i] -= dt;
            while (_faultStateTimer[i] <= 0f)
            {
                _faultIsOn[i] = !_faultIsOn[i];
                float mean = _faultIsOn[i] ? onMean : offMean;
                float u = 1f - Random.value;
                if (u <= 0.0001f) u = 0.0001f;
                _faultStateTimer[i] += -mean * Mathf.Log(u);
                if (_faultIsOn[i])
                    _panicTargetIntensity[i] = Random.Range(_panicIntensityMin[i], _panicIntensityMax[i]);
            }
            _faultIntensity[i] = _faultIsOn[i] ? _panicTargetIntensity[i] : 0f;
            return _faultIntensity[i];
        }
        else // Broken
        {
            _faultStateTimer[i] -= dt;
            if (_faultStateTimer[i] <= 0f)
            {
                _faultIsOn[i] = !_faultIsOn[i];
                _faultStateTimer[i] = _faultIsOn[i]
                    ? Random.Range(_brokenOnMin[i], _brokenOnMax[i])
                    : Random.Range(_brokenOffMin[i], _brokenOffMax[i]);
            }
            float target = _faultIsOn[i] ? _brokenOnIntensity[i] : 0f;
            _faultIntensity[i] = Mathf.MoveTowards(_faultIntensity[i], target, FAULT_FADE_SPEED * dt);
            return _faultIntensity[i];
        }
    }

    // ── Sort, Fill, Upload ───────────────────────────────────────────────────
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

            float specLimit = _specularMaxDistances[i];
            float diffLimit = _diffuseMaxDistances[i];
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
            float realtimeFlag = _isRealtime[li] ? 1.0f : 0.0f;

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
                bool wasDirty = EditorUtility.IsDirty(mgr);

                mgr.shaderWasUpdated = true;
                mgr.shaderUpdatesThisFrame = 1;
                mgr.updateReason = "Editor: LiveData";

                // Same safety net as in Tick(): never let this script's own
                // transient writes be the reason the scene stays "unsaved".
                if (!wasDirty) EditorUtility.ClearDirty(mgr);
            }
        }

        return changed;
    }

    private static void FillUploadBuffers(int finalCount)
    {
        _shaderBuffer[0] = new Vector4((float)finalCount, _rangeScale, 0f, 1f);
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
            float realtimeFlag = _isRealtime[li] ? 1.0f : 0.0f;

            Vector3 fwd = l.transform.forward;
            Vector3 right = l.transform.right;
            Vector3 up = l.transform.up;
            float cosOuter = ComputeCosOuter(l.type, l.spotAngle);
            float cosInner = ComputeCosInner(cosOuter);
            int lightTypeInt = GetLightTypeInt(cosOuter);

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
            _shaderBuffer[baseIdx + 7] = new Vector4(specMaxDist, diffMaxDist, (float)lightTypeInt, cosInner);

            _lastIndicesSorted[i] = li;
        }

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

    private static void UploadToShader()
    {
        Shader.SetGlobalVectorArray("_UdonLightData", _shaderBuffer);
        Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        Shader.SetGlobalFloat("_UdonLightLayerArrayValid", _previewLayerArray != null ? 1f : 0f);

        LayeredLightingManager mgr = _worldRoot?.GetComponent<LayeredLightingManager>();
        if (mgr != null)
        {
            Shader.SetGlobalFloat("_UdonLODDistanceNear", mgr.lodDistanceNear);
            Shader.SetGlobalFloat("_UdonLODDistanceFar", mgr.lodDistanceFar);
            Shader.SetGlobalFloat("_UdonLODMaxMip", mgr.lodAtFar);
        }
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

    // Identical to LayeredLightingManager.ComputeCosInner: 15% penumbra in angular space
    private static float ComputeCosInner(float cosOuter)
    {
        if (cosOuter < -0.9f) return -1.0f; // point — unused
        if (cosOuter <= 0.0f) return 0.0f;  // area — unused
        float angleOuter = Mathf.Acos(cosOuter);
        float angleInner = angleOuter * 0.85f; // 15% penumbra
        return Mathf.Cos(angleInner);
    }

    // Identical to LayeredLightingManager.GetLightTypeInt: 0=point, 1=spot, 2=area
    private static int GetLightTypeInt(float cosOuter)
    {
        if (cosOuter < -0.9f) return 0;   // point
        if (cosOuter <= 0.0f) return 2;   // area
        return 1;                         // spot
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

    [MenuItem("Meenphie/Layered Lighting/Rebuild Light Data")]
    public static void RebuildLightData()
    {
        TryFindAndRescan();
        _previewEnabled = true;
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
    }
}
#endif