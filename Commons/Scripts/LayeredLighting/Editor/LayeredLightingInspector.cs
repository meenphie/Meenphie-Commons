#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Light))]
[CanEditMultipleObjects]
public class LayeredLightingInspector : Editor
{
    private Editor _defaultEditor;
    private bool _foldoutOpen = true;

    private static readonly string[] StyleNames = new string[]
    {
        "Fluorescent — 50 Hz flicker + warm-up reboot",
        "Incandescent — thermal inertia + organic drift"
    };

    // ── Lifecycle ─────────────────────────────────────────────────────────────

    private void OnEnable()
    {
        var defaultEditorType = System.Type.GetType("UnityEditor.LightEditor, UnityEditor");
        if (defaultEditorType != null)
            _defaultEditor = CreateEditor(targets, defaultEditorType);
    }

    private void OnDisable()
    {
        if (_defaultEditor != null)
        {
            DestroyImmediate(_defaultEditor);
            _defaultEditor = null;
        }
    }

    // ── Main GUI ──────────────────────────────────────────────────────────────

    public override void OnInspectorGUI()
    {
        if (_defaultEditor != null)
            _defaultEditor.OnInspectorGUI();
        else
            base.OnInspectorGUI();

        EditorGUILayout.Space(6);
        DrawLayeredLightingFoldout();
    }

    // ── Data helper ───────────────────────────────────────────────────────────

    private struct Entry
    {
        public LayeredLightingManager manager;
        public int index;
        public Light light;
    }

    // ── Foldout ───────────────────────────────────────────────────────────────

