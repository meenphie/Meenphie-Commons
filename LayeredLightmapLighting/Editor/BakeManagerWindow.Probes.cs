using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Meenphie.Commons;

public partial class BakeManagerWindow
{
    private void DrawProbesTab()
    {
        // --- DIAGNOSTIC & ASSIGNATION ---
        DrawProbeHotspotControls();

        var allBakedProbes = ReflectionProbeArrayBuilder.GetAllBakedProbes();
        var plan = MeshArrayBaker.CreateReflectionProbePlan();
        var assignments = plan.Assignments.ToList();
        var probes = plan.Probes;
        var meshReports = Scan()
            .Where(report => report.renderer != null)
            .ToDictionary(report => (Renderer)report.renderer);
        int assignedCount = assignments.Count(assignment => assignment.Value >= 0);
        int unassignedCount = assignments.Count - assignedCount;

        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label($"{probes.Length} used / {allBakedProbes.Length} baked probes", _bold);
            GUILayout.FlexibleSpace();
            GUILayout.Label($"{assignedCount} assigned · {unassignedCount} unassigned", _muted);
        }

        if (probes.Length == 0)
        {
            Callout(Tone.Warn, allBakedProbes.Length == 0
                ? "No baked reflection probes found. Bake probes before assigning them to meshes."
                : "No baked reflection probe is assigned to an eligible mesh. None will be included in the probe arrays.");
            return;
        }

        string query = (_search ?? "").Trim();
        for (int probeIndex = 0; probeIndex < probes.Length; probeIndex++)
        {
            var probe = probes[probeIndex];
            var users = assignments
                .Where(assignment => assignment.Value == probeIndex)
                .Select(assignment => assignment.Key)
                .Where(r => query.Length == 0 ||
                            Has(r != null ? r.name : "", query) ||
                            Has(ProbeRendererMesh(r) != null ? ProbeRendererMesh(r).name : "", query) ||
                            Has(probe.name, query))
                .ToList();
            if (query.Length > 0 && users.Count == 0 && !Has(probe.name, query))
                continue;

            string key = "probe:" + probeIndex + ":" + probe.GetInstanceID();
            bool isOpen = _open.Contains(key);
            using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
            {
                using (new EditorGUILayout.HorizontalScope())
                {
                    if (GUILayout.Button(isOpen ? "▼" : "▶", EditorStyles.miniButton, GUILayout.Width(24)))
                    {
                        if (isOpen) _open.Remove(key); else _open.Add(key);
                    }

                    var nameRect = GUILayoutUtility.GetRect(0, 20, GUILayout.MinWidth(100), GUILayout.ExpandWidth(true));
                    if (Link(nameRect, probe.name, "Select this reflection probe in the scene"))
                    {
                        Selection.activeGameObject = probe.gameObject;
                        EditorGUIUtility.PingObject(probe.gameObject);
                    }

                    Pill(GUILayoutUtility.GetRect(72, 18, GUILayout.Width(72), GUILayout.Height(18)),
                        $"{users.Count} meshes", ToneColor(users.Count > 0 ? Tone.Ok : Tone.Neutral));
                }

                GUILayout.Label(
                    $"Importance {probe.importance:G3}  ·  Bounds {probe.bounds.size.x:G3} × {probe.bounds.size.y:G3} × {probe.bounds.size.z:G3}" +
                    (probe.boxProjection ? "  ·  Box projection" : ""),
                    _muted);

                if (!isOpen) continue;

                if (users.Count == 0)
                {
                    GUILayout.Label("No eligible renderer assigned.", _muted);
                    continue;
                }

                foreach (var renderer in users)
                {
                    Mesh mesh = ProbeRendererMesh(renderer);
                    string meshName = mesh != null ? mesh.name : "(missing mesh)";
                    string state = renderer is SkinnedMeshRenderer
                        ? "skinned"
                        : meshReports.TryGetValue(renderer, out var report) && report.applied
                            ? "applied"
                            : "pending bake/apply";
                    if (Link(GUILayoutUtility.GetRect(0, RowH, GUILayout.ExpandWidth(true)),
                            $"{renderer.name}  ·  {meshName}  ·  {state}"))
                    {
                        Selection.activeGameObject = renderer.gameObject;
                        EditorGUIUtility.PingObject(renderer.gameObject);
                    }
                }
            }
        }

