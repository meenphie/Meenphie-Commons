#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Light))]
[CanEditMultipleObjects]
public class LightSpecularInspector : Editor
{
    private Editor _defaultEditor;
    private bool _foldoutOpen = true;

    private static readonly string[] StyleNames = new string[]
    {
        "0 - Normal",
        "1 - Flicker A",
        "2 - Slow, strong pulse",
        "3 - Candle A",
        "4 - Fast strobe",
        "5 - Gentle pulse",
        "6 - Flicker B",
        "7 - Candle B",
        "8 - Candle C",
        "9 - Slow strobe",
        "10 - Fluorescent flicker",
        "11 - Slow pulse, no black"
    };

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

    public override void OnInspectorGUI()
    {
        if (_defaultEditor != null)
            _defaultEditor.OnInspectorGUI();
        else
            base.OnInspectorGUI();

        EditorGUILayout.Space(6);
        DrawSpecularsFoldout();
    }

    private struct Entry
    {
        public SpecularLightManager manager;
        public int index;
        public Light light;
    }

    private void DrawSpecularsFoldout()
    {
        _foldoutOpen = EditorGUILayout.BeginFoldoutHeaderGroup(_foldoutOpen, "Speculars");
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

            SpecularLightManager mgr = FindManagerFor(light, out int index);
            if (mgr == null || index < 0 ||
                mgr.childLightIsRealtime == null || index >= mgr.childLightIsRealtime.Length ||
                mgr.childLightDiffuseEnabled == null || index >= mgr.childLightDiffuseEnabled.Length ||
                mgr.childLightSpecularEnabled == null || index >= mgr.childLightSpecularEnabled.Length ||
                mgr.childLightIsAnimated == null || index >= mgr.childLightIsAnimated.Length ||
                mgr.childLightStyleIndex == null || index >= mgr.childLightStyleIndex.Length ||
                mgr.childLightAnimationSpeed == null || index >= mgr.childLightAnimationSpeed.Length)
            {
                untracked.Add(light.gameObject.name);
                continue;
            }

            tracked.Add(new Entry { manager = mgr, index = index, light = light });
        }

        if (tracked.Count > 0)
        {
            DrawSharedToggle(
                tracked,
                "Is Realtime",
                "Forces the selected light(s) into the analytic (non-lightmap) diffuse branch.",
                e => e.manager.childLightIsRealtime[e.index],
                (e, v) => e.manager.childLightIsRealtime[e.index] = v);

            DrawSharedToggle(
                tracked,
                "Diffuse",
                "Include the selected light(s) in the diffuse channel.",
                e => e.manager.childLightDiffuseEnabled[e.index],
                (e, v) => e.manager.childLightDiffuseEnabled[e.index] = v);

            DrawSharedToggle(
                tracked,
                "Specular",
                "Include the selected light(s) in the specular channel.",
                e => e.manager.childLightSpecularEnabled[e.index],
                (e, v) => e.manager.childLightSpecularEnabled[e.index] = v);

            EditorGUILayout.Space(4);

            // Animation Settings
            DrawSharedToggle(
                tracked,
                "Is Animated",
                "Applies a classic Quake/Doom-style flicker or pulse.",
                e => e.manager.childLightIsAnimated[e.index],
                (e, v) => e.manager.childLightIsAnimated[e.index] = v);

            bool anyAnimated = false;
            foreach (var e in tracked)
            {
                if (e.manager.childLightIsAnimated[e.index])
                {
                    anyAnimated = true;
                    break;
                }
            }

            if (anyAnimated)
            {
                DrawSharedDropdown(
                    tracked,
                    "Animation Style",
                    "The specific flicker/pulse sequence.",
                    StyleNames,
                    e => e.manager.childLightStyleIndex[e.index],
                    (e, v) => e.manager.childLightStyleIndex[e.index] = v);

                // --- Per‑light animation speed ---
                DrawSharedSlider(
                    tracked,
                    "Animation Speed",
                    "Multiplier for the style’s step rate. 1 = original 10 Hz; 0.5 = half speed.",
                    0.1f, 5.0f,
                    e => e.manager.childLightAnimationSpeed[e.index],
                    (e, v) => e.manager.childLightAnimationSpeed[e.index] = v);
            }
        }

        if (untracked.Count > 0)
        {
            string names = string.Join(", ", untracked);
            EditorGUILayout.HelpBox(
                tracked.Count > 0
                    ? $"Not yet tracked by a SpecularLightManager: {names}. They'll appear automatically shortly."
                    : $"{names} not tracked by any SpecularLightManager in the scene yet. It should appear automatically within a moment — if it doesn't, check that a SpecularLightManager exists in the scene.",
                MessageType.Info);
        }

        EditorGUI.indentLevel--;
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    private static void DrawSharedToggle(
        List<Entry> entries,
        string label,
        string tooltip,
        System.Func<Entry, bool> getValue,
        System.Action<Entry, bool> setValue)
    {
        bool first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
        {
            if (getValue(entries[i]) != first) { mixed = true; break; }
        }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        bool newValue = EditorGUILayout.Toggle(new GUIContent(label, tooltip), first);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
        {
            var touchedManagers = new HashSet<SpecularLightManager>();
            foreach (Entry e in entries) touchedManagers.Add(e.manager);

            foreach (SpecularLightManager mgr in touchedManagers) Undo.RecordObject(mgr, "Change Specular Light Settings");
            foreach (Entry e in entries) setValue(e, newValue);
            foreach (SpecularLightManager mgr in touchedManagers) EditorUtility.SetDirty(mgr);
        }
    }

    private static void DrawSharedDropdown(
        List<Entry> entries,
        string label,
        string tooltip,
        string[] options,
        System.Func<Entry, int> getValue,
        System.Action<Entry, int> setValue)
    {
        int first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
        {
            if (getValue(entries[i]) != first) { mixed = true; break; }
        }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        int newValue = EditorGUILayout.Popup(new GUIContent(label, tooltip), first, options);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
        {
            var touchedManagers = new HashSet<SpecularLightManager>();
            foreach (Entry e in entries) touchedManagers.Add(e.manager);

            foreach (SpecularLightManager mgr in touchedManagers) Undo.RecordObject(mgr, "Change Specular Light Animation");
            foreach (Entry e in entries) setValue(e, newValue);
            foreach (SpecularLightManager mgr in touchedManagers) EditorUtility.SetDirty(mgr);
        }
    }

    private static void DrawSharedSlider(
        List<Entry> entries,
        string label,
        string tooltip,
        float min, float max,
        System.Func<Entry, float> getValue,
        System.Action<Entry, float> setValue)
    {
        float first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
        {
            if (!Mathf.Approximately(getValue(entries[i]), first)) { mixed = true; break; }
        }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        float newValue = EditorGUILayout.Slider(new GUIContent(label, tooltip), first, min, max);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
        {
            var touchedManagers = new HashSet<SpecularLightManager>();
            foreach (Entry e in entries) touchedManagers.Add(e.manager);

            foreach (SpecularLightManager mgr in touchedManagers) Undo.RecordObject(mgr, "Change Animation Speed");
            foreach (Entry e in entries) setValue(e, newValue);
            foreach (SpecularLightManager mgr in touchedManagers) EditorUtility.SetDirty(mgr);
        }
    }

    private static SpecularLightManager FindManagerFor(Light light, out int index)
    {
        index = -1;
        SpecularLightManager[] managers = Object.FindObjectsOfType<SpecularLightManager>(true);

        Debug.Log($"FindManagerFor: Looking for {light.name} | Managers found: {managers.Length}");

        foreach (SpecularLightManager mgr in managers)
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