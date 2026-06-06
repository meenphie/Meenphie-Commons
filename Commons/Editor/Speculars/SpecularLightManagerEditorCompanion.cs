#if UNITY_EDITOR
// ─────────────────────────────────────────────────────────────────────────────
//  SpecularLightManagerEditorCompanion  —  editor-only companion
// ─────────────────────────────────────────────────────────────────────────────
using UnityEngine;
using UnityEditor;

[InitializeOnLoad]
public static class SpecularLightManagerEditorCompanion
{
    private static SpecularLightManager _mgr;
    private static double _lastTick;
    private static bool _previewEnabled = true;

    private static Vector3[] _cachedPositions;
    private static Vector3[] _cachedForwards;

    // Editor-side shader upload buffers (reused every frame).
    // _col is Vector4 — .rgb = colour, .a = isRealtime (1.0 Realtime/Mixed, 0.0 Baked)
    private static readonly Vector4[] _pos = new Vector4[SpecularLightManager.MAX_LIGHTS];
    private static readonly Vector4[] _col = new Vector4[SpecularLightManager.MAX_LIGHTS];
    private static readonly Vector4[] _right = new Vector4[SpecularLightManager.MAX_LIGHTS];
    private static readonly Vector4[] _up = new Vector4[SpecularLightManager.MAX_LIGHTS];
    private static readonly Vector4[] _dir = new Vector4[SpecularLightManager.MAX_LIGHTS];
    private static readonly int[] _idx = new int[SpecularLightManager.MAX_LIGHTS];
    private static readonly float[] _dist = new float[SpecularLightManager.MAX_LIGHTS];

    // ── Static constructor ────────────────────────────────────────────────────
    static SpecularLightManagerEditorCompanion()
    {
        EditorApplication.update -= OnEditorUpdate;
        EditorApplication.update += OnEditorUpdate;
    }

    // ── Editor update loop ────────────────────────────────────────────────────
    private static void OnEditorUpdate()
    {
        if (Application.isPlaying) return;

        double now = EditorApplication.timeSinceStartup;

        if (_mgr == null)
        {
            _mgr = Object.FindFirstObjectByType<SpecularLightManager>();
            if (_mgr == null) return;
            Bootstrap(_mgr);
        }

        if (_mgr.childLights == null || _mgr.childLights.Length == 0) return;
        if (!_previewEnabled) return;

        SceneView sv = SceneView.lastActiveSceneView;
        if (sv != null && sv.camera != null)
            _mgr.lastViewerPos = sv.camera.transform.position;

        bool transformPatchedThisFrame = false;
        if (_mgr.currentActiveCount > 0 && EditorTransformsMoved())
        {
            EditorPatchTransformsAndUpload(_mgr);
            EditorCacheTransforms(_mgr);
            transformPatchedThisFrame = true;
        }

        if (now - _lastTick < _mgr.updateInterval) return;
        _lastTick = now;

        _mgr.BuildMergedGroups();
        int finalCount = EditorSortAndUpload(_mgr, skipUpload: transformPatchedThisFrame);
        _mgr.currentActiveCount = finalCount;
        _mgr.shaderWasUpdated = (finalCount > 0);

        EditorCacheTransforms(_mgr);
    }

    // ── Bootstrap ─────────────────────────────────────────────────────────────
    private static void Bootstrap(SpecularLightManager mgr)
    {
        Light[] lights = mgr.GetComponentsInChildren<Light>(includeInactive: true);
        Vector2[] extents = new Vector2[lights.Length];

        for (int i = 0; i < lights.Length; i++)
        {
            Light l = lights[i];
            extents[i] = l.type == LightType.Area
                ? new Vector2(l.areaSize.x * 0.5f, l.areaSize.y * 0.5f)
                : new Vector2(0.01f, 0.01f);
        }

        SerializedObject so = new SerializedObject(mgr);

        SerializedProperty lightsProp = so.FindProperty("childLights");
        lightsProp.arraySize = lights.Length;
        for (int i = 0; i < lights.Length; i++)
            lightsProp.GetArrayElementAtIndex(i).objectReferenceValue = lights[i];

        SerializedProperty extentsProp = so.FindProperty("childLightHalfExtents");
        extentsProp.arraySize = extents.Length;
        for (int i = 0; i < extents.Length; i++)
            extentsProp.GetArrayElementAtIndex(i).vector2Value = extents[i];

        SerializedProperty realtimeProp = so.FindProperty("childLightIsRealtime");
        realtimeProp.arraySize = lights.Length;
        for (int i = 0; i < lights.Length; i++)
            realtimeProp.GetArrayElementAtIndex(i).boolValue =
                lights[i].lightmapBakeType != LightmapBakeType.Baked;

        so.ApplyModifiedPropertiesWithoutUndo();

        mgr.lastViewerPos = new Vector3(float.MaxValue, 0, 0);
        _lastTick = 0;

        _cachedPositions = new Vector3[lights.Length];
        _cachedForwards = new Vector3[lights.Length];
        for (int i = 0; i < lights.Length; i++)
        {
            _cachedPositions[i] = lights[i].transform.position;
            _cachedForwards[i] = lights[i].transform.forward;
        }

        Debug.Log($"[Specular] Bootstrapped: {lights.Length} child lights registered.");
    }

