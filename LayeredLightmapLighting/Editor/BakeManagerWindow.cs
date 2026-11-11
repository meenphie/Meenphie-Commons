using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Meenphie.Commons;

/// <summary>
/// Bake Manager: single place to bake, apply and audit everything the baker produces.
///
///   Overview  : KPI cards (renderers, materials, submeshes, mesh MB, verts, tris, texture MB), health checks, bake pipeline.
///   Meshes    : sortable table, size in MB / verts / tris per mesh, original vs baked.
///   Materials : baked shared material -> source materials -> meshes, render-state conflicts, skipped renderers.
///   Textures  : thumbnails of every array slice (with usage), memory vs source textures, plus the material table.
///   Preview   : Enabled / Disabled toggle per mesh-array input (see BakeManagerWindow.Preview.cs).
///   LOD       : scene LOD distances and collider cleanup (see BakeManagerWindow.LOD.cs).
///
/// File layout (all partial):
///   BakeManagerWindow.cs            state, lifecycle, header, tabs
///   BakeManagerWindow.UI.cs         styles, palette, reusable widgets (KPI cards, pills, callouts, tables)
///   BakeManagerWindow.Overview.cs
///   BakeManagerWindow.Meshes.cs
///   BakeManagerWindow.Materials.cs
///   BakeManagerWindow.Textures.cs
///   BakeManagerWindow.Actions.cs    bake / apply / delete / revert / report
///   BakeStats.cs                    data + formatting, no GUI
/// </summary>
public partial class BakeManagerWindow : EditorWindow
{
    private enum Tab { Overview, Meshes, Probes, Materials, Textures, Preview, LOD }
    private static readonly string[] TabNames = { "Overview", "Meshes", "Probes", "Materials", "Textures", "Preview", "LOD" };

    // Same order as MeshArrayBaker.ChannelNames (Diffuse, Normal, Metallic, Roughness, Emission)
    private static readonly string[] ChannelTexProps = { "_MainTex", "_BumpMap", "_MetallicMap", "_GlossinessMap", "_EmissionMap" };

    private const int ThumbRes = 128;
    private const int ThumbBudgetPerPass = 8;

    private IBakeOperation[] _lightingOps;
    private MeshArraysBakeOp _meshOp;

    private Tab _tab;
    private Vector2 _scroll;
    private bool _showRuntimeMeshes;

    // Shared by Meshes + Materials tabs
    private string _search = "";
    private readonly HashSet<string> _open = new HashSet<string>();

    // Caches (dropped by InvalidateAll)
    private List<MeshArrayBaker.RendererReport> _scan;
    private BakeStats.SceneStats _stats;
    private List<BakeStats.MeshRow> _meshRows;
    private ChannelData[] _channels;
    private readonly Dictionary<IBakeOperation, OpInfo> _opInfo = new Dictionary<IBakeOperation, OpInfo>();
    private readonly Dictionary<int, Texture2D> _thumbs = new Dictionary<int, Texture2D>();
    private Color[] _tablePx;
    private int _tableW;
    private long _tableBytes = -1;
    private double _nextStatsRepaint;

    private static string[] _channelNames;
    private static string[] ChannelNames => _channelNames ?? (_channelNames = MeshArrayBaker.ChannelNames);

    private struct OpInfo { public string status; public int count; public bool warn, baked; }

    [MenuItem("Meenphie/Bake Manager")]
    public static void Open()
    {
        var w = GetWindow<BakeManagerWindow>("Bake Manager");
        w.minSize = new Vector2(640, 520);
    }

    private void OnEnable()
    {
        _lightingOps = new IBakeOperation[] { new LightmapBakeOp(), new ReflectionProbeBakeOp() };
        _meshOp = new MeshArraysBakeOp();
        wantsMouseMove = true;
        EditorApplication.update += UpdateRenderStats;
    }

