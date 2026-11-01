using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using Meenphie.Commons;

public partial class BakeManagerWindow
{
    private void DrawOverview()
    {
        DrawSceneKpis();
        DrawFrameStats();
        DrawHealth();

        SectionHeader("Lighting and probes");
        foreach (var op in _lightingOps) DrawOpCard(op);

        SectionHeader("Mesh arrays and material table");
        DrawOpCard(_meshOp);
        GUILayout.Label("Rebake always re-reads the original meshes and re-applies if the scene is already applied. " +
                        "Shader keyword: _UDON_MESH_ARRAYS_ON.", _mutedWrap);
    }

    private void DrawSceneKpis()
    {
        SectionHeader("Scene");
        var s = Stats();
        if (s.renderers == 0)
        {
            Callout(Tone.Neutral, "No renderer with a mesh in the loaded scenes.");
            return;
        }

        string Was(string v) => s.anyApplied ? "was " + v : "unique meshes";

        var cards = new List<Kpi>
        {
            new Kpi("Renderers", s.eligible.ToString(),
                $"{s.applied} applied · {s.skipped} skipped · {s.renderers} total",
                s.eligible > 0 && s.applied == s.eligible ? Tone.Ok : Tone.Info,
                "Eligible renderers (baked, or ready to bake)"),

            new Kpi("Materials", $"{s.sourceMaterials} → {s.sharedMaterials}", "source → shared baked",
                Tone.Info, "Distinct source materials vs baked shared materials"),

            new Kpi("Submeshes", $"{s.subBefore} → {s.subNow}",
                $"{BakeStats.Delta(s.subBefore, s.subNow)} · draw call proxy",
                DeltaTone(s.subBefore, s.subNow, true),
                "Submeshes before the bake vs after (projected until applied)"),

            new Kpi("Mesh memory", BakeStats.Mb(s.meshBytesNow),
                s.anyApplied ? $"was {BakeStats.Mb(s.meshBytesBefore)} · {BakeStats.Delta(s.meshBytesBefore, s.meshBytesNow)}" : "original meshes",
                DeltaTone(s.meshBytesBefore, s.meshBytesNow, s.anyApplied),
                "Runtime memory of the unique meshes used by eligible renderers"),

            new Kpi("Vertices", BakeStats.Count(s.vertsNow), Was(BakeStats.Count(s.vertsBefore)),
                DeltaTone(s.vertsBefore, s.vertsNow, s.anyApplied)),

            new Kpi("Triangles", BakeStats.Count(s.trisNow), Was(BakeStats.Count(s.trisBefore)),
                DeltaTone(s.trisBefore, s.trisNow, s.anyApplied)),

            TextureKpi()
        };
        DrawKpiGrid(cards);
    }

    private static Tone DeltaTone(long before, long now, bool applied)
    {
        if (!applied || before == now) return Tone.Info;
        return now < before ? Tone.Ok : Tone.Warn;
    }

    private Kpi TextureKpi()
    {
        long bytes = 0;
        int arrays = 0;
        for (int i = 0; i < ChannelNames.Length; i++)
        {
            var c = Channel(i);
            if (c.array == null) continue;
            arrays++;
            bytes += c.arrayBytes;
        }
        long table = TableBytes();
        bytes += table;

        if (arrays == 0 && table == 0) return new Kpi("Texture arrays", "—", "not baked", Tone.Neutral);
        return new Kpi("Texture arrays", BakeStats.Mb(bytes), $"{arrays} array(s) + material table", Tone.Info,
            "Runtime memory of the baked Texture2DArrays and the material table");
    }

    private long TableBytes()
    {
        if (_tableBytes < 0) _tableBytes = BakeStats.RuntimeBytes(MeshArrayBaker.LoadTable());
        return _tableBytes;
    }

