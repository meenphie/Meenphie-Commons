using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Materials tab: baked shared material -> source materials (with shader) -> meshes,
/// then the renderers that were skipped and why.
/// </summary>
public partial class BakeManagerWindow
{
    private void DrawMaterialsTab()
    {
        var scan = Scan();
        if (scan.Count == 0)
        {
            Callout(Tone.Neutral, "No renderer with a mesh in the loaded scenes.");
            return;
        }

        string q = (_search ?? "").Trim();
        var eligible = scan.Where(r => r.eligible).ToList();
        var s = Stats();

        Callout(Tone.Info,
            $"{s.sourceMaterials} source material(s) → {s.sharedMaterials} shared baked material(s). " +
            "Materials with identical rendering state (shader, keywords, LightGroup, render queue) share one baked material; " +
            "submeshes using the same variant are merged into a single draw call.");

        DrawRenderStateVariations(eligible, q);

        var groups = eligible.GroupBy(r => r.sharedMaterialPath).OrderBy(g => g.Key).ToList();
        SectionHeader($"Shared materials ({groups.Count})");
        if (groups.Count == 0)
            GUILayout.Label("No eligible renderer.", _muted);

        foreach (var g in groups)
            DrawSharedGroup(g.Key, g.ToList(), q);

        var skipped = scan.Where(r => !r.eligible).ToList();
        if (skipped.Count > 0)
        {
            SectionHeader($"Not baked ({skipped.Count})");
            foreach (var g in skipped.GroupBy(r => r.reason ?? "unknown").OrderByDescending(g => g.Count()))
                DrawSkippedGroup(g.Key, g.ToList(), q);
        }
    }

    private void DrawRenderStateVariations(List<MeshArrayBaker.RendererReport> eligible, string q)
    {
        var conflicts = eligible
            .Select(r => new { report = r, reasons = RenderStateDifferences(r.originalMaterials) })
            .Where(x => x.reasons.Count > 0)
            .Where(x => q.Length == 0 || MatchesRenderer(x.report, q) ||
                        x.report.originalMaterials.Any(m => m != null && Has(m.name, q)))
            .ToList();

        if (conflicts.Count == 0) return;

        const string key = "diag:variations";
        bool open = q.Length > 0 || _open.Contains(key);
        var row = EditorGUILayout.GetControlRect(false, RowH);
        EditorGUI.DrawRect(row, HeaderBg);
        bool now = EditorGUI.Foldout(new Rect(row.x + 4, row.y, row.width - 8, row.height), open,
            $"Render-state variations inside multi-material renderers ({conflicts.Count})", true, _boldFoldout);
        if (q.Length == 0) { if (now) _open.Add(key); else _open.Remove(key); }
        if (!now) { GUILayout.Space(4); return; }

        foreach (var conflict in conflicts.Take(40))
        {
            string materials = string.Join(", ", conflict.report.originalMaterials
                .Where(m => m != null).Select(m => m.name).Distinct());
            string reason = string.Join(", ", conflict.reasons);
            var r = EditorGUILayout.GetControlRect(false, RowH - 2);

            if (Link(new Rect(r.x + 16, r.y, r.width - 20, r.height),
                    $"{conflict.report.renderer.name}: {reason}", $"Source materials: {materials}"))
                SelectRenderers(new[] { conflict.report.renderer });
        }
        if (conflicts.Count > 40)
            GUILayout.Label($"      … {conflicts.Count - 40} more (use the search field)", _muted);
        GUILayout.Space(4);
    }

    private static List<string> RenderStateDifferences(Material[] materials)
    {
        var differences = new List<string>();
        if (materials == null || materials.Length < 2 || materials.Any(m => m == null)) return differences;
        Material first = materials[0];

        if (materials.Any(m => m.shader != first.shader)) differences.Add("shader");
        foreach (string keyword in new[]
                 {
                     "_DIFFUSE_ON", "_SPECULARS_ON", "_REFLECTIONS_ON",
                     "_UV_UV0", "_UV_UV2", "_EMISSIONUV_UV0", "_EMISSIONUV_UV2",
                     "_ALPHATEST_ON"
                 })
            if (materials.Any(m => m.IsKeywordEnabled(keyword) != first.IsKeywordEnabled(keyword)))
                differences.Add(keyword);

        AddFloatDifference(differences, materials, "_LightGroupMask");
        AddFloatDifference(differences, materials, "_Offset");
        AddFloatDifference(differences, materials, "_MaskClipValue");
        if (materials.Any(m => m.renderQueue != first.renderQueue)) differences.Add("render queue");
        return differences;
    }

    private static void AddFloatDifference(List<string> differences, Material[] materials, string property)
    {
        if (materials.Any(m => m.HasProperty(property) != materials[0].HasProperty(property)))
        {
            differences.Add(property);
            return;
        }
        if (materials[0].HasProperty(property) &&
            materials.Any(m => m.GetFloat(property) != materials[0].GetFloat(property)))
            differences.Add(property);
    }