    // ── Fast path: patch transforms in-place ──────────────────────────────────
    private static void EditorPatchTransformsAndUpload(SpecularLightManager mgr)
    {
        for (int slot = 0; slot < mgr.currentActiveCount; slot++)
        {
            if (mgr.mergedPos == null || slot >= mgr.mergedPos.Length) continue;
            Vector3 mPos = (Vector3)mgr.mergedPos[_idx[slot]];

            float bestDist = float.MaxValue;
            int bestChild = -1;
            for (int ci = 0; ci < mgr.childLights.Length; ci++)
            {
                Light l2 = mgr.childLights[ci];
                if (l2 == null) continue;
                float d = (l2.transform.position - mPos).sqrMagnitude;
                if (d < bestDist) { bestDist = d; bestChild = ci; }
            }
            if (bestChild < 0) continue;

            Light src = mgr.childLights[bestChild];
            Transform t = src.transform;
            Vector3 pos = t.position;

            float hw = (mgr.childLightHalfExtents != null && bestChild < mgr.childLightHalfExtents.Length)
                ? mgr.childLightHalfExtents[bestChild].x : 0.01f;
            float hh = (mgr.childLightHalfExtents != null && bestChild < mgr.childLightHalfExtents.Length)
                ? mgr.childLightHalfExtents[bestChild].y : 0.01f;

            _pos[slot] = new Vector4(pos.x, pos.y, pos.z, _pos[slot].w);
            _right[slot] = new Vector4(t.right.x, t.right.y, t.right.z, hw);
            _up[slot] = new Vector4(t.up.x, t.up.y, t.up.z, hh);
            _dir[slot] = new Vector4(t.forward.x, t.forward.y, t.forward.z, _dir[slot].w);
            // _col[slot].a (isRealtime) is already correct from the last slow tick — no change needed
        }

        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", _pos);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", _right);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", _up);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", _dir);
    }

    // ── Slow path: full sort + upload ─────────────────────────────────────────
    private static int EditorSortAndUpload(SpecularLightManager mgr, bool skipUpload)
    {
        float maxRadiusSq = mgr.maxRadius * mgr.maxRadius;
        Vector3 viewerPos = mgr.lastViewerPos;
        int count = 0;

        for (int i = 0; i < mgr.mergedCount; i++)
        {
            float distSq = Vector3.SqrMagnitude(viewerPos - (Vector3)mgr.mergedPos[i]);
            if (distSq > maxRadiusSq) continue;

            int ins = count;
            while (ins > 0 && _dist[ins - 1] > distSq) ins--;
            if (ins >= mgr.activeLightCount) continue;

            int maxShift = Mathf.Min(count, mgr.activeLightCount - 1);
            for (int j = maxShift; j > ins; j--)
            {
                _idx[j] = _idx[j - 1];
                _dist[j] = _dist[j - 1];
            }
            _idx[ins] = i;
            _dist[ins] = distSq;
            if (count < mgr.activeLightCount) count++;
        }

        // Rebuild upload arrays — fast path reads them next frame
        for (int i = 0; i < SpecularLightManager.MAX_LIGHTS; i++)
        {
            if (i < count)
            {
                int k = _idx[i];
                _pos[i] = mgr.mergedPos[k];
                _col[i] = mgr.mergedCol[k];   // Vector4 — .a carries isRealtime
                _right[i] = mgr.mergedRight[k];
                _up[i] = mgr.mergedUp[k];
                _dir[i] = mgr.mergedDir[k];
            }
            else
            {
                _pos[i] = _col[i] = _right[i] = _up[i] = _dir[i] = Vector4.zero;
            }
        }

        if (!skipUpload)
        {
            Shader.SetGlobalVectorArray("_UdonSpecularLightPos", _pos);
            Shader.SetGlobalVectorArray("_UdonSpecularLightCol", _col);
            Shader.SetGlobalVectorArray("_UdonSpecularLightRight", _right);
            Shader.SetGlobalVectorArray("_UdonSpecularLightUp", _up);
            Shader.SetGlobalVectorArray("_UdonSpecularLightDir", _dir);
            Shader.SetGlobalFloat("_UdonSpecularLightCount", (float)count);
        }

        return count;
    }

    // ── Transform motion check ────────────────────────────────────────────────
    private static bool EditorTransformsMoved()
    {
        if (_mgr.childLights == null) return false;
        if (_cachedPositions == null || _cachedPositions.Length != _mgr.childLights.Length) return false;
        if (_cachedForwards == null || _cachedForwards.Length != _mgr.childLights.Length) return false;

        const float eps = SpecularLightManager.MOTION_EPSILON_SQ;
        for (int i = 0; i < _mgr.childLights.Length; i++)
        {
            Light l = _mgr.childLights[i];
            if (l == null) continue;
            if ((l.transform.position - _cachedPositions[i]).sqrMagnitude > eps) return true;
            if (1f - Vector3.Dot(l.transform.forward, _cachedForwards[i]) > eps) return true;
        }
        return false;
    }

    // ── Cache editor transforms ───────────────────────────────────────────────
    private static void EditorCacheTransforms(SpecularLightManager mgr)
    {
        if (mgr.childLights == null) return;
        if (_cachedPositions == null || _cachedPositions.Length != mgr.childLights.Length)
            _cachedPositions = new Vector3[mgr.childLights.Length];
        if (_cachedForwards == null || _cachedForwards.Length != mgr.childLights.Length)
            _cachedForwards = new Vector3[mgr.childLights.Length];

        for (int i = 0; i < mgr.childLights.Length; i++)
        {
            if (mgr.childLights[i] == null) continue;
            _cachedPositions[i] = mgr.childLights[i].transform.position;
            _cachedForwards[i] = mgr.childLights[i].transform.forward;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Menu items
    // ─────────────────────────────────────────────────────────────────────────

    [MenuItem("Meenphie/Lighting/Speculars/Rebuild Lights")]
    public static void RefreshChildLights()
    {
        SpecularLightManager mgr = Object.FindFirstObjectByType<SpecularLightManager>();
        if (mgr == null) { Debug.LogError("[Specular] SpecularLightManager not found in scene."); return; }
        _mgr = mgr;
        Bootstrap(mgr);
        _previewEnabled = true;
        Debug.Log("[Specular] Lights rebuilt. Preview enabled.");
    }

    [MenuItem("Meenphie/Lighting/Speculars/Toggle Specular Preview")]
    public static void ToggleSpecularPreview()
    {
        _previewEnabled = !_previewEnabled;

        if (_previewEnabled)
        {
            SpecularLightManager mgr = Object.FindFirstObjectByType<SpecularLightManager>();
            if (mgr != null) { _mgr = mgr; Bootstrap(mgr); }
            Debug.Log("[Specular] Preview ON.");
        }
        else
        {
            ClearPreview();
            Debug.Log("[Specular] Preview OFF.");
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
        Vector4[] empty = new Vector4[SpecularLightManager.MAX_LIGHTS];
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir", empty);
        Shader.SetGlobalFloat("_UdonSpecularLightCount", 0f);
        Debug.Log("[Specular] Preview cleared.");
    }

    // ── Reflection Probes ─────────────────────────────────────────────────────

    [MenuItem("Meenphie/Lighting/Reflection Probes/Bake All Probes")]
    public static void BakeReflectionProbes()
    {
        SpecularLightManager mgr = Object.FindFirstObjectByType<SpecularLightManager>();
        if (mgr != null)
        {
            _mgr = mgr;
            Bootstrap(mgr);
            Debug.Log("[Specular] Lights pushed to shader before probe bake.");
        }

        MeshRenderer[] renderers = Object.FindObjectsByType<MeshRenderer>(FindObjectsSortMode.None);
        bool[] wasContrib = new bool[renderers.Length];

        for (int i = 0; i < renderers.Length; i++)
        {
            StaticEditorFlags flags = GameObjectUtility.GetStaticEditorFlags(renderers[i].gameObject);
            wasContrib[i] = flags.HasFlag(StaticEditorFlags.ContributeGI);
            if (wasContrib[i])
                GameObjectUtility.SetStaticEditorFlags(
                    renderers[i].gameObject,
                    flags & ~StaticEditorFlags.ContributeGI);
        }

        Debug.Log("[Specular] Starting Reflection Probe bake (lightmaps skipped)...");
        Lightmapping.BakeAsync();

        Lightmapping.bakeCompleted += () =>
        {
            for (int i = 0; i < renderers.Length; i++)
            {
                if (!wasContrib[i]) continue;
                GameObjectUtility.SetStaticEditorFlags(
                    renderers[i].gameObject,
                    GameObjectUtility.GetStaticEditorFlags(renderers[i].gameObject)
                    | StaticEditorFlags.ContributeGI);
            }

            Lightmapping.bakeCompleted -= null;
            Debug.Log("[Specular] Reflection Probes baked. ContributeGI restored.");
            EditorUtility.DisplayDialog(
                "Meenphie — Reflection Probes",
                "Bake terminé !",
                "OK");
        };
    }

    [MenuItem("Meenphie/Lighting/Reflection Probes/Bake All Probes", validate = true)]
    public static bool BakeReflectionProbesValidate() => !Lightmapping.isRunning;
}
#endif