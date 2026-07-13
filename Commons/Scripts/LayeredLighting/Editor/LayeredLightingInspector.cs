#if UNITY_EDITOR && UDONSHARP
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Light))]
[CanEditMultipleObjects]
public class LayeredLightingInspector : Editor
{
    private Editor _defaultEditor;
    private bool _foldoutOpen = true;

    private static readonly string[] FaultStateNames = { "Normal", "Broken", "Panic", "Off" };

    // ── Lifecycle ──────────────────────────────────────────────────────────
    private void OnSceneGUI()
    {
        var method = _defaultEditor?.GetType().GetMethod("OnSceneGUI",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        method?.Invoke(_defaultEditor, null);
    }

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

    // ── Main GUI ───────────────────────────────────────────────────────────

    public override void OnInspectorGUI()
    {
        if (_defaultEditor != null)
            _defaultEditor.OnInspectorGUI();
        else
            base.OnInspectorGUI();

        EditorGUILayout.Space(6);
        DrawLayeredLightingFoldout();
    }

    // ── Entry struct ───────────────────────────────────────────────────────

    private struct Entry
    {
        public LayeredLightingManager manager;
        public int index;
        public Light light;
    }

    // ── Foldout ────────────────────────────────────────────────────────────

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
                && mgr.childLightFaultState != null && index < mgr.childLightFaultState.Length
                && mgr.childLightBrokenOnMin != null && index < mgr.childLightBrokenOnMin.Length
                && mgr.childLightBrokenOnMax != null && index < mgr.childLightBrokenOnMax.Length
                && mgr.childLightBrokenOffMin != null && index < mgr.childLightBrokenOffMin.Length
                && mgr.childLightBrokenOffMax != null && index < mgr.childLightBrokenOffMax.Length
                && mgr.childLightBrokenOnIntensity != null && index < mgr.childLightBrokenOnIntensity.Length
                && mgr.childLightPanicSpeed != null && index < mgr.childLightPanicSpeed.Length
                && mgr.childLightPanicIntensityMin != null && index < mgr.childLightPanicIntensityMin.Length
                && mgr.childLightPanicIntensityMax != null && index < mgr.childLightPanicIntensityMax.Length;

            if (!valid)
            {
                untracked.Add(light.gameObject.name);
                continue;
            }

            tracked.Add(new Entry { manager = mgr, index = index, light = light });
        }

        if (tracked.Count > 0)
        {
            // ── Rendering ─────────────────────────────────────────────────

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

            // ── Animation ─────────────────────────────────────────────────

            EditorGUILayout.Space(6);
            EditorGUILayout.LabelField("Animation", EditorStyles.boldLabel);

            DrawSharedDropdown(
                tracked, "State",
                "Normal: not animated.\nBroken: slow irregular blink with smooth fade.\nPanic: rapid erratic flicker at random intensities.",
                FaultStateNames,
                e => (int)e.manager.childLightFaultState[e.index],
                (e, v) => e.manager.childLightFaultState[e.index] = (LightFaultState)v);

            // Determine which states are present across the selection
            bool anyBroken = false, anyPanic = false;
            foreach (var e in tracked)
            {
                var s = e.manager.childLightFaultState[e.index];
                if (s == LightFaultState.Broken) anyBroken = true;
                if (s == LightFaultState.Panic) anyPanic = true;
            }
            bool anyNonNormal = anyBroken || anyPanic;

            if (anyBroken)
            {
                EditorGUILayout.Space(4);
                EditorGUILayout.LabelField("Broken timing", EditorStyles.miniBoldLabel);

                DrawSharedSlider(
                    tracked, "On min",
                    "Minimum duration (seconds) the light stays on per blink.",
                    0.001f, 5f,
                    e => e.manager.childLightBrokenOnMin[e.index],
                    (e, v) => e.manager.childLightBrokenOnMin[e.index] = v);

                DrawSharedSlider(
                    tracked, "On max",
                    "Maximum duration (seconds) the light stays on per blink.",
                    0.001f, 5f,
                    e => e.manager.childLightBrokenOnMax[e.index],
                    (e, v) => e.manager.childLightBrokenOnMax[e.index] = v);

                DrawSharedSlider(
                    tracked, "Off min",
                    "Minimum duration (seconds) the light stays off per blink.",
                    0.001f, 5f,
                    e => e.manager.childLightBrokenOffMin[e.index],
                    (e, v) => e.manager.childLightBrokenOffMin[e.index] = v);

                DrawSharedSlider(
                    tracked, "Off max",
                    "Maximum duration (seconds) the light stays off per blink.",
                    0.001f, 5f,
                    e => e.manager.childLightBrokenOffMax[e.index],
                    (e, v) => e.manager.childLightBrokenOffMax[e.index] = v);

                DrawSharedSlider(
                    tracked, "On intensity",
                    "Intensity multiplier (0–1) applied to the light's base intensity when it is in its on-phase.",
                    0f, 1f,
                    e => e.manager.childLightBrokenOnIntensity[e.index],
                    (e, v) => e.manager.childLightBrokenOnIntensity[e.index] = v);
            }

            if (anyPanic)
            {
                EditorGUILayout.Space(4);
                EditorGUILayout.LabelField("Panic timing", EditorStyles.miniBoldLabel);

                DrawSharedSlider(
                    tracked, "Speed",
                    "Controls how fast the light flickers. 0 = slow sparse blinks, 1 = rapid near-continuous strobe. " +
                    "LightAnomalyController overwrites this at runtime based on proximity.",
                    0f, 1f,
                    e => e.manager.childLightPanicSpeed[e.index],
                    (e, v) => e.manager.childLightPanicSpeed[e.index] = v);

                DrawSharedSlider(
                    tracked, "Intensity min",
                    "Minimum random multiplier applied to the light's base intensity during a Panic on-phase. Values above 1 overshoot the base intensity.",
                    0f, 2f,
                    e => e.manager.childLightPanicIntensityMin[e.index],
                    (e, v) => e.manager.childLightPanicIntensityMin[e.index] = v);

                DrawSharedSlider(
                    tracked, "Intensity max",
                    "Maximum random multiplier applied to the light's base intensity during a Panic on-phase. Values above 1 overshoot the base intensity.",
                    0f, 2f,
                    e => e.manager.childLightPanicIntensityMax[e.index],
                    (e, v) => e.manager.childLightPanicIntensityMax[e.index] = v);
            }

            // ── Audio override ─────────────────────────────────────────────

            if (anyNonNormal)
            {
                EditorGUILayout.Space(4);
                EditorGUILayout.LabelField("Audio (optional override)", EditorStyles.miniBoldLabel);

                if (tracked.Count == 1)
                {
                    var e = tracked[0];
                    bool hasOverride = e.manager.childLightAudioClipOverride != null
                                   && e.index < e.manager.childLightAudioClipOverride.Length
                                   && e.manager.childLightAudioClipOverride[e.index] != null;
                    if (!hasOverride)
                        EditorGUILayout.HelpBox("Default: the manager's fault audio clip.", MessageType.None);
                }

                DrawSharedAudioClipField(
                    tracked,
                    "Clip Override",
                    "Replaces the manager's default fault clip for this specific light. Leave None to use the manager's clip.",
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
                            EditorGUILayout.HelpBox(
                                "Spatial Blend is not 1 — audio will not be fully 3D.",
                                MessageType.Warning);
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

    // ── Shared control helpers ─────────────────────────────────────────────

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

    // ── Generic undo-aware commit ──────────────────────────────────────────

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

    // ── Manager lookup ─────────────────────────────────────────────────────

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