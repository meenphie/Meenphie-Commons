#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

// ==============================================================================
// SpecularLightManagerEditor
// ==============================================================================
// Editor-only companion to SpecularLightManager. Mirrors the runtime's sort +
// upload pipeline so you get a live scene-view preview while editing, and
// keeps the manager's serialized light lists in sync with the scene
// automatically — no manual "Rebuild Lights" step required.
//
// IMPORTANT: per-light overrides (IsRealtime / Diffuse / Specular / GroupMask,
// edited via the "Speculars" foldout in the Light inspector, or written by
// the auto-assigner) are matched by Light REFERENCE across rescans, never by
// array index. lightmapBakeType is only ever used as the initial default for
// a light the manager has never seen before — once a light has an entry,
// rescans preserve it untouched. This is what makes the auto-refresh safe to
// run on every hierarchy change.
//
// Layer slice assignment is manual: childLightLayerSlices is a visible field
// on SpecularLightManager — set each light's slice index there to match your
// own externally-built Texture2DArray (e.g. built in Amplify), or let the
// auto-assigner populate it.
//
// Group mask (childLightGroupMask) follows the same bitmask convention as
// the runtime path and the shader's _LightGroupMask filter: bit N = group N,
// and ~0 (all bits set) means "unconfigured / affects every group" rather
// than "affects no group" — see SpecularLightManager for the reasoning. The
// preview pipeline below mirrors that default so scene-view preview doesn't
// silently exclude every light from every material's group filter.
// ==============================================================================

[InitializeOnLoad]
public static class SpecularLightManagerEditor
{
    public const int MAX_LIGHTS = 32;

    private const float MOTION_EPSILON_SQ = 0.0001f;
    private const float COLOR_EPSILON = 0.004f;
    private const float INTENSITY_EPSILON = 0.001f;
    private const float UPDATE_INTERVAL = 0.00f;
    private const float DEFAULT_RANGE_SCALE = 10f;

    // Minimum time between automatic rescans triggered by hierarchy changes.
    // Hierarchy events can fire many times in a row (e.g. during a drag or a
    // multi-object operation); this avoids re-scanning every Light in the
    // scene on every single one of those events.
    private const double RESCAN_DEBOUNCE_SECONDS = 0.25;

    // Mirrors UdonSpecularSystem.cginc's _FadeEndDist.
    // Past this distance a light can never contribute specular, so it's a
    // safe, shader-accurate cutoff for the editor's candidate pool.
    private const float FADE_END_DIST = 30.0f;
    private const float MAX_RADIUS_SQ = FADE_END_DIST * FADE_END_DIST;

    private static GameObject _worldRoot;
    private static Light[] _lights;
    private static Vector2[] _halfExtents;
    private static bool[] _isRealtime;
    private static bool[] _diffuseEnabled;
    private static bool[] _specularEnabled;
    private static float[] _bakedIntensities;
    private static Vector3[] _bakedColors;
    private static int[] _layerSlices;   // per childLight, -1 = no layer
    private static int[] _groupMasks;    // per childLight, bitmask; ~0 = unconfigured/all groups
    private static float _rangeScale = DEFAULT_RANGE_SCALE;

    // Mirrors SpecularLightManager.activeLightCount
    private static int _activeLightCount = MAX_LIGHTS;

    private static bool _previewEnabled = true;
    private static double _lastTick;
    private static double _lastHierarchyChangeRequest = double.NegativeInfinity;
    private static bool _rescanPending;

    private static Vector3[] _lastLightPositions;
    private static Quaternion[] _lastLightRotations;
    private static float[] _lastLightIntensities;
    private static Vector3[] _lastLightColors;

    private static readonly Vector4[] _shaderPos = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderCol = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderBakedCol = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderRight = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderUp = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderDir = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderLayerIndex = new Vector4[MAX_LIGHTS];

    private static Vector4 _shaderData = Vector4.zero;

    private static int[] _indices = new int[MAX_LIGHTS];
    private static float[] _distances = new float[MAX_LIGHTS];
    private static int[] _lightToShader = new int[0];

    // Preview-only texture reference, read directly from the manager's own lightLayerArray field.
    private static Texture2DArray _previewLayerArray;

