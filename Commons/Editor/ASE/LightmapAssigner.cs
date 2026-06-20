using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using System.IO;

public static class LightmapAssigner
{
    // All shader properties we manage — lightmap + RNM trio
    private static readonly string LightmapProp = "_UdonLightmap";
    private static readonly string[] RnmProps = { "_UdonRNMX0", "_UdonRNMY0", "_UdonRNMZ0" };
    private static readonly string[] RnmSuffixes = { "_RNMX", "_RNMY", "_RNMZ" };

    [MenuItem("Meenphie/Lightmaps/Assign Lightmaps")]
    public static void AssignLightmaps() => ProcessLightmaps(true);

    [MenuItem("Meenphie/Lightmaps/Unassign Lightmaps")]
    public static void UnassignLightmaps() => ProcessLightmaps(false);

    private static void ProcessLightmaps(bool assign)
    {
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

                Undo.RecordObject(mat, assign ? "Assign Lightmaps" : "Unassign Lightmaps");

                if (assign)
                {
                    // Material name format: "Something - GroupName"
                    string[] nameParts = mat.name.Split(new string[] { " - " }, System.StringSplitOptions.None);
                    if (nameParts.Length >= 2)
                    {
                        string groupName = nameParts[1].Trim();
                        if (TryAssign(mat, groupName, textureCache)) touchedCount++;
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

    private static bool TryAssign(Material mat, string groupName, Dictionary<string, Texture> cache)
    {
        bool changed = false;

        // --- Lightmap (_UdonLightmap) ---
        // Looks for: "GroupName_Lightmap_denoised" then "GroupName_Lightmap"
        if (mat.HasProperty(LightmapProp))
        {
            string baseName = groupName + "_Lightmap";
            if (!cache.TryGetValue(baseName + "_denoised", out Texture lightTex))
                cache.TryGetValue(baseName, out lightTex);

            if (lightTex != null)
            {
                mat.SetTexture(LightmapProp, lightTex);
                EditorUtility.SetDirty(mat);
                changed = true;
            }
        }

        // --- RNM trio (_UdonRNMX0 / Y0 / Z0) ---
        for (int i = 0; i < RnmProps.Length; i++)
        {
            if (!mat.HasProperty(RnmProps[i])) continue;

            string baseName = groupName + RnmSuffixes[i];
            if (!cache.TryGetValue(baseName + "_denoised", out Texture rnmTex))
                cache.TryGetValue(baseName, out rnmTex);

            if (rnmTex != null)
            {
                mat.SetTexture(RnmProps[i], rnmTex);
                EditorUtility.SetDirty(mat);
                changed = true;
            }
        }

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

            // Grab lightmap textures and RNM textures
            if (name.Contains("_Lightmap") || name.Contains("_RNM"))
            {
                Texture tex = AssetDatabase.LoadAssetAtPath<Texture>(path);
                if (tex != null) cache[name] = tex;
            }
        }

        return cache;
    }

    private static bool UnassignAll(Material mat)
    {
        bool changed = false;

        // Clear lightmap
        if (mat.HasProperty(LightmapProp) && mat.GetTexture(LightmapProp) != null)
        {
            mat.SetTexture(LightmapProp, null);
            changed = true;
        }

        // Clear RNM trio
        foreach (var prop in RnmProps)
        {
            if (mat.HasProperty(prop) && mat.GetTexture(prop) != null)
            {
                mat.SetTexture(prop, null);
                changed = true;
            }
        }

        if (changed) EditorUtility.SetDirty(mat);
        return changed;
    }

    private static HashSet<Material> CollectSceneMaterials()
    {
        var mats = new HashSet<Material>();
        foreach (GameObject go in SceneManager.GetActiveScene().GetRootGameObjects())
        {
            foreach (Renderer r in go.GetComponentsInChildren<Renderer>(true))
                foreach (Material m in r.sharedMaterials)
                    if (m != null) mats.Add(m);
        }
        return mats;
    }

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }
}