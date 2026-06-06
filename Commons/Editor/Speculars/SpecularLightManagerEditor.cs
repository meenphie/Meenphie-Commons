#if UNITY_EDITOR
// ─────────────────────────────────────────────────────────────────────────────
//  SpecularLightAvatarEditorCompanion  —  editor-only, Avatar SDK compatible
//  Mirrors the runtime SpecularLightManager merging and sorting logic.
// ─────────────────────────────────────────────────────────────────────────────
using UnityEngine;
using UnityEditor;

[InitializeOnLoad]
public static class SpecularLightAvatarEditor
{
    // ── Constants & Settings (Matching Udon Script) ───────────────────────────
    public const int MAX_LIGHTS = 32;
    private const float MERGE_THRESHOLD_SQ = 0.5f;
    private const float DIR_CONFLICT_DOT = 0.5f;
    private const float MAX_RADIUS_SQ = 32f * 32f;
    private const float MOTION_EPSILON_SQ = 0.0001f;
    private const float COLOR_EPSILON = 0.004f;
    private const float INTENSITY_EPSILON = 0.001f;
    private const float UPDATE_INTERVAL = 0.05f;

    // ── State ─────────────────────────────────────────────────────────────────
    private static GameObject _avatarRoot;
    private static Light[] _lights;
    private static Vector2[] _halfExtents;
    private static bool[] _isRealtime;

    private static bool _previewEnabled = true;
    private static double _lastTick;

    // ── Change tracking ───────────────────────────────────────────────────────
    private static Vector3[] _lastLightPositions;
    private static Quaternion[] _lastLightRotations;
    private static float[] _lastLightIntensities;
    private static Vector3[] _lastLightColors;

    // ── Merged groups ─────────────────────────────────────────────────────────
    private static Vector4[] _mergedPos;
    private static Vector4[] _mergedCol;
    private static Vector4[] _mergedRight;
    private static Vector4[] _mergedUp;
    private static Vector4[] _mergedDir;
    private static float[] _mergedMaxInt;
    private static int _mergedCount;

    // ── Shader upload buffers ─────────────────────────────────────────────────
    private static readonly Vector4[] _shaderPos = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderCol = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderRight = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderUp = new Vector4[MAX_LIGHTS];
    private static readonly Vector4[] _shaderDir = new Vector4[MAX_LIGHTS];
    private static float _shaderCount = 0f;

    // ── Sort state ────────────────────────────────────────────────────────────
    private static int[] _indices = new int[MAX_LIGHTS];
    private static float[] _distances = new float[MAX_LIGHTS];
    private static int[] _mergedToShader = new int[MAX_LIGHTS];
    private static int[] _lightToMerged = new int[0];

    // ── Static constructor ────────────────────────────────────────────────────
    static SpecularLightAvatarEditor()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
        SceneView.duringSceneGui -= OnSceneGui;
        SceneView.duringSceneGui += OnSceneGui;

