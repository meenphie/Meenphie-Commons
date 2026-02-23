using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;
using System.Globalization;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    [MenuItem("Meenphie/Materials/Update All")]
    public static void SyncAll() => Process(true);

    private static void Process(bool assign)
    {
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string jsonPath = Path.Combine(projectRoot, "Blender", "materials_map.json");

        if (!File.Exists(jsonPath)) {
            Debug.LogError($"{TAG} JSON introuvable : {jsonPath}");
            return;
        }

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));
        string[] guids = AssetDatabase.FindAssets("t:Material");
        int count = 0;

        try {
            for (int i = 0; i < guids.Length; i++) {
                string path = AssetDatabase.GUIDToAssetPath(guids[i]);
                Material mat = AssetDatabase.LoadAssetAtPath<Material>(path);
                if (mat == null || !data.ContainsKey(mat.name)) continue;

                EditorUtility.DisplayProgressBar("Meenphie Sync", mat.name, (float)i / guids.Length);
                Undo.RecordObject(mat, "Meenphie Sync");

                if (Apply(mat, data[mat.name])) {
                    count++;
                    EditorUtility.SetDirty(mat);
                    AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);
                }
            }
        }
        finally { EditorUtility.ClearProgressBar(); }
        AssetDatabase.SaveAssets();
        Debug.Log($"{TAG} Terminé. {count} matériaux synchronisés.");
    }

    private static bool Apply(Material mat, Dictionary<string, string> data)
    {
        bool changed = false;

        // --- COULEUR & ALPHA ---
        Color finalColor = mat.HasProperty("_Color") ? mat.color : Color.white;
        if (data.ContainsKey("ColorHex") && ColorUtility.TryParseHtmlString("#" + data["ColorHex"], out Color c)) {
            finalColor.r = c.r; finalColor.g = c.g; finalColor.b = c.b;
            changed = true;
        }

        if (data.ContainsKey("AlphaValue")) {
            finalColor.a = ParseF(data["AlphaValue"]);
            changed = true;
        }
        mat.SetColor("_Color", finalColor);

        // --- TRANSPARENCE (MODE) ---
        if (data.ContainsKey("BlendMode") && data["BlendMode"] != "OPAQUE") {
            SetupTransparent(mat);
            changed = true;
        }

        // --- METALLIC / SMOOTHNESS ---
        if (data.ContainsKey("MetallicValue")) { mat.SetFloat("_Metallic", ParseF(data["MetallicValue"])); changed = true; }
        if (data.ContainsKey("SmoothnessValue")) { mat.SetFloat("_Glossiness", ParseF(data["SmoothnessValue"])); changed = true; }

        // --- EMISSION ---
        if (data.ContainsKey("EmissionHex") && ColorUtility.TryParseHtmlString("#" + data["EmissionHex"], out Color ec)) {
            float intensity = data.ContainsKey("EmissionIntensity") ? ParseF(data["EmissionIntensity"]) : 1.0f;
            mat.SetColor("_EmissionColor", ec * intensity);
            mat.EnableKeyword("_EMISSION");
            changed = true;
        }

        // --- TEXTURES ---
        changed |= SetTex(mat, data, "Base Color", "_MainTex");
        changed |= SetTex(mat, data, "Normal", "_BumpMap", "_NORMALMAP");
        changed |= SetTex(mat, data, "Roughness", "_GlossinessMap");
        changed |= SetTex(mat, data, "Metallic", "_MetallicMap");
        changed |= SetTex(mat, data, "Emission", "_EmissionMap", "_EMISSION");

        return changed;
    }

    private static void SetupTransparent(Material mat)
    {
        // Bascule le Standard Shader en mode "Fade" (mieux pour le verre/UI)
        mat.SetFloat("_Mode", 2); 
        mat.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
        mat.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
        mat.SetInt("_ZWrite", 0);
        mat.DisableKeyword("_ALPHATEST_ON");
        mat.EnableKeyword("_ALPHABLEND_ON");
        mat.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
    }

    private static bool SetTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "")
    {
        if (!data.ContainsKey(key)) return false;
        Texture2D tex = FindTex(data[key]);
        if (tex != null && mat.GetTexture(prop) != tex) {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
            return true;
        }
        return false;
    }

    private static Texture2D FindTex(string fileName)
    {
        string name = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(name + " t:Texture");
        foreach (var g in guids) {
            string p = AssetDatabase.GUIDToAssetPath(g);
            if (Path.GetFileName(p) == fileName) return AssetDatabase.LoadAssetAtPath<Texture2D>(p);
        }
        return null;
    }

    private static float ParseF(string s) => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 1.0f;
}

public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.RemoveEmptyEntries);
        string[] keys = { "Base Color", "Normal", "Roughness", "Metallic", "Emission", "ColorHex", "EmissionHex", "MetallicValue", "SmoothnessValue", "EmissionIntensity", "AlphaValue", "BlendMode" };

        foreach (var m in materials) {
            int s = m.IndexOf('"') + 1;
            int e = m.IndexOf('"', s);
            if (s <= 0 || e <= 0) continue;
            string matName = m.Substring(s, e - s);
            var dict = new Dictionary<string, string>();
            foreach (var k in keys) {
                string search = $"\"{k}\": ";
                if (m.Contains(search)) {
                    int vStart = m.IndexOf(search) + search.Length;
                    if (m[vStart] == '"') {
                        vStart++;
                        dict[k] = m.Substring(vStart, m.IndexOf('"', vStart) - vStart);
                    } else {
                        int vEnd = m.IndexOfAny(new char[] { ',', '}', '\n' }, vStart);
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