    private void DrawFrameStats()
    {
        SectionHeader("Rendering — latest editor frame");
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                using (new EditorGUILayout.VerticalScope(GUILayout.ExpandWidth(true)))
                {
                    StatRow("Batches", UnityStats.batches.ToString("N0"));
                    StatRow("Draw calls", UnityStats.drawCalls.ToString("N0"));
                    StatRow("SetPass", UnityStats.setPassCalls.ToString("N0"));
                }
                using (new EditorGUILayout.VerticalScope(GUILayout.ExpandWidth(true)))
                {
                    StatRow("Static batches", UnityStats.staticBatches.ToString("N0"));
                    StatRow("Dynamic batches", UnityStats.dynamicBatches.ToString("N0"));
                    StatRow("Instanced batches", UnityStats.instancedBatches.ToString("N0"));
                }
                using (new EditorGUILayout.VerticalScope(GUILayout.ExpandWidth(true)))
                {
                    StatRow("Triangles", BakeStats.Count(UnityStats.triangles));
                    StatRow("Vertices", BakeStats.Count(UnityStats.vertices));
                    StatRow("Shadow casters", UnityStats.shadowCasters.ToString("N0"));
                }
            }
            GUILayout.Label("Valeurs Unity de la dernière frame rendue (Game View ou Scene View) ; elles ne mesurent pas uniquement les objets bakés.",
                _mutedWrap);
        }
    }

    private void DrawHealth()
    {
        var s = Stats();
        if (s.renderers == 0) return;

        var mesh = Info(_meshOp);
        GUILayout.Space(4);

        if (s.eligible > 0 && !mesh.baked)
        {
            Callout(Tone.Info, "Nothing baked yet. Use Bake All, or Bake on the Mesh arrays card below.");
        }
        else if (mesh.baked && s.applied < s.eligible)
        {
            if (Callout(Tone.Warn, $"{s.eligible - s.applied} renderer(s) still use their original mesh/materials.", "Apply"))
            {
                ApplyToScene();
                GUIUtility.ExitGUI();
            }
        }
        else if (s.eligible > 0)
        {
            Callout(Tone.Ok, "Up to date: every eligible renderer uses its baked mesh and shared material.");
        }

        if (s.skipped > 0)
        {
            if (Callout(Tone.Neutral, $"{s.skipped} renderer(s) skipped: {s.SkipSummary()}", "Review"))
            {
                _meshView = 2;
                _tab = Tab.Meshes;
                _scroll = Vector2.zero;
                Repaint();
            }
        }

        foreach (var op in AllOps())
        {
            var info = Info(op);
            if (info.warn)
                Callout(Tone.Warn, $"{op.DisplayName}: {info.count} slices, above the supported limit.");
        }
    }

    private void DrawOpCard(IBakeOperation op)
    {
        var info = Info(op);
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            using (new EditorGUILayout.HorizontalScope())
            {
                GUILayout.Label(op.DisplayName, _bold, GUILayout.Height(22));

                string state = info.baked ? "Baked" : "Not baked";
                float pw = PillWidth(state);
                var pr = GUILayoutUtility.GetRect(pw, 18, GUILayout.Width(pw), GUILayout.Height(18));
                pr.y += 2;
                Pill(pr, state, ToneColor(info.baked ? Tone.Ok : Tone.Neutral));

                GUILayout.FlexibleSpace();

                if (info.warn)
                    GUILayout.Label(new GUIContent($" {info.count} slices (too many)",
                        EditorGUIUtility.IconContent("console.warnicon.sml").image), _muted, GUILayout.Height(22));
                else if (info.count > 0)
                    GUILayout.Label($"{info.count} slices max", _muted, GUILayout.Height(22));
            }

            GUILayout.Label(info.status, _mutedWrap);
            GUILayout.Space(4);

            using (new EditorGUILayout.HorizontalScope())
            {
                if (GUILayout.Button(info.baked ? "Rebake" : "Bake", GUILayout.Width(90), GUILayout.Height(24)))
                {
                    BakePreview.Suspend();
                    op.Bake();
                    LightingEditorScene.RebuildLightData();
                    InvalidateAll();
                    GUIUtility.ExitGUI();
                }

                if (op is MeshArraysBakeOp)
                {
                    using (new EditorGUI.DisabledScope(!info.baked))
                        if (GUILayout.Button("Apply", GUILayout.Width(90), GUILayout.Height(24)))
                        {
                            ApplyToScene();
                            GUIUtility.ExitGUI();
                        }
                }

                using (new EditorGUI.DisabledScope(!info.baked))
                    if (GUILayout.Button("Delete", GUILayout.Width(90), GUILayout.Height(24)))
                    {
                        if (EditorUtility.DisplayDialog($"Delete {op.DisplayName}", "Confirmer la suppression ?", "Delete", "Cancel"))
                        {
                            BakePreview.Suspend();
                            op.Delete();
                            LightingEditorScene.RebuildLightData();
                            InvalidateAll();
                        }
                        GUIUtility.ExitGUI();
                    }
            }
        }
    }
}
