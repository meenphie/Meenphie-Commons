using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using System.IO;

public static class LightmapAssigner
{
    private static readonly string[][] ShaderPropGroups = {
        new string[] { "_RNMX0", "_RNMY0", "_RNMZ0" }, // Slot 0 (OFF / Standard)
        new string[] { "_RNMX1", "_RNMY1", "_RNMZ1" }  // Slot 1 (ON)
    };

    [MenuItem("Meenphie/Lightmaps/Assign Lightmaps")]
    public static void AssignLightmaps() => ProcessLightmaps(true);

    [MenuItem("Meenphie/Lightmaps/Unassign Lightmaps")]
    public static void UnassignLightmaps() => ProcessLightmaps(false);

    private static void ProcessLightmaps(bool assign)
    {
        HashSet<Material> materials = assign ? CollectSceneMaterials() : CollectAllProjectMaterials();
        
        // Cache all project textures once to avoid slow disk hits in the loop
        Dictionary<string, Texture> textureCache = BuildTextureCache();

        int matIndex = 0;
        int totalMats = materials.Count;
        int touchedCount = 0;

        try
        {
            foreach (Material mat in materials)
            {
                if (mat == null) continue;
                ShowProgress(assign ? "Assigning" : "Unassigning", mat.name, matIndex, totalMats);

                if (assign)
                {
                    // Split name: "Shader - Group - Name" -> index 1 is "Station"
                    string[] nameParts = mat.name.Split(new string[] { " - " }, System.StringSplitOptions.None);
                    if (nameParts.Length >= 2)
                    {
                        string groupName = nameParts[1].Trim(); 
                        
                        // We check both "Group" and "Group ON" / "Group OFF"
                        if (TryAssignGroup(mat, groupName, textureCache, 0)) touchedCount++; // Default/OFF
                        if (TryAssignGroup(mat, groupName + " ON", textureCache, 1)) touchedCount++;
                        if (TryAssignGroup(mat, groupName + " OFF", textureCache, 0)) touchedCount++;
                    }
                }
                else
                {
                    UnassignAll(mat);
                }
                matIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"[<color=purple>Meenphie</color>] Done. {touchedCount} properties updated.");
    }

    private static bool TryAssignGroup(Material mat, string groupName, Dictionary<string, Texture> cache, int slot)
    {
        bool changed = false;
        string[] suffixes = { "_RNMX", "_RNMY", "_RNMZ" };

        for (int i = 0; i < 3; i++)
        {
            string baseName = groupName + suffixes[i];
            
            // PRIORITY 1: Denoised version
            // PRIORITY 2: Original version
            Texture tex = null;
            if (!cache.TryGetValue(baseName + "_denoised", out tex))
            {
                cache.TryGetValue(baseName, out tex);
            }

            if (tex != null)
            {
                string prop = ShaderPropGroups[slot][i];
                if (mat.HasProperty(prop) && mat.GetTexture(prop) != tex)
                {
                    mat.SetTexture(prop, tex);
                    EditorUtility.SetDirty(mat);
                    changed = true;
                }
            }
        }
        return changed;
    }

    private static void UnassignAll(Material mat)
    {
        foreach (var group in ShaderPropGroups)
        {
            foreach (var prop in group)
            {
                if (mat.HasProperty(prop) && mat.GetTexture(prop) != null)
                {
                    mat.SetTexture(prop, null);
                    EditorUtility.SetDirty(mat);
                }
            }
        }
    }

    private static Dictionary<string, Texture> BuildTextureCache()
    {
        var cache = new Dictionary<string, Texture>(System.StringComparer.OrdinalIgnoreCase);
        string[] guids = AssetDatabase.FindAssets("t:Texture");
        
        foreach (var guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            string name = Path.GetFileNameWithoutExtension(path);
            
            // Only cache lightmap-related textures to save memory
            if (name.Contains("_RNM"))
            {
                Texture tex = AssetDatabase.LoadAssetAtPath<Texture>(path);
                if (tex != null) cache[name] = tex;
            }
        }
        return cache;
    }

    private static HashSet<Material> CollectSceneMaterials()
    {
        HashSet<Material> mats = new HashSet<Material>();
        foreach (GameObject go in SceneManager.GetActiveScene().GetRootGameObjects())
        {
            foreach (Renderer r in go.GetComponentsInChildren<Renderer>(true))
            {
                foreach (Material m in r.sharedMaterials) if (m != null) mats.Add(m);
            }
        }
        return mats;
    }

    private static HashSet<Material> CollectAllProjectMaterials()
    {
        HashSet<Material> mats = new HashSet<Material>();
        string[] guids = AssetDatabase.FindAssets("t:Material");
        foreach (string g in guids)
        {
            Material m = AssetDatabase.LoadAssetAtPath<Material>(AssetDatabase.GUIDToAssetPath(g));
            if (m != null) mats.Add(m);
        }
        return mats;
    }

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }
}