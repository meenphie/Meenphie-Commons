using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using System.IO;

public static class LightmapAssigner
{
    private static readonly string[][] ShaderPropGroups = {
        new string[] { "_UdonRNMX0", "_UdonRNMY0", "_UdonRNMZ0" },
        new string[] { "_UdonRNMX1", "_UdonRNMY1", "_UdonRNMZ1" }
    };

    [MenuItem("Meenphie/Lightmaps/Assign Lightmaps")]
    public static void AssignLightmaps() => ProcessLightmaps(true);

    [MenuItem("Meenphie/Lightmaps/Unassign Lightmaps")]
    public static void UnassignLightmaps() => ProcessLightmaps(false);

    private static void ProcessLightmaps(bool assign)
    {
        // Use Scene materials for speed, or Project materials for a total wipe
        HashSet<Material> materials = CollectSceneMaterials();
        Dictionary<string, Texture> textureCache = assign ? BuildTextureCache() : null;

        int matIndex = 0;
        int totalMats = materials.Count;
        int touchedCount = 0;

        try
        {
            foreach (Material mat in materials)
            {
                if (mat == null) continue;
                ShowProgress(assign ? "Assigning" : "Unassigning", mat.name, matIndex, totalMats);

                // Start recording for Undo
                Undo.RecordObject(mat, assign ? "Assign Lightmaps" : "Unassign Lightmaps");

                if (assign)
                {
                    string[] nameParts = mat.name.Split(new string[] { " - " }, System.StringSplitOptions.None);
                    if (nameParts.Length >= 2)
                    {
                        string groupName = nameParts[1].Trim(); 
                        bool a = TryAssignGroup(mat, groupName, textureCache, 0);
                        bool b = TryAssignGroup(mat, groupName + " ON", textureCache, 1);
                        bool c = TryAssignGroup(mat, groupName + " OFF", textureCache, 0);
                        if (a || b || c) touchedCount++;
                    }
                }
                else
                {
                    if (UnassignAll(mat)) touchedCount++;
                }
                matIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"[<color=purple>Meenphie</color>] Done. {touchedCount} materials updated.");
    }

    private static bool TryAssignGroup(Material mat, string groupName, Dictionary<string, Texture> cache, int slot)
    {
        bool changed = false;
        string[] suffixes = { "_UdonRNMX", "_UdonRNMY", "_UdonRNMZ" };

        for (int i = 0; i < 3; i++)
        {
            string baseName = groupName + suffixes[i];
            Texture tex = null;
            
            // Priority: Denoised -> Original
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

    // THE ONLY UNASSIGNALL FUNCTION
    private static bool UnassignAll(Material mat)
    {
        bool changed = false;
        foreach (var group in ShaderPropGroups)
        {
            foreach (var prop in group)
            {
                if (mat.HasProperty(prop) && mat.GetTexture(prop) != null)
                {
                    mat.SetTexture(prop, null);
                    changed = true;
                }
            }
        }
        if (changed) EditorUtility.SetDirty(mat);
        return changed;
    }

    private static Dictionary<string, Texture> BuildTextureCache()
    {
        var cache = new Dictionary<string, Texture>(System.StringComparer.OrdinalIgnoreCase);
        string[] guids = AssetDatabase.FindAssets("t:Texture");
        foreach (var guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            string name = Path.GetFileNameWithoutExtension(path);
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

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }
}