using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using System.Linq;

public static class LightmapAssigner
{
    [MenuItem("Meenphie/Assign Lightmaps")]
    public static void AssignLightmaps()
    {
        // Collect all GI materials used in the active scene
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

        string[] suffixes = { "_RNMX", "_RNMY", "_RNMZ" };
        string[] shaderProps = { "_RNMX0", "_RNMY0", "_RNMZ0" };

        // Group materials by their detected group name
        Dictionary<string, List<Material>> groups = new Dictionary<string, List<Material>>();

        foreach (Material mat in sceneMaterials)
        {
            string[] words = mat.name.Split(' ', '-', '_')
                                     .Where(w => !string.IsNullOrWhiteSpace(w) && w != "GI")
                                     .ToArray();

            // Pick first word that matches a texture name in the project
            string groupKey = words.FirstOrDefault(word =>
                AssetDatabase.FindAssets(word + "_RNMX t:Texture").Length > 0
            );

            if (string.IsNullOrEmpty(groupKey))
                continue;

            if (!groups.ContainsKey(groupKey))
                groups[groupKey] = new List<Material>();

            groups[groupKey].Add(mat);
        }

        int groupIndex = 0;
        int totalGroups = groups.Count;
        int assignCount = 0;

        try
        {
            foreach (var kvp in groups)
            {
                string groupName = kvp.Key;
                List<Material> materials = kvp.Value;

                float progress = (float)groupIndex / totalGroups;
                EditorUtility.DisplayProgressBar("Assigning Lightmaps", $"Processing group {groupName}...", progress);

                for (int i = 0; i < suffixes.Length; i++)
                {
                    string searchName = groupName + suffixes[i];
                    string[] texGuids = AssetDatabase.FindAssets(searchName + " t:Texture");

                    if (texGuids.Length > 0)
                    {
                        string texPath = AssetDatabase.GUIDToAssetPath(texGuids[0]);
                        Texture tex = AssetDatabase.LoadAssetAtPath<Texture>(texPath);

                        if (tex != null)
                        {
                            foreach (Material mat in materials)
                            {
                                Texture currentTex = mat.GetTexture(shaderProps[i]);
                                if (currentTex != null && currentTex.name == tex.name)
                                    continue;

                                mat.SetTexture(shaderProps[i], tex);
                                EditorUtility.SetDirty(mat);
                                assignCount++;
                            }
                        }
                    }
                    else
                    {
                        Debug.LogWarning($"No texture found for {searchName} (group {groupName})");
                    }
                }

                groupIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();

        Debug.Log($"Added {assignCount} Lightmaps");
    }
}
