using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;
using System.Globalization;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    // --- MENU MEENPHIE ---

    [MenuItem("Meenphie/Texture/Find and Assign")]
    public static void SyncAllMaterials() => ProcessMaterials(true);

    [MenuItem("Meenphie/Texture/Unassign Textures")]
    public static void UnassignAllMaterials() => ProcessMaterials(false);

    private static void ProcessMaterials(bool assign)
    {
        // 1. Charger le JSON (Hors Assets, dans /Blender/)
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string jsonPath = Path.Combine(projectRoot, "Blender", "materials_map.json");

        if (!File.Exists(jsonPath))
        {
            Debug.LogError($"{TAG} JSON introuvable : {jsonPath}");
            return;
        }

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));
        
        // 2. Scan du projet
        string[] guids = AssetDatabase.FindAssets("t:Material");
        int updatedCount = 0;

        try
        {
            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                Material mat = AssetDatabase.LoadAssetAtPath<Material>(path);
                if (mat == null || !data.ContainsKey(mat.name)) continue;

                ShowProgress(assign ? "Assigning" : "Unassigning", mat.name, i, guids.Length);

                if (assign)
                {
                    Undo.RecordObject(mat, "Meenphie Sync");
                    if (ApplyDataToMaterial(mat, data[mat.name]))
                    {
                        updatedCount++;
                        Debug.Log($"[<color=green>Assign</color>] Mat: <b>{mat.name}</b>");
                    }
                }
                else
                {
                    Undo.RecordObject(mat, "Meenphie Unassign");
                    if (ClearMaterial(mat))
                    {
                        updatedCount++;
                        Debug.Log($"[<color=red>Unassign</color>] Mat: <b>{mat.name}</b>");
                    }
                }
                EditorUtility.SetDirty(mat);
            }
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"{TAG} Processing finished. <color=green>{updatedCount}</color> materials handled.");
    }

    // --- LOGIQUE D'ASSIGNATION ---

    private static bool ApplyDataToMaterial(Material mat, Dictionary<string, string> data)
    {
        bool changed = false;

        // 1. Couleurs et Sliders (Values)
        if (data.ContainsKey("ColorHex") && ColorUtility.TryParseHtmlString("#" + data["ColorHex"], out Color col)) {
            mat.SetColor("_Color", col); changed = true;
        }
        
        if (data.ContainsKey("MetallicValue")) {
            mat.SetFloat("_Metallic", ParseFloat(data["MetallicValue"])); changed = true;
        }

        if (data.ContainsKey("SmoothnessValue")) {
            mat.SetFloat("_Glossiness", ParseFloat(data["SmoothnessValue"])); changed = true;
        }

        // Emission Color & Intensity
        if (data.ContainsKey("EmissionHex") && ColorUtility.TryParseHtmlString("#" + data["EmissionHex"], out Color emCol)) {
            float intensity = data.ContainsKey("EmissionIntensity") ? ParseFloat(data["EmissionIntensity"]) : 1.0f;
            mat.SetColor("_EmissionColor", emCol * intensity);
            mat.EnableKeyword("_EMISSION");
            changed = true;
        }

        // 2. Textures (Maps)
        changed |= TryAssignTex(mat, data, "Base Color", "_MainTex");
        changed |= TryAssignTex(mat, data, "Normal", "_BumpMap", "_NORMALMAP");
        changed |= TryAssignTex(mat, data, "Metallic", "_MetallicMap");
        changed |= TryAssignTex(mat, data, "Roughness", "_GlossinessMap");
        changed |= TryAssignTex(mat, data, "Emission", "_EmissionMap", "_EMISSION");

        return changed;
    }

    private static bool TryAssignTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "")
    {
        if (!data.ContainsKey(key)) return false;
        
        Texture2D tex = FindTextureGlobal(data[key]);
        if (tex == null) return false;

        if (mat.GetTexture(prop) != tex)
        {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
            return true;
        }
        return false;
    }

    private static bool ClearMaterial(Material mat)
    {
        string[] texProps = { "_MainTex", "_BumpMap", "_MetallicMap", "_GlossinessMap", "_EmissionMap" };
        foreach (string p in texProps) {
            if (mat.HasProperty(p)) mat.SetTexture(p, null);
        }
        mat.DisableKeyword("_NORMALMAP");
        mat.DisableKeyword("_EMISSION");
        return true;
    }

    // --- HELPERS ---

    private static Texture2D FindTextureGlobal(string fileName)
    {
        string nameOnly = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(nameOnly + " t:Texture");
        foreach (string guid in guids) {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            if (Path.GetFileName(path) == fileName)
                return AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        }
        return guids.Length > 0 ? AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(guids[0])) : null;
    }

    private static float ParseFloat(string val) {
        if (float.TryParse(val, NumberStyles.Any, CultureInfo.InvariantCulture, out float result)) return result;
        return 0;
    }

    private static void ShowProgress(string title, string matName, int index, int total) {
        EditorUtility.DisplayProgressBar(title, $"Processing {matName}...", (float)index / total);
    }

    // --- AUTOMATISATION IMPORT ---

    void OnPostprocessModel(GameObject gameObject)
    {
        foreach (MeshFilter filter in gameObject.GetComponentsInChildren<MeshFilter>())
        {
            Mesh mesh = filter.sharedMesh;
            if (mesh != null) ApplyPacking(mesh);
        }
        Debug.Log($"{TAG} Re-import : <b>{gameObject.name}</b> | UV Packing completed.");
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>(), uv1 = new List<Vector2>();
        mesh.GetUVs(0, uv0); mesh.GetUVs(1, uv1);
        if (uv0.Count == 0 || uv1.Count != uv0.Count) return;

        List<Vector4> packed = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
            packed.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));

        mesh.SetUVs(0, packed);
    }
}

// --- PARSEUR JSON ---

public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        // Split par objet matériau
        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.None);
        
        string[] keys = { 
            "ColorHex", "Base Color", "Normal", "Roughness", "Metallic", 
            "MetallicValue", "SmoothnessValue", "EmissionHex", "Emission", "EmissionIntensity" 
        };

        foreach (var m in materials)
        {
            try
            {
                int firstQuote = m.IndexOf('"') + 1;
                int secondQuote = m.IndexOf('"', firstQuote);
                if (firstQuote <= 0 || secondQuote <= 0) continue;
                string matName = m.Substring(firstQuote, secondQuote - firstQuote);

                var matData = new Dictionary<string, string>();
                foreach (string key in keys)
                {
                    if (m.Contains($"\"{key}\""))
                    {
                        matData[key] = ExtractVal(m, key);
                    }
                }
                result[matName] = matData;
            }
            catch { }
        }
        return result;
    }

    static string ExtractVal(string text, string key)
    {
        string search = "\"" + key + "\": ";
        int start = text.IndexOf(search) + search.Length;
        
        // Si c'est un string (commence par ")
        if (text[start] == '"') {
            start++;
            int end = text.IndexOf('"', start);
            return text.Substring(start, end - start);
        }
        // Si c'est un nombre (finit par , ou })
        else {
            int end = text.IndexOfAny(new char[] { ',', '}', '\n' }, start);
            return text.Substring(start, end - start).Trim();
        }
    }
}