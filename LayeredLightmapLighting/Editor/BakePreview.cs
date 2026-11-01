using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Preview toggles for the Bake Manager: switch each baked input on/off (Enabled / Disabled) to find which one breaks the look.
///
/// Lighting toggles (diffuse, specular, reflections, SSS, shadows...) already exist elsewhere and are NOT duplicated here.
/// This class only covers the mesh-array / material inputs:
///   - Global texture overrides (mesh arrays, emission, material table): scene-wide.
///   - Material keywords (_BUMPMAP, _METALLICMAP...): set in memory on the SHARED materials only.
///
/// "Enabled" = original value restored. "Disabled" = forced off. Everything is restored before an assembly reload,
/// before an asset save and on quit, so a debug state can't be serialized into the shared materials by accident.
/// </summary>
public static class BakePreview
{
    // ───────────────────────── Model ─────────────────────────

    public abstract class PreviewToggle
    {
        public readonly string Label, Tip;
        public bool Enabled { get; private set; } = true;

        protected PreviewToggle(string label, string tip) { Label = label; Tip = tip; }

        public void Set(bool enabled, IReadOnlyList<Material> mats)
        {
            Enabled = enabled;
            Apply(enabled, mats);
        }

        /// <summary>Re-applies a disabled state after a bake/apply recreated materials or rewrote globals.</summary>
        public void Reapply(IReadOnlyList<Material> mats)
        {
            if (!Enabled) Apply(false, mats);
        }

        public virtual string Status(IReadOnlyList<Material> mats) => "";
        protected abstract void Apply(bool enabled, IReadOnlyList<Material> mats);
    }

    public sealed class Group
    {
        public readonly string Name;
        public readonly PreviewToggle[] Toggles;
        public Group(string name, params PreviewToggle[] toggles) { Name = name; Toggles = toggles; }
    }

    // ── Global texture array -> neutral array ──
    private sealed class ArrayOverrideToggle : PreviewToggle
    {
        private readonly string _prop;
        private readonly Color32 _fill;
        private Texture _saved;
        private bool _hasSaved;
        private Texture2DArray _neutral;

        public ArrayOverrideToggle(string label, string tip, string prop, Color32 fill) : base(label, tip)
        {
            _prop = prop;
            _fill = fill;
        }

        protected override void Apply(bool enabled, IReadOnlyList<Material> mats)
        {
            if (enabled)
            {
                if (_hasSaved) { Shader.SetGlobalTexture(_prop, _saved); _saved = null; _hasSaved = false; }
                return;
            }

            var cur = Shader.GetGlobalTexture(_prop);
            if (!_hasSaved || cur != _neutral) { _saved = cur; _hasSaved = true; }

            // Same depth as the real array, so any slice index stays valid on every platform.
            var arr = _saved as Texture2DArray;
            int depth = arr != null ? Mathf.Max(1, arr.depth) : 1;
            if (_neutral == null || _neutral.depth != depth) Rebuild(depth);
            Shader.SetGlobalTexture(_prop, _neutral);
        }

        private void Rebuild(int depth)
        {
            if (_neutral != null) UnityEngine.Object.DestroyImmediate(_neutral);
            _neutral = new Texture2DArray(4, 4, depth, TextureFormat.RGBA32, false) { hideFlags = HideFlags.HideAndDontSave };
            var px = Enumerable.Repeat(_fill, 16).ToArray();
            for (int i = 0; i < depth; i++) _neutral.SetPixels32(px, i);
            _neutral.Apply(false, false);
        }

        public override string Status(IReadOnlyList<Material> mats)
        {
            var t = Shader.GetGlobalTexture(_prop);
            if (t == null) return "no array";
            if (t == _neutral) return "neutral";
            var a = t as Texture2DArray;
            return a != null ? a.depth + " slices" : "?";
        }
    }

    // ── Material keyword on the shared materials ──
    private sealed class KeywordToggle : PreviewToggle
    {
        private readonly string _kw;
        private readonly Dictionary<Material, bool> _saved = new Dictionary<Material, bool>();

        public KeywordToggle(string label, string tip, string keyword) : base(label, tip) { _kw = keyword; }

        protected override void Apply(bool enabled, IReadOnlyList<Material> mats)
        {
            if (enabled)
            {
                foreach (var kv in _saved)
                {
                    if (kv.Key == null) continue;
                    if (kv.Value) kv.Key.EnableKeyword(_kw); else kv.Key.DisableKeyword(_kw);
                }
                _saved.Clear();
                return;
            }

            foreach (var m in mats)
            {
                if (m == null) continue;
                bool cur = m.IsKeywordEnabled(_kw);
                if (!_saved.ContainsKey(m) || cur) _saved[m] = cur;   // cur == true: (re)enabled since, that is the original
                if (cur) m.DisableKeyword(_kw);
            }
        }

