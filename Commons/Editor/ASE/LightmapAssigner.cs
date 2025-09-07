using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;

public static class LightmapAssigner
{
    [MenuItem("Meenphie/Assign Lightmaps")]
    public static void AssignLightmaps()
    {
        // Collect all GI materials in the active scene
        HashSet<Material> sceneMaterials = CollectSceneMaterials();

        string[] shaderProps = { "_RNMX0", "_RNMY0", "_RNMZ0" };

        // Find all available lightmap groups in the project
        Dictionary<string, Texture[]> lightmapGroups = BuildLightmapGroups();

        int assignCount = 0;
        int matIndex = 0;
        int totalMats = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                float progress = (float)matIndex / totalMats;
                EditorUtility.DisplayProgressBar("Assigning Lightmaps", $"Processing {mat.name}...", progress);

                foreach (var kvp in lightmapGroups)
                {
                    string groupName = kvp.Key;
                    string cleanGroupName = groupName.Replace("GI ", "").Trim();

                    if (mat.name.IndexOf(cleanGroupName, System.StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        Texture[] texSet = kvp.Value;

                        for (int i = 0; i < 3; i++)
                        {
                            if (texSet[i] == null) continue;

                            Texture currentTex = mat.GetTexture(shaderProps[i]);
                            if (currentTex != null && currentTex.name == texSet[i].name)
                                continue;

                            mat.SetTexture(shaderProps[i], texSet[i]);
                            EditorUtility.SetDirty(mat);
                            assignCount++;
                        }

                        break; // found matching group, stop searching
                    }
                }

                matIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        
        Debug.Log($"[<color=purple>Meenphie</color>] {assignCount} Lightmaps assigned");
    }

    [MenuItem("Meenphie/Unassign Lightmaps")]
    public static void UnassignLightmaps()
    {
        // Collect all GI materials in the active scene
        HashSet<Material> sceneMaterials = CollectSceneMaterials();

        string[] shaderProps = { "_RNMX0", "_RNMY0", "_RNMZ0" };

        int unassignCount = 0;
        int matIndex = 0;
        int totalMats = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                float progress = (float)matIndex / totalMats;
                EditorUtility.DisplayProgressBar("Unassigning Lightmaps", $"Processing {mat.name}...", progress);

                for (int i = 0; i < 3; i++)
                {
                    if (mat.GetTexture(shaderProps[i]) != null)
                    {
                        mat.SetTexture(shaderProps[i], null);
                        EditorUtility.SetDirty(mat);
                        unassignCount++;
                    }
                }

                matIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();

        Debug.Log($"[<color=purple>Meenphie</color>] {unassignCount} Lightmaps unassigned");
    }

    // --- Helpers ---
    private static HashSet<Material> CollectSceneMaterials()
    {
        HashSet<Material> sceneMaterials = new HashSet<Material>();
        foreach (GameObject go in SceneManager.GetActiveScene().GetRootGameObjects())
        {
            Renderer[] renderers = go.GetComponentsInChildren<Renderer>(true);
            foreach (Renderer rend in renderers)
            {
                foreach (Material mat in rend.sharedMaterials)
                {
                    if (mat != null && mat.name.StartsWith("GI"))
                        sceneMaterials.Add(mat);
                }
            }
        }
        return sceneMaterials;
    }

    private static Dictionary<string, Texture[]> BuildLightmapGroups()
    {
        Dictionary<string, Texture[]> lightmapGroups = new Dictionary<string, Texture[]>();

        string[] rnmxGuids = AssetDatabase.FindAssets("_RNMX t:Texture");
        foreach (string guid in rnmxGuids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            Texture texX = AssetDatabase.LoadAssetAtPath<Texture>(path);
            if (texX == null) continue;

            string baseName = texX.name.Replace("_RNMX", "");
            if (!lightmapGroups.ContainsKey(baseName))
                lightmapGroups[baseName] = new Texture[3];

            lightmapGroups[baseName][0] = texX; // RNMX

            string[] yGuids = AssetDatabase.FindAssets(baseName + "_RNMY t:Texture");
            if (yGuids.Length > 0)
                lightmapGroups[baseName][1] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(yGuids[0]));

            string[] zGuids = AssetDatabase.FindAssets(baseName + "_RNMZ t:Texture");
            if (zGuids.Length > 0)
                lightmapGroups[baseName][2] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(zGuids[0]));
        }

        return lightmapGroups;
    }
}
