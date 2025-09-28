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

        // Shader property groups (slot 0 = ON, slot 1 = OFF)
        string[][] shaderPropGroups = {
            new string[] { "_RNMX0", "_RNMY0", "_RNMZ0" }, // Slot 0 (OFF)
            new string[] { "_RNMX1", "_RNMY1", "_RNMZ1" }  // Slot 1 (ON)
        };

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
                    string groupName = kvp.Key; // e.g. "Balcony ON" or "Balcony OFF"
                    string cleanGroupName = groupName.Replace("GI ", "").Trim();

                    // Match without ON/OFF suffix for base detection
                    string baseName = cleanGroupName.Replace(" ON", "").Replace(" OFF", "").Trim();

                    if (mat.name.IndexOf(baseName, System.StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        Texture[] texSet = kvp.Value;
                        int slotIndex = groupName.EndsWith("OFF") ? 0 : 1; // decide ON vs OFF

                        for (int i = 0; i < 3; i++)
                        {
                            if (texSet[i] == null) continue;

                            string prop = shaderPropGroups[slotIndex][i];
                            Texture currentTex = mat.GetTexture(prop);
                            if (currentTex != null && currentTex.name == texSet[i].name)
                                continue;

                            mat.SetTexture(prop, texSet[i]);
                            EditorUtility.SetDirty(mat);
                            assignCount++;
                        }

                        // no break; → allow both ON and OFF sets to apply
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

        // Shader property groups (slot 0 = ON, slot 1 = OFF)
        string[][] shaderPropGroups = {
            new string[] { "_RNMX0", "_RNMY0", "_RNMZ0" },
            new string[] { "_RNMX1", "_RNMY1", "_RNMZ1" }
        };

        int unassignCount = 0;
        int matIndex = 0;
        int totalMats = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                float progress = (float)matIndex / totalMats;
                EditorUtility.DisplayProgressBar("Unassigning Lightmaps", $"Processing {mat.name}...", progress);

                foreach (var propGroup in shaderPropGroups)
                {
                    for (int i = 0; i < 3; i++)
                    {
                        if (mat.GetTexture(propGroup[i]) != null)
                        {
                            mat.SetTexture(propGroup[i], null);
                            EditorUtility.SetDirty(mat);
                            unassignCount++;
                        }
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