        var unassigned = assignments
            .Where(assignment => assignment.Value < 0)
            .Select(assignment => assignment.Key)
            .Where(r => query.Length == 0 ||
                        Has(r != null ? r.name : "", query) ||
                        Has(ProbeRendererMesh(r) != null ? ProbeRendererMesh(r).name : "", query))
            .ToList();
        if (unassigned.Count == 0) return;

        SectionHeader($"No probe assigned ({unassigned.Count})");
        GUILayout.Label("These renderers have no matching baked probe assignment.", _mutedWrap);
        foreach (var renderer in unassigned)
        {
            Mesh mesh = ProbeRendererMesh(renderer);
            string meshName = mesh != null ? mesh.name : "(missing mesh)";
            if (Link(GUILayoutUtility.GetRect(0, RowH, GUILayout.ExpandWidth(true)),
                    $"{renderer.name}  ·  {meshName}"))
            {
                Selection.activeGameObject = renderer.gameObject;
                EditorGUIUtility.PingObject(renderer.gameObject);
            }
        }
    }

    private static Mesh ProbeRendererMesh(Renderer renderer)
    {
        if (renderer is SkinnedMeshRenderer skinnedRenderer)
            return skinnedRenderer.sharedMesh;

        MeshFilter meshFilter = renderer != null ? renderer.GetComponent<MeshFilter>() : null;
        return meshFilter != null ? meshFilter.sharedMesh : null;
    }

    private void DrawProbeHotspotControls()
    {
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            bool removeBrightPixels = EditorGUILayout.ToggleLeft(
                "Remove bright pixels from probe captures",
                ReflectionProbeArrayBuilder.RemoveBrightPixels);
            if (removeBrightPixels != ReflectionProbeArrayBuilder.RemoveBrightPixels)
                ReflectionProbeArrayBuilder.RemoveBrightPixels = removeBrightPixels;

            using (new EditorGUI.DisabledScope(!removeBrightPixels))
            {
                float threshold = EditorGUILayout.FloatField(
                    "Linear RGB max-channel threshold",
                    ReflectionProbeArrayBuilder.BrightPixelThreshold);
                if (!Mathf.Approximately(threshold, ReflectionProbeArrayBuilder.BrightPixelThreshold))
                    ReflectionProbeArrayBuilder.BrightPixelThreshold = threshold;

                float feather = EditorGUILayout.Slider(
                    "Threshold feather",
                    ReflectionProbeArrayBuilder.BrightPixelFeather,
                    0f,
                    0.5f);
                if (!Mathf.Approximately(feather, ReflectionProbeArrayBuilder.BrightPixelFeather))
                    ReflectionProbeArrayBuilder.BrightPixelFeather = feather;

                int replacement = EditorGUILayout.Popup(
                    "Replacement",
                    ReflectionProbeArrayBuilder.BrightPixelReplacement,
                    new[] { "Black", "Estimate from nearby pixels" });
                if (replacement != ReflectionProbeArrayBuilder.BrightPixelReplacement)
                    ReflectionProbeArrayBuilder.BrightPixelReplacement = replacement;
            }

            EditorGUILayout.HelpBox(
                "The arrays are stored as compressed SDR textures. Threshold feather blends the replacement across a linear-brightness band around the threshold. Nearby-pixel estimation can hide small light sources, but cannot reconstruct what was occluded behind them. Rebuild the arrays after changing these settings.",
                MessageType.Info);

            using (new EditorGUI.DisabledScope(EditorApplication.isPlaying))
            {
                if (GUILayout.Button("Rebuild Reflection Probe Arrays"))
                {
                    BakePreview.Suspend();
                    ReflectionProbeArrayBuilder.Build();
                    InvalidateAll();
                }
            }
        }
    }
}