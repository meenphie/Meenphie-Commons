using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

public partial class BakeManagerWindow
{
    private enum Tone { Neutral, Info, Ok, Warn }

    private static readonly Color Line = new Color(0.5f, 0.5f, 0.5f, 0.28f);
    private static readonly Color Accent = new Color(0.25f, 0.55f, 0.95f, 1f);
    private static readonly Color CellBg = new Color(0.5f, 0.5f, 0.5f, 0.12f);
    private static readonly Color CellHot = new Color(0.5f, 0.5f, 0.5f, 0.28f);
    private static readonly Color CellSel = new Color(0.24f, 0.48f, 0.9f, 0.40f);
    private static readonly Color HeaderBg = new Color(0.5f, 0.5f, 0.5f, 0.18f);

    private const float PagePad = 8f;
    private const float RowH = 20f;

    private GUIStyle _bold, _muted, _mutedWrap, _mutedR, _boldFoldout;
    private GUIStyle _tabStyle, _tabSelStyle, _cellLabel, _cellSub;

    private sealed class Kpi
    {
        public readonly string title, value, detail, tooltip;
        public readonly Tone tone;

        public Kpi(string title, string value, string detail, Tone tone, string tooltip = null)
        {
            this.title = title;
            this.value = value;
            this.detail = detail;
            this.tone = tone;
            this.tooltip = tooltip;
        }
    }

    private void EnsureStyles()
    {
        if (_bold != null) return;
        _bold = new GUIStyle(EditorStyles.boldLabel);
        _muted = new GUIStyle(EditorStyles.miniLabel);
        _muted.normal.textColor = EditorGUIUtility.isProSkin
            ? new Color(0.68f, 0.68f, 0.68f)
            : new Color(0.38f, 0.38f, 0.38f);
        _mutedWrap = new GUIStyle(_muted) { wordWrap = true };
        _mutedR = new GUIStyle(_muted) { alignment = TextAnchor.MiddleRight };
        _boldFoldout = new GUIStyle(EditorStyles.foldout) { fontStyle = FontStyle.Bold };
        _tabStyle = new GUIStyle(EditorStyles.label) { alignment = TextAnchor.MiddleCenter };
        _tabSelStyle = new GUIStyle(_tabStyle) { fontStyle = FontStyle.Bold };
        _cellLabel = new GUIStyle(EditorStyles.miniLabel)
        {
            alignment = TextAnchor.UpperLeft,
            clipping = TextClipping.Clip,
            wordWrap = false
        };
        _cellSub = new GUIStyle(_cellLabel);
        _cellSub.normal.textColor = _muted.normal.textColor;
    }

    private static Color ToneColor(Tone tone)
    {
        switch (tone)
        {
            case Tone.Ok: return new Color(0.22f, 0.72f, 0.40f);
            case Tone.Warn: return new Color(0.88f, 0.55f, 0.16f);
            case Tone.Info: return Accent;
            default: return new Color(0.48f, 0.50f, 0.53f);
        }
    }

    private static float PillWidth(string text) => EditorStyles.miniLabel.CalcSize(new GUIContent(text)).x + 16f;

    private static void Pill(Rect rect, string text, Color color)
    {
        EditorGUI.DrawRect(rect, new Color(color.r, color.g, color.b, 0.22f));
        var style = new GUIStyle(EditorStyles.miniLabel)
        {
            alignment = TextAnchor.MiddleCenter,
            fontStyle = FontStyle.Bold
        };
        style.normal.textColor = color;
        GUI.Label(rect, text, style);
    }