    private void OnDisable()
    {
        EditorApplication.update -= UpdateRenderStats;
        ClearMeshPreview();
        ClearThumbs();
        ClearProbeThumbs();
        ClearLightmapThumbs();
    }

    private void UpdateRenderStats()
    {
        bool needsRefresh = _tab == Tab.Overview || EditorApplication.isPlaying;
        if (!needsRefresh || EditorApplication.timeSinceStartup < _nextStatsRepaint) return;
        _nextStatsRepaint = EditorApplication.timeSinceStartup + 0.5d;
        Repaint();
    }
    private void OnProjectChange() => InvalidateAll();

    private void InvalidateAll()
    {
        RefreshScan();
        _opInfo.Clear();
        InvalidatePreview();
        ClearThumbs();
        Repaint();
    }

    /// <summary>Drops everything derived from the scene scan (cheaper than InvalidateAll: keeps op info and thumbnails).</summary>
    private void RefreshScan()
    {
        _scan = null;
        _stats = null;
        _meshRows = null;
        _channels = null;
        _tablePx = null;
        _tableBytes = -1;
    }

    private void ClearThumbs()
    {
        foreach (var t in _thumbs.Values) if (t != null) DestroyImmediate(t);
        _thumbs.Clear();
    }

    private List<MeshArrayBaker.RendererReport> Scan() => _scan ?? (_scan = MeshArrayBaker.Scan());
    private BakeStats.SceneStats Stats() => _stats ?? (_stats = BakeStats.Compute(Scan()));
    private List<BakeStats.MeshRow> MeshRows() => _meshRows ?? (_meshRows = BakeStats.BuildMeshRows(Scan()));

    private OpInfo Info(IBakeOperation op)
    {
        if (_opInfo.TryGetValue(op, out var i)) return i;
        var (count, warn) = op.GetSliceInfo();
        i = new OpInfo { status = op.GetStatus(), count = count, warn = warn, baked = op.IsBaked };
        _opInfo[op] = i;
        return i;
    }

    private IEnumerable<IBakeOperation> AllOps()
    {
        foreach (var o in _lightingOps) yield return o;
        yield return _meshOp;
    }

    private (string text, Tone tone) OverallState()
    {
        var s = Stats();
        if (s.eligible == 0) return ("Nothing to bake", Tone.Neutral);
        if (!Info(_meshOp).baked) return ("Not baked", Tone.Warn);
        if (s.applied < s.eligible) return ("Pending apply", Tone.Warn);
        return ("Up to date", Tone.Ok);
    }