        // How many shared materials currently have the keyword. A low number while "Enabled" means the baker
        // generated shared materials without it.
        public override string Status(IReadOnlyList<Material> mats) =>
            mats.Count(m => m != null && m.IsKeywordEnabled(_kw)) + "/" + mats.Count + " mats";
    }

    private sealed class MaterialTableTintToggle : PreviewToggle
    {
        private const string TableProperty = "_UdonMaterialTable";
        private Texture _savedTable;
        private Texture2D _untintedTable;
        private bool _hasSavedTable;

        public MaterialTableTintToggle() : base("Tint (_Color)",
            "The baked shader reads _Color from the material table, not from shared material properties. " +
            "Disabled replaces the table tints with white using a temporary copy.")
        {
        }

        protected override void Apply(bool enabled, IReadOnlyList<Material> mats)
        {
            if (enabled)
            {
                if (_hasSavedTable)
                {
                    Shader.SetGlobalTexture(TableProperty, _savedTable);
                    _savedTable = null;
                    _hasSavedTable = false;
                }
                DestroyUntintedTable();
                return;
            }

            var table = MeshArrayBaker.LoadTable();
            if (table == null)
            {
                Debug.LogWarning("[BakePreview] Cannot disable tint: no baked material table was found.");
                return;
            }

            Texture current = Shader.GetGlobalTexture(TableProperty);
            if (!_hasSavedTable || current != _untintedTable)
            {
                _savedTable = current;
                _hasSavedTable = true;
            }

            if (_untintedTable == null || _untintedTable.width != table.width ||
                _untintedTable.height != table.height)
                BuildUntintedTable(table);

            Shader.SetGlobalTexture(TableProperty, _untintedTable);
        }

        public override string Status(IReadOnlyList<Material> mats)
        {
            var table = MeshArrayBaker.LoadTable();
            if (table == null) return "no baked material table";
            return !Enabled && Shader.GetGlobalTexture(TableProperty) == _untintedTable
                ? "all baked tints forced to white"
                : $"{table.width} baked tint(s)";
        }

        private void BuildUntintedTable(Texture2D source)
        {
            DestroyUntintedTable();
            var pixels = source.GetPixels();
            for (int column = 0; column < source.width; column++)
            {
                Color tint = pixels[column];
                pixels[column] = new Color(1f, 1f, 1f, tint.a);
            }

            _untintedTable = new Texture2D(source.width, source.height, source.format, false, true)
            {
                name = "BakePreview_UntintedMaterialTable",
                hideFlags = HideFlags.HideAndDontSave,
                filterMode = source.filterMode,
                wrapMode = source.wrapMode
            };
            _untintedTable.SetPixels(pixels);
            _untintedTable.Apply(false, false);
        }

        private void DestroyUntintedTable()
        {
            if (_untintedTable == null) return;
            UnityEngine.Object.DestroyImmediate(_untintedTable);
            _untintedTable = null;
        }
    }

    // ───────────────────────── Toggle list ─────────────────────────

    public static readonly Group[] Groups =
    {
        new Group("Shader outputs (material keywords on shared materials)",
            new KeywordToggle("Diffuse output",
                "_DIFFUSE_ON. Also drives the reflection occlusion factor.", "_DIFFUSE_ON"),
            new KeywordToggle("Speculars output",
                "_SPECULARS_ON", "_SPECULARS_ON"),
            new KeywordToggle("Reflections output",
                "_REFLECTIONS_ON", "_REFLECTIONS_ON")),

        new Group("Mesh arrays / material data",
            new KeywordToggle("Mesh arrays (master)",
                "_UDON_MESH_ARRAYS_ON. Disabled: the shader reads the material's own _MainTex/_BumpMap/... (empty on a shared material).",
                "_UDON_MESH_ARRAYS_ON"),
            new ArrayOverrideToggle("Albedo array",
                "Replaces the global _UdonAlbedoArray by a white array of the same depth: you only see _Color.",
                "_UdonAlbedoArray", new Color32(255, 255, 255, 255)),
            new KeywordToggle("Normal array (_BUMPMAP)",
                "Disabled: flat normal. Enabled but 0/n mats: the shared materials don't have the keyword.", "_BUMPMAP"),
            new KeywordToggle("Metallic array (_METALLICMAP)",
                "Disabled: uses the constant _Metallic. Enabled but 0/n mats: the shared materials don't have the keyword.", "_METALLICMAP"),
            new KeywordToggle("Roughness array (_GLOSSINESSMAP)",
                "Disabled: uses the constant _Glossiness. Enabled but 0/n mats: the shared materials don't have the keyword.", "_GLOSSINESSMAP"),
            new MaterialTableTintToggle(),
            new ArrayOverrideToggle("Emission array",
                "Replaces the global _UdonEmissionArray with black, disabling baked emission.",
                "_UdonEmissionArray", new Color32(0, 0, 0, 255)))
    };

