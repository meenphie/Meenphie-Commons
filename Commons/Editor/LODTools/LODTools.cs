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
            Undo.RecordObject(lodGroup, "Set LODs");

            var lods = lodGroup.GetLODs();
            if (lods.Length == 0)
                continue;

            var lodArray = new LOD[lods.Length];

            for (int i = 0; i < lods.Length; i++)
            {
                lodArray[i] = lods[i];

                if (i == lods.Length - 1)
                {
                    // Always last LOD = culled at 5%
                    lodArray[i].screenRelativeTransitionHeight = 0.05f;
                }
                else if (i == 0)
                {
                    // First LOD = 100%
                    lodArray[i].screenRelativeTransitionHeight = 1f;
                }
                else if (i == 1)
                {
                    // Second LOD = 50%
                    lodArray[i].screenRelativeTransitionHeight = 0.5f;
                }
                // Any intermediate LODs (if >3) keep their current value
            }

            lodGroup.SetLODs(lodArray);
            lodGroup.RecalculateBounds();
            EditorUtility.SetDirty(lodGroup);
            count++;
        }

        Debug.Log($"[<color=purple>Meenphie</color>] Updated LODs for {count} LODGroup(s).");
    }
}
