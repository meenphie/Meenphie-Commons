using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

// ==============================================================================
// SpecularLightManager
// ==============================================================================
// Manages up to 32 lights, sorts them by distance each tick, and uploads their
// data to global shader properties consumed by UdonSpecularSystem.hlsl.
//
// Lightmap layering replaces the old LMDelta approach:
//   • Each baked light can have a pre-baked layer slice in _UdonLightLayerArray
//     (a Texture2DArray, up to 32 slices).
//   • childLightLayerSlices[i] stores which slice index belongs to childLights[i].
//     -1 means "no layer" (realtime lights, or baked lights without a layer yet).
//   • At upload time, FillUploadBuffers writes the correct slice index into
//     _UdonLightLayerIndex[shaderSlot].x so the shader can sample it.
//
// Workflow:
//   1. For each baked/static light, bake it in isolation (that light only,
//      all other static lights off) and import the result as a slice in
//      _UdonLightLayerArray (editor tool handles this — see
//      SpecularLightManagerEditor.cs).
//   2. In the inspector, childLightLayerSlices[i] is auto-filled by the editor.
//   3. At runtime, the Udon script sorts lights, remaps slice indices per slot,
//      and the shader samples each light's isolated slice directly, scaled by
//      liveInt/bakedInt — there is no "all lights on" bake to subtract from;
//      that subtractive approach was the old LMDelta system this replaced.
//
// Light selection (SortNearest):
//   The only thing that can ever exclude a light from a shader slot is the
//   fixed array budget (activeLightCount, <= MAX_LIGHTS). There is no
//   distance-based reject — nearest-to-viewer is used purely as the
//   tie-break when there are more candidate lights than slots. Diffuse and
//   specular are both computed shader-side from whatever ends up in the
//   array; any per-pixel camera-distance fade is a specular-only concern
//   that lives entirely in UdonSpecularSystem.cginc, never here.
// ==============================================================================

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    // ── Inspector ─────────────────────────────────────────────────────────────
    [Header("Settings")]
    [Tooltip("Seconds between sort/upload ticks (~20 Hz = 0.05).")]
    public float updateInterval = 0.05f;

    [Tooltip("Lights closer than this (metres²) are merged into one entry.")]
    public float mergeThresholdSq = 0.5f;

    [Tooltip("Dot-product threshold below which merged lights become omni/bidirectional.")]
    public float dirConflictDot = 0.5f;

    [Range(1, MAX_LIGHTS)]
    public int activeLightCount = MAX_LIGHTS;

    [Tooltip("Multiplier for derived light range: range = sqrt(bakedIntensity) * rangeScale.")]
    public float rangeScale = 10f;

    // ── Lightmap layer array ───────────────────────────────────────────────────
    [Header("Lightmap Layer")]
    [Tooltip("Texture2DArray (up to 32 slices). Each slice is the baked " +
             "contribution layer for one light. Assign via the editor menu.")]
    public Texture2DArray lightLayerArray;

    // ── Debug ─────────────────────────────────────────────────────────────────
    [Header("Debug Info (read-only)")]
    public int  currentDynamicLights;
    public int  currentStaticLights;
    public int  currentActiveCount;
    public bool shaderWasUpdated;

    // ── Constants ─────────────────────────────────────────────────────────────
    public const int MAX_LIGHTS = 32;

    // ── Child lights — serialized by the editor companion ─────────────────────
    [Header("Light Sources (auto-filled — use Refresh Child Lights menu)")]
    public Light[] childLights;

    [HideInInspector] public Vector2[] childLightHalfExtents;
    [HideInInspector] public bool[]    childLightIsRealtime;

    // Baked intensity snapshot — set once via editor companion.
    // This is the intensity each light had at bake time; the shader uses it as
    // the "fully on" reference to compute dimFactor = 1 - (liveInt / bakedInt).
    [HideInInspector] public float[]   childLightBakedIntensities;
    [HideInInspector] public Vector3[] childLightBakedColors;

    // Per-light slice index in lightLayerArray.
    // -1 = no layer assigned (realtime light, or baked light not yet layered).
    // Set by the editor tool after baking individual light layers.
    [HideInInspector] public int[] childLightLayerSlices;

    // ── Merged groups ─────────────────────────────────────────────────────────
    // Each merged group collapses co-located lights into one shader entry.
    // The dominant light (highest intensity) sets position, direction, extents.
    //
    // Pos      : xyz = world position,   w = bakedIntensity
    // Col      : xyz = live color,       w = live intensity
    // Dir      : xyz = forward,          w = cosOuter / type flag
    // Right    : xyz = right vector,     w = halfWidth
    // Up       : xyz = up vector,        w = halfHeight
    // BakedCol : xyz = bake-time color,  w = 1.0 realtime / 0.0 baked
    // LayerSlice: slice index in lightLayerArray, -1 if none
    [HideInInspector] public Vector4[] mergedPos;
    [HideInInspector] public Vector4[] mergedCol;
    [HideInInspector] public Vector4[] mergedRight;
    [HideInInspector] public Vector4[] mergedUp;
    [HideInInspector] public Vector4[] mergedDir;
    [HideInInspector] public Vector4[] mergedBakedCol;
    [HideInInspector] public float[]   mergedMaxInt;
    [HideInInspector] public int[]     mergedLayerSlice; // per-group slice index, -1 = none
    [HideInInspector] public int       mergedCount;

    // ── Shader upload buffers ─────────────────────────────────────────────────
    private Vector4[] _shaderPos       = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderCol       = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRight     = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUp        = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderDir       = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderBakedCol  = new Vector4[MAX_LIGHTS];

    // Slice index per shader slot: .x = slice in _UdonLightLayerArray, -1 = none.
    // This is what the shader reads to know which layer slice to sample.
    private Vector4[] _shaderLayerIndex = new Vector4[MAX_LIGHTS];

    // ── Sort state ────────────────────────────────────────────────────────────
    private int[]   _indices           = new int[MAX_LIGHTS];
    private float[] _distances         = new float[MAX_LIGHTS];
    private int[]   _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[]   _mergedToShader    = new int[MAX_LIGHTS];
    private int     _lastFinalCount    = -1;

    // ── Caching & Optimization ────────────────────────────────────────────────
    private Transform[] _childTransforms;
    private Transform   _thisTransform;

    // Property IDs cached at Start() to avoid string lookups each frame
    private int _dataID, _posID, _colID, _rightID, _upID, _dirID, _bakedColID, _layerIndexID, _layerArrayID;

    [HideInInspector] public Vector3[]    lastLightPositions;
    [HideInInspector] public Quaternion[] lastLightRotations;
    [HideInInspector] public float[]      lastLightIntensities;
    [HideInInspector] public Vector3[]    lastLightColors;
    [HideInInspector] public Vector3      lastViewerPos = new Vector3(float.MaxValue, 0, 0);

    private int[] _lightToMerged = new int[0];

    public const float MOTION_EPSILON_SQ  = 0.0001f;
    public const float COLOR_EPSILON      = 0.004f;
    public const float INTENSITY_EPSILON  = 0.001f;

    private VRCPlayerApi _localPlayer;
    private float        _tickTimer;
    private bool         _specularEnabled = true;

    // ── Lifecycle ─────────────────────────────────────────────────────────────
    void Start()
    {
        _localPlayer  = Networking.LocalPlayer;
        _thisTransform = transform;

        _dataID       = VRCShader.PropertyToID("_UdonSpecularLightData");
        _posID        = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID        = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID      = VRCShader.PropertyToID("_UdonSpecularLightRight");
        _upID         = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _dirID        = VRCShader.PropertyToID("_UdonSpecularLightDir");
        _bakedColID   = VRCShader.PropertyToID("_UdonSpecularLightBakedCol");
        _layerIndexID  = VRCShader.PropertyToID("_UdonLightLayerIndex");
        _layerArrayID  = VRCShader.PropertyToID("_UdonLightLayerArray");

        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            _lastIndicesSorted[i] = -1;
            _mergedToShader[i]    = -1;
        }

        // Upload the Texture2DArray once at start; it doesn't change at runtime.
        if (lightLayerArray != null)
            VRCShader.SetGlobalTexture(_layerArrayID, lightLayerArray);

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
        _lastFinalCount      = 0;
        currentActiveCount   = 0;
        currentDynamicLights = 0;
        currentStaticLights  = 0;
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
            // Light changed this frame but it's not tick time yet — upload
            // position/color/direction immediately so there's no visual lag.
            UploadAllBuffers();
            shaderWasUpdated = true;
        }
    }

    // ── UpdateLiveData ────────────────────────────────────────────────────────
    // Fast per-frame update: only touches lights that actually changed.
    // Writes directly into the shader buffer slots using _mergedToShader remapping.
    private bool UpdateLiveData()
    {
        if (_lightToMerged == null || _lightToMerged.Length != childLights.Length) return false;

        bool changed = false;

        for (int li = 0; li < childLights.Length; li++)
        {
            // Baked lights don't move or change at runtime — skip them here.
            if (childLightIsRealtime != null && li < childLightIsRealtime.Length && !childLightIsRealtime[li])
                continue;

            Light l = childLights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;

            int mi = _lightToMerged[li];
            if (mi < 0) continue;

            int si = _mergedToShader[mi];
            if (si < 0) continue;

            Transform  t         = _childTransforms[li];
            Vector3    pos       = t.position;
            Quaternion rot       = t.rotation;
            float      intensity = l.intensity;
            Color      lColor    = l.color;

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
                Vector4 p      = mergedPos[mi];
                mergedPos[mi]  = new Vector4(pos.x, pos.y, pos.z, p.w);
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
                Vector3 col    = new Vector3(lColor.r, lColor.g, lColor.b);
                mergedCol[mi]  = new Vector4(col.x, col.y, col.z, intensity);
                lastLightIntensities[li] = intensity;
                lastLightColors[li]      = col;
            }

            // Push updated merged data into the corresponding shader slot
            _shaderPos[si]        = mergedPos[mi];
            _shaderCol[si]        = mergedCol[mi];
            _shaderRight[si]      = mergedRight[mi];
            _shaderUp[si]         = mergedUp[mi];
            _shaderDir[si]        = mergedDir[mi];
            _shaderBakedCol[si]   = mergedBakedCol[mi];
            // LayerIndex doesn't change per frame — it was set in FillUploadBuffers
        }

        return changed;
    }

    // ── Tick ──────────────────────────────────────────────────────────────────
    // Full rebuild: re-merge groups, re-sort by distance, re-upload everything.
    public void Tick()
    {
        if (childLights == null || childLights.Length == 0) return;

        Vector3 viewerPos = _localPlayer != null
            ? _localPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head).position
            : _thisTransform.position;

        BuildMergedGroups();
        int finalCount = SortNearest(viewerPos);
        currentActiveCount = finalCount;

