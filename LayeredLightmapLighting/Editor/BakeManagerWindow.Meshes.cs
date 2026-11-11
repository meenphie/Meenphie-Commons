using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

public partial class BakeManagerWindow
{
    private sealed class RuntimeMeshEntry
    {
        public Mesh mesh;
        public readonly List<Renderer> renderers = new List<Renderer>();
    }

    private int _meshView;
    private int _meshSortColumn;
    private bool _meshSortAscending = true;
    private PreviewRenderUtility _meshPreview;
    private Material _meshPreviewMaterial;

    private void ClearMeshPreview()
    {
        _meshPreview?.Cleanup();
        _meshPreview = null;
        _meshPreviewMaterial = null;
    }

    private void DrawMeshesTab()
    {
        if (EditorApplication.isPlaying)
        {
            using (new EditorGUILayout.HorizontalScope(EditorStyles.toolbar))
            {
                GUILayout.Label("View", EditorStyles.miniLabel, GUILayout.Width(34));
                _showRuntimeMeshes = GUILayout.Toggle(_showRuntimeMeshes, "Live Play Mode",
                    EditorStyles.toolbarButton, GUILayout.Width(105));
                GUILayout.Label(_showRuntimeMeshes
                    ? "Meshes currently assigned to scene renderers"
                    : "Baker eligibility and baked assets", _muted);
            }

            if (_showRuntimeMeshes)
            {
                DrawRuntimeMeshes();
                return;
            }
        }

        var rows = MeshRows();
        if (rows.Count == 0)
        {
            Callout(Tone.Neutral, "No mesh renderer in the loaded scenes.");
            return;
        }

        var views = new[] { "All", "Eligible", "Skipped" };
        _meshView = Mathf.Clamp(GUILayout.Toolbar(_meshView, views), 0, views.Length - 1);
        DrawMeshSummary(rows);
        string query = (_search ?? "").Trim();

        IEnumerable<BakeStats.MeshRow> visible = rows;
        if (_meshView == 1) visible = visible.Where(r => r.eligibleCount > 0);
        else if (_meshView == 2) visible = visible.Where(r => r.skippedCount > 0);
        if (query.Length > 0)
            visible = visible.Where(r => Has(r.name, query) || Has(r.path, query) ||
                                         r.users.Any(u => MatchesRenderer(u, query)));

        var ordered = SortRows(visible).ToList();
        SectionHeader($"Meshes ({ordered.Count})");
        DrawMeshSortControls();

        foreach (var row in ordered)
            DrawMeshRow(row);
    }

    

    
    private void DrawRuntimeMeshes()
    {
        var entries = new Dictionary<Mesh, RuntimeMeshEntry>();
        foreach (var renderer in Resources.FindObjectsOfTypeAll<Renderer>())
        {
            if (renderer == null || !renderer.gameObject.scene.IsValid() || EditorUtility.IsPersistent(renderer))
                continue;

            Mesh mesh;
            if (renderer is SkinnedMeshRenderer skinnedRenderer)
                mesh = skinnedRenderer.sharedMesh;
            else if (renderer is MeshRenderer)
                mesh = renderer.GetComponent<MeshFilter>()?.sharedMesh;
            else
                continue;
            if (mesh == null) continue;

            if (!entries.TryGetValue(mesh, out var entry))
            {
                entry = new RuntimeMeshEntry { mesh = mesh };
                entries.Add(mesh, entry);
            }
            entry.renderers.Add(renderer);
        }

        var ordered = entries.Values.OrderBy(e => e.mesh.name, StringComparer.OrdinalIgnoreCase).ToList();
        if (ordered.Count == 0)
        {
            Callout(Tone.Neutral, "No live mesh renderers found in loaded scenes.");
            return;
        }

        long vertices = 0, triangles = 0, memory = 0, gpuBytes = 0;
        foreach (var entry in ordered)
        {
            var info = BakeStats.Describe(entry.mesh);
            vertices += info.vertices;
            triangles += info.triangles;
            memory += info.bytes;
            gpuBytes += info.gpuBufferBytes;
        }

        DrawKpiGrid(new List<Kpi>
        {
            new Kpi("Unique live meshes", ordered.Count.ToString(),
                $"{ordered.Sum(e => e.renderers.Count)} renderer references", Tone.Info),
            new Kpi("Vertices", BakeStats.Count(vertices), "unique mesh instances", Tone.Info),
            new Kpi("Triangles", BakeStats.Count(triangles), "unique mesh instances", Tone.Info),
            new Kpi("Runtime memory", BakeStats.Mb(memory), "Unity Profiler estimate", Tone.Info),
            new Kpi("GPU buffers ≈", BakeStats.Mb(gpuBytes), "Estimated vertex + index buffers", Tone.Warn)
        });

        Callout(Tone.Info,
            "Live snapshot: meshes currently assigned to renderers in Play Mode, grouped by mesh reference. This view does not merge meshes.");
        SectionHeader($"Runtime meshes ({ordered.Count})");

        foreach (var entry in ordered)
        {
            Mesh mesh = entry.mesh;
            BakeStats.MeshInfo info = BakeStats.Describe(mesh);
            string assetPath = AssetDatabase.GetAssetPath(mesh);
            bool isBakerAsset = !string.IsNullOrEmpty(assetPath) &&
                                assetPath.StartsWith(BakePaths.Meshes, StringComparison.OrdinalIgnoreCase);

            using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
            {
                using (new EditorGUILayout.HorizontalScope())
                {
                    GUI.Label(GUILayoutUtility.GetRect(18, 18, GUILayout.Width(18), GUILayout.Height(18)),
                        EditorGUIUtility.IconContent("Mesh Icon"));
                    GUILayout.Label(mesh.name, _bold, GUILayout.ExpandWidth(true));
                    Pill(GUILayoutUtility.GetRect(76, 18, GUILayout.Width(76), GUILayout.Height(18)),
                        isBakerAsset ? "BAKED" : "LIVE", ToneColor(isBakerAsset ? Tone.Ok : Tone.Info));
                    GUILayout.Label($"{entry.renderers.Count} renderer(s)", _mutedR, GUILayout.Width(110));
                }

                using (new EditorGUILayout.HorizontalScope())
                {
                    GUILayout.Space(22);
                    GUILayout.Label(
                        $"{BakeStats.Count(info.vertices)} verts  ·  {BakeStats.Count(info.triangles)} tris  ·  " +
                        $"{info.subMeshes} submesh(es)  ·  {BakeStats.Mb(info.bytes)}  ·  GPU ≈ {BakeStats.Mb(info.gpuBufferBytes)}",
                        _mutedWrap, GUILayout.ExpandWidth(true));
                }

                if (!string.IsNullOrEmpty(assetPath))
                {
                    using (new EditorGUILayout.HorizontalScope())
                    {
                        GUILayout.Space(22);
                        GUILayout.Label(assetPath, _mutedWrap);
                    }
                }

                foreach (var renderer in entry.renderers.OrderBy(r => r.transform.GetSiblingIndex()))
                {
                    using (new EditorGUILayout.HorizontalScope())
                    {
                        GUILayout.Space(22);
                        string rootPath = GetTransformPath(renderer.transform.root);
                        if (Link(GUILayoutUtility.GetRect(0, RowH - 2, GUILayout.ExpandWidth(true)),
                                $"{GetTransformPath(renderer.transform)}  ·  root: {rootPath}"))
                            SelectRenderers(new[] { renderer });
                    }
                }
            }
        }
    }

