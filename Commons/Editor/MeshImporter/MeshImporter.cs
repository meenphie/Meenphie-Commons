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
    public static void SyncAll() => Process();

    private static void Process()
    {
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string jsonPath = Path.Combine(projectRoot, "Blender", "materials_map.json");

        if (!File.Exists(jsonPath)) return;

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));
        string[] guids = AssetDatabase.FindAssets("t:Material");

        foreach (var guid in guids)
        {
            string path = AssetDatabase.GUIDToAssetPath(guid);
            Material mat = AssetDatabase.LoadAssetAtPath<Material>(path);

            if (mat != null && data.ContainsKey(mat.name))
            {
                Undo.RecordObject(mat, "Meenphie Sync");
                if (ApplyData(mat, data[mat.name]))
                {
                    EditorUtility.SetDirty(mat);
                    AssetDatabase.ImportAsset(path);
                }
            }
        }
        AssetDatabase.SaveAssets();
    }

    private static bool ApplyData(Material mat, Dictionary<string, string> info)
    {
        bool changed = false;

        // 1. Couleurs & Alpha
        if (info.ContainsKey("ColorHex") && ColorUtility.TryParseHtmlString("#" + info["ColorHex"], out Color c))
        {
            float alpha = info.ContainsKey("AlphaValue") ? ParseF(info["AlphaValue"]) : 1.0f;
            mat.SetColor("_Color", new Color(c.r, c.g, c.b, alpha));
            changed = true;
        }

        // 2. Propriétés de rendu (Transparency & Double Sided)
        if (info.ContainsKey("BlendMode") && info["BlendMode"] != "OPAQUE")
        {
            SetupTransparentMode(mat);
            changed = true;
        }

        if (info.ContainsKey("DoubleSided") && info["DoubleSided"].ToLower() == "true")
        {
            mat.SetInt("_Cull", (int)UnityEngine.Rendering.CullMode.Off);
            changed = true;
        }

        // 3. Valeurs numériques
        if (info.ContainsKey("MetallicValue")) mat.SetFloat("_Metallic", ParseF(info["MetallicValue"]));
        if (info.ContainsKey("SmoothnessValue")) mat.SetFloat("_Glossiness", ParseF(info["SmoothnessValue"]));

        // 4. Textures
        changed |= SetTex(mat, info, "Base Color", "_MainTex");
        changed |= SetTex(mat, info, "Normal", "_BumpMap", "_NORMALMAP");
        changed |= SetTex(mat, info, "Roughness", "_GlossinessMap");
        changed |= SetTex(mat, info, "Metallic", "_MetallicMap");
        changed |= SetTex(mat, info, "Occlusion", "_OcclusionMap");
        changed |= SetTex(mat, info, "Emission", "_EmissionMap", "_EMISSION");

        return changed;
    }

    private static void SetupTransparentMode(Material mat)
    {
        mat.SetFloat("_Mode", 2); // Fade
        mat.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
        mat.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
        mat.SetInt("_ZWrite", 0);
        mat.EnableKeyword("_ALPHABLEND_ON");
        mat.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
    }

    private static bool SetTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "")
    {
        if (!data.ContainsKey(key)) return false;
        Texture2D tex = FindTex(data[key]);
        if (tex != null)
        {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
            return true;
        }
        return false;
    }

    private static Texture2D FindTex(string name)
    {
        string cleanName = Path.GetFileNameWithoutExtension(name);
        string guid = AssetDatabase.FindAssets(cleanName + " t:Texture").FirstOrDefault();
        return guid != null ? AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(guid)) : null;
    }

    private static float ParseF(string s) => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 0;
}

public static class SimpleJsonParser
{
    // Parser plus générique pour accepter n'importe quelle clé
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        // Note: Pour un vrai projet, utilise Newtonsoft.Json. 
        // Ici c'est un parser simplifié par String pour éviter les dépendances.
        string[] parts = json.Split(new string[] { "}," }, System.StringSplitOptions.None);
        foreach (var p in parts)
        {
            if (!p.Contains(": {")) continue;
            string matName = p.Split('"')[1];
            var dict = new Dictionary<string, string>();
            string content = p.Substring(p.IndexOf("{") + 1);
            string[] lines = content.Split(',');
            foreach (var line in lines)
            {
                if (!line.Contains(":")) continue;
                string[] kv = line.Split(':');
                string key = kv[0].Trim().Replace("\"", "");
                string val = kv[1].Trim().Replace("\"", "").Replace("}", "");
                dict[key] = val;
            }
            result[matName] = dict;
        }
        return result;
    }
}