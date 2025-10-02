using UnityEngine;
using UnityEditor;

public static class LODTools
{
    private const float LOD0_HEIGHT = 0.5f;
    private const float LOD1_HEIGHT = 0.25f;
    private const float LAST_LOD_HEIGHT = 0.05f;

    [MenuItem("Meenphie/LOD/Set LODs Distances")]
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

                if (i == 0)
                {
                    targetHeight = LOD0_HEIGHT;
                }
                else if (i == 1)
                {
                    targetHeight = LOD1_HEIGHT;
                }
                else if (i == lods.Length - 1)
                {
                    targetHeight = LAST_LOD_HEIGHT;
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

    [MenuItem("Meenphie/LOD/Remove Extra Colliders")]
    private static void RemoveCollidersFromNonLOD0()
    {
        var lodGroups = Object.FindObjectsOfType<LODGroup>();
        int removedCount = 0;

        foreach (var lodGroup in lodGroups)
        {
            var lods = lodGroup.GetLODs();
            if (lods.Length <= 1)
                continue;

            // Skip LOD0, process LOD1+
            for (int i = 1; i < lods.Length; i++)
            {
                foreach (var renderer in lods[i].renderers)
                {
                    if (renderer == null) continue;

                    var colliders = renderer.GetComponentsInChildren<Collider>(true);
                    foreach (var collider in colliders)
                    {
                        Undo.DestroyObjectImmediate(collider);
                        removedCount++;
                    }
                }
            }
        }

        if (removedCount > 0)
            Debug.Log($"[<color=purple>Meenphie</color>] Removed {removedCount} Colliders.");
        else
            Debug.Log("[<color=purple>Meenphie</color>] No Colliders found outside LOD0.");
    }
}