    private static string GetTransformPath(Transform transform)
    {
        if (transform == null) return "(missing)";
        var names = new Stack<string>();
        for (var current = transform; current != null; current = current.parent)
            names.Push(current.name);
        return string.Join("/", names);
    }

    private void DrawMeshSummary(List<BakeStats.MeshRow> rows)
    {
        var s = Stats();
        var cards = new List<Kpi>
        {
            new Kpi("Unique meshes", $"{s.meshesBefore} → {s.meshesNow}",
                $"{rows.Count} source mesh(es)", Tone.Info),
            new Kpi("Vertices", BakeStats.Count(s.vertsNow),
                $"original {BakeStats.Count(s.vertsBefore)}", Tone.Info),
            new Kpi("Triangles", BakeStats.Count(s.trisNow),
                $"original {BakeStats.Count(s.trisBefore)}", Tone.Info),
            new Kpi("Runtime mesh memory", BakeStats.Mb(s.meshBytesNow),
                $"original {BakeStats.Mb(s.meshBytesBefore)}", Tone.Info,
                "Unity Profiler runtime memory estimate for unique meshes"),
            new Kpi("GPU mesh buffers ≈", BakeStats.Mb(s.meshGpuBytesNow),
                $"original {BakeStats.Mb(s.meshGpuBytesBefore)}", Tone.Warn,
                "Estimate: vertex-buffer strides × vertices + index-buffer size. Excludes GPU alignment/driver overhead.")
        };
        DrawKpiGrid(cards);
        GUILayout.Space(4);
    }

