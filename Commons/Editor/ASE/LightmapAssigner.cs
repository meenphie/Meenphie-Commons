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
        // Collect all GI materials in the active scene
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

        // Find all available lightmap groups in the project
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

            // Load matching RNMY
            string[] yGuids = AssetDatabase.FindAssets(baseName + "_RNMY t:Texture");
            if (yGuids.Length > 0)
                lightmapGroups[baseName][1] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(yGuids[0]));

            // Load matching RNMZ
            string[] zGuids = AssetDatabase.FindAssets(baseName + "_RNMZ t:Texture");
            if (zGuids.Length > 0)
                lightmapGroups[baseName][2] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(zGuids[0]));
        }

        int assignCount = 0;
        int matIndex = 0;
        int totalMats = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                float progress = (float)matIndex / totalMats;
                EditorUtility.DisplayProgressBar("Assigning Lightmaps", $"Processing {mat.name}...", progress);

                bool assignedAny = false;

                foreach (var kvp in lightmapGroups)
                {
                    string groupName = kvp.Key;

                    if (mat.name.IndexOf(groupName, System.StringComparison.OrdinalIgnoreCase) >= 0)
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
                            assignedAny = true;
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
        Debug.Log($"Lightmap assignment complete. Total assignments made: {assignCount}");
    }
}
