using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditorInternal;
using Meenphie.Commons;

[InitializeOnLoad]
public static class LightingEditorScene
{
    public const int MAX_LIGHTS = 32;
    private const int BUFFER_SIZE = MAX_LIGHTS * 8 + 1;

    private const float DEFAULT_RANGE_SCALE = 100f;
    private const double RESCAN_DEBOUNCE_SECONDS = 0.25;

    private static GameObject _worldRoot;
    private static Light[] _lights;
    private static Vector2[] _halfExtents;
    private static bool[] _isRealtime;
    private static bool[] _diffuseEnabled;
    private static bool[] _specularEnabled;
    private static LightFaultState[] _faultStates;
    private static Vector3[] _bakedColors;
    private static int[] _layerSlices;
    private static int[] _groupMasks;
    private static int[] _cookieSlices;
    private static float _rangeScale = DEFAULT_RANGE_SCALE;

    private static int _activeSpecularCount = MAX_LIGHTS;
    private static bool _previewEnabled = true;
    private static double _lastPrevTime;
    private static double _lastHierarchyChangeRequest = double.NegativeInfinity;
    private static bool _rescanPending;

    private static double _lastViewerTick;
    private static int _lastFinalCount = -1;

    private static double _lastSceneGuiTime = double.NegativeInfinity;
    private const double SCENE_VISIBLE_TIMEOUT = 0.5;

    private static bool _lastKnownAlwaysRefresh = true;
    private static bool _alwaysRefreshKnown = false;
    private static bool _alwaysRefreshFieldMissingLogged = false;

    private static Vector3[] _lastLightPositions;
    private static Quaternion[] _lastLightRotations;
    private static float[] _lastLightIntensities;
    private static Vector3[] _lastLightColors;

    private static readonly Vector4[] _shaderBuffer = new Vector4[BUFFER_SIZE];
    private static int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private static int _lastUploadedSlotCount = 0;

    private static int[] _indices = new int[MAX_LIGHTS];
    private static float[] _distances = new float[MAX_LIGHTS];
    private static int[] _lightToShader = new int[0];
    private static float _specCullDistanceSq;

    private static Texture2DArray _previewLayerArray;
    private static Texture2DArray _previewCookieArray;

    static LightingEditorScene()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
        SceneView.duringSceneGui -= OnSceneGui;
        SceneView.duringSceneGui += OnSceneGui;
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;

