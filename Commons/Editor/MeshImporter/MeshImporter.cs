using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;
using System.Globalization;
using System.Linq;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    [MenuItem("Meenphie/Materials/Update All")]
    public static void SyncAll()
    {
        // 1. On force Unity à voir les fichiers modifiés sur le disque (Blender export)
        AssetDatabase.Refresh();
        Process(true);
    }

    private static void Process(bool assign)
    {
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string jsonPath = Path.Combine(projectRoot, "Blender", "materials_map.json");

        if (!File.Exists(jsonPath))
        {
            Debug.LogError($"{TAG} JSON introuvable : {jsonPath}");
            return;
        }

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));
        string[] guids = AssetDatabase.FindAssets("t:Material");
        int count = 0;

        // Optimisation : On bloque l'importation auto le temps de la boucle
        AssetDatabase.StartAssetEditing();

        try
        {
            for (int i = 0; i < guids.Length; i++)
            {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                Material mat = AssetDatabase.LoadAssetAtPath<Material>(path);

                if (mat == null || !data.ContainsKey(mat.name)) continue;

                EditorUtility.DisplayProgressBar("Meenphie Sync", mat.name, (float)i / guids.Length);
                Undo.RecordObject(mat, "Meenphie Sync");

                bool changed = assign ? Apply(mat, data[mat.name]) : Clear(mat);

                if (changed)
                {
                    count++;
                    EditorUtility.SetDirty(mat);
                }
            }
        }
        finally
        {
            AssetDatabase.StopAssetEditing();
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"{TAG} Terminé. {count} matériaux synchronisés.");
    }

    private static bool Apply(Material mat, Dictionary<string, string> data)
    {
        bool changed = false;

        // --- COULEURS & ALPHA ---
        if (data.ContainsKey("ColorHex") && ColorUtility.TryParseHtmlString("#" + data["ColorHex"], out Color c))
        {
            if (data.ContainsKey("AlphaValue")) c.a = ParseF(data["AlphaValue"]);
            mat.SetColor("_Color", c);
            changed = true;
        }

        // --- VALEURS ---
        if (data.ContainsKey("MetallicValue")) { mat.SetFloat("_Metallic", ParseF(data["MetallicValue"])); changed = true; }
        if (data.ContainsKey("SmoothnessValue")) { mat.SetFloat("_Glossiness", ParseF(data["SmoothnessValue"])); changed = true; }

        // --- EMISSION ---
        if (data.ContainsKey("EmissionHex") && ColorUtility.TryParseHtmlString("#" + data["EmissionHex"], out Color ec))
        {
            float intensity = data.ContainsKey("EmissionIntensity") ? ParseF(data["EmissionIntensity"]) : 1.0f;
            mat.SetColor("_EmissionColor", ec * intensity);
            mat.EnableKeyword("_EMISSION");
            changed = true;
        }

        // --- TEXTURES (Le coeur du problème) ---
        changed |= SetTex(mat, data, "Base Color", "_MainTex");
        changed |= SetTex(mat, data, "Normal", "_BumpMap", "_NORMALMAP", true); // On précise que c'est une Normal
        changed |= SetTex(mat, data, "Roughness", "_GlossinessMap");
        changed |= SetTex(mat, data, "Metallic", "_MetallicMap");
        changed |= SetTex(mat, data, "Emission", "_EmissionMap", "_EMISSION");

        return changed;
    }

    private static bool SetTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "", bool isNormal = false)
    {
        if (!data.ContainsKey(key) || string.IsNullOrEmpty(data[key])) return false;

        Texture2D tex = FindAndFixTex(data[key], isNormal);

        if (tex != null && mat.GetTexture(prop) != tex)
        {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
            return true;
        }
        return false;
    }

    private static Texture2D FindAndFixTex(string fileName, bool isNormal)
    {
        string nameOnly = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(nameOnly + " t:Texture");

        foreach (var g in guids)
        {
            string p = AssetDatabase.GUIDToAssetPath(g);
            if (Path.GetFileName(p).Equals(fileName, System.StringComparison.OrdinalIgnoreCase))
            {
                // CORRECTION DES NORMAL MAPS
                if (isNormal)
                {
                    TextureImporter importer = AssetImporter.GetAtPath(p) as TextureImporter;
                    if (importer != null && importer.textureType != TextureImporterType.NormalMap)
                    {
                        importer.textureType = TextureImporterType.NormalMap;
                        importer.SaveAndReimport();
                    }
                }
                return AssetDatabase.LoadAssetAtPath<Texture2D>(p);
            }
        }
        return null;
    }

    private static bool Clear(Material mat)
    {
        string[] texProps = { "_MainTex", "_BumpMap", "_MetallicMap", "_GlossinessMap", "_EmissionMap" };
        foreach (var p in texProps) if (mat.HasProperty(p)) mat.SetTexture(p, null);

        mat.SetColor("_Color", Color.white);
        mat.SetColor("_EmissionColor", Color.black);
        if (mat.HasProperty("_EmissionIntensity")) mat.SetFloat("_EmissionIntensity", 0);

        mat.SetFloat("_Metallic", 0);
        mat.SetFloat("_Glossiness", 0);
        mat.DisableKeyword("_NORMALMAP");
        mat.DisableKeyword("_EMISSION");
        return true;
    }

    private static float ParseF(string s) => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 0;

    // --- PACKING UV (Modifié pour être plus robuste) ---
    void OnPostprocessModel(GameObject g)
    {
        foreach (MeshFilter filter in g.GetComponentsInChildren<MeshFilter>())
        {
            if (filter.sharedMesh != null) ApplyPacking(filter.sharedMesh);
        }

        // Ajustement de l'intensité des lumières Blender -> Unity
        Light[] lights = g.GetComponentsInChildren<Light>();
        foreach (Light light in lights)
        {
            light.intensity *= 0.1f;
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        List<Vector2> uv0 = new List<Vector2>(), uv1 = new List<Vector2>();
        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        if (uv0.Count == 0 || uv1.Count != uv0.Count) return;

        List<Vector4> packed = new List<Vector4>(uv0.Count);
        for (int i = 0; i < uv0.Count; i++)
            packed.Add(new Vector4(uv0[i].x, uv0[i].y, uv1[i].x, uv1[i].y));

        mesh.SetUVs(0, packed);
        // Note: On garde les UVs d'origine si besoin, ou on peut les vider ici.
    }
}

