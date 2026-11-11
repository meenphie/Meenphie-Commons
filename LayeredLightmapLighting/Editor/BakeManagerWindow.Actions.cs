using System.Linq;
using System.Text;
using UnityEditor;
using UnityEngine;

/// <summary>Everything that changes the project or the scene. No drawing code in here.</summary>
public partial class BakeManagerWindow
{
    private void ShowMoreMenu(Rect buttonRect)
    {
        var menu = new GenericMenu();

        menu.AddItem(new GUIContent("Refresh scan"), false, () => { RefreshScan(); Repaint(); });
        menu.AddItem(new GUIContent("Copy report to clipboard"), false, () => EditorGUIUtility.systemCopyBuffer = BuildReport());
        menu.AddSeparator("");

        menu.AddItem(new GUIContent("Restore originals (keep assets)"), false, () =>
        {
            BakePreview.Suspend();
            MeshArrayBaker.Restore();
            InvalidateAll();
        });
        menu.AddItem(new GUIContent("Revert prefab mesh and materials"), false, () =>
        {
            if (EditorUtility.DisplayDialog("Revert Prefab",
                "Restaure le Mesh ET les Matériaux d'origine des Prefabs (ex: FBX) ?\n\n" +
                "⚠️ Seuls les meshes et les Matériaux seront restaurés.", "Revert", "Cancel"))
            {
                BakePreview.Suspend();
                RevertPrefabMeshAndMaterials();
                InvalidateAll();
            }
        });
        menu.AddSeparator("");

        menu.AddItem(new GUIContent("Delete all generated assets"), false, () =>
        {
            if (EditorUtility.DisplayDialog("Delete All",
                "Restaure les meshes/matériaux d'origine puis supprime TOUS les assets générés ?", "Delete", "Cancel"))
            {
                BakePreview.Suspend();
                DeleteAll();
                InvalidateAll();
            }
        });

        menu.DropDown(buttonRect);
    }

    private void BakeAll()
    {
        BakePreview.Suspend();
        var ops = AllOps().ToList();
        MeshArrayBaker.ReflectionProbePlan probePlan = MeshArrayBaker.CreateReflectionProbePlan();
        try
        {
            for (int i = 0; i < ops.Count; i++)
            {
                EditorUtility.DisplayProgressBar("Bake All", $"{ops[i].DisplayName}...", (i + 0.5f) / (ops.Count + 1));
                if (ops[i] is ReflectionProbeBakeOp reflectionProbeOp)
                    reflectionProbeOp.Bake(probePlan);
                else if (ops[i] is MeshArraysBakeOp meshArraysOp)
                    meshArraysOp.Bake(probePlan);
                else
                    ops[i].Bake();
            }

            EditorUtility.DisplayProgressBar("Bake All", "Applying to scene...", ops.Count / (float)(ops.Count + 1));
            MeshArrayBaker.Apply(probePlan);
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        LightingEditorScene.RebuildLightData();
        InvalidateAll();
    }

    private void ApplyToScene()
    {
        BakePreview.Suspend();
        MeshArrayBaker.Apply();
        LightingEditorScene.RebuildLightData();
        InvalidateAll();
    }

    private void DeleteAll()
    {
        if (!MeshArrayBaker.DeleteAll()) return;
        foreach (var op in _lightingOps) op.Delete();
        AssetDatabase.Refresh();
        LightingEditorScene.RebuildLightData();
    }

    private void RevertPrefabMeshAndMaterials()
    {
        int count = 0;
#if UNITY_2022_2_OR_NEWER
        var renderers = Object.FindObjectsByType<Renderer>(FindObjectsInactive.Include, FindObjectsSortMode.None);
#else
        var renderers = Object.FindObjectsOfType<Renderer>(true);
#endif
        foreach (var r in renderers)
        {
            if (!(r is MeshRenderer) && !(r is SkinnedMeshRenderer)) continue;
            if (!PrefabUtility.IsPartOfPrefabInstance(r.gameObject)) continue;

            Component meshComponent = r is SkinnedMeshRenderer ? (Component)r : r.GetComponent<MeshFilter>();
            if (meshComponent != null)
            {
                var meshSO = new SerializedObject(meshComponent);
                var meshProp = meshSO.FindProperty("m_Mesh");
                if (meshProp != null) PrefabUtility.RevertPropertyOverride(meshProp, InteractionMode.UserAction);
            }

            var rSO = new SerializedObject(r);
            var matsProp = rSO.FindProperty("m_Materials");
            if (matsProp != null) PrefabUtility.RevertPropertyOverride(matsProp, InteractionMode.UserAction);
            count++;
        }
        Debug.Log($"[BakeManager] Revert terminé : Mesh et Matériaux restaurés sur {count} objets.");
    }

    /// <summary>Plain-text summary of the current state, handy for a PR, a ticket or a Discord message.</summary>
    private string BuildReport()
    {
        var s = Stats();
        var sb = new StringBuilder();
        sb.AppendLine("Bake Manager report");
        sb.AppendLine("Scene: " + UnityEngine.SceneManagement.SceneManager.GetActiveScene().name);
        sb.AppendLine($"Renderers: {s.eligible} eligible · {s.applied} applied · {s.skipped} skipped");
        if (s.skipped > 0) sb.AppendLine("Skipped: " + s.SkipSummary());
        sb.AppendLine($"Materials: {s.sourceMaterials} source -> {s.sharedMaterials} shared");
        sb.AppendLine($"Submeshes: {s.subBefore} -> {s.subNow} ({BakeStats.Delta(s.subBefore, s.subNow)})");
        sb.AppendLine($"Meshes: {s.meshesBefore} -> {s.meshesNow}");
        sb.AppendLine($"Mesh memory: {BakeStats.Mb(s.meshBytesBefore)} -> {BakeStats.Mb(s.meshBytesNow)} ({BakeStats.Delta(s.meshBytesBefore, s.meshBytesNow)})");
        sb.AppendLine($"GPU mesh buffers (estimate): {BakeStats.Mb(s.meshGpuBytesBefore)} -> {BakeStats.Mb(s.meshGpuBytesNow)}");
        sb.AppendLine($"Vertices: {BakeStats.Count(s.vertsBefore)} -> {BakeStats.Count(s.vertsNow)}");
        sb.AppendLine($"Triangles: {BakeStats.Count(s.trisBefore)} -> {BakeStats.Count(s.trisNow)}");
        sb.AppendLine("Last rendered editor frame (Game View or Scene View; whole view, not bake-only):");
        sb.AppendLine($"Batches: {UnityEditor.UnityStats.batches} · draw calls: {UnityEditor.UnityStats.drawCalls} · SetPass: {UnityEditor.UnityStats.setPassCalls}");
        sb.AppendLine($"Static batches: {UnityEditor.UnityStats.staticBatches} · dynamic batches: {UnityEditor.UnityStats.dynamicBatches} · instanced batches: {UnityEditor.UnityStats.instancedBatches}");
        sb.AppendLine($"Frame geometry: {UnityEditor.UnityStats.triangles} triangles · {UnityEditor.UnityStats.vertices} vertices · {UnityEditor.UnityStats.shadowCasters} shadow casters");

        for (int i = 0; i < ChannelNames.Length; i++)
        {
            var c = Channel(i);
            if (c.array == null) continue;
            sb.AppendLine($"Array {ChannelNames[i]}: {c.array.width}x{c.array.height} · {c.array.depth} slices · {BakeStats.Mb(c.arrayBytes)}");
        }
        long table = TableBytes();
        if (table > 0) sb.AppendLine($"Material table: {BakeStats.Mb(table)}");
        return sb.ToString();
    }
}