    private IEnumerable<BakeStats.MeshRow> SortRows(IEnumerable<BakeStats.MeshRow> rows)
    {
        Func<BakeStats.MeshRow, IComparable> key;
        switch (_meshSortColumn)
        {
            case 1: key = r => r.info.bytes; break;
            case 2: key = r => r.info.vertices; break;
            case 3: key = r => r.info.triangles; break;
            case 4: key = r => r.baked.bytes; break;
            case 5: key = r => r.baked.vertices; break;
            case 6: key = r => r.baked.triangles; break;
            case 7: key = r => r.eligibleCount + r.skippedCount; break;
            default: key = r => r.name; break;
        }
        return _meshSortAscending ? rows.OrderBy(key) : rows.OrderByDescending(key);
    }

    private void DrawMeshSortControls()
    {
        using (new EditorGUILayout.HorizontalScope(EditorStyles.toolbar))
        {
            string[] labels = { "Name", "Runtime memory", "Vertices", "Triangles", "Baked memory", "Baked vertices", "Baked triangles", "Renderer count" };
            _meshSortColumn = EditorGUILayout.Popup("Sort by", _meshSortColumn, labels, GUILayout.MinWidth(210));
            GUILayout.FlexibleSpace();
            if (GUILayout.Button(_meshSortAscending ? "Ascending" : "Descending", EditorStyles.toolbarButton, GUILayout.Width(84)))
                _meshSortAscending = !_meshSortAscending;
        }
    }

    private void DrawMeshRow(BakeStats.MeshRow row)
    {
        string key = "mesh:" + row.path + row.name;
        bool isOpen = _open.Contains(key);
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                var iconRect = GUILayoutUtility.GetRect(18, 18, GUILayout.Width(18), GUILayout.Height(18));
                GUI.Label(iconRect, EditorGUIUtility.IconContent("Mesh Icon"));

                var nameRect = GUILayoutUtility.GetRect(0, 20, GUILayout.MinWidth(100), GUILayout.ExpandWidth(true));
                EditorGUIUtility.AddCursorRect(nameRect, MouseCursor.Link);
                bool clicked = row.mesh != null &&
                               GUI.Button(nameRect, new GUIContent(row.name,
                                   string.IsNullOrEmpty(row.path) ? "Click to ping this mesh" : row.path),
                                   EditorStyles.linkLabel);
                if (clicked)
                {
                    EditorGUIUtility.PingObject(row.mesh);
                    if (Event.current.clickCount == 2) Selection.activeObject = row.mesh;
                }

                var status = row.skippedCount > 0 ? Tone.Warn : Tone.Ok;
                string statusText = row.skippedCount == 0 ? "Ready" :
                    row.eligibleCount == 0 ? "Skipped" : "Partial";
                Pill(GUILayoutUtility.GetRect(64, 18, GUILayout.Width(64), GUILayout.Height(18)),
                    statusText, ToneColor(status));

                GUILayout.Label($"{row.eligibleCount} eligible · {row.skippedCount} skipped",
                    _mutedR, GUILayout.Width(152));

                if (GUILayout.Button(isOpen ? "Hide" : "Details", EditorStyles.miniButton, GUILayout.Width(56)))
                {
                    isOpen = !isOpen;
                    if (isOpen) _open.Add(key); else _open.Remove(key);
                }
            }

