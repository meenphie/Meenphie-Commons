#if VRC_SDK_VRCSDK3 && UDON
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    // ── Inspector ─────────────────────────────────────────────────────────────
    [Header("Settings")]
    [Tooltip("Seconds between merge-rebuild / re-sort ticks (~20 Hz = 0.05).")]
    public float updateInterval = 0.05f;

    [Tooltip("Lights closer than this (metres²) are merged into one entry.")]
    public float mergeThresholdSq = 0.5f;

    [Tooltip("Dot-product threshold below which merged lights become omni/bidirectional.")]
    public float dirConflictDot = 0.5f;

    [Tooltip("Lights beyond this radius (metres) are ignored.")]
    public float maxRadius = 32f;

    [Range(1, MAX_LIGHTS)]
    public int activeLightCount = MAX_LIGHTS;

    // ── Debug ─────────────────────────────────────────────────────────────────
    [Header("Debug Info (read-only)")]
    public int currentDynamicLights;
    public int currentStaticLights;
    public int currentActiveCount;
    public bool shaderWasUpdated;

    // ── Constants ─────────────────────────────────────────────────────────────
    public const int MAX_LIGHTS = 32;

    // ── Child lights — serialized by the editor companion ─────────────────────
    [Header("Light Sources (auto-filled — use Refresh Child Lights menu)")]
    public Light[] childLights;
    [HideInInspector] public Vector2[] childLightHalfExtents;
    [HideInInspector] public bool[] childLightIsRealtime;

    // ── Merged groups ─────────────────────────────────────────────────────────
    [HideInInspector] public Vector4[] mergedPos;
    [HideInInspector] public Vector4[] mergedCol;
    [HideInInspector] public Vector4[] mergedRight;
    [HideInInspector] public Vector4[] mergedUp;
    [HideInInspector] public Vector4[] mergedDir;
    [HideInInspector] public float[]   mergedMaxInt;
    [HideInInspector] public int       mergedCount;

    // ── Shader upload buffers ─────────────────────────────────────────────────
    private Vector4[] _shaderPos   = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderCol   = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRight = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUp    = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderDir   = new Vector4[MAX_LIGHTS];

    // ── Sort state ────────────────────────────────────────────────────────────
    private int[]   _indices          = new int[MAX_LIGHTS];
    private float[] _distances        = new float[MAX_LIGHTS];
    private int[]   _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[]   _mergedToShader   = new int[MAX_LIGHTS];
    private int     _lastFinalCount   = -1;

    // ── Caching & Optimization ────────────────────────────────────────────────
    private Transform[] _childTransforms; // OPTIMIZATION: Avoid .transform native calls
    private Transform   _thisTransform;   // OPTIMIZATION: Cache manager transform
    private int _posID, _colID, _rightID, _upID, _dirID, _countID;

    [HideInInspector] public Vector3[]    lastLightPositions;
    [HideInInspector] public Quaternion[] lastLightRotations;
    [HideInInspector] public float[]      lastLightIntensities;
    [HideInInspector] public Vector3[]    lastLightColors;
    [HideInInspector] public Vector3      lastViewerPos = new Vector3(float.MaxValue, 0, 0);

    private int[] _lightToMerged = new int[0];

    public const float MOTION_EPSILON_SQ  = 0.0001f;
    public const float COLOR_EPSILON      = 0.004f;
    public const float INTENSITY_EPSILON  = 0.001f;

    private float        _maxRadiusSq;
    private VRCPlayerApi _localPlayer;
    private float        _tickTimer;
    private bool         _specularEnabled = true;

    // ── Lifecycle ─────────────────────────────────────────────────────────────
    void Start()
    {
        _maxRadiusSq = maxRadius * maxRadius;
        _localPlayer = Networking.LocalPlayer;
        _thisTransform = transform; // Cache transform

        _posID   = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID   = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID = VRCShader.PropertyToID("_UdonSpecularLightRight");
        _upID    = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _dirID   = VRCShader.PropertyToID("_UdonSpecularLightDir");
        _countID = VRCShader.PropertyToID("_UdonSpecularLightCount");

        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            _lastIndicesSorted[i] = -1;
            _mergedToShader[i]    = -1;
        }

        AllocateMergeBuffers();
    }

    void OnEnable()
    {
        if (_localPlayer == null) return;
        _lastFinalCount = -1;
        lastViewerPos   = new Vector3(float.MaxValue, 0, 0);
    }

    void OnDisable()
    {
        UploadToShader(0);
        _lastFinalCount       = 0;
        currentActiveCount    = 0;
        currentDynamicLights  = 0;
        currentStaticLights   = 0;
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
    }

    // ── Update ────────────────────────────────────────────────────────────────
    void Update()
    {
        if (!_specularEnabled || childLights == null || childLights.Length == 0) return;

        bool anyChanged = UpdateLiveData();

        _tickTimer += Time.deltaTime;
        if (_tickTimer >= updateInterval)
        {
            _tickTimer = 0f;
            Tick();
        }
        else if (anyChanged)
        {
            UploadPosColDir();
            shaderWasUpdated = true;
        }
    }

    // ── UpdateLiveData ────────────────────────────────────────────────────────
    private bool UpdateLiveData()
    {
        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length) return false;

        bool changed = false;

        for (int li = 0; li < childLights.Length; li++)
        {
            // OPTIMIZATION: Completely skip static/baked lights for frame-by-frame updates.
            // They will still be updated at 20Hz in Tick() if they toggle on/off.
            if (childLightIsRealtime != null && li < childLightIsRealtime.Length && !childLightIsRealtime[li]) 
                continue;

            Light l = childLights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;

            int mi = _lightToMerged[li];
            if (mi < 0) continue;

            int si = _mergedToShader[mi];
            if (si < 0) continue;

            Transform t = _childTransforms[li]; // Uses cached transform
            Vector3 pos = t.position;
            
            bool posChanged = (pos - lastLightPositions[li]).sqrMagnitude > MOTION_EPSILON_SQ;
            
            Quaternion rot = t.rotation;
            bool rotChanged = Quaternion.Dot(rot, lastLightRotations[li]) < 0.9999f;
            
            float intensity = l.intensity;
            bool intChanged = Mathf.Abs(intensity - lastLightIntensities[li]) > INTENSITY_EPSILON;
            
            Color lColor = l.color;
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
                Vector3 fwd   = rot * Vector3.forward;
                Vector3 right = rot * Vector3.right;
                Vector3 up    = rot * Vector3.up;

                mergedDir[mi]   = new Vector4(fwd.x,   fwd.y,   fwd.z,   mergedDir[mi].w);
                mergedRight[mi] = new Vector4(right.x, right.y, right.z, mergedRight[mi].w);
                mergedUp[mi]    = new Vector4(up.x,    up.y,    up.z,    mergedUp[mi].w);
                lastLightRotations[li] = rot;
            }

            if (intChanged || colChanged)
            {
                Vector3 col = new Vector3(lColor.r, lColor.g, lColor.b);
                Vector3 oldContrib = lastLightColors[li] * lastLightIntensities[li];
                Vector3 newContrib = col * intensity;

                Vector4 mc = mergedCol[mi];
                mergedCol[mi] = new Vector4(mc.x - oldContrib.x + newContrib.x, 
                                            mc.y - oldContrib.y + newContrib.y, 
                                            mc.z - oldContrib.z + newContrib.z, 
                                            mc.w);

                lastLightIntensities[li] = intensity;
                lastLightColors[li]      = col;
            }

            _shaderPos[si]   = mergedPos[mi];
            _shaderCol[si]   = mergedCol[mi];
            _shaderRight[si] = mergedRight[mi];
            _shaderUp[si]    = mergedUp[mi];
            _shaderDir[si]   = mergedDir[mi];
        }

        return changed;
    }

    // ── Tick ──────────────────────────────────────────────────────────────────
    public void Tick()
    {
        if (childLights == null || childLights.Length == 0) return;

        Vector3 viewerPos = _localPlayer != null
            ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position
            : _thisTransform.position; // Use cached transform

        BuildMergedGroups();
        int finalCount = SortNearest(viewerPos);
        currentActiveCount = finalCount;

        int dynCount  = 0;
        int statCount = 0;
        for (int i = 0; i < finalCount; i++)
        {
            if (mergedCol[_indices[i]].w > 0.5f) dynCount++; 
            else statCount++;
        }
        currentDynamicLights = dynCount;
        currentStaticLights  = statCount;

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

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
        _lastFinalCount    = finalCount;
        shaderWasUpdated   = isDirty;
    }

    // ── BuildMergedGroups ─────────────────────────────────────────────────────
    public void BuildMergedGroups()
    {
        if (mergedPos == null || mergedPos.Length < childLights.Length) AllocateMergeBuffers();
        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length) _lightToMerged = new int[childLights.Length];

        mergedCount = 0;

        for (int li = 0; li < childLights.Length; li++)
        {
            _lightToMerged[li] = -1;

            Light l = childLights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
            if (l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex) continue;

            Transform t = _childTransforms[li]; // Uses cached transform
            Vector3 pos = t.position;
            float intensity = l.intensity;
            float range = l.range;

            float width = 0.01f, height = 0.01f;
            if (childLightHalfExtents != null && li < childLightHalfExtents.Length)
            {
                width  = childLightHalfExtents[li].x;
                height = childLightHalfExtents[li].y;
            }

            Vector3 fwd = t.forward;
            float cosOuter = (l.type == LightType.Spot) ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad) : (l.type == LightType.Area ? 0.0f : -1.0f);

            Color lColor = l.color;
            Vector3 contribution = new Vector3(lColor.r, lColor.g, lColor.b) * intensity;

            float isRealtime = (childLightIsRealtime != null && li < childLightIsRealtime.Length && childLightIsRealtime[li]) ? 1f : 0f;

            bool merged = false;
            for (int i = 0; i < mergedCount; i++)
            {
                if (((Vector3)mergedPos[i] - pos).sqrMagnitude >= mergeThresholdSq) continue;

                Vector4 mc = mergedCol[i];
                mergedCol[i] = new Vector4(mc.x + contribution.x, mc.y + contribution.y, mc.z + contribution.z, mc.w);

                Vector3 exFwd = new Vector3(mergedDir[i].x, mergedDir[i].y, mergedDir[i].z);
                bool alreadyOmni = mergedDir[i].w < -0.1f;
                bool conflict = !alreadyOmni && Vector3.Dot(exFwd, fwd) < dirConflictDot;
                float newMax = Mathf.Max(mergedMaxInt[i], intensity);

                if (intensity > mergedMaxInt[i])
                {
                    mergedPos[i]   = new Vector4(pos.x, pos.y, pos.z, range);
                    mergedRight[i] = new Vector4(t.right.x, t.right.y, t.right.z, width);
                    mergedUp[i]    = new Vector4(t.up.x, t.up.y, t.up.z, height);
                    mergedDir[i]   = new Vector4(fwd.x, fwd.y, fwd.z, conflict ? -0.5f : cosOuter);
                    mergedCol[i]   = new Vector4(mergedCol[i].x, mergedCol[i].y, mergedCol[i].z, isRealtime);
                }
                else if (conflict)
                {
                    Vector4 d = mergedDir[i];
                    mergedDir[i] = new Vector4(d.x, d.y, d.z, -0.5f);
                }

                mergedMaxInt[i] = newMax;
                _lightToMerged[li] = i;
                merged = true;
                break;
            }

            if (!merged && mergedCount < mergedPos.Length)
            {
                int mi = mergedCount;
                mergedPos[mi]   = new Vector4(pos.x, pos.y, pos.z, range);
                mergedCol[mi]   = new Vector4(contribution.x, contribution.y, contribution.z, isRealtime);
                mergedRight[mi] = new Vector4(t.right.x, t.right.y, t.right.z, width);
                mergedUp[mi]    = new Vector4(t.up.x, t.up.y, t.up.z, height);
                mergedDir[mi]   = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                mergedMaxInt[mi]   = intensity;
                _lightToMerged[li] = mi;
                mergedCount++;
            }
        }
    }

    // ── SortNearest ───────────────────────────────────────────────────────────
    public int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        for (int i = 0; i < mergedCount; i++)
        {
            float distSq = (viewerPos - (Vector3)mergedPos[i]).sqrMagnitude;
            if (distSq > _maxRadiusSq) continue;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= activeLightCount) continue;

            int maxShift = Mathf.Min(count, activeLightCount - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j]   = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }
            _indices[ins]   = i;
            _distances[ins] = distSq;
            if (count < activeLightCount) count++;
        }
        return count;
    }

    // ── FillUploadBuffers ─────────────────────────────────────────────────────
    private void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx = _indices[i];
                _shaderPos[i]    = mergedPos[idx];
                _shaderCol[i]    = mergedCol[idx];
                _shaderRight[i]  = mergedRight[idx];
                _shaderUp[i]     = mergedUp[idx];
                _shaderDir[i]    = mergedDir[idx];
                _lastIndicesSorted[i] = idx;
            }
            else
            {
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] = _shaderUp[i] = _shaderDir[i] = Vector4.zero;
                _lastIndicesSorted[i] = -1;
            }
        }
    }

    // ── UploadPosColDir ───────────────────────────────────────────────────────
    private void UploadPosColDir()
    {
        VRCShader.SetGlobalVectorArray(_posID,   _shaderPos);
        VRCShader.SetGlobalVectorArray(_colID,   _shaderCol);
        VRCShader.SetGlobalVectorArray(_dirID,   _shaderDir);
        VRCShader.SetGlobalVectorArray(_rightID, _shaderRight);
        VRCShader.SetGlobalVectorArray(_upID,    _shaderUp);
    }

    // ── UploadToShader ────────────────────────────────────────────────────────
    private void UploadToShader(int count)
    {
        VRCShader.SetGlobalVectorArray(_posID,   _shaderPos);
        VRCShader.SetGlobalVectorArray(_colID,   _shaderCol);
        VRCShader.SetGlobalVectorArray(_rightID, _shaderRight);
        VRCShader.SetGlobalVectorArray(_upID,    _shaderUp);
        VRCShader.SetGlobalVectorArray(_dirID,   _shaderDir);
        VRCShader.SetGlobalFloat(_countID, (float)count);
    }

    // ── CacheLightStates ──────────────────────────────────────────────────────
    private void CacheLightStates()
    {
        int n = childLights.Length;
        if (lastLightPositions  == null || lastLightPositions.Length  != n) lastLightPositions  = new Vector3[n];
        if (lastLightRotations  == null || lastLightRotations.Length  != n) lastLightRotations  = new Quaternion[n];
        if (lastLightIntensities == null || lastLightIntensities.Length != n) lastLightIntensities = new float[n];
        if (lastLightColors     == null || lastLightColors.Length     != n) lastLightColors     = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = childLights[i];
            if (l == null) continue;
            Transform t = _childTransforms[i];
            lastLightPositions[i]  = t.position;
            lastLightRotations[i]  = t.rotation;
            lastLightIntensities[i] = l.intensity;
            Color c = l.color;
            lastLightColors[i] = new Vector3(c.r, c.g, c.b);
        }
    }

    // ── AllocateMergeBuffers ──────────────────────────────────────────────────
    private void AllocateMergeBuffers()
    {
        int cap = (childLights != null) ? childLights.Length : MAX_LIGHTS;
        mergedPos    = new Vector4[cap];
        mergedCol    = new Vector4[cap];
        mergedRight  = new Vector4[cap];
        mergedUp     = new Vector4[cap];
        mergedDir    = new Vector4[cap];
        mergedMaxInt = new float[cap];

        _childTransforms = new Transform[cap];
        for (int i = 0; i < cap; i++)
        {
            if (childLights != null && i < childLights.Length && childLights[i] != null)
            {
                _childTransforms[i] = childLights[i].transform;
            }
        }
    }

    // ── Toggle ────────────────────────────────────────────────────────────────
    public void ToggleSpecular()
    {
        SetSpecular(!_specularEnabled);
    }

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;

        if (!enabled)
        {
            for (int i = 0; i < MAX_LIGHTS; i++)
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] = _shaderUp[i] = _shaderDir[i] = Vector4.zero;

            UploadPosColDir();
            VRCShader.SetGlobalFloat(_countID, 0f);

            currentActiveCount   = 0;
            currentDynamicLights = 0;
            currentStaticLights  = 0;
            shaderWasUpdated     = true;
        }
        else
        {
            _lastFinalCount = -1;
            Tick();
        }
    }

    public bool IsSpecularEnabled() => _specularEnabled;
}
#endif