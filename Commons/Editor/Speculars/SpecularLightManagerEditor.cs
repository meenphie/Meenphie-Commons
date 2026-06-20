#if UNITY_EDITOR
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEditor;


[InitializeOnLoad]
public static class SpecularLightManagerEditor
{
    public const int MAX_LIGHTS = 32;

    private const float MERGE_THRESHOLD_SQ  = 0.5f;
    private const float DIR_CONFLICT_DOT    = 0.5f;
    private const float MOTION_EPSILON_SQ   = 0.0001f;
    private const float COLOR_EPSILON       = 0.004f;
    private const float INTENSITY_EPSILON   = 0.001f;
    private const float UPDATE_INTERVAL     = 0.00f;
    private const float DEFAULT_RANGE_SCALE = 10f;

    // Mirrors UdonSpecularSystem.cginc's _FadeEndDist (the camera-distance
    // fade is universal — it gates EVERY light's specular contribution to
    // zero past this radius, regardless of that light's own baked range).
    // Past this distance a light can never contribute specular, so it's a
    // safe, shader-accurate cutoff for the editor's candidate pool.
    // This is a *slot-selection* cutoff for the preview tool only — the
    // runtime SpecularLightManager intentionally has no distance reject
    // here (see its SortNearest doc comment); this constant exists solely
    // so the edit-mode preview doesn't waste slots on lights that the
    // shader will fade to zero anyway.
    private const float FADE_END_DIST       = 30.0f;
    private const float MAX_RADIUS_SQ       = FADE_END_DIST * FADE_END_DIST;

    private static GameObject   _avatarRoot;
    private static Light[]      _lights;
    private static Vector2[]    _halfExtents;
    private static bool[]       _isRealtime;
    private static float[]      _bakedIntensities;
    private static Vector3[]    _bakedColors;
    private static int[]        _layerSlices;      // per childLight, -1 = no layer
    private static Texture2D[]  _layerTextures;    // per childLight, null = no layer
    private static float        _rangeScale = DEFAULT_RANGE_SCALE;

    // Mirrors SpecularLightManager.activeLightCount — pulled from the
    // manager at Bootstrap() so the preview respects the same slot budget
    // the runtime will actually use, instead of always filling all 32.
    private static int          _activeLightCount = MAX_LIGHTS;

    private static bool         _previewEnabled = true;
    private static double       _lastTick;

    private static Vector3[]    _lastLightPositions;
    private static Quaternion[] _lastLightRotations;
    private static float[]      _lastLightIntensities;
    private static Vector3[]    _lastLightColors;

    private static Vector4[] _mergedPos;
    private static Vector4[] _mergedCol;
    private static Vector4[] _mergedBakedCol;
    private static Vector4[] _mergedRight;
    private static Vector4[] _mergedUp;
    private static Vector4[] _mergedDir;
    private static float[]   _mergedMaxInt;
    private static int[]     _mergedLayerSlice; // per merged group
    private static int       _mergedCount;

    private static readonly Vector4[] _shaderPos       = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderCol       = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderBakedCol  = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderRight     = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderUp        = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderDir       = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderLayerIndex = new Vector4[MAX_LIGHTS];

    private static Vector4 _shaderData = Vector4.zero;

    private static int[]   _indices        = new int[MAX_LIGHTS];
    private static float[] _distances      = new float[MAX_LIGHTS];
    private static int[]   _mergedToShader = new int[MAX_LIGHTS];
    private static int[]   _lightToMerged  = new int[0];

    private static Texture2DArray _previewLayerArray;

    static SpecularLightManagerEditor()
    {
        EditorApplication.update           -= OnEditorUpdate;
        EditorApplication.update           += OnEditorUpdate;
        SceneView.duringSceneGui           -= OnSceneGui;
        SceneView.duringSceneGui           += OnSceneGui;
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;
    }