        EditorApplication.playModeStateChanged -= OnPlayModeStateChanged;
        EditorApplication.playModeStateChanged += OnPlayModeStateChanged;
    }

    private static void OnPlayModeStateChanged(PlayModeStateChange change)
    {
        if (change != PlayModeStateChange.EnteredEditMode) return;

        Shader.SetGlobalFloat("_UdonDiffuseStaticEnabled", 1f);
        Shader.SetGlobalFloat("_UdonDiffuseRealtimeEnabled", 1f);
        Shader.SetGlobalFloat("_UdonRNMEnabled", 1f);

        _worldRoot = null;
        _lastFinalCount = -1;
        _rescanPending = false;

        TryFindAndRescan();
        UploadToShader();
    }

    private static void OnHierarchyChanged()
    {
        if (Application.isPlaying) return;
        _rescanPending = true;
        _lastHierarchyChangeRequest = EditorApplication.timeSinceStartup;
    }

    private static void OnSceneGui(SceneView sv)
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        if (BuildPipeline.isBuildingPlayer) return;

        if (_worldRoot == null) _worldRoot = null;   // forces destroyed object to null

        _lastSceneGuiTime = EditorApplication.timeSinceStartup;
        if (!_previewEnabled || Application.isPlaying) return;
        UploadToShader();
    }

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

    private static void PollAlwaysRefresh()
    {
        bool found = TryGetAlwaysRefresh(out bool current);
        if (!found)
        {
            if (!_alwaysRefreshFieldMissingLogged)
            {
                Debug.LogWarning("[LayeredLightingEditor] Could not read the Always Refresh flag on this Unity version.");
                _alwaysRefreshFieldMissingLogged = true;
            }
            return;
        }

        if (!_alwaysRefreshKnown || current != _lastKnownAlwaysRefresh)
        {
            Debug.Log("[LayeredLightingEditor] Always Refresh (Animated Materials) = " + current);
            _lastKnownAlwaysRefresh = current;
            _alwaysRefreshKnown = true;
        }
    }

    private static void OnEditorUpdate()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        if (BuildPipeline.isBuildingPlayer) return;
        if (Application.isPlaying) return;

        if (!_previewEnabled) return;

        double now = EditorApplication.timeSinceStartup;

        PollAlwaysRefresh();

        bool editorActive = InternalEditorUtility.isApplicationActive;
        bool sceneVisible = (now - _lastSceneGuiTime) < SCENE_VISIBLE_TIMEOUT;
        bool refreshAllowed = !_alwaysRefreshKnown || _lastKnownAlwaysRefresh;
        if (!editorActive || !sceneVisible || !refreshAllowed)
        {
            _lastPrevTime = now;
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
            LightingManager mgr = _worldRoot.GetComponent<LightingManager>();
            if (mgr != null) Rescan(mgr);
        }

        LightingManager liveMgr = _worldRoot.GetComponent<LightingManager>();
        if (liveMgr != null && ShouldCheckExternalEditsNow() && HasExternalArrayEdits(liveMgr))
            Rescan(liveMgr);

        float dt = (float)(now - _lastPrevTime);
        _lastPrevTime = now;
        dt = Mathf.Clamp(dt, 0f, 0.1f);

        Tick(dt, liveMgr);
    }

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

    private static bool HasExternalArrayEdits(LightingManager mgr)
    {
        if (ArrayDiffers(mgr.childLightLayerSlices, _layerSlices)) return true;
        if (ArrayDiffers(mgr.childLightGroupIndex, _groupMasks)) return true;
        if (ArrayDiffers(mgr.childLightCookieSlice, _cookieSlices)) return true;
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
        LightingManager mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr != null) Rescan(mgr);
    }

    private static void Rescan(LightingManager mgr)
    {
        _worldRoot = mgr.gameObject;
        _rangeScale = mgr.rangeScale;
        _activeSpecularCount = Mathf.Clamp(mgr.activeSpecularCount, 1, MAX_LIGHTS);
        _specCullDistanceSq = Sq(mgr.specCameraFadeEnd + mgr.specCullMargin);

        Light[] previousLights = mgr.childLights;
        Light[] freshLights = Object.FindObjectsOfType<Light>(includeInactive: true);
        int count = freshLights.Length;

        bool lightsChanged = (previousLights == null || previousLights.Length != count);
        if (!lightsChanged)
        {
            for (int i = 0; i < count; i++)
                if (previousLights[i] != freshLights[i])
                {
                    lightsChanged = true;
                    break;
                }
        }

        // If nothing changed structurally, just sync static arrays from the manager, no scene dirtying
        if (!lightsChanged && mgr.childLightIsRealtime != null && mgr.childLightIsRealtime.Length == count)
        {
            _lights = mgr.childLights;
            _halfExtents = mgr.childLightHalfExtents;
            _isRealtime = mgr.childLightIsRealtime;
            _diffuseEnabled = mgr.childLightDiffuseEnabled;
            _specularEnabled = mgr.childLightSpecularDistance;
            _faultStates = mgr.childLightFaultState;
            _layerSlices = mgr.childLightLayerSlices;
            _groupMasks = mgr.childLightGroupIndex;
            _bakedColors = mgr.childLightBakedColors;
            _cookieSlices = mgr.childLightCookieSlice;
        }
        else
        {
            // Reallocation needed – preserve old values by Light reference for EVERY tracked field
            var oldRealtimeByLight = new Dictionary<Light, bool>();
            var oldDiffuseByLight = new Dictionary<Light, bool>();
            var oldSpecularByLight = new Dictionary<Light, bool>();
            var oldFaultStateByLight = new Dictionary<Light, LightFaultState>();
            var oldSliceByLight = new Dictionary<Light, int>();
            var oldGroupMaskByLight = new Dictionary<Light, int>();
            var oldCookieSliceByLight = new Dictionary<Light, int>();
            var oldBakedColByLight = new Dictionary<Light, Vector3>();

            var oldCookieTexByLight = new Dictionary<Light, Texture2D>();
            var oldAudioOverrideByLight = new Dictionary<Light, AudioClip>();
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
                    if (mgr.childLightFaultState != null && i < mgr.childLightFaultState.Length)
                        oldFaultStateByLight[l] = mgr.childLightFaultState[i];
                    if (mgr.childLightLayerSlices != null && i < mgr.childLightLayerSlices.Length)
                        oldSliceByLight[l] = mgr.childLightLayerSlices[i];
                    if (mgr.childLightGroupIndex != null && i < mgr.childLightGroupIndex.Length)
                        oldGroupMaskByLight[l] = mgr.childLightGroupIndex[i];
                    if (mgr.childLightCookieSlice != null && i < mgr.childLightCookieSlice.Length)
                        oldCookieSliceByLight[l] = mgr.childLightCookieSlice[i];
                    if (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                        oldBakedColByLight[l] = mgr.childLightBakedColors[i];

                    if (mgr.childLightCookieTexture != null && i < mgr.childLightCookieTexture.Length)
                        oldCookieTexByLight[l] = mgr.childLightCookieTexture[i];
                    if (mgr.childLightAudioClipOverride != null && i < mgr.childLightAudioClipOverride.Length)
                        oldAudioOverrideByLight[l] = mgr.childLightAudioClipOverride[i];
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
            _faultStates = new LightFaultState[count];
            _bakedColors = new Vector3[count];
            _layerSlices = new int[count];
            _groupMasks = new int[count];
            _cookieSlices = new int[count];

            var cookieTextures = new Texture2D[count];
            var audioOverrides = new AudioClip[count];
            var brokenOnMin = new float[count];
            var brokenOnMax = new float[count];
            var brokenOffMin = new float[count];
            var brokenOffMax = new float[count];
            var brokenOnIntensity = new float[count];
            var panicSpeed = new float[count];
            var panicIntensityMin = new float[count];
            var panicIntensityMax = new float[count];

            for (int i = 0; i < count; i++)
            {
                Light l = freshLights[i];
                _halfExtents[i] = (l.type == LightType.Area)
                    ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                    : new Vector2(0.01f, 0.01f);

                _isRealtime[i] = oldRealtimeByLight.TryGetValue(l, out bool prevRt) ? prevRt : false;
                _diffuseEnabled[i] = oldDiffuseByLight.TryGetValue(l, out bool prevDiff) ? prevDiff : true;
                _specularEnabled[i] = oldSpecularByLight.TryGetValue(l, out bool prevSpec) ? prevSpec : true;
                _faultStates[i] = oldFaultStateByLight.TryGetValue(l, out LightFaultState prevFault) ? prevFault : LightFaultState.Normal;
                _layerSlices[i] = oldSliceByLight.TryGetValue(l, out int prevSlice) ? prevSlice : -1;
                _groupMasks[i] = oldGroupMaskByLight.TryGetValue(l, out int prevMask) ? prevMask : ~0;
                _cookieSlices[i] = oldCookieSliceByLight.TryGetValue(l, out int prevCookie) ? prevCookie : -1;
                _bakedColors[i] = oldBakedColByLight.TryGetValue(l, out Vector3 prevCol) ? prevCol : new Vector3(l.color.r, l.color.g, l.color.b);

                cookieTextures[i] = oldCookieTexByLight.TryGetValue(l, out Texture2D prevCookieTex) ? prevCookieTex : null;
                audioOverrides[i] = oldAudioOverrideByLight.TryGetValue(l, out AudioClip prevClip) ? prevClip : null;
                brokenOnMin[i] = oldBrokenOnMinByLight.TryGetValue(l, out float prevOnMin) ? prevOnMin : 0.01f;
                brokenOnMax[i] = oldBrokenOnMaxByLight.TryGetValue(l, out float prevOnMax) ? prevOnMax : 1.5f;
                brokenOffMin[i] = oldBrokenOffMinByLight.TryGetValue(l, out float prevOffMin) ? prevOffMin : 0.5f;
                brokenOffMax[i] = oldBrokenOffMaxByLight.TryGetValue(l, out float prevOffMax) ? prevOffMax : 2.0f;
                brokenOnIntensity[i] = oldBrokenOnIntensityByLight.TryGetValue(l, out float prevOnInt) ? prevOnInt : 0.8f;
                panicSpeed[i] = oldPanicSpeedByLight.TryGetValue(l, out float prevSpeed) ? prevSpeed : 0.5f;
                panicIntensityMin[i] = oldPanicIntensityMinByLight.TryGetValue(l, out float prevPMin) ? prevPMin : 0.1f;
                panicIntensityMax[i] = oldPanicIntensityMaxByLight.TryGetValue(l, out float prevPMax) ? prevPMax : 1.2f;

                bool existedBefore = previousLights != null && System.Array.IndexOf(previousLights, l) >= 0;
                if (existedBefore && !oldRealtimeByLight.ContainsKey(l))
                    Debug.LogWarning("[LightingEditorScene] Rescan lost tracked data for '" + l.name +
                                      "' — it existed before but its old values weren't found by reference.");
            }

            mgr.childLights = freshLights;
            mgr.childLightIsRealtime = _isRealtime;
            mgr.childLightDiffuseEnabled = _diffuseEnabled;
            mgr.childLightSpecularDistance = _specularEnabled;
            mgr.childLightFaultState = _faultStates;
            mgr.childLightHalfExtents = _halfExtents;
            mgr.childLightLayerSlices = _layerSlices;
            mgr.childLightGroupIndex = _groupMasks;
            mgr.childLightCookieSlice = _cookieSlices;
            mgr.childLightBakedColors = _bakedColors;

            mgr.childLightCookieTexture = cookieTextures;
            mgr.childLightAudioClipOverride = audioOverrides;
            mgr.childLightBrokenOnMin = brokenOnMin;
            mgr.childLightBrokenOnMax = brokenOnMax;
            mgr.childLightBrokenOffMin = brokenOffMin;
            mgr.childLightBrokenOffMax = brokenOffMax;
            mgr.childLightBrokenOnIntensity = brokenOnIntensity;
            mgr.childLightPanicSpeed = panicSpeed;
            mgr.childLightPanicIntensityMin = panicIntensityMin;
            mgr.childLightPanicIntensityMax = panicIntensityMax;

            EditorUtility.SetDirty(mgr); // only dirty when structural change
            _lights = freshLights;
        }

        if (mgr.lightLayerArray != null)
        {
            _previewLayerArray = mgr.lightLayerArray;
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        }
        Shader.SetGlobalFloat("_UdonLightLayerArrayValid", _previewLayerArray != null ? 1f : 0f);
        Shader.SetGlobalFloat("_UdonLightmapSliceOffset", (float)mgr.lightmapGroupCount);

        _previewCookieArray = mgr.cookieArray;
        Shader.SetGlobalTexture("_UdonCookieArray", _previewCookieArray);
        Shader.SetGlobalFloat("_UdonCookieArrayValid", _previewCookieArray != null ? 1f : 0f);

        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        _lastUploadedSlotCount = 0;
        _lastFinalCount = -1;
        _lastViewerTick = 0;

        CacheLightStates();
        _lastPrevTime = EditorApplication.timeSinceStartup;
        Tick(0f, mgr);
    }

    private static void Tick(float dt, LightingManager mgr)
    {
        if (_lights == null || _lights.Length == 0) return;

        double now = EditorApplication.timeSinceStartup;
        float viewerInterval = LightingManager.VIEWER_UPDATE_INTERVAL;

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

        CacheLightStates();
        FillUploadBuffers(finalCount);

        UploadToShader();
        RepaintSceneViews();

        _lastFinalCount = finalCount;
    }

    private static int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        int cap = Mathf.Clamp(_activeSpecularCount, 1, MAX_LIGHTS);
        float maxDistSq = _rangeScale * _rangeScale;

        for (int i = 0; i < _lights.Length; i++)
        {
            Light l = _lights[i];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy ||
                l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex)
                continue;

            float distSq = Vector3.SqrMagnitude(viewerPos - l.transform.position);

            bool diffuseOn = (_diffuseEnabled != null && i < _diffuseEnabled.Length) ? _diffuseEnabled[i] : true;
            bool specularOn = (_specularEnabled != null && i < _specularEnabled.Length) ? _specularEnabled[i] : true;
            bool withinSpecFade = distSq <= _specCullDistanceSq;

            if (!diffuseOn && !(specularOn && withinSpecFade)) continue;
            if (distSq > maxDistSq) continue;

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

    private static float Sq(float x) => x * x;

    private static void FillUploadBuffers(int finalCount)
    {
        _shaderBuffer[0] = new Vector4((float)finalCount, 0f, 1f, 1f);
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
            bool liRealtime = (_isRealtime != null && li < _isRealtime.Length) && _isRealtime[li];
            float realtimeFlag = liRealtime ? 1.0f : 0.0f;

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
            int cookieSlice = (_cookieSlices != null && li < _cookieSlices.Length) ? _cookieSlices[li] : -1;   // ← ajout

            // Ranges are now zero – shader uses its own global constants
            _shaderBuffer[baseIdx + 0] = new Vector4(pos.x, pos.y, pos.z, intensity);
            _shaderBuffer[baseIdx + 1] = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
            _shaderBuffer[baseIdx + 2] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
            _shaderBuffer[baseIdx + 3] = new Vector4(right.x, right.y, right.z, halfX);
            _shaderBuffer[baseIdx + 4] = new Vector4(up.x, up.y, up.z, halfY);
            _shaderBuffer[baseIdx + 5] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
            _shaderBuffer[baseIdx + 6] = new Vector4(layerSlice, diffuseOn ? 1f : 0f, specularOn ? 1f : 0f, groupMask);
            _shaderBuffer[baseIdx + 7] = new Vector4((float)cookieSlice, 0f, (float)lightTypeInt, cosInner);

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
        if (_worldRoot == null)
            return;

        Shader.SetGlobalVectorArray("_UdonLightData", _shaderBuffer);
        Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        Shader.SetGlobalFloat("_UdonLightLayerArrayValid", _previewLayerArray != null ? 1f : 0f);

        Shader.SetGlobalTexture("_UdonCookieArray", _previewCookieArray);
        Shader.SetGlobalFloat("_UdonCookieArrayValid", _previewCookieArray != null ? 1f : 0f);

        LightingManager mgr = _worldRoot.GetComponent<LightingManager>();
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

    private static float ComputeCosInner(float cosOuter)
    {
        if (cosOuter < -0.9f) return -1.0f;
        if (cosOuter <= 0.0f) return 0.0f;
        float angleOuter = Mathf.Acos(cosOuter);
        float angleInner = angleOuter * 0.85f;
        return Mathf.Cos(angleInner);
    }

    private static int GetLightTypeInt(float cosOuter)
    {
        if (cosOuter < -0.9f) return 0;
        if (cosOuter <= 0.0f) return 2;
        return 1;
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
        RepaintSceneViews();
    }
}