    // ───────────────────────── API ─────────────────────────

    public static IEnumerable<PreviewToggle> All => Groups.SelectMany(g => g.Toggles);

    public static bool AnyDisabled => All.Any(t => !t.Enabled);

    // ── Suspend / Resume around bake, apply and delete ──
    // A bake rewrites the shared materials. Restoring a value captured BEFORE the bake onto the NEW material would
    // corrupt it, so the window calls Suspend() right before such an action (restores everything, remembers what was
    // disabled) and Resume() once the new materials exist (disables the same toggles again).
    private static List<PreviewToggle> _suspended;
    public static bool HasSuspended => _suspended != null && _suspended.Count > 0;

    public static void Suspend()
    {
        var off = All.Where(t => !t.Enabled).ToList();
        if (off.Count == 0) return;
        ResetAll();
        _suspended = off;
    }

    public static void Resume(IReadOnlyList<Material> mats)
    {
        if (_suspended == null) return;
        var list = _suspended;
        _suspended = null;
        foreach (var t in list) t.Set(false, mats);
        SceneView.RepaintAll();
    }

    private static readonly string[] ArrayGlobals =
        { "_UdonAlbedoArray", "_UdonNormalArray", "_UdonMetallicArray", "_UdonRoughnessArray", "_UdonEmissionArray" };

    /// <summary>
    /// Edit-mode test: binds the baked arrays (MeshArrayBaker.LoadArray, channel order Albedo, Normal, Metallic, Roughness)
    /// to the shader globals. If the look is fixed after this, nothing was binding them (LightingManager has no field for them).
    /// </summary>
    public static void PushArraysToGlobals()
    {
        int n = Mathf.Min(ArrayGlobals.Length, MeshArrayBaker.ChannelNames.Length);
        for (int i = 0; i < n; i++)
        {
            var arr = MeshArrayBaker.LoadArray(i);
            if (arr != null) Shader.SetGlobalTexture(ArrayGlobals[i], arr);
            else Debug.LogWarning($"[BakePreview] No baked array for channel '{MeshArrayBaker.ChannelNames[i]}' ({ArrayGlobals[i]} left as is).");
        }
        SceneView.RepaintAll();
    }

    // ── Stopgap for the material inspector resetting texture-linked keywords ──
    private static readonly string[] ArrayKeywords = { "_UDON_MESH_ARRAYS_ON", "_BUMPMAP", "_METALLICMAP", "_GLOSSINESSMAP" };

    /// <summary>
    /// Re-enables the array keywords on the shared materials. Opening a shared material in the ASE inspector can strip
    /// _BUMPMAP / _METALLICMAP / _GLOSSINESSMAP (its texture slots are empty, the real textures live in global arrays).
    /// Test tool: the clean fix is in the shader (array path must not depend on those keywords).
    /// </summary>
    public static void ForceArrayKeywords(IReadOnlyList<Material> mats)
    {
        Suspend();   // restore toggled keywords first, so the values below are not overwritten by a stale restore
        foreach (var m in mats)
        {
            if (m == null) continue;
            foreach (var k in ArrayKeywords) m.EnableKeyword(k);
            EditorUtility.SetDirty(m);
        }
        Resume(mats);
        SceneView.RepaintAll();
    }

    private static string DescribeGlobal(string prop)
    {
        var t = Shader.GetGlobalTexture(prop);
        if (t == null) return "NOT SET";
        var a = t as Texture2DArray;
        return a != null ? $"{a.depth} slices · {a.width}x{a.height} · {a.graphicsFormat}" : t.GetType().Name;
    }

    public static void Reapply(IReadOnlyList<Material> mats)
    {
        foreach (var t in All) t.Reapply(mats);
        SceneView.RepaintAll();
    }

    public static void ResetAll()
    {
        var none = Array.Empty<Material>();
        foreach (var t in All)
            if (!t.Enabled) t.Set(true, none);
        SceneView.RepaintAll();
    }

    public static void SetGroup(Group g, bool enabled, IReadOnlyList<Material> mats)
    {
        foreach (var t in g.Toggles)
            if (t.Enabled != enabled) t.Set(enabled, mats);
        SceneView.RepaintAll();
    }

    /// <summary>Text summary to paste in a bug report: one line per toggle with its state and live status.</summary>
    public static string Dump(IReadOnlyList<Material> mats)
    {
        var sb = new StringBuilder("[BakePreview]\n");
        foreach (var g in Groups)
        {
            sb.AppendLine(g.Name);
            foreach (var t in g.Toggles)
                sb.AppendLine($"  {t.Label}: {(t.Enabled ? "ENABLED" : "DISABLED")}  {t.Status(mats)}");
        }
        sb.AppendLine("Global arrays");
        foreach (var g in ArrayGlobals) sb.AppendLine($"  {g}: {DescribeGlobal(g)}");
        return sb.ToString();
    }