        // Nouveau : bootstrap automatique à l'ouverture/chargement de scène
        EditorApplication.hierarchyChanged -= OnHierarchyChanged;
        EditorApplication.hierarchyChanged += OnHierarchyChanged;
    }

    private static void OnHierarchyChanged()
    {
        if (_avatarRoot == null && !Application.isPlaying)
            TryFindAndBootstrap();
    }

    // ── Scene GUI hook — re-pushes current buffers before every repaint ───────
    private static void OnSceneGui(SceneView sv)
    {
        if (!_previewEnabled || Application.isPlaying) return;
        // Just re-upload whatever is already in the buffers; no logic, no cost
        PushBuffersToShader();
    }

    // ── Editor update loop ────────────────────────────────────────────────────
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

        double now = EditorApplication.timeSinceStartup;

        bool anyChanged = UpdateLiveData();

        if (now - _lastTick >= UPDATE_INTERVAL)
        {
            _lastTick = now;
            Tick();
        }
        else if (anyChanged)
        {
            UploadPosColDir();
            RepaintSceneViews();
        }
    }

    // ── Find avatar root ──────────────────────────────────────────────────────
    private static void TryFindAndBootstrap()
    {
        // Priorité 1 : objet sélectionné
        if (Selection.activeGameObject != null)
        {
            Transform root = Selection.activeGameObject.transform.root;
            if (root.GetComponentsInChildren<Light>(true).Length > 0)
            {
                Bootstrap(root.gameObject);
                return;
            }
        }

        // Priorité 2 : racines avec Animator
        Animator[] animators = Object.FindObjectsOfType<Animator>();
        foreach (Animator anim in animators)
        {
            if (anim.transform.root == anim.transform &&
                anim.GetComponentsInChildren<Light>(true).Length > 0)
            {
                Bootstrap(anim.gameObject);
                return;
            }
        }

        // Priorité 3 (nouveau) : n'importe quelle racine de hiérarchie avec des lights
        Light[] allLights = Object.FindObjectsOfType<Light>();
        foreach (Light l in allLights)
        {
            GameObject root = l.transform.root.gameObject;
            Bootstrap(root);
            return;
        }
    }

    // ── Bootstrap ─────────────────────────────────────────────────────────────
    private static void Bootstrap(GameObject avatarRoot)
    {
        _avatarRoot = avatarRoot;

        _lights = avatarRoot.GetComponentsInChildren<Light>(includeInactive: true);
        int count = _lights.Length;
        _halfExtents = new Vector2[count];
        _isRealtime = new bool[count];

        for (int i = 0; i < count; i++)
        {
            Light l = _lights[i];
            _halfExtents[i] = l.type == LightType.Area
                ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                : new Vector2(0.01f, 0.01f);
            _isRealtime[i] = l.lightmapBakeType != LightmapBakeType.Baked;
        }

        AllocateMergeBuffers(count);
        CacheLightStates();

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;

        _lastTick = 0;
        Tick();

        Debug.Log($"[Specular Avatar] Bootstrapped on '{avatarRoot.name}': {count} lights found.");
    }

    // ── Tick (Full Merge & Sort) ──────────────────────────────────────────────
    private static void Tick()
    {
        if (_lights == null || _lights.Length == 0) return;

        Vector3 viewerPos = GetViewerPos();

        BuildMergedGroups();
        int finalCount = SortNearest(viewerPos);

        for (int i = 0; i < MAX_LIGHTS; i++) _mergedToShader[i] = -1;
        for (int i = 0; i < finalCount; i++) _mergedToShader[_indices[i]] = i;

        CacheLightStates();
        FillUploadBuffers(finalCount);
        UploadToShader(finalCount);
        RepaintSceneViews();
    }

    // ── BuildMergedGroups ─────────────────────────────────────────────────────
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
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;
            if (l.type == LightType.Directional) continue;
            if (l.renderMode == LightRenderMode.ForceVertex) continue;

            Vector3 pos = l.transform.position;
            float intensity = l.intensity;
            float range = l.range;
            float width = _halfExtents[li].x;
            float height = _halfExtents[li].y;
            Vector3 fwd = l.transform.forward;

            float cosOuter;
            if (l.type == LightType.Spot) cosOuter = Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad);
            else if (l.type == LightType.Area) cosOuter = 0.0f;
            else cosOuter = -1.0f;

            Vector3 contribution = new Vector3(l.color.r, l.color.g, l.color.b) * intensity;
            float isRealtime = _isRealtime[li] ? 1f : 0f;

            bool merged = false;
            for (int i = 0; i < _mergedCount; i++)
            {
                if (((Vector3)_mergedPos[i] - pos).sqrMagnitude >= MERGE_THRESHOLD_SQ) continue;

                Vector4 mc = _mergedCol[i];
                _mergedCol[i] = new Vector4(mc.x + contribution.x, mc.y + contribution.y, mc.z + contribution.z, mc.w);

                Vector3 exFwd = new Vector3(_mergedDir[i].x, _mergedDir[i].y, _mergedDir[i].z);
                bool alreadyOmni = _mergedDir[i].w < -0.1f;
                bool conflict = !alreadyOmni && Vector3.Dot(exFwd, fwd) < DIR_CONFLICT_DOT;
                float newMax = Mathf.Max(_mergedMaxInt[i], intensity);

                if (intensity > _mergedMaxInt[i])
                {
                    _mergedPos[i] = new Vector4(pos.x, pos.y, pos.z, range);
                    _mergedRight[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                    _mergedUp[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height);
                    _mergedDir[i] = new Vector4(fwd.x, fwd.y, fwd.z, conflict ? -0.5f : cosOuter);
                    _mergedCol[i] = new Vector4(_mergedCol[i].x, _mergedCol[i].y, _mergedCol[i].z, isRealtime);
                }
                else if (conflict)
                {
                    Vector4 d = _mergedDir[i];
                    _mergedDir[i] = new Vector4(d.x, d.y, d.z, -0.5f);
                }

                _mergedMaxInt[i] = newMax;
                _lightToMerged[li] = i;
                merged = true;
                break;
            }

            if (!merged && _mergedCount < _mergedPos.Length)
            {
                int mi = _mergedCount;
                _mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, range);
                _mergedCol[mi] = new Vector4(contribution.x, contribution.y, contribution.z, isRealtime);
                _mergedRight[mi] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                _mergedUp[mi] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height);
                _mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, cosOuter);
                _mergedMaxInt[mi] = intensity;
                _lightToMerged[li] = mi;
                _mergedCount++;
            }
        }
    }

    // ── SortNearest ───────────────────────────────────────────────────────────
    private static int SortNearest(Vector3 viewerPos)
    {
        int count = 0;
        for (int i = 0; i < _mergedCount; i++)
        {
            float distSq = Vector3.SqrMagnitude(viewerPos - (Vector3)_mergedPos[i]);
            if (distSq > MAX_RADIUS_SQ) continue;

            int ins = count;
            while (ins > 0 && _distances[ins - 1] > distSq) ins--;
            if (ins >= MAX_LIGHTS) continue;

            int maxShift = Mathf.Min(count, MAX_LIGHTS - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _indices[j] = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }
            _indices[ins] = i;
            _distances[ins] = distSq;
            if (count < MAX_LIGHTS) count++;
        }
        return count;
    }

    // ── UpdateLiveData (Fast Path) ────────────────────────────────────────────
    private static bool UpdateLiveData()
    {
        if (_lightToMerged == null || _lightToMerged.Length != _lights.Length)
            return false;

        bool changed = false;

        for (int li = 0; li < _lights.Length; li++)
        {
            Light l = _lights[li];
            if (l == null || !l.enabled || !l.gameObject.activeInHierarchy) continue;

            int mi = _lightToMerged[li];
            if (mi < 0) continue;

            int si = _mergedToShader[mi];
            if (si < 0) continue;

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

            if (posChanged)
            {
                Vector4 p = _mergedPos[mi];
                _mergedPos[mi] = new Vector4(pos.x, pos.y, pos.z, p.w);
                _lastLightPositions[li] = pos;
            }

            if (rotChanged)
            {
                Vector3 fwd = rot * Vector3.forward;
                Vector3 right = rot * Vector3.right;
                Vector3 up = rot * Vector3.up;

                _mergedDir[mi] = new Vector4(fwd.x, fwd.y, fwd.z, _mergedDir[mi].w);
                _mergedRight[mi] = new Vector4(right.x, right.y, right.z, _mergedRight[mi].w);
                _mergedUp[mi] = new Vector4(up.x, up.y, up.z, _mergedUp[mi].w);
                _lastLightRotations[li] = rot;
            }

            if (intChanged || colChanged)
            {
                Vector3 oldContrib = _lastLightColors[li] * _lastLightIntensities[li];
                Vector3 newContrib = col * intensity;

                Vector4 mc = _mergedCol[mi];
                Vector3 newRgb = new Vector3(mc.x, mc.y, mc.z) - oldContrib + newContrib;
                _mergedCol[mi] = new Vector4(newRgb.x, newRgb.y, newRgb.z, mc.w);

                _lastLightIntensities[li] = intensity;
                _lastLightColors[li] = col;
            }

            _shaderPos[si] = _mergedPos[mi];
            _shaderCol[si] = _mergedCol[mi];
            _shaderRight[si] = _mergedRight[mi];
            _shaderUp[si] = _mergedUp[mi];
            _shaderDir[si] = _mergedDir[mi];
        }

        return changed;
    }

    // ── Utilities ─────────────────────────────────────────────────────────────
    private static Vector3 GetViewerPos()
    {
        SceneView sv = SceneView.lastActiveSceneView;
        return (sv != null && sv.camera != null) ? sv.camera.transform.position : Vector3.zero;
    }

    private static void FillUploadBuffers(int finalCount)
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            if (i < finalCount)
            {
                int idx = _indices[i];
                _shaderPos[i] = _mergedPos[idx];
                _shaderCol[i] = _mergedCol[idx];
                _shaderRight[i] = _mergedRight[idx];
                _shaderUp[i] = _mergedUp[idx];
                _shaderDir[i] = _mergedDir[idx];
            }
            else
            {
                _shaderPos[i] = _shaderCol[i] = _shaderRight[i] = _shaderUp[i] = _shaderDir[i] = Vector4.zero;
            }
        }
    }

    // Stores the last uploaded count so OnSceneGui can re-push it correctly
    private static void PushBuffersToShader()
    {
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", _shaderPos);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", _shaderCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", _shaderDir);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", _shaderRight);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", _shaderUp);
        Shader.SetGlobalFloat("_UdonSpecularLightCount", _shaderCount);
    }

    private static void UploadPosColDir()
    {
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", _shaderPos);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", _shaderCol);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", _shaderDir);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", _shaderRight);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", _shaderUp);
    }

    private static void UploadToShader(int count)
    {
        _shaderCount = (float)count;   // ← keep a local copy for re-push
        UploadPosColDir();
        Shader.SetGlobalFloat("_UdonSpecularLightCount", _shaderCount);
    }

    // Forces all open Scene views to repaint so the shader data is visible
    private static void RepaintSceneViews()
    {
        SceneView.RepaintAll();
    }

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

    private static void AllocateMergeBuffers(int cap)
    {
        _mergedPos = new Vector4[cap];
        _mergedCol = new Vector4[cap];
        _mergedRight = new Vector4[cap];
        _mergedUp = new Vector4[cap];
        _mergedDir = new Vector4[cap];
        _mergedMaxInt = new float[cap];
    }

    // ── Menu items ────────────────────────────────────────────────────────────

    [MenuItem("Meenphie/Lighting/Speculars/Rebuild Lights")]
    public static void RefreshLights()
    {
        TryFindAndBootstrap();
        _previewEnabled = true;
        Debug.Log("[Specular Avatar] Lights rebuilt. Preview enabled.");
    }

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
        _shaderCount = 0f;
        Vector4[] empty = new Vector4[MAX_LIGHTS];
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", empty);
        Shader.SetGlobalFloat("_UdonSpecularLightCount", 0f);
        RepaintSceneViews();
        Debug.Log("[Specular Avatar] Preview cleared.");
    }
}
#endif