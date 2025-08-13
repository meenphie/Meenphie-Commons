using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;

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

        Debug.Log($"Found {sceneMaterials.Count} GI materials in scene.");

        string[] suffixes = { "_RNMX", "_RNMY", "_RNMZ" };
        string[] shaderProps = { "_RNMX0", "_RNMY0", "_RNMZ0" };

        int matIndex = 0;
        int totalSteps = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                float progress = (float)matIndex / totalSteps;
                EditorUtility.DisplayProgressBar("Assigning Lightmaps", $"Processing {mat.name}...", progress);

                string matName = mat.name;

                for (int i = 0; i < suffixes.Length; i++)
                {
                    string searchName = matName + suffixes[i];

                    // Skip if already correct
                    Texture currentTex = mat.GetTexture(shaderProps[i]);
                    if (currentTex != null && currentTex.name == searchName)
                        continue;

                    // Find and assign texture
                    string[] texGuids = AssetDatabase.FindAssets(searchName + " t:Texture");
                    if (texGuids.Length > 0)
                    {
                        string texPath = AssetDatabase.GUIDToAssetPath(texGuids[0]);
                        Texture tex = AssetDatabase.LoadAssetAtPath<Texture>(texPath);

                        if (tex != null)
                        {
                            mat.SetTexture(shaderProps[i], tex);
                            Debug.Log($"Assigned {tex.name} → {mat.name}:{shaderProps[i]}");
                            EditorUtility.SetDirty(mat);
                        }
                    }
                    else
                    {
                        Debug.LogWarning($"No texture found for {searchName} for material {mat.name}");
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
    }
}