            using (new EditorGUILayout.HorizontalScope())
            {
                GUILayout.Space(22);
                string metrics = $"Original  {BakeStats.Mb(row.info.bytes)}  ·  {BakeStats.Count(row.info.vertices)} verts  ·  {BakeStats.Count(row.info.triangles)} tris";
                if (row.appliedCount > 0)
                    metrics += $"     |     Baked  {BakeStats.Mb(row.baked.bytes)}  ·  {BakeStats.Count(row.baked.vertices)} verts  ·  {BakeStats.Count(row.baked.triangles)} tris";
                GUILayout.Label(metrics, _mutedWrap, GUILayout.ExpandWidth(true));
            }

            if (row.skippedCount > 0)
            {
                using (new EditorGUILayout.HorizontalScope())
                {
                    GUILayout.Space(22);
                    GUILayout.Label($"Skipped: {PrettyReason(row.reason)}", _mutedWrap);
                }
            }

            if (!isOpen) return;

            var users = row.users.Where(u => _meshView == 0 || (_meshView == 1 && u.eligible) ||
                                             (_meshView == 2 && !u.eligible)).ToList();
            DrawMeshDetails(row);
            DrawMaterialSlotDiagnostics(users);
            foreach (var user in users)
            {
                using (new EditorGUILayout.HorizontalScope())
                {
                    GUILayout.Space(22);
                    string status = user.eligible ? (user.applied ? "applied" : "eligible") : PrettyReason(user.reason);
                    if (Link(GUILayoutUtility.GetRect(0, RowH - 2, GUILayout.ExpandWidth(true)),
                            $"{(user.renderer != null ? user.renderer.name : "(missing renderer)")}  ·  {status}" +
                            (user.eligible ? $"  ·  Probe: {user.reflectionProbeName}" : "")))
                        SelectRenderers(new[] { user.renderer });
                }
            }
        }
    }

    private void DrawMaterialSlotDiagnostics(List<MeshArrayBaker.RendererReport> users)
    {
        var mismatches = users.Where(u => !u.eligible &&
                                          u.reason != null &&
                                          u.reason.StartsWith("material count mismatch", StringComparison.Ordinal))
            .ToList();
        if (mismatches.Count == 0) return;

        SectionHeader("Material / submesh mismatch");
        foreach (var report in mismatches)
        {
            var renderer = report.renderer;
            var mesh = report.originalMesh;
            if (renderer == null || mesh == null) continue;

            var materials = renderer.sharedMaterials;
            using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
            {
                GUILayout.Label(renderer.name, _bold);
                GUILayout.Label(
                    $"Mesh submeshes: {mesh.subMeshCount}  ·  Renderer material slots: {materials.Length}",
                    _muted);
                GUILayout.Label(
                    "The baker requires one material slot per submesh; Unity's static batching and this bake eligibility check are separate.",
                    _mutedWrap);

                for (int i = 0; i < materials.Length; i++)
                {
                    Material material = materials[i];
                    string materialName = material != null ? material.name : "(missing material)";
                    string shaderName = material != null && material.shader != null
                        ? material.shader.name
                        : "(no shader)";
                    string path = material != null ? AssetDatabase.GetAssetPath(material) : "";

                    using (new EditorGUILayout.HorizontalScope())
                    {
                        GUILayout.Space(12);
                        GUILayout.Label($"Slot {i}: {materialName}  ·  {shaderName}", _mutedWrap);
                    }
                    if (!string.IsNullOrEmpty(path))
                    {
                        using (new EditorGUILayout.HorizontalScope())
                        {
                            GUILayout.Space(28);
                            GUILayout.Label(path, _mutedWrap);
                        }
                    }
                }

                if (materials.Length < mesh.subMeshCount)
                    GUILayout.Label($"Material array has {mesh.subMeshCount - materials.Length} fewer slot(s) than submeshes; the baker will not infer this mapping.",
                        _mutedWrap);
                else if (materials.Length > mesh.subMeshCount)
                    GUILayout.Label($"{materials.Length - mesh.subMeshCount} extra material slot(s) are unused by the mesh.",
                        _mutedWrap);
            }
        }
    }

    private void DrawMeshDetails(BakeStats.MeshRow row)
    {
        Mesh bakedMesh = row.users.Where(u => u.eligible && u.applied)
            .Select(BakeStats.CurrentMesh).FirstOrDefault(m => m != null);

        using (new EditorGUILayout.HorizontalScope())
        {
            DrawMeshPreviewColumn("Original", row.mesh);
            if (bakedMesh != null && bakedMesh != row.mesh)
                DrawMeshPreviewColumn(row.bakedMeshes > 1 ? $"Baked sample ({row.bakedMeshes})" : "Baked", bakedMesh);

            GUILayout.Space(8);
            using (new EditorGUILayout.VerticalScope(GUILayout.ExpandWidth(true)))
            {
                GUILayout.Label(row.name, _bold);
                StatRow("Submeshes", $"{row.info.subMeshes}" +
                    (bakedMesh != null ? $" → {bakedMesh.subMeshCount}" : " → not applied"));
                StatRow("Vertices", $"{BakeStats.Count(row.info.vertices)}" +
                    (bakedMesh != null ? $" → {BakeStats.Count(bakedMesh.vertexCount)}" : ""));
                StatRow("Triangles", $"{BakeStats.Count(row.info.triangles)}" +
                    (bakedMesh != null ? $" → {BakeStats.Count(BakeStats.Describe(bakedMesh).triangles)}" : ""));
                StatRow("Runtime", BakeStats.Mb(row.info.bytes) +
                    (bakedMesh != null ? $" → {BakeStats.Mb(BakeStats.RuntimeBytes(bakedMesh))}" : ""));
                StatRow("GPU buffers ≈", BakeStats.Mb(row.info.gpuBufferBytes) +
                    (bakedMesh != null ? $" → {BakeStats.Mb(BakeStats.Describe(bakedMesh).gpuBufferBytes)}" : ""));
                if (!string.IsNullOrEmpty(row.path))
                    GUILayout.Label(row.path, _mutedWrap);
            }
        }
    }

    private void DrawMeshPreviewColumn(string label, Mesh mesh)
    {
        using (new EditorGUILayout.VerticalScope(GUILayout.Width(132)))
        {
            GUILayout.Label(label, _muted);
            var rect = GUILayoutUtility.GetRect(124, 92, GUILayout.Width(124), GUILayout.Height(92));
            if (Event.current.type == EventType.Repaint)
            {
                EditorGUI.DrawRect(rect, new Color(0.12f, 0.12f, 0.12f, 1f));
                if (mesh != null) RenderMeshPreview(rect, mesh);
                else GUI.Label(rect, "Preview unavailable", _muted);
            }
        }
    }

    private void RenderMeshPreview(Rect rect, Mesh mesh)
    {
        if (_meshPreview == null)
        {
            _meshPreview = new PreviewRenderUtility();
            _meshPreview.cameraFieldOfView = 30f;
            _meshPreview.camera.clearFlags = CameraClearFlags.Color;
            _meshPreview.camera.backgroundColor = new Color(0.12f, 0.12f, 0.12f, 1f);
            _meshPreview.lights[0].intensity = 1.2f;
            _meshPreview.lights[0].transform.rotation = Quaternion.Euler(30f, 35f, 0f);
            _meshPreview.lights[1].intensity = 0.8f;
            _meshPreviewMaterial = AssetDatabase.GetBuiltinExtraResource<Material>("Default-Diffuse.mat");
        }

        if (_meshPreviewMaterial == null)
        {
            Debug.LogWarning("[BakeManager] Unity's Default-Diffuse preview material is unavailable.");
            return;
        }

        Bounds bounds = mesh.bounds;
        float diameter = Mathf.Max(bounds.size.x, bounds.size.y, bounds.size.z, 0.001f);
        float scale = 1.6f / diameter;
        Matrix4x4 transform = Matrix4x4.TRS(-bounds.center * scale, Quaternion.identity, Vector3.one * scale);
        _meshPreview.BeginPreview(rect, GUIStyle.none);
        _meshPreview.DrawMesh(mesh, transform, _meshPreviewMaterial, 0);
        _meshPreview.camera.transform.position = new Vector3(2.4f, 1.8f, 2.4f);
        _meshPreview.camera.transform.rotation = Quaternion.LookRotation(-_meshPreview.camera.transform.position);
        _meshPreview.camera.nearClipPlane = 0.01f;
        _meshPreview.camera.farClipPlane = 20f;
        _meshPreview.camera.Render();
        GUI.DrawTexture(rect, _meshPreview.EndPreview(), ScaleMode.ScaleToFit, false);
    }
}