    private void DrawLayeredLightingFoldout()
    {
        _foldoutOpen = EditorGUILayout.BeginFoldoutHeaderGroup(_foldoutOpen, "Layered Lighting");
        if (!_foldoutOpen)
        {
            EditorGUILayout.EndFoldoutHeaderGroup();
            return;
        }

        EditorGUI.indentLevel++;

        var tracked = new List<Entry>();
        var untracked = new List<string>();

        foreach (Object t in targets)
        {
            Light light = t as Light;
            if (light == null) continue;

            LayeredLightingManager mgr = FindManagerFor(light, out int index);

            bool valid = mgr != null && index >= 0
                && mgr.childLightIsRealtime != null && index < mgr.childLightIsRealtime.Length
                && mgr.childLightDiffuseEnabled != null && index < mgr.childLightDiffuseEnabled.Length
                && mgr.childLightSpecularDistance != null && index < mgr.childLightSpecularDistance.Length
                && mgr.childLightSpecularMaxDistance != null && index < mgr.childLightSpecularMaxDistance.Length
                && mgr.childLightDiffuseMaxDistance != null && index < mgr.childLightDiffuseMaxDistance.Length
                && mgr.childLightIsAnimated != null && index < mgr.childLightIsAnimated.Length
                && mgr.childLightAnimationModel != null && index < mgr.childLightAnimationModel.Length
                && mgr.childLightIsBroken != null && index < mgr.childLightIsBroken.Length
                && mgr.childLightFailureRate != null && index < mgr.childLightFailureRate.Length;

            if (!valid)
            {
                untracked.Add(light.gameObject.name);
                continue;
            }

            tracked.Add(new Entry { manager = mgr, index = index, light = light });
        }

        if (tracked.Count > 0)
        {
            // ── Rendering ────────────────────────────────────────────────────

            EditorGUILayout.LabelField("Rendering", EditorStyles.boldLabel);

            DrawSharedToggle(
                tracked, "Is Realtime",
                "Forces the selected light(s) into the analytic (non-lightmap) diffuse branch.",
                e => e.manager.childLightIsRealtime[e.index],
                (e, v) => e.manager.childLightIsRealtime[e.index] = v);

            DrawSharedToggle(
                tracked, "Diffuse",
                "Include the selected light(s) in the diffuse channel.",
                e => e.manager.childLightDiffuseEnabled[e.index],
                (e, v) => e.manager.childLightDiffuseEnabled[e.index] = v);

            DrawSharedToggle(
                tracked, "Specular",
                "Include the selected light(s) in the specular channel.",
                e => e.manager.childLightSpecularDistance[e.index],
                (e, v) => e.manager.childLightSpecularDistance[e.index] = v);

            DrawSharedSlider(
                tracked, "Max Specular Distance",
                "Maximum distance for this light to contribute to specular/realtime lighting. 0 = unlimited (uses default range). Fades out smoothly as it approaches this distance.",
                0f, 100f,
                e => e.manager.childLightSpecularMaxDistance[e.index],
                (e, v) => e.manager.childLightSpecularMaxDistance[e.index] = v);

            DrawSharedSlider(
                tracked, "Max Diffuse Distance",
                "Maximum distance for this light to contribute diffuse lighting. 0 = unlimited (uses default range). Applies to both static (lightmap) and dynamic meshes: lightmap sampling hard-cuts at this distance (no fade, perf-only), while realtime diffuse fades out smoothly like specular does.",
                0f, 100f,
                e => e.manager.childLightDiffuseMaxDistance[e.index],
                (e, v) => e.manager.childLightDiffuseMaxDistance[e.index] = v);

            // ── Animation ────────────────────────────────────────────────────

            EditorGUILayout.Space(6);
            EditorGUILayout.LabelField("Animation", EditorStyles.boldLabel);

            DrawSharedToggle(
                tracked, "Is Animated",
                "Enables physical light animation (Fluorescent or Incandescent model).",
                e => e.manager.childLightIsAnimated[e.index],
                (e, v) => e.manager.childLightIsAnimated[e.index] = v);

            bool anyAnimated = false;
            foreach (var e in tracked)
                if (e.manager.childLightIsAnimated[e.index]) { anyAnimated = true; break; }

            if (anyAnimated)
            {
                DrawSharedDropdown(
                    tracked, "Model",
                    "Physical model driving the intensity animation.",
                    StyleNames,
                    e => e.manager.childLightAnimationModel[e.index],
                    (e, v) => e.manager.childLightAnimationModel[e.index] = v);

                bool anyFluorescent = false;
                foreach (var e in tracked)
                    if (e.manager.childLightAnimationModel[e.index] == 0) { anyFluorescent = true; break; }

                if (anyFluorescent)
                {
                    DrawSharedToggle(
                        tracked, "Is Broken",
                        "When enabled, the fluorescent light enters a broken cycle: off, attempts to start (rarely succeeds), stays on briefly, then fails again.",
                        e => e.manager.childLightIsBroken[e.index],
                        (e, v) => e.manager.childLightIsBroken[e.index] = v);

                    DrawSharedSlider(
                        tracked, "Failure Rate",
                        "Controls the time the light stays off before attempting a restart. 0 = long off time, 1 = short off time.",
                        0f, 1f,
                        e => e.manager.childLightFailureRate[e.index],
                        (e, v) => e.manager.childLightFailureRate[e.index] = v);
                }

                // ── Audio override ────────────────────────────────────────────

                EditorGUILayout.Space(4);
                EditorGUILayout.LabelField("Audio (optional override)", EditorStyles.miniBoldLabel);

                bool hasOverride = false;
                if (tracked.Count == 1)
                {
                    var e = tracked[0];
                    bool ov = e.manager.childLightAudioClipOverride != null
                           && e.index < e.manager.childLightAudioClipOverride.Length
                           && e.manager.childLightAudioClipOverride[e.index] != null;
                    hasOverride = ov;

                    int model = e.manager.childLightAnimationModel[e.index];
                    string defaultInfo = model == 0
                        ? "Model default: Fluorescent clip (assigned on manager)"
                        : "Model default: Incandescent clip (assigned on manager, usually silent)";

                    if (!hasOverride)
                    {
                        EditorGUILayout.HelpBox(defaultInfo, MessageType.None);
                    }
                }

                DrawSharedAudioClipField(
                    tracked,
                    "Clip Override",
                    "Optional: replaces the model-default clip for this specific light. Leave None to use the manager's model clip.",
                    e => (e.manager.childLightAudioClipOverride != null &&
                          e.index < e.manager.childLightAudioClipOverride.Length)
                         ? e.manager.childLightAudioClipOverride[e.index] : null,
                    (e, v) =>
                    {
                        if (e.manager.childLightAudioClipOverride != null &&
                            e.index < e.manager.childLightAudioClipOverride.Length)
                            e.manager.childLightAudioClipOverride[e.index] = v;
                    });

                if (tracked.Count == 1)
                {
                    var e = tracked[0];
                    AudioSource src = e.light.GetComponent<AudioSource>();
                    if (src == null)
                    {
                        EditorGUILayout.HelpBox(
                            "No AudioSource found on this Light. Add one (3D, loop) to enable spatial audio.",
                            MessageType.Warning);

                        if (GUILayout.Button("Add AudioSource"))
                        {
                            Undo.AddComponent<AudioSource>(e.light.gameObject);
                            AudioSource added = e.light.GetComponent<AudioSource>();
                            added.spatialBlend = 1f;
                            added.loop = true;
                            added.playOnAwake = false;
                            added.volume = 0f;
                            EditorUtility.SetDirty(e.light.gameObject);
                        }
                    }
                    else
                    {
                        EditorGUI.BeginDisabledGroup(true);
                        EditorGUILayout.FloatField("Spatial Blend", src.spatialBlend);
                        EditorGUILayout.FloatField("Max Distance", src.maxDistance);
                        EditorGUI.EndDisabledGroup();

                        if (!Mathf.Approximately(src.spatialBlend, 1f))
                        {
                            EditorGUILayout.HelpBox(
                                "Spatial Blend is not 1 — audio will not be fully 3D.",
                                MessageType.Warning);
                        }
                    }
                }
            }
        }

        if (untracked.Count > 0)
        {
            string names = string.Join(", ", untracked.ToArray());
            EditorGUILayout.HelpBox(
                tracked.Count > 0
                    ? $"Not yet tracked by a LayeredLightingManager: {names}."
                    : $"{names} is not tracked by any LayeredLightingManager in the scene.",
                MessageType.Info);
        }

        EditorGUI.indentLevel--;
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Shared control helpers
    // ─────────────────────────────────────────────────────────────────────────

    private static void DrawSharedToggle(
        List<Entry> entries, string label, string tooltip,
        System.Func<Entry, bool> getValue,
        System.Action<Entry, bool> setValue)
    {
        bool first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
            if (getValue(entries[i]) != first) { mixed = true; break; }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        bool newValue = EditorGUILayout.Toggle(new GUIContent(label, tooltip), first);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
            CommitChange(entries, "Change " + label, e => setValue(e, newValue));
    }

    private static void DrawSharedDropdown(
        List<Entry> entries, string label, string tooltip, string[] options,
        System.Func<Entry, int> getValue,
        System.Action<Entry, int> setValue)
    {
        int first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
            if (getValue(entries[i]) != first) { mixed = true; break; }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        int newValue = EditorGUILayout.Popup(new GUIContent(label, tooltip), first, options);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
            CommitChange(entries, "Change " + label, e => setValue(e, newValue));
    }

    private static void DrawSharedSlider(
        List<Entry> entries, string label, string tooltip, float min, float max,
        System.Func<Entry, float> getValue,
        System.Action<Entry, float> setValue)
    {
        float first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
            if (!Mathf.Approximately(getValue(entries[i]), first)) { mixed = true; break; }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        float newValue = EditorGUILayout.Slider(new GUIContent(label, tooltip), first, min, max);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
            CommitChange(entries, "Change " + label, e => setValue(e, newValue));
    }

    private static void DrawSharedAudioClipField(
        List<Entry> entries, string label, string tooltip,
        System.Func<Entry, AudioClip> getValue,
        System.Action<Entry, AudioClip> setValue)
    {
        AudioClip first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
            if (getValue(entries[i]) != first) { mixed = true; break; }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        var newValue = (AudioClip)EditorGUILayout.ObjectField(
            new GUIContent(label, tooltip), first, typeof(AudioClip), false);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
            CommitChange(entries, "Change " + label, e => setValue(e, newValue));
    }

    // ── Generic undo-aware commit ─────────────────────────────────────────────

    private static void CommitChange(
        List<Entry> entries, string undoLabel,
        System.Action<Entry> apply)
    {
        var managers = new HashSet<LayeredLightingManager>();
        foreach (var e in entries) managers.Add(e.manager);

        foreach (var mgr in managers) Undo.RecordObject(mgr, undoLabel);
        foreach (var e in entries) apply(e);
        foreach (var mgr in managers) EditorUtility.SetDirty(mgr);
    }

    // ── Manager lookup ────────────────────────────────────────────────────────

    private static LayeredLightingManager FindManagerFor(Light light, out int index)
    {
        index = -1;
        LayeredLightingManager[] managers =
            Object.FindObjectsOfType<LayeredLightingManager>(true);

        foreach (LayeredLightingManager mgr in managers)
        {
            if (mgr.childLights == null) continue;
            for (int i = 0; i < mgr.childLights.Length; i++)
            {
                if (mgr.childLights[i] == light)
                {
                    index = i;
                    return mgr;
                }
            }
        }
        return null;
    }
}
#endif