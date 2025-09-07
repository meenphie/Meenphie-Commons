using UnityEngine;
using UnityEditor;

public static class LODTools
{
    [MenuItem("Meenphie/Set LODs")]
    private static void SetLods()
    {
        var lodGroups = Object.FindObjectsOfType<LODGroup>();
        int count = 0;

        foreach (var lodGroup in lodGroups)
        {
            var lods = lodGroup.GetLODs();
            if (lods.Length == 0)
                continue;

            bool changed = false;
            var lodArray = new LOD[lods.Length];

            for (int i = 0; i < lods.Length; i++)
            {
                lodArray[i] = lods[i];
                float targetHeight = lodArray[i].screenRelativeTransitionHeight;

                if (i == lods.Length - 1)
                {
                    targetHeight = 0.05f; // Last LOD
                }
                else if (i == 0)
                {
                    targetHeight = 0.5f; // First LOD
                }
                else if (i == 1)
                {
                    targetHeight = 0.25f; // Second LOD
                }

                if (!Mathf.Approximately(lodArray[i].screenRelativeTransitionHeight, targetHeight))
                {
                    lodArray[i].screenRelativeTransitionHeight = targetHeight;
                    changed = true;
                }
            }

            if (changed)
            {
                Undo.RecordObject(lodGroup, "Set LODs");
                lodGroup.SetLODs(lodArray);
                lodGroup.RecalculateBounds();
                EditorUtility.SetDirty(lodGroup);
                count++;
            }
        }

        if (count > 0)
            Debug.Log($"[<color=purple>Meenphie</color>] Updated LODs for {count} LODGroup(s).");
        else
            Debug.Log("[<color=purple>Meenphie</color>] No LODs needed updating.");
    }
}
