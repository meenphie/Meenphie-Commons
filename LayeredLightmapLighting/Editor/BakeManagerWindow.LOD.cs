using UnityEditor;
using UnityEngine;

public partial class BakeManagerWindow
{
    private void DrawLODTab()
    {
        SectionHeader("LOD distances");
        EditorGUILayout.HelpBox(
            "Sets LOD0 to 0.6, LOD1 to 0.25, the last LOD to 0.05, and caps each LODGroup size at 4.",
            MessageType.Info);

        if (GUILayout.Button("Set LOD Distances", GUILayout.Height(30)))
            LODTools.SetLods();

        GUILayout.Space(12);
        SectionHeader("LOD colliders");
        EditorGUILayout.HelpBox(
            "Keeps colliders only on LOD1. Restores removed prefab collider overrides when possible, ensures a collider exists on LOD1, and disables Convex on its MeshColliders.",
            MessageType.Warning);

        if (GUILayout.Button("Remove Extra Colliders", GUILayout.Height(30)) &&
            EditorUtility.DisplayDialog(
                "Remove Extra Colliders",
                "This operation affects LODGroups in all currently loaded scenes. It removes colliders from every LOD except LOD1, where it restores or creates a collider. You can undo scene changes.",
                "Continue",
                "Cancel"))
        {
            LODTools.RemoveExtraColliders();
        }
    }
}
