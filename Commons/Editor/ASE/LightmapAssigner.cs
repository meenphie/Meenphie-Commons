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
        HashSet<Material> materials = assign ? CollectSceneMaterials() : CollectAllProjectMaterials();
        Dictionary<string, Texture[]> lightmapGroups = assign ? BuildLightmapGroups() : null;

        HashSet<Texture> touchedTextures = new HashSet<Texture>();
        int matIndex = 0;
        int totalMats = materials.Count;

        try
        {
            foreach (Material mat in materials)
            {
                if (mat == null) continue;
                ShowProgress(assign ? "Assigning Lightmaps" : "Unassigning Lightmaps", mat.name, matIndex, totalMats);

                if (assign)
                {
                    // 1. On extrait le groupe du nom du matériau : "Shader - Groupe - Nom"
                    string[] nameParts = mat.name.Split(new string[] { " - " }, System.StringSplitOptions.None);
                    
                    // On a besoin d'au moins [Shader] et [Groupe]
                    if (nameParts.Length >= 2)
                    {
                        string materialGroupName = nameParts[1].Trim(); // Récupère "Station"

                        foreach (var kvp in lightmapGroups)
                        {
                            string lightmapGroupName = kvp.Key; 
                            string baseLMName = lightmapGroupName.Replace("GI ", "").Replace(" ON", "").Replace(" OFF", "").Trim();

                            // 2. Comparaison stricte entre le groupe du mat et le groupe de la lightmap
                            if (string.Equals(materialGroupName, baseLMName, System.StringComparison.OrdinalIgnoreCase))
                            {
                                Texture[] textures = kvp.Value;
                                int slotIndex = lightmapGroupName.EndsWith("ON") ? 1 : 0;

                                for (int i = 0; i < 3; i++)
                                {
                                    Texture tex = textures[i];
                                    if (tex == null) continue;

                                    string prop = ShaderPropGroups[slotIndex][i];
                                    Texture currentTex = mat.GetTexture(prop);

                                    // Comparaison par référence (évite les réassignations inutiles)
                                    if (currentTex != tex)
                                    {
                                        mat.SetTexture(prop, tex);
                                        EditorUtility.SetDirty(mat);
                                        touchedTextures.Add(tex);
                                        
                                        Debug.Log($"[<color=green>Assign</color>] Mat: <b>{mat.name}</b> | Slot: {slotIndex} | Groupe: {materialGroupName}");
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    // Reset des propriétés
                    foreach (var propGroup in ShaderPropGroups)
                    {
                        foreach (string prop in propGroup)
                        {
                            if (mat.HasProperty(prop) && mat.GetTexture(prop) != null)
                            {
                                mat.SetTexture(prop, null);
                                EditorUtility.SetDirty(mat);
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
        Debug.Log($"[<color=purple>Meenphie</color>] Processing finished. {touchedTextures.Count} unique textures handled.");
    }

    // --- Helpers ---
    private static HashSet<Material> CollectSceneMaterials()
    {
        HashSet<Material> sceneMaterials = new HashSet<Material>();
        foreach (GameObject go in SceneManager.GetActiveScene().GetRootGameObjects())
        {
            foreach (Renderer rend in go.GetComponentsInChildren<Renderer>(true))
            {
                foreach (Material m in rend.sharedMaterials)
                {
                    if (m != null) sceneMaterials.Add(m);
                }
            }
        }
        return sceneMaterials;
    }

    private static HashSet<Material> CollectAllProjectMaterials()
    {
        HashSet<Material> allMaterials = new HashSet<Material>();
        string[] guids = AssetDatabase.FindAssets("t:Material");
        foreach (string guid in guids)
        {
            Material m = AssetDatabase.LoadAssetAtPath<Material>(AssetDatabase.GUIDToAssetPath(guid));
            if (m != null) allMaterials.Add(m);
        }
        return allMaterials;
    }

    private static Dictionary<string, Texture[]> BuildLightmapGroups()
{
    Dictionary<string, Texture[]> lightmapGroups = new Dictionary<string, Texture[]>();
    
    // On cherche tous les fichiers RNMX (originaux ou DN)
    string[] rnmxGuids = AssetDatabase.FindAssets("_RNMX t:Texture");

    foreach (string guid in rnmxGuids)
    {
        string path = AssetDatabase.GUIDToAssetPath(guid);
        Texture texX = AssetDatabase.LoadAssetAtPath<Texture>(path);
        if (texX == null) continue;

        // Si le fichier actuel est déjà un _DN, on récupère le nom de base sans le suffixe _DN
        // Sinon on prend juste le nom de base.
        string baseName = texX.name.Replace("_RNMX", "").Replace("_DN", "");

        if (!lightmapGroups.ContainsKey(baseName))
            lightmapGroups[baseName] = new Texture[3];

        // Pour chaque canal (X, Y, Z), on tente de trouver la version débruitée
        lightmapGroups[baseName][0] = GetBestTexture(baseName + "_RNMX");
        lightmapGroups[baseName][1] = GetBestTexture(baseName + "_RNMY");
        lightmapGroups[baseName][2] = GetBestTexture(baseName + "_RNMZ");
    }
    return lightmapGroups;
}

/// <summary>
/// Cherche d'abord "Nom_DN", sinon retourne "Nom"
/// </summary>
private static Texture GetBestTexture(string textureFullBaseName)
{
    // 1. Priorité au Denoised (_DN)
    string dnPath = FindPath(textureFullBaseName + "_DN");
    if (!string.IsNullOrEmpty(dnPath))
    {
        return AssetDatabase.LoadAssetAtPath<Texture>(dnPath);
    }

    // 2. Fallback sur l'original
    string originalPath = FindPath(textureFullBaseName);
    if (!string.IsNullOrEmpty(originalPath))
    {
        return AssetDatabase.LoadAssetAtPath<Texture>(originalPath);
    }

    return null;
}

private static string FindPath(string assetName)
{
    string[] guids = AssetDatabase.FindAssets(assetName + " t:Texture");
    foreach (string guid in guids)
    {
        string path = AssetDatabase.GUIDToAssetPath(guid);
        // Vérification stricte du nom pour éviter de trouver "Exit_RNMX_DN" quand on cherche "Exit_RNMX"
        if (System.IO.Path.GetFileNameWithoutExtension(path) == assetName)
        {
            return path;
        }
    }
    return null;
}

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }
}