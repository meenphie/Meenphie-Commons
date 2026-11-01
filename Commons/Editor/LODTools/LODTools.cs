using UnityEngine;
using UnityEditor;

public static class LODTools
{
    // Constantes pour éviter les magic numbers
    private const float LOD0_HEIGHT = 0.6f;   // Premier LOD
    private const float LOD1_HEIGHT = 0.25f;  // Deuxième LOD
    private const float LAST_LOD_HEIGHT = 0.05f; // Dernier LOD (culled)
    private const float MAX_LOD_GROUP_SIZE = 4f;

    [MenuItem("Meenphie/LOD/Set LODs Distances")]
    public static void SetLods()
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

                // ⚠️ L'ordre est important (comme ton ancien script)
                if (i == lods.Length - 1)
                {
                    targetHeight = LAST_LOD_HEIGHT;
                }
                else if (i == 0)
                {
                    targetHeight = LOD0_HEIGHT;
                }
                else if (i == 1)
                {
                    targetHeight = LOD1_HEIGHT;
                }

                if (!Mathf.Approximately(lodArray[i].screenRelativeTransitionHeight, targetHeight))
                {
                    lodArray[i].screenRelativeTransitionHeight = targetHeight;
                    changed = true;
                }
            }

            bool sizeChanged = lodGroup.size > MAX_LOD_GROUP_SIZE;
            if (changed || sizeChanged)
            {
                Undo.RecordObject(lodGroup, "Set LODs");

                if (changed)
                {
                    lodGroup.SetLODs(lodArray);
                    lodGroup.RecalculateBounds();
                }

                if (lodGroup.size > MAX_LOD_GROUP_SIZE)
                    lodGroup.size = MAX_LOD_GROUP_SIZE;

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
    public static void RemoveExtraColliders()
    {
        var lodGroups = Object.FindObjectsOfType<LODGroup>();
        var collidersToRemove = new System.Collections.Generic.HashSet<Collider>();
        var collidersToKeep = new System.Collections.Generic.HashSet<Collider>();
        var lod1Renderers = new System.Collections.Generic.HashSet<Renderer>();

        foreach (var lodGroup in lodGroups)
        {
            var lods = lodGroup.GetLODs();
            if (lods.Length == 0)
                continue;

            for (int i = 0; i < lods.Length; i++)
            {
                bool isLod1 = i == 1;
                var target = isLod1 ? collidersToKeep : collidersToRemove;
                foreach (var renderer in lods[i].renderers)
                {
                    if (renderer == null) continue;

                    if (isLod1)
                        lod1Renderers.Add(renderer);

                    foreach (var collider in renderer.GetComponentsInChildren<Collider>(true))
                        target.Add(collider);
                }
            }
        }

        int removedCount = 0;
        int addedCount = 0;
        int restoredCount = 0;
        int convexCount = 0;
        int skippedModelColliderCount = 0;
        int missingMeshCount = 0;

        foreach (var renderer in lod1Renderers)
        {
            restoredCount += RestoreRemovedColliders(renderer);

            var rendererColliders = renderer.GetComponentsInChildren<Collider>(true);
            foreach (var collider in rendererColliders)
                collidersToKeep.Add(collider);

            if (rendererColliders.Length > 0)
                continue;

            var meshFilter = renderer.GetComponent<MeshFilter>();
            if (meshFilter == null || meshFilter.sharedMesh == null)
            {
                missingMeshCount++;
                continue;
            }

            var meshCollider = Undo.AddComponent<MeshCollider>(renderer.gameObject);
            if (meshCollider == null)
            {
                missingMeshCount++;
                continue;
            }

            Undo.RecordObject(meshCollider, "Assign LOD1 Mesh Collider");
            meshCollider.sharedMesh = meshFilter.sharedMesh;
            meshCollider.convex = false;
            EditorUtility.SetDirty(meshCollider);
            collidersToKeep.Add(meshCollider);
            addedCount++;
        }

        foreach (var collider in collidersToKeep)
        {
            if (!(collider is MeshCollider meshCollider) || !meshCollider.convex)
                continue;

            if (IsImporterOwnedModelCollider(collider))
            {
                skippedModelColliderCount++;
                continue;
            }

            Undo.RecordObject(meshCollider, "Disable Convex on LOD1 Collider");
            meshCollider.convex = false;
            EditorUtility.SetDirty(meshCollider);
            convexCount++;
        }

        collidersToRemove.ExceptWith(collidersToKeep);
        foreach (var collider in collidersToRemove)
        {
            if (IsImporterOwnedModelCollider(collider))
            {
                skippedModelColliderCount++;
                continue;
            }

            Undo.DestroyObjectImmediate(collider);
            removedCount++;
        }

        if (removedCount > 0 || addedCount > 0 || restoredCount > 0 || convexCount > 0 || skippedModelColliderCount > 0 || missingMeshCount > 0)
            Debug.Log($"[<color=purple>Meenphie</color>] Removed {removedCount} collider(s), restored {restoredCount} removed LOD1 collider override(s), added {addedCount} fallback LOD1 MeshCollider(s), disabled Convex on {convexCount}, skipped {skippedModelColliderCount} FBX collider removal(s), and found {missingMeshCount} LOD1 renderer(s) without a usable MeshFilter.");
        else
            Debug.Log("[<color=purple>Meenphie</color>] No collider changes needed.");

        if (skippedModelColliderCount > 0)
            Debug.LogWarning("[Meenphie] Some FBX importer-owned colliders cannot be changed on the scene instance. Adjust their collider setup in the FBX importer/source; added scene-instance colliders remain editable.");
        if (missingMeshCount > 0)
            Debug.LogWarning("[Meenphie] Some LOD1 renderers have no MeshFilter with a mesh; their colliders could not be recreated automatically.");
    }

    private static bool IsImporterOwnedModelCollider(Collider collider)
    {
        return PrefabUtility.GetPrefabAssetType(collider.gameObject) == PrefabAssetType.Model &&
               !PrefabUtility.IsAddedComponentOverride(collider);
    }

    private static int RestoreRemovedColliders(Renderer renderer)
    {
        GameObject prefabRoot = PrefabUtility.GetOutermostPrefabInstanceRoot(renderer.gameObject);
        if (prefabRoot == null)
            return 0;

        var rendererObjects = new System.Collections.Generic.HashSet<GameObject>();
        foreach (var child in renderer.GetComponentsInChildren<Transform>(true))
            rendererObjects.Add(child.gameObject);

        int restoredCount = 0;
        var removedComponents = PrefabUtility.GetRemovedComponents(prefabRoot);
        foreach (var removed in removedComponents)
        {
            if (!(removed.assetComponent is Collider) ||
                removed.containingInstanceGameObject == null ||
                !rendererObjects.Contains(removed.containingInstanceGameObject))
                continue;

            PrefabUtility.RevertRemovedComponent(
                removed.containingInstanceGameObject,
                removed.assetComponent,
                InteractionMode.UserAction);
            restoredCount++;
        }

        return restoredCount;
    }
}