    private static void SectionHeader(string title)
    {
        GUILayout.Space(4);
        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label(title, EditorStyles.boldLabel);
            GUILayout.Space(6);
            var line = GUILayoutUtility.GetRect(0, 1, GUILayout.ExpandWidth(true), GUILayout.Height(1));
            if (Event.current.type == EventType.Repaint) EditorGUI.DrawRect(line, Line);
        }
        GUILayout.Space(2);
    }

    private static void StatRow(string label, string value)
    {
        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label(label, EditorStyles.miniLabel, GUILayout.Width(80));
            GUILayout.Label(value, EditorStyles.miniLabel);
        }
    }

    private bool Callout(Tone tone, string message, string action = null)
    {
        const float actionWidth = 68f;
        float width = Mathf.Max(100f, position.width - PagePad * 2f - 28f);
        float textWidth = width - 18f - (string.IsNullOrEmpty(action) ? 0f : actionWidth + 6f);
        float textHeight = EditorStyles.wordWrappedMiniLabel.CalcHeight(new GUIContent(message), textWidth);
        float height = Mathf.Max(EditorGUIUtility.singleLineHeight, textHeight);
        var rect = EditorGUILayout.GetControlRect(false, height);
        var marker = new Rect(rect.x, rect.y + 1f, 3f, height - 2f);
        if (Event.current.type == EventType.Repaint) EditorGUI.DrawRect(marker, ToneColor(tone));
        GUI.Label(new Rect(rect.x + 9f, rect.y, textWidth, height), message, EditorStyles.wordWrappedMiniLabel);
        return !string.IsNullOrEmpty(action) &&
               GUI.Button(new Rect(rect.xMax - actionWidth, rect.y, actionWidth, EditorGUIUtility.singleLineHeight), action);
    }

    private static void DrawKpiGrid(IReadOnlyList<Kpi> cards)
    {
        const int columns = 3;
        for (int i = 0; i < cards.Count; i += columns)
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                for (int j = 0; j < columns; j++)
                {
                    int index = i + j;
                    if (index >= cards.Count)
                    {
                        GUILayout.FlexibleSpace();
                        continue;
                    }

                    var card = cards[index];
                    using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox, GUILayout.ExpandWidth(true), GUILayout.MinHeight(62)))
                    {
                        var titleRect = GUILayoutUtility.GetRect(0, 18, GUILayout.ExpandWidth(true));
                        if (Event.current.type == EventType.Repaint)
                            EditorGUI.DrawRect(new Rect(titleRect.x, titleRect.y, 3, titleRect.height), ToneColor(card.tone));
                        GUI.Label(new Rect(titleRect.x + 8, titleRect.y, titleRect.width - 8, titleRect.height),
                            new GUIContent(card.title, card.tooltip), EditorStyles.miniLabel);
                        GUILayout.Label(card.value, EditorStyles.boldLabel);
                        if (!string.IsNullOrEmpty(card.detail))
                            GUILayout.Label(card.detail, EditorStyles.miniLabel);
                    }
                }
            }
        }
    }

    private static bool Has(string value, string query) =>
        value != null && value.IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0;

    private static bool MatchesRenderer(MeshArrayBaker.RendererReport report, string query) =>
        Has(report.renderer != null ? report.renderer.name : "", query) ||
        Has(report.originalMesh != null ? report.originalMesh.name : "", query);

    private static string PrettyReason(string reason)
    {
        switch (reason)
        {
            case "other shader": return "Other shader (not a bake target)";
            case "dynamic mesh": return "Dynamic mesh (_IsDynamicMesh)";
            case "null material": return "Missing material";
            case "fewer materials than submeshes": return "Fewer materials than submeshes";
            case "non-triangle topology": return "Non-triangle topology";
            case "baked mesh without registry entry": return "Baked mesh without registry entry (restore or rebake)";
            default: return reason ?? "unknown";
        }
    }

    private static void SelectRenderers(IEnumerable<MeshRenderer> renderers)
    {
        var objects = renderers.Where(r => r != null).Select(r => (Object)r.gameObject).ToArray();
        if (objects.Length == 0) return;
        Selection.objects = objects;
        EditorGUIUtility.PingObject(objects[0]);
    }

    private static bool Link(Rect rect, string text, string tooltip = null)
    {
        EditorGUIUtility.AddCursorRect(rect, MouseCursor.Link);
        return GUI.Button(rect, new GUIContent(text, tooltip), EditorStyles.label);
    }

    private static void AssetLink(Rect rect, string text, Object asset, string tooltip = null)
    {
        if (asset == null) return;
        EditorGUIUtility.AddCursorRect(rect, MouseCursor.Link);
        GUI.Label(rect, new GUIContent(text, tooltip), EditorStyles.label);
        Event current = Event.current;
        if (current.type != EventType.MouseDown || current.button != 0 || !rect.Contains(current.mousePosition))
            return;

        EditorGUIUtility.PingObject(asset);
        if (current.clickCount == 2) Selection.activeObject = asset;
        current.Use();
    }

    private static Color ToDisplay(Color linear)
    {
        var gamma = linear.gamma;
        gamma.r = Mathf.Clamp01(gamma.r);
        gamma.g = Mathf.Clamp01(gamma.g);
        gamma.b = Mathf.Clamp01(gamma.b);
        gamma.a = 1f;
        return gamma;
    }

    private Rect BeginGrid(int count, float cellW, float cellH, float pad, out int cols)
    {
        float avail = Mathf.Max(100f, position.width - PagePad * 2f - 30f);
        cols = Mathf.Max(1, Mathf.FloorToInt((avail + pad) / (cellW + pad)));
        int rows = Mathf.Max(1, Mathf.CeilToInt(count / (float)cols));
        float height = rows * (cellH + pad);
        return GUILayoutUtility.GetRect(avail, height, GUILayout.Width(avail), GUILayout.Height(height));
    }

    private static Rect CellRect(Rect area, int index, int cols, float width, float height, float pad) =>
        new Rect(area.x + (index % cols) * (width + pad), area.y + (index / cols) * (height + pad), width, height);

    private static Rect[] Cols(Rect row, float firstWidth, float secondWidth)
    {
        float first = Mathf.Min(firstWidth, row.width * 0.55f);
        float second = Mathf.Min(secondWidth, row.width * 0.3f);
        return new[]
        {
            new Rect(row.x, row.y, first, row.height),
            new Rect(row.x + first, row.y, second, row.height),
            new Rect(row.x + first + second, row.y, Mathf.Max(0, row.width - first - second), row.height)
        };
    }
}