    private void DrawPlayModeBanner()
    {
        if (!EditorApplication.isPlaying) return;

        EditorGUILayout.HelpBox(
            "Play Mode : le static batching fusionne les meshes à l'exécution, les stats d'édition " +
            "(0 → 0, 'Combined Mesh') ne sont pas fiables ici. Bake / Apply sont désactivés.",
            MessageType.Info);

        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Space(PagePad);
            GUILayout.Label(
                $"Batches {UnityStats.batches}  ·  Draw calls {UnityStats.drawCalls}  ·  " +
                $"SetPass {UnityStats.setPassCalls}  ·  " +
                $"Static {UnityStats.staticBatches} ({UnityStats.staticBatchedDrawCalls} draw calls)  ·  " +
                $"Dynamic {UnityStats.dynamicBatches}  ·  Instanced {UnityStats.instancedBatches}",
                EditorStyles.miniLabel);
        }
    }

    private void OnGUI()
    {
        EnsureStyles();
        TickPreview();
        if (Event.current.type == EventType.MouseMove) Repaint();

        DrawHeader();
        DrawTabBar();
        DrawPlayModeBanner();
        if (_tab == Tab.Meshes || _tab == Tab.Probes || _tab == Tab.Materials) DrawSearchBar();

        _scroll = EditorGUILayout.BeginScrollView(_scroll);
        try
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                GUILayout.Space(PagePad);
                using (new EditorGUILayout.VerticalScope(GUILayout.ExpandWidth(true)))
                {
                    GUILayout.Space(4);
                    switch (_tab)
                    {
                        case Tab.Overview: DrawOverview(); break;
                        case Tab.Meshes: DrawMeshesTab(); break;
                        case Tab.Probes: DrawProbesTab(); break;
                        case Tab.Materials: DrawMaterialsTab(); break;
                        case Tab.Textures: DrawTexturesTab(); break;
                        case Tab.Preview: DrawPreviewTab(); break;
                        case Tab.LOD: DrawLODTab(); break;
                    }
                    GUILayout.Space(8);
                }
                GUILayout.Space(PagePad);
            }
        }
        finally
        {
            EditorGUILayout.EndScrollView();
        }
    }

    private void DrawHeader()
    {
        using (new EditorGUILayout.HorizontalScope(EditorStyles.toolbar))
        {
            GUILayout.Label("Bake Manager", EditorStyles.boldLabel);

            var (text, tone) = OverallState();
            float pw = PillWidth(text);
            var pr = GUILayoutUtility.GetRect(pw, 16, GUILayout.Width(pw), GUILayout.Height(16));
            pr.y += 2;
            Pill(pr, text, ToneColor(tone));

            GUILayout.FlexibleSpace();

            if (GUILayout.Button("Bake All", EditorStyles.toolbarButton, GUILayout.Width(72)))
            {
                if (EditorUtility.DisplayDialog("Bake All",
                    "Lance TOUS les bakes (Lightmaps → Probes → Mesh Arrays),\n" +
                    "puis applique les meshes/matériaux partagés sur la scène.", "Bake", "Cancel"))
                    BakeAll();
                GUIUtility.ExitGUI();
            }

            if (GUILayout.Button("Apply", EditorStyles.toolbarButton, GUILayout.Width(56)))
            {
                ApplyToScene();
                GUIUtility.ExitGUI();
            }

            if (EditorGUILayout.DropdownButton(new GUIContent("More"), FocusType.Passive, EditorStyles.toolbarDropDown, GUILayout.Width(60)))
                ShowMoreMenu(GUILayoutUtility.GetLastRect());
        }
    }

    private void DrawTabBar()
    {
        var bar = GUILayoutUtility.GetRect(0, 28, GUILayout.ExpandWidth(true));
        var e = Event.current;

        if (e.type == EventType.Repaint)
            EditorGUI.DrawRect(new Rect(bar.x, bar.yMax - 1, bar.width, 1), Line);

        float x = bar.x + 8;
        for (int i = 0; i < TabNames.Length; i++)
        {
            var content = new GUIContent(TabNames[i]);
            float w = _tabSelStyle.CalcSize(content).x + 30f;
            var r = new Rect(x, bar.y, w, bar.height);
            x += w;

            bool sel = i == (int)_tab;
            if (e.type == EventType.Repaint)
            {
                if (!sel && r.Contains(e.mousePosition)) EditorGUI.DrawRect(r, CellBg);
                if (sel) EditorGUI.DrawRect(new Rect(r.x, r.yMax - 2, r.width, 2), Accent);
            }
            GUI.Label(r, content, sel ? _tabSelStyle : _tabStyle);
            EditorGUIUtility.AddCursorRect(r, MouseCursor.Link);

            if (e.type == EventType.MouseDown && e.button == 0 && r.Contains(e.mousePosition))
            {
                _tab = (Tab)i;
                _scroll = Vector2.zero;
                GUI.FocusControl(null);
                e.Use();
                Repaint();
            }
        }
    }

    private void DrawSearchBar()
    {
        using (new EditorGUILayout.HorizontalScope(EditorStyles.toolbar))
        {
            _search = EditorGUILayout.TextField(_search, EditorStyles.toolbarSearchField);
            if (GUILayout.Button("Refresh", EditorStyles.toolbarButton, GUILayout.Width(64)))
                RefreshScan();
        }
    }
}