    private static void OnHierarchyChanged()
    {
        if (_avatarRoot == null && !Application.isPlaying) TryFindAndBootstrap();
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

        if (_avatarRoot == null)
        {
            TryFindAndBootstrap();
            if (_avatarRoot == null) return;
        }

        if (_lights == null || _lights.Length == 0) return;

        bool anyChanged = UpdateLiveData();
        double now = EditorApplication.timeSinceStartup;

        if (now - _lastTick >= UPDATE_INTERVAL)
        {
            _lastTick = now;
            Tick();
        }
        else if (anyChanged)
        {
            UploadAllBuffers();
            RepaintSceneViews();
        }
    }

    private static void TryFindAndBootstrap()
    {
        if (Selection.activeGameObject != null)
        {
            Transform root = Selection.activeGameObject.transform.root;
            if (root.GetComponentsInChildren<Light>(true).Length > 0)
            {
                Bootstrap(root.gameObject);
                return;
            }
        }

        foreach (Animator anim in Object.FindObjectsOfType<Animator>())
        {
            if (anim.transform.root == anim.transform &&
                anim.GetComponentsInChildren<Light>(true).Length > 0)
            {
                Bootstrap(anim.gameObject);
                return;
            }
        }

        Light[] allLights = Object.FindObjectsOfType<Light>();
        if (allLights.Length > 0)
            Bootstrap(allLights[0].transform.root.gameObject);
    }

    private static void Bootstrap(GameObject avatarRoot)
    {
        _avatarRoot = avatarRoot;
        SpecularLightManager mgr = avatarRoot.GetComponentInChildren<SpecularLightManager>();
        if (mgr != null)
        {
            _rangeScale       = mgr.rangeScale;
            _activeLightCount = Mathf.Clamp(mgr.activeLightCount, 1, MAX_LIGHTS);
        }
        else
        {
            _activeLightCount = MAX_LIGHTS;
        }

        _lights = avatarRoot.GetComponentsInChildren<Light>(includeInactive: true);
        int count = _lights.Length;

        _halfExtents      = new Vector2[count];
        _isRealtime       = new bool[count];
        _bakedIntensities = new float[count];
        _bakedColors      = new Vector3[count];
        _layerSlices       = new int[count];
        _layerTextures     = new Texture2D[count];

        for (int i = 0; i < count; i++)
        {
            Light l = _lights[i];

            _halfExtents[i] = (l.type == LightType.Area)
                ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                : new Vector2(0.01f, 0.01f);

            _isRealtime[i] = (l.lightmapBakeType != LightmapBakeType.Baked);

            if (mgr != null && mgr.childLightBakedIntensities != null &&
                i < mgr.childLightBakedIntensities.Length &&
                mgr.childLightBakedIntensities[i] > 0f)
            {
                _bakedIntensities[i] = mgr.childLightBakedIntensities[i];
            }
            else
            {
                _bakedIntensities[i] = l.intensity;
            }

            _bakedColors[i] = new Vector3(l.color.r, l.color.g, l.color.b);

            _layerSlices[i] = (mgr != null && mgr.childLightLayerSlices != null &&
                              i < mgr.childLightLayerSlices.Length)
                             ? mgr.childLightLayerSlices[i]
                             : -1;
        }

        // Rebuild preview Texture2DArray from saved asset if available
        if (mgr != null && mgr.lightLayerArray != null)
        {
            _previewLayerArray = mgr.lightLayerArray;
            Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        }

        AllocateMergeBuffers(count);
        CacheLightStates();

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;

        _lastTick = 0;
        Tick();
    }

    private static void Tick()
    {
        if (_lights == null || _lights.Length == 0) return;

        BuildMergedGroups();
        int finalCount = SortNearest(GetViewerPos());

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount;  i++) _mergedToShader[_indices[i]] = i;

        UpdateDebugCounts(finalCount);