// Version plus "safe" du Parser pour éviter les sauts de ligne Blender
public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();

        // On nettoie un peu le JSON pour enlever les retours à la ligne inutiles
        json = json.Replace("\r", "").Replace("\n", "");

        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.RemoveEmptyEntries);
        string[] keys = { "Base Color", "Normal", "Roughness", "Metallic", "Emission", "ColorHex", "EmissionHex", "MetallicValue", "SmoothnessValue", "EmissionIntensity", "AlphaValue" };

        foreach (var m in materials)
        {
            int s = m.IndexOf('"') + 1;
            int e = m.IndexOf('"', s);
            if (s <= 0 || e <= 0) continue;

            string matName = m.Substring(s, e - s);
            var dict = new Dictionary<string, string>();

            foreach (var k in keys)
            {
                string search = $"\"{k}\":"; // On enlève l'espace forcé après les deux points
                int keyIdx = m.IndexOf(search);
                if (keyIdx != -1)
                {
                    int vStart = keyIdx + search.Length;
                    // On avance jusqu'à trouver le début de la valeur (soit " soit un chiffre)
                    while (vStart < m.Length && (m[vStart] == ' ' || m[vStart] == ':')) vStart++;

                    if (vStart < m.Length && m[vStart] == '"')
                    {
                        vStart++;
                        int vEnd = m.IndexOf('"', vStart);
                        dict[k] = m.Substring(vStart, vEnd - vStart);
                    }
                    else
                    {
                        int vEnd = m.IndexOfAny(new char[] { ',', '}', ' ' }, vStart);
                        if (vEnd == -1) vEnd = m.Length;
                        dict[k] = m.Substring(vStart, vEnd - vStart).Trim();
                    }
                }
            }
            result[matName] = dict;
        }
        return result;
    }
}