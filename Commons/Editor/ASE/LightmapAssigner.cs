using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;

public static class LightmapAssigner
{
    private static readonly string[][] ShaderPropGroups = {
        new string[] { "_RNMX0", "_RNMY0", "_RNMZ0" }, // Slot 0 = OFF
        new string[] { "_RNMX1", "_RNMY1", "_RNMZ1" }  // Slot 1 = ON
    };

    [MenuItem("Meenphie/Lightmaps/Assign Lightmaps")]
    public static void AssignLightmaps() => ProcessLightmaps(true);

    [MenuItem("Meenphie/Lightmaps/Unassign Lightmaps")]
    public static void UnassignLightmaps() => ProcessLightmaps(false);

    private static void ProcessLightmaps(bool assign)
    {
        HashSet<Material> sceneMaterials = CollectSceneMaterials();
        Dictionary<string, Texture[]> lightmapGroups = assign ? BuildLightmapGroups() : null;

        HashSet<Texture> touchedTextures = new HashSet<Texture>(); // <-- évite les doublons
        int matIndex = 0;
        int totalMats = sceneMaterials.Count;

        try
        {
            foreach (Material mat in sceneMaterials)
            {
                ShowProgress(assign ? "Assigning Lightmaps" : "Unassigning Lightmaps", mat.name, matIndex, totalMats);

                if (assign)
                {
                    foreach (var kvp in lightmapGroups)
                    {
                        string groupName = kvp.Key;
                        string cleanGroupName = groupName.Replace("GI ", "").Trim();
                        string baseName = cleanGroupName.Replace(" ON", "").Replace(" OFF", "").Trim();

                        if (mat.name.IndexOf(baseName, System.StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            Texture[] textures = kvp.Value;
                            int slotIndex = groupName.EndsWith("ON") ? 1 : 0;

                            for (int i = 0; i < 3; i++)
                            {
                                Texture tex = textures[i];
                                if (tex == null) continue;

                                string prop = ShaderPropGroups[slotIndex][i];
                                Texture currentTex = mat.GetTexture(prop);

                                if (currentTex == null || currentTex.name != tex.name)
                                {
                                    mat.SetTexture(prop, tex);
                                    EditorUtility.SetDirty(mat);
                                    touchedTextures.Add(tex);
                                }
                            }
                        }
                    }
                }
                else
                {
                    foreach (var propGroup in ShaderPropGroups)
                    {
                        for (int i = 0; i < 3; i++)
                        {
                            Texture tex = mat.GetTexture(propGroup[i]);
                            if (tex != null)
                            {
                                mat.SetTexture(propGroup[i], null);
                                EditorUtility.SetDirty(mat);
                                touchedTextures.Add(tex);
                            }
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
        Debug.Log($"[<color=purple>Meenphie</color>] {touchedTextures.Count} Lightmaps {(assign ? "assigned" : "unassigned")}");
    }

    // --- Helpers ---
    private static HashSet<Material> CollectSceneMaterials()
    {
        HashSet<Material> sceneMaterials = new HashSet<Material>();
        foreach (GameObject go in SceneManager.GetActiveScene().GetRootGameObjects())
        {
            foreach (Renderer rend in go.GetComponentsInChildren<Renderer>(true))
            {
                foreach (Material mat in rend.sharedMaterials)
                {
                    if (mat != null && mat.name.Contains("GI"))
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

            lightmapGroups[baseName][0] = texX;

            string[] yGuids = AssetDatabase.FindAssets(baseName + "_RNMY t:Texture");
            if (yGuids.Length > 0)
                lightmapGroups[baseName][1] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(yGuids[0]));

            string[] zGuids = AssetDatabase.FindAssets(baseName + "_RNMZ t:Texture");
            if (zGuids.Length > 0)
                lightmapGroups[baseName][2] = AssetDatabase.LoadAssetAtPath<Texture>(AssetDatabase.GUIDToAssetPath(zGuids[0]));
        }

        return lightmapGroups;
    }

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        float progress = (float)index / total;
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", progress);
    }
}
