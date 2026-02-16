using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";


    [MenuItem("Meenphie/Texture/Find and Assign")]
    public static void SyncAllMaterials() => ProcessMaterials(true);

    [MenuItem("Meenphie/Texture/Unassign Textures")]
    public static void UnassignAllMaterials() => ProcessMaterials(false);

    private static void ProcessMaterials(bool assign)
    {
        // 1. Charger le JSON (Indispensable pour Assign ET Unassign maintenant)
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string jsonPath = Path.Combine(projectRoot, "Blender", "materials_map.json");

        if (!File.Exists(jsonPath))
        {
            Debug.LogError($"{TAG} JSON introuvable : {jsonPath}");
            return;
        }

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));

        // 2. Scan
        string[] guids = AssetDatabase.FindAssets("t:Material");
        int matIndex = 0;
        int totalMats = guids.Length;
        int updatedCount = 0;

        try
        {
            foreach (string guid in guids)
            {
                string path = AssetDatabase.GUIDToAssetPath(guid);
                Material mat = AssetDatabase.LoadAssetAtPath<Material>(path);
                if (mat == null) continue;

                ShowProgress(assign ? "Assigning Textures" : "Unassigning Textures", mat.name, matIndex, totalMats);

                // On ne traite LE MATÉRIAU que s'il est présent dans le JSON
                if (data.ContainsKey(mat.name))
                {
                    if (assign)
                    {
                        Undo.RecordObject(mat, "Auto Texture Sync");
                        if (ApplyTexturesToMaterial(mat, data[mat.name]))
                        {
                            updatedCount++;
                            Debug.Log($"[<color=green>Assign</color>] Mat: <b>{mat.name}</b> | Status: Updated");
                        }
                    }
                    else
                    {
                        Undo.RecordObject(mat, "Unassign Textures");
                        if (ClearMaterialTextures(mat))
                        {
                            updatedCount++;
                            Debug.Log($"[<color=red>Unassign</color>] Mat: <b>{mat.name}</b> | Status: Cleared");
                        }
                    }
                    EditorUtility.SetDirty(mat);
                }
                matIndex++;
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"{TAG} Processing finished. <color=green>{updatedCount}</color> materials handled.");
    }

    // --- AUTOMATISATION IMPORT ---

    void OnPostprocessModel(GameObject gameObject)
    {
        // UV Packing
        foreach (MeshFilter filter in gameObject.GetComponentsInChildren<MeshFilter>())
        {
            Mesh mesh = filter.sharedMesh;
            if (mesh != null) ApplyPacking(mesh);
        }
        Debug.Log($"{TAG} Re-import : <b>{gameObject.name}</b> | UV Packing completed.");
    }

    // --- HELPERS ---

    private static bool ApplyTexturesToMaterial(Material mat, Dictionary<string, string> textures)
    {
        bool changed = false;
        foreach (var entry in textures)
        {
            Texture2D tex = FindTextureGlobal(entry.Value);
            if (tex == null) continue;

            string propName = GetAutoPropName(mat, entry.Key);
            if (!string.IsNullOrEmpty(propName))
            {
                if (mat.GetTexture(propName) != tex)
                {
                    mat.SetTexture(propName, tex);
                    if (entry.Key == "Normal") mat.EnableKeyword("_NORMALMAP");
                    changed = true;
                }
            }
        }
        return changed;
    }

    private static bool ClearMaterialTextures(Material mat)
    {
        bool changed = false;
        Shader shader = mat.shader;
        for (int i = 0; i < ShaderUtil.GetPropertyCount(shader); i++)
        {
            if (ShaderUtil.GetPropertyType(shader, i) == ShaderUtil.ShaderPropertyType.TexEnv)
            {
                string propName = ShaderUtil.GetPropertyName(shader, i);
                if (mat.GetTexture(propName) != null)
                {
                    mat.SetTexture(propName, null);
                    changed = true;
                }
            }
        }
        return changed;
    }

    private static string GetAutoPropName(Material mat, string blenderSlot)
    {
        Shader shader = mat.shader;
        for (int i = 0; i < ShaderUtil.GetPropertyCount(shader); i++)
        {
            if (ShaderUtil.GetPropertyType(shader, i) != ShaderUtil.ShaderPropertyType.TexEnv) continue;
            string desc = ShaderUtil.GetPropertyDescription(shader, i).ToLower();
            string name = ShaderUtil.GetPropertyName(shader, i);

            if (blenderSlot == "Base Color" && (desc.Contains("color") || desc.Contains("albedo") || desc.Contains("main") || desc.Contains("diffuse"))) return name;
            if (blenderSlot == "Normal" && (desc.Contains("normal") || desc.Contains("bump"))) return name;
            if (blenderSlot == "Roughness" && (desc.Contains("roughness") || desc.Contains("gloss") || desc.Contains("smoothness"))) return name;
            if (blenderSlot == "Metallic" && (desc.Contains("metal") || desc.Contains("mask"))) return name;
        }
        return null;
    }

    private static Texture2D FindTextureGlobal(string fileName)
    {
        string nameOnly = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(nameOnly + " t:Texture");
        foreach (string guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            if (Path.GetFileName(path) == fileName)
                return AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        }
        return guids.Length > 0 ? AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(guids[0])) : null;
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>();
        List<Vector2> uv1 = new List<Vector2>();
        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);
        if (uv0.Count == 0 || uv1.Count != uv0.Count) return;

        List<Vector4> packedUVs = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
            packedUVs.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));

        mesh.SetUVs(0, packedUVs);
    }

    private static void ShowProgress(string title, string matName, int index, int total)
    {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }
}

public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.None);
        foreach (var m in materials)
        {
            try
            {
                int firstQuote = m.IndexOf('"') + 1;
                int secondQuote = m.IndexOf('"', firstQuote);
                if (firstQuote <= 0 || secondQuote <= 0) continue;
                string matName = m.Substring(firstQuote, secondQuote - firstQuote);

                var texs = new Dictionary<string, string>();
                if (m.Contains("Base Color")) texs.Add("Base Color", ExtractVal(m, "Base Color"));
                if (m.Contains("Roughness")) texs.Add("Roughness", ExtractVal(m, "Roughness"));
                if (m.Contains("Normal")) texs.Add("Normal", ExtractVal(m, "Normal"));
                if (m.Contains("Metallic")) texs.Add("Metallic", ExtractVal(m, "Metallic"));
                result[matName] = texs;
            }
            catch { }
        }
        return result;
    }
    static string ExtractVal(string text, string key)
    {
        string search = "\"" + key + "\": \"";
        int start = text.IndexOf(search) + search.Length;
        int end = text.IndexOf("\"", start);
        return text.Substring(start, end - start);
    }
}