    [InitializeOnLoadMethod]
    private static void HookReset()
    {
        AssemblyReloadEvents.beforeAssemblyReload += ResetAll;
        EditorApplication.quitting += ResetAll;
    }

    // ───────────────────────── GUI ─────────────────────────

    private static GUIStyle _statusStyle;

    public static void DrawGUI(IReadOnlyList<Material> mats)
    {
        if (_statusStyle == null)
            _statusStyle = new GUIStyle(EditorStyles.miniLabel) { alignment = TextAnchor.MiddleRight };

        EditorGUILayout.HelpBox(
            "Enabled = original value. Disabled = forced off, to see what each input contributes. " +
            "Materials are only changed in memory, and everything is restored before a save or a script reload.",
            MessageType.Info);

        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label($"{mats.Count} shared material(s) targeted", EditorStyles.miniLabel);
            GUILayout.FlexibleSpace();
            if (GUILayout.Button(new GUIContent("Force array keywords",
                    "Re-enables _UDON_MESH_ARRAYS_ON, _BUMPMAP, _METALLICMAP, _GLOSSINESSMAP on the shared materials (test)."),
                    EditorStyles.miniButtonLeft, GUILayout.Width(120)))
                ForceArrayKeywords(mats);
            if (GUILayout.Button("Copy state", EditorStyles.miniButtonMid, GUILayout.Width(80)))
                GUIUtility.systemCopyBuffer = Dump(mats);
            using (new EditorGUI.DisabledScope(!AnyDisabled))
                if (GUILayout.Button("Reset all", EditorStyles.miniButtonRight, GUILayout.Width(80)))
                    ResetAll();
        }
        GUILayout.Space(4);

        foreach (var g in Groups)
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                GUILayout.Label(g.Name, EditorStyles.boldLabel);
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("All on", EditorStyles.miniButtonLeft, GUILayout.Width(56)))
                    SetGroup(g, true, mats);
                if (GUILayout.Button("All off", EditorStyles.miniButtonRight, GUILayout.Width(56)))
                    SetGroup(g, false, mats);
            }

            using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
                foreach (var t in g.Toggles) DrawRow(t, mats);

            GUILayout.Space(6);
        }

        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label("Global arrays seen by the shaders", EditorStyles.boldLabel);
            GUILayout.FlexibleSpace();
            if (GUILayout.Button(new GUIContent("Push baked arrays to globals",
                    "Edit mode test: Shader.SetGlobalTexture with the baked arrays. If the look gets fixed, nothing was binding them."),
                    EditorStyles.miniButton, GUILayout.Width(180)))
            {
                PushArraysToGlobals();
                Reapply(mats);   // keeps the Albedo override if it is currently Disabled
            }
        }
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
            foreach (var g in ArrayGlobals)
                using (new EditorGUILayout.HorizontalScope())
                {
                    GUILayout.Label(g, GUILayout.ExpandWidth(true));
                    string d = DescribeGlobal(g);
                    var prev = GUI.color;
                    if (d == "NOT SET") GUI.color = new Color(1f, 0.45f, 0.4f);
                    GUILayout.Label(d, _statusStyle, GUILayout.Width(260));
                    GUI.color = prev;
                }
    }

    private static void DrawRow(PreviewToggle t, IReadOnlyList<Material> mats)
    {
        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label(new GUIContent(t.Label, t.Tip), GUILayout.ExpandWidth(true));
            GUILayout.Label(t.Status(mats), _statusStyle, GUILayout.Width(110));

            // Both values are read before any Set, so a click on the already-active button is simply ignored.
            bool wantOn = GUILayout.Toggle(t.Enabled, "Enabled", EditorStyles.miniButtonLeft, GUILayout.Width(64));
            bool wantOff = GUILayout.Toggle(!t.Enabled, "Disabled", EditorStyles.miniButtonRight, GUILayout.Width(64));

            if (wantOn && !t.Enabled) { t.Set(true, mats); SceneView.RepaintAll(); }
            else if (wantOff && t.Enabled) { t.Set(false, mats); SceneView.RepaintAll(); }
        }
    }
}

/// <summary>Restores every preview override before Unity writes assets, so a debug state is never serialized.</summary>
internal sealed class BakePreviewSaveGuard : AssetModificationProcessor
{
    private static string[] OnWillSaveAssets(string[] paths)
    {
        if (BakePreview.AnyDisabled)
        {
            Debug.Log("[BakePreview] Previews reset before saving.");
            BakePreview.ResetAll();
        }
        return paths;
    }
}