    private void DrawSharedGroup(string path, List<MeshArrayBaker.RendererReport> reps, string q)
    {
        string name = string.IsNullOrEmpty(path) ? "(no shared material)" : Path.GetFileNameWithoutExtension(path);
        var asset = string.IsNullOrEmpty(path) ? null : AssetDatabase.LoadAssetAtPath<Material>(path);
        bool searching = q.Length > 0;

        var mats = reps.Where(r => r.originalMaterials != null).SelectMany(r => r.originalMaterials)
                       .Where(m => m != null).Distinct().OrderBy(m => m.name).ToList();

        bool groupMatch = searching && Has(name, q);
        var visible = mats.Where(m => !searching || groupMatch || Has(m.name, q) ||
                                      reps.Any(r => r.originalMaterials != null && r.originalMaterials.Contains(m) && MatchesRenderer(r, q))).ToList();
        if (searching && visible.Count == 0) return;

        string openKey = path ?? "";
        bool open = searching || _open.Contains(openKey);
        var row = EditorGUILayout.GetControlRect(false, RowH);
        EditorGUI.DrawRect(row, HeaderBg);

        const float rightW = 230f;
        bool now = EditorGUI.Foldout(new Rect(row.x + 4, row.y, row.width - rightW - 8, row.height), open, name, true, _boldFoldout);
        GUI.Label(new Rect(row.xMax - rightW - 4, row.y, rightW, row.height), $"{reps.Count} renderers · {mats.Count} materials", _mutedR);
        if (asset == null)
        {
            float pw = PillWidth("not baked");
            Pill(new Rect(row.xMax - rightW - pw - 10, row.y + 4, pw, row.height - 8), "not baked", ToneColor(Tone.Warn));
        }
        if (!searching) { if (now) _open.Add(openKey); else _open.Remove(openKey); }
        if (!now) return;

        if (asset != null)
        {
            var pr = EditorGUILayout.GetControlRect(false, RowH - 2);
            AssetLink(new Rect(pr.x + 16, pr.y, pr.width - 20, pr.height), "Ping shared material asset", asset, path);
        }

        foreach (var m in visible)
        {
            var users = reps.Where(r => r.originalMaterials != null && r.originalMaterials.Contains(m)).ToList();

            var mr = EditorGUILayout.GetControlRect(false, RowH);
            var cols = Cols(new Rect(mr.x + 12, mr.y, mr.width - 12, mr.height), 190f, 96f);

            var c = m.HasProperty("_AlbedoColor") ? m.GetColor("_AlbedoColor") : m.HasProperty("_Color") ? m.GetColor("_Color") : Color.white;
            c.a = 1f;
            EditorGUI.DrawRect(new Rect(cols[0].x, mr.y + 5, 14, 14), c);
            AssetLink(new Rect(cols[0].x + 20, mr.y, cols[0].width - 20, mr.height), m.name, m, AssetDatabase.GetAssetPath(m));
            GUI.Label(cols[1], m.shader != null ? m.shader.name : "—", _muted);
            GUI.Label(cols[2], users.Count == 1 ? "1 renderer" : $"{users.Count} renderers", _mutedR);

            var meshGroups = users.GroupBy(r => r.originalMesh).OrderByDescending(x => x.Count()).ToList();
            foreach (var mg in meshGroups.Take(10))
            {
                var lr = EditorGUILayout.GetControlRect(false, RowH - 2);
                int sub = mg.Key != null ? mg.Key.subMeshCount : 0;
                string meshName = mg.Key != null ? mg.Key.name : "(null mesh)";
                string text = $"{meshName}  ×{mg.Count()}" + (sub > 1 ? $"  ·  {sub} submeshes" : "");
                string tip = "Select in hierarchy\nMaterials: " + string.Join(", ",
                    (mg.First().originalMaterials ?? new Material[0]).Where(x => x != null).Select(x => x.name));
                if (Link(new Rect(lr.x + 36, lr.y, lr.width - 40, lr.height), text, tip))
                    SelectRenderers(mg.Select(x => x.renderer));
            }
            if (meshGroups.Count > 10)
                GUILayout.Label($"      … {meshGroups.Count - 10} more mesh(es)", _muted);

            GUILayout.Space(2);
        }
        GUILayout.Space(4);
    }

    private void DrawSkippedGroup(string reason, List<MeshArrayBaker.RendererReport> reps, string q)
    {
        var shown = q.Length == 0 ? reps : reps.Where(r => MatchesRenderer(r, q) ||
                        (r.originalMaterials != null && r.originalMaterials.Any(m => m != null && Has(m.name, q)))).ToList();
        if (shown.Count == 0) return;

        string key = "skip:" + reason;
        bool open = q.Length > 0 || _open.Contains(key);
        var row = EditorGUILayout.GetControlRect(false, RowH);
        EditorGUI.DrawRect(row, HeaderBg);
        bool now = EditorGUI.Foldout(new Rect(row.x + 4, row.y, row.width - 8, row.height), open,
            $"{PrettyReason(reason)}  ({shown.Count})", true, _boldFoldout);
        if (q.Length == 0) { if (now) _open.Add(key); else _open.Remove(key); }
        if (!now) return;

        foreach (var r in shown.Take(60))
        {
            var rr = EditorGUILayout.GetControlRect(false, RowH - 2);
            var mats = (r.originalMaterials ?? new Material[0]).Where(m => m != null).ToList();
            string matNames = string.Join(", ", mats.Select(m => m.name).Distinct());
            string tip = string.Join("\n", mats.Where(m => m.shader != null).Select(m => m.name + " → " + m.shader.name).Distinct());
            string meshName = r.originalMesh != null ? r.originalMesh.name : "(null mesh)";
            if (Link(new Rect(rr.x + 16, rr.y, rr.width - 20, rr.height), $"{r.renderer.name}  ·  {meshName}  ·  {matNames}", tip))
                SelectRenderers(new[] { r.renderer });
        }
        if (shown.Count > 60)
            GUILayout.Label($"      … {shown.Count - 60} more (use the search field)", _muted);
        GUILayout.Space(4);
    }
}