#if UNITY_EDITOR
        // Inspector-only debug readout. mergedBakedCol[i].w already carries
        // the realtime flag (1 = realtime, 0 = baked) per merged group, so
        // this is a flat O(finalCount) pass — no nested search needed.
        //
        // NOTE: UdonSharp compiles inside the Unity Editor process, so
        // UNITY_EDITOR can still be true at Udon-compile time and this block
        // may end up baked into the uploaded program regardless of this
        // #if. If that turns out to be the case, swap this for an explicit
        // serialized bool toggle instead of relying on the preprocessor.
        int dynCount = 0, statCount = 0;
        for (int i = 0; i < finalCount; i++)
        {
            int mi = _indices[i];
            if (mergedBakedCol[mi].w > 0.5f) dynCount++; else statCount++;
        }
        currentDynamicLights = dynCount;
        currentStaticLights  = statCount;
#endif

        // Rebuild merged→shader remapping table
        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount;  i++) _mergedToShader[_indices[i]] = i;

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
        _lastFinalCount  = finalCount;
        shaderWasUpdated = isDirty;
    }

    // ── BuildMergedGroups ─────────────────────────────────────────────────────
    // Collapse co-located lights into single shader entries.
    // The dominant (brightest) light sets position, direction, extents, and layer.
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

            Transform t         = _childTransforms[li];
            Vector3   pos       = t.position;
            float     intensity = l.intensity;
            Color     lColor    = l.color;
            Vector3   rawColor  = new Vector3(lColor.r, lColor.g, lColor.b);
            Vector3   fwd       = t.forward;

            float width  = 0.01f;
            float height = 0.01f;
            if (childLightHalfExtents != null && li < childLightHalfExtents.Length)
            {
                width  = childLightHalfExtents[li].x;
                height = childLightHalfExtents[li].y;
            }

            float bakedInt = (childLightBakedIntensities != null && li < childLightBakedIntensities.Length
                              && childLightBakedIntensities[li] > 0f)
                             ? childLightBakedIntensities[li]
                             : intensity;

            Vector3 bakedCol = (childLightBakedColors != null && li < childLightBakedColors.Length)
                               ? childLightBakedColors[li]
                               : rawColor;

            // Slice index for this light's baked layer; -1 if not assigned
            int layerSlice = (childLightLayerSlices != null && li < childLightLayerSlices.Length)
                            ? childLightLayerSlices[li]
                            : -1;

            // BakedCol.w encodes the realtime flag:
            //   1.0 = realtime light  →  shader adds direct diffuse, no layer sample
            //   0.0 = baked light     →  shader applies layer sample
            bool  isRt         = (childLightIsRealtime != null && li < childLightIsRealtime.Length)
                                 ? childLightIsRealtime[li] : true;
            float realtimeFlag = isRt ? 1f : 0f;

            float cosOuter = (l.type == LightType.Spot)  ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                           : (l.type == LightType.Area)  ? 0.0f
                           :                               -1.0f; // point/omni

            // ── Try to merge into an existing nearby group ──────────────────
            bool merged = false;
            for (int i = 0; i < mergedCount; i++)
            {
                if (((Vector3)mergedPos[i] - pos).sqrMagnitude >= mergeThresholdSq) continue;

                Vector3 exFwd       = new Vector3(mergedDir[i].x, mergedDir[i].y, mergedDir[i].z);
                bool    alreadyOmni = mergedDir[i].w < -0.1f;
                bool    conflict    = !alreadyOmni && Vector3.Dot(exFwd, fwd) < dirConflictDot;
                float   newMax      = Mathf.Max(mergedMaxInt[i], intensity);

                if (intensity > mergedMaxInt[i])
                {
                    // Dominant light changed — update all fields
                    mergedPos[i]      = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                    mergedCol[i]      = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                    mergedRight[i]    = new Vector4(t.right.x, t.right.y, t.right.z, width);
                    mergedUp[i]       = new Vector4(t.up.x, t.up.y, t.up.z, height);
                    mergedDir[i]      = new Vector4(fwd.x, fwd.y, fwd.z, conflict ? -0.5f : cosOuter);
                    mergedBakedCol[i] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                    mergedLayerSlice[i] = layerSlice; // dominant light's layer takes priority
                }
                else if (conflict)
                {
                    // Direction conflict with non-dominant light → force bidirectional
                    Vector4 d        = mergedDir[i];
                    mergedDir[i]     = new Vector4(d.x, d.y, d.z, -0.5f);
                }

                mergedMaxInt[i]    = newMax;
                _lightToMerged[li] = i;
                merged             = true;
                break;
            }

            // ── No nearby group found → create a new one ───────────────────
            if (!merged && mergedCount < mergedPos.Length)
            {
                int mi             = mergedCount;
                mergedPos[mi]      = new Vector4(pos.x, pos.y, pos.z, bakedInt);
                mergedCol[mi]      = new Vector4(rawColor.x, rawColor.y, rawColor.z, intensity);
                mergedRight[mi]    = new Vector4(t.right.x, t.right.y, t.right.z, width);
                mergedUp[mi]       = new Vector4(t.up.x, t.up.y, t.up.z, height);
                mergedDir[mi]      = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                mergedBakedCol[mi] = new Vector4(bakedCol.x, bakedCol.y, bakedCol.z, realtimeFlag);
                mergedMaxInt[mi]   = intensity;
                mergedLayerSlice[mi] = layerSlice;
                _lightToMerged[li] = mi;
                mergedCount++;
            }
        }
    }

    // ── SortNearest ───────────────────────────────────────────────────────────
    // Insertion sort into _indices / _distances, nearest first, capped at
    // activeLightCount slots.
    //
    // There is NO distance-based reject. Every merged group is a candidate
    // regardless of how far it is from the viewer — the only thing that can
    // exclude a light from a shader slot is running out of slots
    // (activeLightCount). Distance is used purely to rank candidates when
    // there are more of them than there is room for.
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
    // Copy sorted merged-group data into the flat shader upload arrays.
    // This is where the slice index remapping happens:
    //   mergedLayerSlice[mergedIndex] → _shaderLayerIndex[shaderSlot].x
    private void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx = _indices[i];
                _shaderPos[i]        = mergedPos[idx];
                _shaderCol[i]        = mergedCol[idx];
                _shaderRight[i]      = mergedRight[idx];
                _shaderUp[i]         = mergedUp[idx];
                _shaderDir[i]        = mergedDir[idx];
                _shaderBakedCol[i]   = mergedBakedCol[idx];
                // .x = slice index in _UdonLightLayerArray; -1 means no layer.
                // .yzw = unused, reserved for future use (e.g. layer blend weight).
                _shaderLayerIndex[i]  = new Vector4(mergedLayerSlice[idx], 0f, 0f, 0f);
                _lastIndicesSorted[i] = idx;
            }
            else
            {
                // Pad unused slots with zeros so the shader loop exits cleanly
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] =
                _shaderUp[i]  = _shaderDir[i] = _shaderBakedCol[i] = Vector4.zero;
                _shaderLayerIndex[i]   = new Vector4(-1f, 0f, 0f, 0f); // -1 = no layer
                _lastIndicesSorted[i] = -1;
            }
        }
    }

    // ── Upload helpers ────────────────────────────────────────────────────────

    // Full upload — all buffers + count/rangeScale data vector.
    private void UploadToShader(int count)
    {
        UploadAllBuffers();
        VRCShader.SetGlobalVector(_dataID, new Vector4((float)count, rangeScale, 0f, 0f));
    }

    // Upload geometry/color/layer buffers without changing the light count.
    // Used mid-frame when a realtime light changes but no resort is needed.
    private void UploadAllBuffers()
    {
        VRCShader.SetGlobalVectorArray(_posID,       _shaderPos);
        VRCShader.SetGlobalVectorArray(_colID,       _shaderCol);
        VRCShader.SetGlobalVectorArray(_dirID,       _shaderDir);
        VRCShader.SetGlobalVectorArray(_rightID,     _shaderRight);
        VRCShader.SetGlobalVectorArray(_upID,        _shaderUp);
        VRCShader.SetGlobalVectorArray(_bakedColID,  _shaderBakedCol);
        VRCShader.SetGlobalVectorArray(_layerIndexID, _shaderLayerIndex);
    }

    // ── CacheLightStates ──────────────────────────────────────────────────────
    private void CacheLightStates()
    {
        int n = childLights.Length;
        if (lastLightPositions   == null || lastLightPositions.Length   != n) lastLightPositions   = new Vector3[n];
        if (lastLightRotations   == null || lastLightRotations.Length   != n) lastLightRotations   = new Quaternion[n];
        if (lastLightIntensities == null || lastLightIntensities.Length != n) lastLightIntensities = new float[n];
        if (lastLightColors      == null || lastLightColors.Length      != n) lastLightColors      = new Vector3[n];

        for (int i = 0; i < n; i++)
        {
            Light l = childLights[i];
            if (l == null) continue;
            Transform t              = _childTransforms[i];
            lastLightPositions[i]    = t.position;
            lastLightRotations[i]    = t.rotation;
            lastLightIntensities[i]  = l.intensity;
            Color c                  = l.color;
            lastLightColors[i]       = new Vector3(c.r, c.g, c.b);
        }
    }

    // ── AllocateMergeBuffers ──────────────────────────────────────────────────
    private void AllocateMergeBuffers()
    {
        int cap = (childLights != null) ? childLights.Length : MAX_LIGHTS;

        mergedPos       = new Vector4[cap];
        mergedCol       = new Vector4[cap];
        mergedRight     = new Vector4[cap];
        mergedUp        = new Vector4[cap];
        mergedDir       = new Vector4[cap];
        mergedBakedCol  = new Vector4[cap];
        mergedMaxInt    = new float[cap];
        mergedLayerSlice = new int[cap];   // new

        // Initialize all layer slices to -1 (no layer)
        for (int i = 0; i < cap; i++) mergedLayerSlice[i] = -1;

        _childTransforms = new Transform[cap];
        for (int i = 0; i < cap; i++)
        {
            if (childLights != null && i < childLights.Length && childLights[i] != null)
                _childTransforms[i] = childLights[i].transform;
        }
    }

    // ── Toggle ────────────────────────────────────────────────────────────────
    public void ToggleSpecular() => SetSpecular(!_specularEnabled);

    public void SetSpecular(bool enabled)
    {
        _specularEnabled = enabled;

        if (!enabled)
        {
            // Clear all shader slots
            for (int i = 0; i < MAX_LIGHTS; i++)
            {
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] =
                _shaderUp[i]  = _shaderDir[i] = _shaderBakedCol[i] = Vector4.zero;
                _shaderLayerIndex[i] = new Vector4(-1f, 0f, 0f, 0f);
            }
            UploadAllBuffers();
            VRCShader.SetGlobalVector(_dataID, new Vector4(0f, rangeScale, 0f, 0f));
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