using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Light))]
[CanEditMultipleObjects]
public class LightInspector : Editor
{
    private Editor _defaultEditor;
    private bool _foldoutOpen = true;

    // Dérivé de l'enum du manager : reste synchronisé si un état est ajouté.
    private static readonly string[] FaultStateNames = System.Enum.GetNames(typeof(LightFaultState));

    // FindObjectsOfType à chaque événement IMGUI (plusieurs par frame, un de plus à chaque mouvement de souris)
    // coûte cher dans une grosse scène : on garde la liste une seconde.
    private static LightingManager[] _managers;
    private static double _managersTime = -10.0;
    private const double ManagerCacheSeconds = 1.0;

    // En Play, le LightingManager que voit cet éditeur est le proxy C# : MarkDirty() s'exécuterait sur lui et pas dans
    // le programme Udon qui tourne. SendCustomEvent (hérité d'UdonSharpBehaviour) envoie l'événement au programme.
    private static readonly System.Reflection.MethodInfo SendCustomEventMethod =
        typeof(LightingManager).GetMethod("SendCustomEvent", new[] { typeof(string) });

    // ── Lifecycle ──────────────────────────────────────────────────────────
    private void OnSceneGUI()
    {
        var method = _defaultEditor?.GetType().GetMethod("OnSceneGUI",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        method?.Invoke(_defaultEditor, null);
    }

    private void OnEnable()
    {
        _managers = null;
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
        EditorGUI.BeginChangeCheck();
        if (_defaultEditor != null)
            _defaultEditor.OnInspectorGUI();
        else
            base.OnInspectorGUI();
        bool lightEdited = EditorGUI.EndChangeCheck();

        // Intensité, couleur, type... modifiés dans la partie standard : l'aperçu en mode Édition doit suivre.
        if (lightEdited) QueuePreviewForSelection();

        EditorGUILayout.Space(6);
        DrawLayeredLightingFoldout();
    }

    // U# compile tout l'assembly (inspector compris) avec COMPILER_UDONSHARP défini : QueuePreviewRefresh n'existe que
    // dans le bloc éditeur du manager, donc les appels sont gardés de la même façon.
    private void QueuePreviewForSelection()
    {
#if !COMPILER_UDONSHARP
        if (Application.isPlaying) return;

        var seen = new HashSet<LightingManager>();
        foreach (Object t in targets)
        {
            Light light = t as Light;
            if (light == null) continue;

            int index;
            LightingManager mgr = FindManagerFor(light, out index);
            if (mgr != null && seen.Add(mgr)) mgr.QueuePreviewRefresh();
        }
#endif
    }

    // ── Entry struct ───────────────────────────────────────────────────────

    private struct Entry
    {
        public LightingManager manager;
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

            int index;
            LightingManager mgr = FindManagerFor(light, out index);

            if (!IsTracked(mgr, index))
            {
                untracked.Add(light.gameObject.name);
                continue;
            }

            tracked.Add(new Entry { manager = mgr, index = index, light = light });
        }

        if (tracked.Count > 0)
        {
            DrawIgnoredNotice(tracked);
            DrawRenderingSection(tracked);
            DrawCookieSection(tracked);
            DrawAnimationSection(tracked);
        }

        if (untracked.Count > 0)
        {
            string names = string.Join(", ", untracked.ToArray());
            EditorGUILayout.HelpBox(
                tracked.Count > 0
                    ? $"Not yet tracked by a LightingManager: {names}."
                    : $"{names} is not tracked by any LightingManager in the scene.",
                MessageType.Info);
        }

        EditorGUI.indentLevel--;
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    // ── Sections ───────────────────────────────────────────────────────────

    // Le manager n'envoie jamais au shader les lights directionnelles ni celles en Render Mode "Not Important".
    private static void DrawIgnoredNotice(List<Entry> tracked)
    {
        var names = new List<string>();
        foreach (var e in tracked)
            if (e.light.type == LightType.Directional || e.light.renderMode == LightRenderMode.ForceVertex)
                names.Add(e.light.gameObject.name);

        if (names.Count == 0) return;

        EditorGUILayout.HelpBox(
            "Ignorée(s) par le LightingManager (directionnelle, ou Render Mode = Not Important) : "
            + string.Join(", ", names.ToArray()) + ". Les réglages ci-dessous n'ont aucun effet pour elles.",
            MessageType.Warning);
    }

    private static void DrawRenderingSection(List<Entry> tracked)
    {
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

        DrawSharedToggle(
            tracked, "Casts Shadow",
            "Marque la lumière comme éligible à un slot du shadow atlas (ShadowAtlasCaster), " +
            "indépendamment du Shadow Type natif du composant Light.",
            e => e.manager.childLightCastsShadow[e.index],
            (e, v) => e.manager.childLightCastsShadow[e.index] = v);

        // Cohérence realtime / lightmap : une light "baked" sans slice n'ajoute aucun diffus ;
        // une light "realtime" ignore la lightmap bakée qui existe pour elle.
        int bakedNoSlice = 0, realtimeWithSlice = 0;
        foreach (var e in tracked)
        {
            bool realtime = e.manager.childLightIsRealtime[e.index];
            int slice = SliceOf(e);
            if (!realtime && slice < 0) bakedNoSlice++;
            if (realtime && slice >= 0) realtimeWithSlice++;
        }

        if (tracked.Count == 1)
        {
            int slice = SliceOf(tracked[0]);
            EditorGUILayout.LabelField("Lightmap slice", slice >= 0 ? slice.ToString() : "aucune (-1)");
        }

        if (bakedNoSlice > 0)
            EditorGUILayout.HelpBox(
                bakedNoSlice + " light(s) en Baked sans lightmap slice : elles n'ajoutent aucun diffus (spéculaire seulement). " +
                "Relance le bake des layers, ou coche Is Realtime.",
                MessageType.Warning);

        if (realtimeWithSlice > 0)
            EditorGUILayout.HelpBox(
                realtimeWithSlice + " light(s) en Realtime alors qu'une lightmap bakée existe : elle est ignorée, " +
                "la light passe par le diffus analytique.",
                MessageType.Info);
    }

    private static void DrawCookieSection(List<Entry> tracked)
    {
        EditorGUILayout.Space(6);
        EditorGUILayout.LabelField("Cookie", EditorStyles.boldLabel);

        // On ne modifie plus les tableaux pendant le dessin (le simple fait de sélectionner une light salissait la scène).
        bool arraysOk = true;
        foreach (var e in tracked)
            if (!CookieArraysOk(e.manager)) { arraysOk = false; break; }

        if (!arraysOk)
        {
            EditorGUILayout.HelpBox("Les tableaux de cookies n'ont pas la taille de childLights.", MessageType.Warning);
            if (GUILayout.Button("Redimensionner les tableaux de cookies"))
                FixCookieArrays(tracked);
            return;
        }

        DrawSharedObjectField(
            tracked, "Cookie Texture",
            "Assign a Texture2D cookie. It will be used on dynamic meshes and for lights marked as realtime.",
            e => e.manager.childLightCookieTexture[e.index],
            (e, v) => e.manager.childLightCookieTexture[e.index] = v,
            false);   // pas d'effet runtime direct : la texture sert au bake du tableau de cookies

        bool allPoint = true;
        foreach (var e in tracked)
            if (e.light.type != LightType.Point) { allPoint = false; break; }

        if (allPoint)
        {
            EditorGUILayout.HelpBox("Les lights Point ignorent les cookies (seuls Spot et Area en utilisent).", MessageType.Info);
        }
        else if (tracked.Count == 1
                 && tracked[0].manager.childLightIsRealtime[tracked[0].index]
                 && tracked[0].manager.childLightCookieTexture[tracked[0].index] == null)
        {
            EditorGUILayout.HelpBox(
                "No cookie texture assigned. Use the Cookie Texture field above to assign a Texture2D.",
                MessageType.Info);
        }
    }

    private static void DrawAnimationSection(List<Entry> tracked)
    {
        EditorGUILayout.Space(6);
        EditorGUILayout.LabelField("Animation", EditorStyles.boldLabel);

        DrawSharedDropdown(
            tracked, "State",
            "Normal: not animated.\nBroken: slow irregular blink with smooth fade.\nPanic: rapid erratic flicker at random intensities.\nOff: forced to zero intensity.",
            FaultStateNames,
            e => (int)e.manager.childLightFaultState[e.index],
            (e, v) => e.manager.childLightFaultState[e.index] = (LightFaultState)v);   // changer d'état => rebuild

        bool anyBroken = false, anyPanic = false;
        foreach (var e in tracked)
        {
            var s = e.manager.childLightFaultState[e.index];
            if (s == LightFaultState.Broken) anyBroken = true;
            if (s == LightFaultState.Panic) anyPanic = true;
        }

        // Les curseurs de timing ne demandent pas de rebuild : le manager relit ces tableaux à chaque tick.
        if (anyBroken)
        {
            EditorGUILayout.Space(4);
            EditorGUILayout.LabelField("Broken timing", EditorStyles.miniBoldLabel);

            DrawSharedSlider(
                tracked, "On min",
                "Minimum duration (seconds) the light stays on per blink.",
                0.001f, 5f,
                e => e.manager.childLightBrokenOnMin[e.index],
                (e, v) => e.manager.childLightBrokenOnMin[e.index] = v, false);

            DrawSharedSlider(
                tracked, "On max",
                "Maximum duration (seconds) the light stays on per blink.",
                0.001f, 5f,
                e => e.manager.childLightBrokenOnMax[e.index],
                (e, v) => e.manager.childLightBrokenOnMax[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Off min",
                "Minimum duration (seconds) the light stays off per blink.",
                0.001f, 5f,
                e => e.manager.childLightBrokenOffMin[e.index],
                (e, v) => e.manager.childLightBrokenOffMin[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Off max",
                "Maximum duration (seconds) the light stays off per blink.",
                0.001f, 5f,
                e => e.manager.childLightBrokenOffMax[e.index],
                (e, v) => e.manager.childLightBrokenOffMax[e.index] = v, false);

            DrawSharedSlider(
                tracked, "On intensity",
                "Intensity multiplier (0–1) applied to the light's base intensity when it is in its on-phase.",
                0f, 1f,
                e => e.manager.childLightBrokenOnIntensity[e.index],
                (e, v) => e.manager.childLightBrokenOnIntensity[e.index] = v, false);

            EditorGUILayout.Space(4);
            EditorGUILayout.LabelField("Broken organic texture", EditorStyles.miniBoldLabel);

            DrawSharedSlider(
                tracked, "Noise amount",
                "Depth of the low-frequency breathing applied during the ON phase. 0 = flat, 1 = very alive.",
                0f, 1f,
                e => e.manager.childLightBrokenNoiseAmount[e.index],
                (e, v) => e.manager.childLightBrokenNoiseAmount[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Ember",
                "Residual warm glow during the OFF phase. 0 = pure black, 0.2 = hot filament still cooling.",
                0f, 0.2f,
                e => e.manager.childLightBrokenEmber[e.index],
                (e, v) => e.manager.childLightBrokenEmber[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Sputter",
                "Turn-on catch + dying flicker intensity. 0 = clean, 1 = violent struggle.",
                0f, 1f,
                e => e.manager.childLightBrokenSputter[e.index],
                (e, v) => e.manager.childLightBrokenSputter[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Fade speed",
                "How fast the intensity reaches its target each tick. Low values (3-6) make the organic texture visible; high (>15) looks binary.",
                1f, 30f,
                e => e.manager.childLightBrokenFadeSpeed[e.index],
                (e, v) => e.manager.childLightBrokenFadeSpeed[e.index] = v, false);
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
                (e, v) => e.manager.childLightPanicSpeed[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Intensity min",
                "Minimum random multiplier applied to the light's base intensity during a Panic on-phase. Values above 1 overshoot the base intensity.",
                0f, 2f,
                e => e.manager.childLightPanicIntensityMin[e.index],
                (e, v) => e.manager.childLightPanicIntensityMin[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Intensity max",
                "Maximum random multiplier applied to the light's base intensity during a Panic on-phase. Values above 1 overshoot the base intensity.",
                0f, 2f,
                e => e.manager.childLightPanicIntensityMax[e.index],
                (e, v) => e.manager.childLightPanicIntensityMax[e.index] = v, false);

            EditorGUILayout.Space(4);
            EditorGUILayout.LabelField("Panic organic texture", EditorStyles.miniBoldLabel);

            DrawSharedSlider(
                tracked, "Noise amount",
                "Depth of the high-frequency jitter during an ON phase. 0 = clean strobe, 1 = violently alive.",
                0f, 1f,
                e => e.manager.childLightPanicNoiseAmount[e.index],
                (e, v) => e.manager.childLightPanicNoiseAmount[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Ghost rate",
                "Probability per second of a sudden near-death spike during an ON phase.",
                0f, 3f,
                e => e.manager.childLightPanicGhostRate[e.index],
                (e, v) => e.manager.childLightPanicGhostRate[e.index] = v, false);

            DrawSharedSlider(
                tracked, "Ember",
                "Residual warm glow during an OFF phase. 0 = pure black, 0.2 = hot filament.",
                0f, 0.2f,
                e => e.manager.childLightPanicEmber[e.index],
                (e, v) => e.manager.childLightPanicEmber[e.index] = v, false);
        }

        if (anyBroken || anyPanic)
            DrawAudioSection(tracked);
    }

    private static void DrawAudioSection(List<Entry> tracked)
    {
        EditorGUILayout.Space(4);
        EditorGUILayout.LabelField("Audio (optional override)", EditorStyles.miniBoldLabel);

        if (tracked.Count == 1)
        {
            var e = tracked[0];
            bool hasOverride = Has(e.manager.childLightAudioClipOverride, e.index)
                               && e.manager.childLightAudioClipOverride[e.index] != null;
            if (!hasOverride)
                EditorGUILayout.HelpBox("Default: the manager's fault audio clip.", MessageType.None);
        }

        DrawSharedAudioClipField(
            tracked,
            "Clip Override",
            "Replaces the manager's default fault clip for this specific light. Leave None to use the manager's clip.",
            e => Has(e.manager.childLightAudioClipOverride, e.index) ? e.manager.childLightAudioClipOverride[e.index] : null,
            (e, v) =>
            {
                if (Has(e.manager.childLightAudioClipOverride, e.index))
                    e.manager.childLightAudioClipOverride[e.index] = v;
            },
            false);   // lu par le manager au démarrage du son

        if (tracked.Count != 1) return;

        var single = tracked[0];
        AudioSource src = single.light.GetComponent<AudioSource>();
        if (src == null)
        {
            EditorGUILayout.HelpBox(
                "No AudioSource found on this Light. Add one (3D, loop) to enable spatial audio.",
                MessageType.Warning);

            if (GUILayout.Button("Add AudioSource"))
            {
                Undo.AddComponent<AudioSource>(single.light.gameObject);
                AudioSource added = single.light.GetComponent<AudioSource>();
                added.spatialBlend = 1f;
                added.loop = true;
                added.playOnAwake = false;
                added.volume = 0f;
                EditorUtility.SetDirty(single.light.gameObject);
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

    // ── Data helpers ───────────────────────────────────────────────────────

    private static bool Has<T>(T[] arr, int index)
    {
        return arr != null && index >= 0 && index < arr.Length;
    }

    private static int SliceOf(Entry e)
    {
        return Has(e.manager.childLightLayerSlices, e.index) ? e.manager.childLightLayerSlices[e.index] : -1;
    }

    private static bool IsTracked(LightingManager mgr, int index)
    {
        return mgr != null && index >= 0
            && Has(mgr.childLightIsRealtime, index)
            && Has(mgr.childLightDiffuseEnabled, index)
            && Has(mgr.childLightSpecularDistance, index)
            && Has(mgr.childLightCastsShadow, index)
            && Has(mgr.childLightFaultState, index)
            && Has(mgr.childLightBrokenOnMin, index)
            && Has(mgr.childLightBrokenOnMax, index)
            && Has(mgr.childLightBrokenOffMin, index)
            && Has(mgr.childLightBrokenOffMax, index)
            && Has(mgr.childLightBrokenOnIntensity, index)
            && Has(mgr.childLightBrokenNoiseAmount, index)
            && Has(mgr.childLightBrokenEmber, index)
            && Has(mgr.childLightBrokenSputter, index)
            && Has(mgr.childLightBrokenFadeSpeed, index)
            && Has(mgr.childLightPanicSpeed, index)
            && Has(mgr.childLightPanicIntensityMin, index)
            && Has(mgr.childLightPanicIntensityMax, index)
            && Has(mgr.childLightPanicNoiseAmount, index)
            && Has(mgr.childLightPanicGhostRate, index)
            && Has(mgr.childLightPanicEmber, index);
    }

    private static bool CookieArraysOk(LightingManager mgr)
    {
        int cap = mgr.childLights.Length;
        return mgr.childLightCookieTexture != null && mgr.childLightCookieTexture.Length == cap
            && mgr.childLightCookieSlice != null && mgr.childLightCookieSlice.Length == cap;
    }

    private static void FixCookieArrays(List<Entry> entries)
    {
        var managers = new HashSet<LightingManager>();
        foreach (var e in entries) managers.Add(e.manager);

        foreach (var mgr in managers)
        {
            Undo.RecordObject(mgr, "Resize cookie arrays");
            EnsureCookieArraysSized(mgr, mgr.childLights.Length);
            EditorUtility.SetDirty(mgr);
        }
    }

    private static void EnsureCookieArraysSized(LightingManager mgr, int cap)
    {
        if (mgr.childLightCookieTexture == null || mgr.childLightCookieTexture.Length != cap)
        {
            var newTex = new Texture2D[cap];
            if (mgr.childLightCookieTexture != null)
            {
                int copyLen = Mathf.Min(mgr.childLightCookieTexture.Length, cap);
                System.Array.Copy(mgr.childLightCookieTexture, newTex, copyLen);
            }
            mgr.childLightCookieTexture = newTex;
        }

        if (mgr.childLightCookieSlice == null || mgr.childLightCookieSlice.Length != cap)
        {
            var newSlice = new int[cap];
            int oldLen = 0;
            if (mgr.childLightCookieSlice != null)
            {
                oldLen = Mathf.Min(mgr.childLightCookieSlice.Length, cap);
                System.Array.Copy(mgr.childLightCookieSlice, newSlice, oldLen);
            }
            for (int i = oldLen; i < cap; i++) newSlice[i] = -1;
            mgr.childLightCookieSlice = newSlice;
        }
    }

    // ── Shared control helpers ─────────────────────────────────────────────
    // needsRebuild : true si le manager doit reconstruire ses données fusionnées pour voir le changement
    // (flags, état de panne). Les paramètres de timing et d'audio sont relus à chaque tick : false.

    private static void DrawSharedToggle(
        List<Entry> entries, string label, string tooltip,
        System.Func<Entry, bool> getValue,
        System.Action<Entry, bool> setValue,
        bool needsRebuild = true)
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
            CommitChange(entries, "Change " + label, e => setValue(e, newValue), needsRebuild);
    }

    private static void DrawSharedDropdown(
        List<Entry> entries, string label, string tooltip, string[] options,
        System.Func<Entry, int> getValue,
        System.Action<Entry, int> setValue,
        bool needsRebuild = true)
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
            CommitChange(entries, "Change " + label, e => setValue(e, newValue), needsRebuild);
    }

    private static void DrawSharedSlider(
        List<Entry> entries, string label, string tooltip, float min, float max,
        System.Func<Entry, float> getValue,
        System.Action<Entry, float> setValue,
        bool needsRebuild = true)
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
            CommitChange(entries, "Change " + label, e => setValue(e, newValue), needsRebuild);
    }

    private static void DrawSharedAudioClipField(
        List<Entry> entries, string label, string tooltip,
        System.Func<Entry, AudioClip> getValue,
        System.Action<Entry, AudioClip> setValue,
        bool needsRebuild = true)
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
            CommitChange(entries, "Change " + label, e => setValue(e, newValue), needsRebuild);
    }

    private static void DrawSharedObjectField(
        List<Entry> entries, string label, string tooltip,
        System.Func<Entry, Texture2D> getValue,
        System.Action<Entry, Texture2D> setValue,
        bool needsRebuild = true)
    {
        Texture2D first = getValue(entries[0]);
        bool mixed = false;
        for (int i = 1; i < entries.Count; i++)
            if (getValue(entries[i]) != first) { mixed = true; break; }

        EditorGUI.showMixedValue = mixed;
        EditorGUI.BeginChangeCheck();
        var newValue = (Texture2D)EditorGUILayout.ObjectField(
            new GUIContent(label, tooltip), first, typeof(Texture2D), false);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
            CommitChange(entries, "Change " + label, e => setValue(e, newValue), needsRebuild);
    }

    // ── Generic undo-aware commit ──────────────────────────────────────────

    private static void CommitChange(
        List<Entry> entries, string undoLabel,
        System.Action<Entry> apply, bool needsRebuild)
    {
        var managers = new HashSet<LightingManager>();
        foreach (var e in entries) managers.Add(e.manager);

        foreach (var mgr in managers) Undo.RecordObject(mgr, undoLabel);
        foreach (var e in entries) apply(e);
        foreach (var mgr in managers)
        {
            EditorUtility.SetDirty(mgr);
            if (needsRebuild) RequestRebuild(mgr);
        }
    }

    private static void RequestRebuild(LightingManager mgr)
    {
        if (!Application.isPlaying)
        {
#if !COMPILER_UDONSHARP
            mgr.QueuePreviewRefresh();   // hors Play le manager ne tourne pas : on met à jour l'aperçu du shader
#endif
            return;
        }

        try
        {
            if (SendCustomEventMethod != null)
            {
                SendCustomEventMethod.Invoke(mgr, new object[] { "MarkDirty" });
                return;
            }
        }
        catch (System.Exception) { }

        mgr.MarkDirty();   // repli : au pire, sans effet sur le programme Udon
    }

    // ── Manager lookup ─────────────────────────────────────────────────────

    private static LightingManager[] GetManagers()
    {
        double now = EditorApplication.timeSinceStartup;
        if (_managers == null || now - _managersTime > ManagerCacheSeconds)
        {
            _managers = Object.FindObjectsOfType<LightingManager>(true);
            _managersTime = now;
        }
        return _managers;
    }

    private static LightingManager FindManagerFor(Light light, out int index)
    {
        index = -1;
        LightingManager[] managers = GetManagers();

        for (int m = 0; m < managers.Length; m++)
        {
            LightingManager mgr = managers[m];
            if (mgr == null || mgr.childLights == null) continue;   // détruit depuis la mise en cache
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