        CacheLightStates();
        FillUploadBuffers(finalCount);
        UploadToShader(finalCount);
        RepaintSceneViews();
    }

    // Mirrors the runtime SpecularLightManager's #if UNITY_EDITOR debug
    // block: a flat O(finalCount) pass over the selected slots, counting
    // how many are dynamic/realtime vs static/baked via mergedBakedCol[].w
    // (1 = realtime, 0 = baked — matches BuildMergedGroups' realtimeFlag).
    // Written straight back onto the manager component so the inspector's
    // read-only debug fields stay live while editing, not just at runtime.
    private static void UpdateDebugCounts(int finalCount)
    {
        int dynCount = 0, statCount = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int mi = _indices[i];
            if (_mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
        }

        SpecularLightManager mgr = _avatarRoot != null
            ? _avatarRoot.GetComponentInChildren<SpecularLightManager>()
            : null;

        if (mgr == null) return;

        mgr.currentDynamicLights = dynCount;
        mgr.currentStaticLights  = statCount;
        mgr.currentActiveCount   = finalCount;
        EditorUtility.SetDirty(mgr);
    }

    private static void BuildMergedGroups()
    {
        if (_mergedPos == null || _mergedPos.Length < _lights.Length)
            AllocateMergeBuffers(_lights.Length);

        if (_lightToMerged == null || _lightToMerged.Length != _lights.Length)
            _lightToMerged = new int[_lights.Length];

        _mergedCount = 0;

        for (int li = 0; li < _lights.Length; li++)
        {
            _lightToMerged[li] = -1;

            Light l = _lights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy ||
                l.type == LightType.Directional ||
                l.renderMode == LightRenderMode.ForceVertex) continue;

            Vector3 pos       = l.transform.position;
            float   intensity = l.intensity;
            float   width     = _halfExtents[li].x;
            float   height    = _halfExtents[li].y;
            Vector3 fwd       = l.transform.forward;
            Vector3 rawColor  = new Vector3(l.color.r, l.color.g, l.color.b);

            float   bakedInt = (_bakedIntensities != null && li < _bakedIntensities.Length &&
                                _bakedIntensities[li] > 0f)
                               ? _bakedIntensities[li] : intensity;
            Vector3 bakedCol = (_bakedColors != null && li < _bakedColors.Length)
                               ? _bakedColors[li]
                               : rawColor;

            int layerSlice = (_layerSlices != null && li < _layerSlices.Length)
                            ? _layerSlices[li] : -1;

            bool  isStatic = (l.lightmapBakeType == LightmapBakeType.Baked);
            float realtimeFlag = isStatic ? 0.0f : 1.0f; // 0 = static/baked, 1 = dynamic/realtime

            float cosOuter = (l.type == LightType.Spot) ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                           : (l.type == LightType.Area) ? 0.0f
                           :                              -1.0f;

            bool merged = false;
            for (int i = 0; i < _mergedCount; i++)
            {
                if (((Vector3)_mergedPos[i] - pos).sqrMagnitude >= MERGE_THRESHOLD_SQ) continue;

                Vector3 exFwd       = new Vector3(_mergedDir[i].x, _mergedDir[i].y, _mergedDir[i].z);
                bool    alreadyOmni = _mergedDir[i].w < -0.1f;
                bool    conflict    = !alreadyOmni && Vector3.Dot(exFwd, fwd) < DIR_CONFLICT_DOT;
                float   newMax      = Mathf.Max(_mergedMaxInt[i], intensity);

                if (intensity > _mergedMaxInt[i])
                {
                    _mergedPos[i]       = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                    _mergedCol[i]       = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                    _mergedBakedCol[i]  = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                    _mergedRight[i]     = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                    _mergedUp[i]        = new Vector4(l.transform.up.x,    l.transform.up.y,    l.transform.up.z,    height);
                    _mergedDir[i]       = new Vector4(fwd.x, fwd.y, fwd.z, conflict ? -0.5f : cosOuter);
                    _mergedLayerSlice[i] = layerSlice;
                }
                else if (conflict)
                {
                    Vector4 d     = _mergedDir[i];
                    _mergedDir[i] = new Vector4(d.x, d.y, d.z, -0.5f);
                }

                _mergedMaxInt[i]   = newMax;
                _lightToMerged[li] = i;
                merged             = true;
                break;
            }

            if (!merged && _mergedCount < _mergedPos.Length)
            {
                int mi               = _mergedCount;
                _mergedPos[mi]       = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                _mergedCol[mi]       = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                _mergedBakedCol[mi]  = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                _mergedRight[mi]     = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                _mergedUp[mi]        = new Vector4(l.transform.up.x,    l.transform.up.y,    l.transform.up.z,    height);
                _mergedDir[mi]       = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                _mergedMaxInt[mi]    = intensity;
                _mergedLayerSlice[mi] = layerSlice;
                _lightToMerged[li]   = mi;
                _mergedCount++;
            }
        }
    }

    // Candidate pool for the 32 specular slots, nearest-to-viewer first,
    // capped at _activeLightCount (mirrors the manager's activeLightCount
    // setting rather than always assuming all 32 slots are open).
    //
    // MAX_RADIUS_SQ here is a specular-only, shader-accurate cutoff: past
    // _FadeEndDist a light's specular contribution is zero for every light
    // regardless of its own baked range (see UdonSpecularSystem.cginc's
    // _UdonCameraFade). Rejecting those candidates early just keeps the
    // editor preview from spending a slot on a light that would render
    // with zero specular anyway — it is NOT a diffuse cutoff (diffuse for
    // baked lights samples the layer array directly, unrelated to slots).
    private static int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        int cap   = Mathf.Clamp(_activeLightCount, 1, MAX_LIGHTS);

        for (int i = 0; i < _mergedCount; i++)
        {
            float distSq = Vector3.SqrMagnitude(viewerPos - (Vector3)_mergedPos[i]);
            if (distSq > MAX_RADIUS_SQ) continue;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= cap) continue;

            int maxShift = Mathf.Min(count, cap - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j]   = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }
            _indices[ins]   = i;
            _distances[ins] = distSq;
            if (count < cap) count++;
        }
        return count;
    }

    private static bool UpdateLiveData()
    {
        if (_lightToMerged == null || _lightToMerged.Length != _lights.Length) return false;

        bool changed = false;

        for (int li = 0; li < _lights.Length; li++)
        {
            Light l = _lights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;

            int mi = _lightToMerged[li];
            if (mi < 0) continue;

            int si = _mergedToShader[mi];
            if (si < 0) continue;

            Transform  t         = l.transform;
            Vector3    pos       = t.position;
            Quaternion rot       = t.rotation;
            float      intensity = l.intensity;
            Vector3    col       = new Vector3(l.color.r, l.color.g, l.color.b);

            bool posChanged = (pos - _lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
            bool rotChanged = Quaternion.Dot(rot, _lastLightRotations[li]) < 0.9999f;
            bool intChanged = Mathf.Abs(intensity - _lastLightIntensities[li]) > INTENSITY_EPSILON;
            bool colChanged = Mathf.Abs(col.x - _lastLightColors[li].x) > COLOR_EPSILON ||
                              Mathf.Abs(col.y - _lastLightColors[li].y) > COLOR_EPSILON ||
                              Mathf.Abs(col.z - _lastLightColors[li].z) > COLOR_EPSILON;

            if (!posChanged && !rotChanged && !intChanged && !colChanged) continue;

            changed = true;

            if (posChanged)
            {
                Vector4 p      = _mergedPos[mi];
                _mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, p.w);
                _lastLightPositions[li] = pos;
            }

            if (rotChanged)
            {
                Vector3 f  = rot * Vector3.forward;
                Vector3 r  = rot * Vector3.right;
                Vector3 u  = rot * Vector3.up;
                _mergedDir[mi]   = new Vector4(f.x, f.y, f.z, _mergedDir[mi].w);
                _mergedRight[mi] = new Vector4(r.x, r.y, r.z, _mergedRight[mi].w);
                _mergedUp[mi]    = new Vector4(u.x, u.y, u.z, _mergedUp[mi].w);
                _lastLightRotations[li] = rot;
            }

            if (intChanged || colChanged)
            {
                _mergedCol[mi] = new Vector4(col.x, col.y, col.z, intensity);
                _lastLightIntensities[li] = intensity;
                _lastLightColors[li]      = col;
            }

            _shaderPos[si]      = _mergedPos[mi];
            _shaderCol[si]      = _mergedCol[mi];
            _shaderBakedCol[si] = _mergedBakedCol[mi];
            _shaderRight[si]    = _mergedRight[mi];
            _shaderUp[si]       = _mergedUp[mi];
            _shaderDir[si]      = _mergedDir[mi];
            // LayerIndex is stable — no need to update per frame
        }

        return changed;
    }

    private static void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx             = _indices[i];
                _shaderPos[i]       = _mergedPos[idx];
                _shaderCol[i]       = _mergedCol[idx];
                _shaderBakedCol[i]  = _mergedBakedCol[idx];
                _shaderRight[i]     = _mergedRight[idx];
                _shaderUp[i]        = _mergedUp[idx];
                _shaderDir[i]       = _mergedDir[idx];
                _shaderLayerIndex[i] = new Vector4(_mergedLayerSlice[idx], 0f, 0f, 0f);
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
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos",       _shaderPos);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol",       _shaderCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightBakedCol",  _shaderBakedCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir",       _shaderDir);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight",     _shaderRight);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp",        _shaderUp);
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
        if (_lastLightPositions   == null || _lastLightPositions.Length   != n) _lastLightPositions   = new Vector3[n];
        if (_lastLightRotations   == null || _lastLightRotations.Length   != n) _lastLightRotations   = new Quaternion[n];
        if (_lastLightIntensities == null || _lastLightIntensities.Length != n) _lastLightIntensities = new float[n];
        if (_lastLightColors      == null || _lastLightColors.Length      != n) _lastLightColors      = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = _lights[i];
            if (l == null) continue;
            _lastLightPositions[i]   = l.transform.position;
            _lastLightRotations[i]   = l.transform.rotation;
            _lastLightIntensities[i] = l.intensity;
            _lastLightColors[i]      = new Vector3(l.color.r, l.color.g, l.color.b);
        }
    }

    private static void AllocateMergeBuffers(int cap)
    {
        _mergedPos       = new Vector4[cap];
        _mergedCol       = new Vector4[cap];
        _mergedBakedCol  = new Vector4[cap];
        _mergedRight     = new Vector4[cap];
        _mergedUp        = new Vector4[cap];
        _mergedDir       = new Vector4[cap];
        _mergedMaxInt    = new float[cap];
        _mergedLayerSlice = new int[cap];

        for (int i = 0; i < cap; i++) _mergedLayerSlice[i] = -1;
    }

    public static void SnapshotBakedIntensities()
    {
        if (_avatarRoot == null) TryFindAndBootstrap();
        if (_lights == null) return;

        SpecularLightManager mgr = _avatarRoot != null
            ? _avatarRoot.GetComponentInChildren<SpecularLightManager>()
            : null;

        int count = _lights.Length;
        _bakedIntensities = new float[count];
        _bakedColors      = new Vector3[count];

        float[]   serialized       = new float[count];
        Vector3[] serializedColors = new Vector3[count];

        for (int i = 0; i < count; i++)
        {
            Light l = _lights[i];
            if (l == null) continue;
            _bakedIntensities[i]   = l.intensity;
            serialized[i]          = l.intensity;
            _bakedColors[i]        = new Vector3(l.color.r, l.color.g, l.color.b);
            serializedColors[i]    = _bakedColors[i];
        }

        if (mgr != null)
        {
            mgr.childLightBakedIntensities = serialized;
            mgr.childLightBakedColors      = serializedColors;
            EditorUtility.SetDirty(mgr);
        }

        Debug.Log($"[Specular Avatar] Baked intensities and colors saved for {count} lights.");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Assign Layer Textures")]
    public static void OpenLayerAssignWindow()
    {
        if (_avatarRoot == null) TryFindAndBootstrap();
        LayerAssignWindow.Open(_lights, _layerTextures, _layerSlices, OnLayerAssignmentChanged);
    }

    private static void OnLayerAssignmentChanged(Texture2D[] textures, int[] slices)
    {
        _layerTextures = textures;
        _layerSlices   = slices;

        SpecularLightManager mgr = _avatarRoot != null
            ? _avatarRoot.GetComponentInChildren<SpecularLightManager>()
            : null;

        if (mgr != null)
        {
            mgr.childLightLayerSlices = slices;
            EditorUtility.SetDirty(mgr);
        }

        Tick();
        Debug.Log("[Specular Avatar] Layer slice assignments updated.");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Build Layer Array")]
    public static void BuildLayerArray()
    {
        if (_avatarRoot == null) TryFindAndBootstrap();
        if (_layerTextures == null || _layerTextures.Length == 0)
        {
            Debug.LogWarning("[Specular Avatar] No layer textures assigned. Use 'Assign Layer Textures' first.");
            return;
        }

        int maxSlice = -1;
        for (int i = 0; i < _layerSlices.Length; i++)
        {
            if (_layerTextures[i] != null && _layerSlices[i] > maxSlice)
                maxSlice = _layerSlices[i];
        }

        if (maxSlice < 0)
        {
            Debug.LogWarning("[Specular Avatar] No valid layer assignments found.");
            return;
        }

        int depth = maxSlice + 1;

        int width = 0, height = 0;
        for (int i = 0; i < _layerTextures.Length; i++)
        {
            if (_layerTextures[i] != null)
            {
                width  = _layerTextures[i].width;
                height = _layerTextures[i].height;
                break;
            }
        }

        if (width == 0)
        {
            Debug.LogError("[Specular Avatar] Could not determine layer texture resolution.");
            return;
        }

        Texture2DArray array = new Texture2DArray(width, height, depth,
                                                  TextureFormat.RGBAHalf, mipChain: false, linear: true);
        array.filterMode = FilterMode.Bilinear;
        array.wrapMode   = TextureWrapMode.Clamp;

        Color[] black = new Color[width * height];

        for (int slice = 0; slice < depth; slice++)
        {
            Texture2D src = null;
            for (int li = 0; li < _layerTextures.Length; li++)
            {
                if (_layerTextures[li] != null && _layerSlices[li] == slice)
                {
                    src = _layerTextures[li];
                    break;
                }
            }

            if (src == null)
            {
                array.SetPixels(black, slice);
                continue;
            }

            if (src.width != width || src.height != height)
            {
                Debug.LogWarning($"[Specular Avatar] Layer '{src.name}' is {src.width}x{src.height}, " +
                                 $"expected {width}x{height}. It will be skipped (slice {slice} = black).");
                array.SetPixels(black, slice);
                continue;
            }

            try
            {
                Color[] pixels = src.GetPixels();
                array.SetPixels(pixels, slice);
            }
            catch (System.Exception e)
            {
                Debug.LogError($"[Specular Avatar] Could not read '{src.name}': {e.Message}\n" +
                               "Make sure Read/Write is enabled in the texture import settings.");
                array.SetPixels(black, slice);
            }
        }

        array.Apply(updateMipmaps: false);

        string dir  = "Assets/LightLayers";
        string path = dir + "/LightLayerArray.asset";
        if (!AssetDatabase.IsValidFolder(dir))
            AssetDatabase.CreateFolder("Assets", "LightLayers");

        AssetDatabase.CreateAsset(array, path);
        AssetDatabase.SaveAssets();

        _previewLayerArray = array;

        SpecularLightManager mgr = _avatarRoot != null
            ? _avatarRoot.GetComponentInChildren<SpecularLightManager>()
            : null;

        if (mgr != null)
        {
            mgr.lightLayerArray = array;
            EditorUtility.SetDirty(mgr);
        }

        Shader.SetGlobalTexture("_UdonLightLayerArray", _previewLayerArray);
        RepaintSceneViews();

        Debug.Log($"[Specular Avatar] Layer array built: {depth} slices at {width}x{height}. Saved to {path}");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Rebuild Lights")]
    public static void RefreshLights()
    {
        TryFindAndBootstrap();
        _previewEnabled = true;
        Debug.Log("[Specular Avatar] Lights rebuilt. Preview enabled.");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Snapshot Baked Intensities")]
    public static void SnapshotBakedIntensitiesMenu() => SnapshotBakedIntensities();

    [MenuItem("Meenphie/Lighting/Speculars/Toggle Specular Preview")]
    public static void ToggleSpecularPreview()
    {
        _previewEnabled = !_previewEnabled;
        if (_previewEnabled)
        {
            TryFindAndBootstrap();
            Debug.Log("[Specular Avatar] Preview ON.");
        }
        else
        {
            ClearPreview();
            Debug.Log("[Specular Avatar] Preview OFF.");
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
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos",       empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol",       empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightBakedCol",  empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight",     empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp",        empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir",       empty);
        Shader.SetGlobalVectorArray("_UdonLightLayerIndex", empty);
        Shader.SetGlobalVector("_UdonSpecularLightData",           Vector4.zero);
        RepaintSceneViews();
        Debug.Log("[Specular Avatar] Preview cleared.");
    }
}


public class LayerAssignWindow : EditorWindow
{
    private Light[]      _lights;
    private Texture2D[]  _textures;
    private int[]        _slices;
    private Vector2      _scroll;
    private System.Action<Texture2D[], int[]> _onSave;

    public static void Open(Light[] lights, Texture2D[] existing,
                            int[] existingSlices,
                            System.Action<Texture2D[], int[]> onSave)
    {
        LayerAssignWindow win = GetWindow<LayerAssignWindow>("Assign Layer Textures");
        win._lights   = lights;
        win._textures = (existing != null && existing.Length == lights.Length)
                        ? (Texture2D[])existing.Clone()
                        : new Texture2D[lights.Length];
        win._slices   = (existingSlices != null && existingSlices.Length == lights.Length)
                        ? (int[])existingSlices.Clone()
                        : Enumerable.Repeat(-1, lights.Length).ToArray();
        win._onSave   = onSave;
        win.Show();
    }

    private void OnGUI()
    {
        if (_lights == null) { Close(); return; }

        EditorGUILayout.HelpBox(
            "Assign an HDR RGB layer EXR (baked in Cycles in isolation) to each static light group.\n" +
            "Dynamic/realtime lights don't need layers — leave them empty.\n" +
            "Click Save to pack into a Texture2DArray and assign slice indices.",
            MessageType.Info);

        EditorGUILayout.Space();

        _scroll = EditorGUILayout.BeginScrollView(_scroll);

        for (int i = 0; i < _lights.Length; i++)
        {
            Light l = _lights[i];
            if (l == null) continue;

            EditorGUILayout.BeginHorizontal();

            string bakeLabel = (l.lightmapBakeType == LightmapBakeType.Baked) ? "[Static]" : "[Dynamic]";
            EditorGUILayout.LabelField($"{bakeLabel} {l.name}", GUILayout.Width(200));

            _textures[i] = (Texture2D)EditorGUILayout.ObjectField(
                _textures[i], typeof(Texture2D), allowSceneObjects: false, GUILayout.Width(160));

            string sliceHint = (_textures[i] != null) ? $"→ slice {_slices[i]}" : "no layer";
            EditorGUILayout.LabelField(sliceHint, GUILayout.Width(80));

            EditorGUILayout.EndHorizontal();
        }

        EditorGUILayout.EndScrollView();
        EditorGUILayout.Space();

        if (GUILayout.Button("Save & Assign Slices"))
        {
            int nextSlice = 0;
            for (int i = 0; i < _lights.Length; i++)
            {
                _slices[i] = (_textures[i] != null) ? nextSlice++ : -1;
            }
            _onSave?.Invoke(_textures, _slices);
            Close();
        }
    }
}
#endif