    static SpecularLightManagerEditor()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
        SceneView.duringSceneGui -= OnSceneGui;
        SceneView.duringSceneGui += OnSceneGui;
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;
    }

    // Hierarchy events can fire rapidly and repeatedly; just flag that a
    // rescan is needed and let OnEditorUpdate debounce + perform it. This
    // also covers lights being added/removed/renamed/reparented — anything
    // that changes the hierarchy triggers a resync, automatically.
    private static void OnHierarchyChanged()
    {
        if (Application.isPlaying) return;
        _rescanPending = true;
        _lastHierarchyChangeRequest = EditorApplication.timeSinceStartup;
    }

    private static void OnSceneGui(SceneView sv)
    {
        if (!_previewEnabled || Application.isPlaying) return;
        PushBuffersToShader();
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

        if (_rescanPending && ShouldRescanNow())
        {
            _rescanPending = false;
            SpecularLightManager mgr = _worldRoot.GetComponent<SpecularLightManager>();
            if (mgr != null) Rescan(mgr);
        }

        if (_lights == null || _lights.Length == 0) return;

        // Also catch slice/layer/group-mask edits made directly in the
        // manager inspector or by the auto-assigner (those don't fire
        // hierarchyChanged since no GameObject changed).
        SpecularLightManager liveMgr = _worldRoot.GetComponent<SpecularLightManager>();
        if (liveMgr != null && HasExternalArrayEdits(liveMgr))
        {
            Rescan(liveMgr);
        }

        bool anyChanged = UpdateLiveData();
        double tickNow = EditorApplication.timeSinceStartup;

        if (tickNow - _lastTick >= UPDATE_INTERVAL)
        {
            _lastTick = tickNow;
            Tick();
        }
        else if (anyChanged)
        {
            UploadAllBuffers();
            RepaintSceneViews();
        }
    }

    private static bool ShouldRescanNow()
    {
        double now = EditorApplication.timeSinceStartup;
        if (_lastHierarchyChangeRequest == double.NegativeInfinity)
        {
            _lastHierarchyChangeRequest = now;
            return false; // wait one tick so rapid-fire events still collapse
        }

        if (now - _lastHierarchyChangeRequest >= RESCAN_DEBOUNCE_SECONDS)
        {
            _lastHierarchyChangeRequest = double.NegativeInfinity;
            return true;
        }

        return false;
    }

    // Detects edits made directly to childLightLayerSlices or
    // childLightGroupMask (or array length mismatches from undo/redo, scene
    // reloads, the auto-assigner running, etc.) so the preview stays correct
    // even when nothing in the hierarchy itself changed.
    private static bool HasExternalArrayEdits(SpecularLightManager mgr)
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
        SpecularLightManager mgr = Object.FindObjectOfType<SpecularLightManager>();
        if (mgr != null) Rescan(mgr);
    }

    // Rescans the scene for lights and merges the result into the manager's
    // arrays, preserving every existing per-light value (IsRealtime, Diffuse,
    // Specular, layer slice, group mask, baked intensity/color) by Light
    // REFERENCE. lightmapBakeType is consulted only as the default for a
    // light that has never been seen by this manager before.
    private static void Rescan(SpecularLightManager mgr)
    {
        _worldRoot = mgr.gameObject;

        _rangeScale = mgr.rangeScale;
        _activeLightCount = Mathf.Clamp(mgr.activeLightCount, 1, MAX_LIGHTS);

        Light[] previousLights = mgr.childLights;
        Light[] freshLights = Object.FindObjectsOfType<Light>(includeInactive: true);
        int count = freshLights.Length;

        // Build a lookup of old data keyed by Light reference, so values
        // survive reordering, additions, and removals.
        var oldRealtimeByLight  = new Dictionary<Light, bool>();
        var oldDiffuseByLight   = new Dictionary<Light, bool>();
        var oldSpecularByLight  = new Dictionary<Light, bool>();
        var oldSliceByLight     = new Dictionary<Light, int>();
        var oldGroupMaskByLight = new Dictionary<Light, int>();
        var oldBakedIntByLight  = new Dictionary<Light, float>();
        var oldBakedColByLight  = new Dictionary<Light, Vector3>();

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

                if (mgr.childLightSpecularEnabled != null && i < mgr.childLightSpecularEnabled.Length)
                    oldSpecularByLight[l] = mgr.childLightSpecularEnabled[i];

                if (mgr.childLightLayerSlices != null && i < mgr.childLightLayerSlices.Length)
                    oldSliceByLight[l] = mgr.childLightLayerSlices[i];

                if (mgr.childLightGroupIndex != null && i < mgr.childLightGroupIndex.Length)
                    oldGroupMaskByLight[l] = mgr.childLightGroupIndex[i];

                if (mgr.childLightBakedIntensities != null && i < mgr.childLightBakedIntensities.Length)
                    oldBakedIntByLight[l] = mgr.childLightBakedIntensities[i];

                if (mgr.childLightBakedColors != null && i < mgr.childLightBakedColors.Length)
                    oldBakedColByLight[l] = mgr.childLightBakedColors[i];
            }
        }

        _halfExtents      = new Vector2[count];
        _isRealtime       = new bool[count];
        _diffuseEnabled   = new bool[count];
        _specularEnabled  = new bool[count];
        _bakedIntensities = new float[count];
        _bakedColors      = new Vector3[count];
        _layerSlices      = new int[count];
        _groupMasks       = new int[count];

        for (int i = 0; i < count; i++)
        {
            Light l = freshLights[i];

            _halfExtents[i] = (l.type == LightType.Area)
                ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                : new Vector2(0.01f, 0.01f);

            // IsRealtime: preserve existing per-light value if we've seen
            // this light before. Only brand-new lights fall back to
            // lightmapBakeType as a starting guess.
            _isRealtime[i] = oldRealtimeByLight.TryGetValue(l, out bool prevRealtime)
                ? prevRealtime
                : (l.lightmapBakeType != LightmapBakeType.Baked);

            _diffuseEnabled[i] = oldDiffuseByLight.TryGetValue(l, out bool prevDiffuse)
                ? prevDiffuse
                : true;

            _specularEnabled[i] = oldSpecularByLight.TryGetValue(l, out bool prevSpecular)
                ? prevSpecular
                : true;

            _layerSlices[i] = oldSliceByLight.TryGetValue(l, out int prevSlice)
                ? prevSlice
                : -1;

            // Same default as SpecularLightManager: ~0 ("affects every
            // group") rather than 0 ("affects no group"), so a brand-new or
            // never-tagged light is loudly visible in preview instead of
            // silently filtered out of every material everywhere.
            _groupMasks[i] = oldGroupMaskByLight.TryGetValue(l, out int prevGroupMask)
                ? prevGroupMask
                : ~0;

            _bakedIntensities[i] = oldBakedIntByLight.TryGetValue(l, out float prevBakedInt) && prevBakedInt > 0f
                ? prevBakedInt
                : l.intensity;

            _bakedColors[i] = oldBakedColByLight.TryGetValue(l, out Vector3 prevBakedCol)
                ? prevBakedCol
                : new Vector3(l.color.r, l.color.g, l.color.b);
        }

        mgr.childLights                = freshLights;
        mgr.childLightIsRealtime       = _isRealtime;
        mgr.childLightDiffuseEnabled   = _diffuseEnabled;
        mgr.childLightSpecularEnabled  = _specularEnabled;
        mgr.childLightHalfExtents      = _halfExtents;
        mgr.childLightLayerSlices      = _layerSlices;
        mgr.childLightGroupIndex        = _groupMasks;
        mgr.childLightBakedIntensities = _bakedIntensities;
        mgr.childLightBakedColors      = _bakedColors;

        EditorUtility.SetDirty(mgr);

        _lights = freshLights;

        if (mgr.lightLayerArray != null)
        {
            _previewLayerArray = mgr.lightLayerArray;
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        }

        CacheLightStates();

        _lastTick = 0;
        Tick();
    }

    private static void Tick()
    {
        if (_lights == null || _lights.Length == 0) return;

        int finalCount = SortNearest(GetViewerPos());

        if (_lightToShader == null || _lightToShader.Length != _lights.Length)
            _lightToShader = new int[_lights.Length];

        for (int i = 0; i < _lightToShader.Length; i++) _lightToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _lightToShader[_indices[i]] = i;

        UpdateDebugCounts(finalCount);
        CacheLightStates();
        FillUploadBuffers(finalCount);
        UploadToShader(finalCount);
        RepaintSceneViews();
    }

    private static void UpdateDebugCounts(int finalCount)
    {
        int dynCount = 0, statCount = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int idx = _indices[i];
            if (_isRealtime[idx]) dynCount++; else statCount++;
        }

        SpecularLightManager mgr = _worldRoot != null
            ? _worldRoot.GetComponent<SpecularLightManager>()
            : null;

        if (mgr == null) return;

        mgr.currentDynamicLights = dynCount;
        mgr.currentStaticLights = statCount;
        mgr.currentActiveCount = finalCount;
        EditorUtility.SetDirty(mgr);
    }

    private static int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        int cap = Mathf.Clamp(_activeLightCount, 1, MAX_LIGHTS);

        for (int i = 0; i < _lights.Length; i++)
        {
            Light l = _lights[i];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy ||
                l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex) 
                continue;

            float distSq = Vector3.SqrMagnitude(viewerPos - l.transform.position);
            if (distSq > MAX_RADIUS_SQ) continue;

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
            if (si < 0) continue; // Skip uploading to shader buffers if it's not currently selected

            float bakedInt = (_bakedIntensities != null && li < _bakedIntensities.Length && _bakedIntensities[li] > 0f) ? _bakedIntensities[li] : intensity;
            Vector3 bakedCol = (_bakedColors != null && li < _bakedColors.Length) ? _bakedColors[li] : col;
            float realtimeFlag = _isRealtime[li] ? 1.0f : 0.0f;

            if (posChanged || intChanged)
            {
                _shaderPos[si] = new Vector4(pos.x, pos.y, pos.z, bakedInt);
            }

            if (intChanged || colChanged)
            {
                _shaderCol[si] = new Vector4(col.x, col.y, col.z, intensity);
                _shaderBakedCol[si] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
            }

            if (rotChanged)
            {
                Vector3 f = rot * Vector3.forward;
                Vector3 r = rot * Vector3.right;
                Vector3 u = rot * Vector3.up;

                float cosOuter = (l.type == LightType.Spot) ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                               : (l.type == LightType.Area) ? 0.0f
                               : -1.0f;

                _shaderRight[si] = new Vector4(r.x, r.y, r.z, _halfExtents[li].x);
                _shaderUp[si] = new Vector4(u.x, u.y, u.z, _halfExtents[li].y);
                _shaderDir[si] = new Vector4(f.x, f.y, f.z, cosOuter);
            }
        }

        return changed;
    }

    private static void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx = _indices[i];
                Light l = _lights[idx];

                Vector3 pos = l.transform.position;
                float intensity = l.intensity;
                float width = _halfExtents[idx].x;
                float height = _halfExtents[idx].y;
                Vector3 fwd = l.transform.forward;
                Vector3 rawColor = new Vector3(l.color.r, l.color.g, l.color.b);

                float bakedInt = (_bakedIntensities != null && idx < _bakedIntensities.Length && _bakedIntensities[idx] > 0f) ? _bakedIntensities[idx] : intensity;
                Vector3 bakedCol = (_bakedColors != null && idx < _bakedColors.Length) ? _bakedColors[idx] : rawColor;

                int layerSlice = (_layerSlices != null && idx < _layerSlices.Length) ? _layerSlices[idx] : -1;
                int groupMask = (_groupMasks != null && idx < _groupMasks.Length) ? _groupMasks[idx] : ~0;
                float realtimeFlag = _isRealtime[idx] ? 1.0f : 0.0f;
                float diffuseFlag  = (_diffuseEnabled  != null && idx < _diffuseEnabled.Length  && _diffuseEnabled[idx])  ? 1f : 0f;
                float specularFlag = (_specularEnabled != null && idx < _specularEnabled.Length && _specularEnabled[idx]) ? 1f : 0f;

                float cosOuter = (l.type == LightType.Spot) ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                               : (l.type == LightType.Area) ? 0.0f
                               : -1.0f;

                _shaderPos[i] = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                _shaderCol[i] = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                _shaderBakedCol[i] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                _shaderRight[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                _shaderUp[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height);
                _shaderDir[i] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                _shaderLayerIndex[i] = new Vector4(layerSlice, diffuseFlag, specularFlag, (float)groupMask);
            }
            else
            {
                _shaderPos[i] = _shaderCol[i] = _shaderBakedCol[i] =
                _shaderRight[i] = _shaderUp[i] = _shaderDir[i] = Vector4.zero;
                _shaderLayerIndex[i] = new Vector4(-1f, 0f, 0f, 0f);
            }
        }
    }

    private static void PushBuffersToShader()
    {
        UploadAllBuffers();
        Shader.SetGlobalVector("_UdonSpecularLightData", _shaderData);
        if (_previewLayerArray != null)
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
    }

    private static void UploadAllBuffers()
    {
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", _shaderPos);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", _shaderCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightBakedCol", _shaderBakedCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", _shaderDir);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", _shaderRight);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", _shaderUp);
        Shader.SetGlobalVectorArray("_UdonLightLayerIndex", _shaderLayerIndex);
    }

    private static void UploadToShader(int count)
    {
        _shaderData = new Vector4((float)count, _rangeScale, 0f, 0f);
        UploadAllBuffers();
        Shader.SetGlobalVector("_UdonSpecularLightData", _shaderData);
        if (_previewLayerArray != null)
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
    }

    private static Vector3 GetViewerPos()
    {
        SceneView sv = SceneView.lastActiveSceneView;
        return (sv != null && sv.camera != null) ? sv.camera.transform.position : Vector3.zero;
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

    public static void SnapshotBakedIntensities()
    {
        if (_worldRoot == null) TryFindAndRescan();
        if (_lights == null) return;

        SpecularLightManager mgr = _worldRoot != null
            ? _worldRoot.GetComponent<SpecularLightManager>()
            : null;

        int count = _lights.Length;
        _bakedIntensities = new float[count];
        _bakedColors = new Vector3[count];

        float[] serialized = new float[count];
        Vector3[] serializedColors = new Vector3[count];

        for (int i = 0; i < count; i++)
        {
            Light l = _lights[i];
            if (l == null) continue;
            _bakedIntensities[i] = l.intensity;
            serialized[i] = l.intensity;
            _bakedColors[i] = new Vector3(l.color.r, l.color.g, l.color.b);
            serializedColors[i] = _bakedColors[i];
        }

        if (mgr != null)
        {
            mgr.childLightBakedIntensities = serialized;
            mgr.childLightBakedColors = serializedColors;
            EditorUtility.SetDirty(mgr);
        }

        Debug.Log($"[Specular World] Baked intensities and colors saved for {count} lights.");
    }

    // "Rebuild Lights" menu item removed — rescans now happen automatically
    // on hierarchy changes (debounced) and preserve existing per-light
    // overrides by Light reference. If you ever need to force one manually
    // (e.g. after editing arrays via script), use this instead:
    [MenuItem("Meenphie/Lighting/Speculars/Force Rescan Now")]
    public static void ForceRescanNow()
    {
        TryFindAndRescan();
        _previewEnabled = true;
        Debug.Log("[Specular World] Rescanned. Preview enabled.");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Snapshot Baked Intensities")]
    public static void SnapshotBakedIntensitiesMenu() => SnapshotBakedIntensities();

    [MenuItem("Meenphie/Lighting/Speculars/Toggle Specular Preview")]
    public static void ToggleSpecularPreview()
    {
        _previewEnabled = !_previewEnabled;
        if (_previewEnabled)
        {
            TryFindAndRescan();
            Debug.Log("[Specular World] Preview ON.");
        }
        else
        {
            ClearPreview();
            Debug.Log("[Specular World] Preview OFF.");
        }
    }

    [MenuItem("Meenphie/Lighting/Speculars/Toggle Specular Preview", validate = true)]
    public static bool ToggleSpecularPreviewValidate()
    {
        Menu.SetChecked("Meenphie/Lighting/Speculars/Toggle Specular Preview", _previewEnabled);
        return true;
    }

    [MenuItem("Meenphie/Lighting/Speculars/Clear Preview")]
    public static void ClearPreview()
    {
        _shaderData = Vector4.zero;
        Vector4[] empty = new Vector4[MAX_LIGHTS];
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightBakedCol", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", empty);
        Shader.SetGlobalVectorArray("_UdonLightLayerIndex", empty);
        Shader.SetGlobalVector("_UdonSpecularLightData", Vector4.zero);
        RepaintSceneViews();
        Debug.Log("[Specular World] Preview cleared.");
    }
}
#endif