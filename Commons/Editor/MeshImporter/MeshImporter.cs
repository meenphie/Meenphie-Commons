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

        if (!File.Exists(jsonPath))
        {
            Debug.LogError($"{TAG} JSON introuvable : {jsonPath}");
            return;
        }

        var data = SimpleJsonParser.Parse(File.ReadAllText(jsonPath));
        string[] guids = AssetDatabase.FindAssets("t:Material");
        int count = 0;

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
                    // FORCE LA MISE À JOUR ICI :
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

        // --- COULEURS & ALPHA ---
        // On récupère la couleur actuelle (ou blanc par défaut) pour ne pas écraser l'alpha s'il n'y a que la couleur qui change
        Color colorToApply = mat.HasProperty("_Color") ? mat.GetColor("_Color") : Color.white;
        bool updateColor = false;

        if (data.ContainsKey("ColorHex") && ColorUtility.TryParseHtmlString("#" + data["ColorHex"], out Color c))
        {
            colorToApply.r = c.r;
            colorToApply.g = c.g;
            colorToApply.b = c.b;
            updateColor = true;
        }

        if (data.ContainsKey("AlphaValue"))
        {
            colorToApply.a = ParseF(data["AlphaValue"]);
            updateColor = true;
        }

        if (updateColor)
        {
            mat.SetColor("_Color", colorToApply);
            changed = true;
        }

        // --- VALEURS ---
        if (data.ContainsKey("MetallicValue"))
        {
            mat.SetFloat("_Metallic", ParseF(data["MetallicValue"])); changed = true;
        }
        if (data.ContainsKey("SmoothnessValue"))
        {
            mat.SetFloat("_Glossiness", ParseF(data["SmoothnessValue"])); changed = true;
        }

        // --- EMISSION (Color HDR + Slider Intensity) ---
        if (data.ContainsKey("EmissionHex") && ColorUtility.TryParseHtmlString("#" + data["EmissionHex"], out Color ec))
        {
            float intensity = data.ContainsKey("EmissionIntensity") ? ParseF(data["EmissionIntensity"]) : 1.0f;

            // On applique l'intensité sur la couleur (HDR)
            mat.SetColor("_EmissionColor", ec * intensity);

            // Si le shader a un slider spécifique pour l'intensité
            if (mat.HasProperty("_EmissionIntensity"))
            {
                mat.SetFloat("_EmissionIntensity", intensity);
            }

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

    private static bool SetTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "")
    {
        if (!data.ContainsKey(key)) return false;
        Texture2D tex = FindTex(data[key]);
        if (tex != null && mat.GetTexture(prop) != tex)
        {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
            return true;
        }
        return false;
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

    private static Texture2D FindTex(string fileName)
    {
        string name = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(name + " t:Texture");
        foreach (var g in guids)
        {
            string p = AssetDatabase.GUIDToAssetPath(g);
            if (Path.GetFileName(p) == fileName) return AssetDatabase.LoadAssetAtPath<Texture2D>(p);
        }
        return guids.Length > 0 ? AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(guids[0])) : null;
    }

    private static float ParseF(string s) => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 0;

    // --- PACKING UV ---
    void OnPostprocessModel(GameObject g)
    {
        foreach (MeshFilter filter in g.GetComponentsInChildren<MeshFilter>())
        {
            if (filter.sharedMesh != null) ApplyPacking(filter.sharedMesh);
        }

        Light[] lights = g.GetComponentsInChildren<Light>();
        foreach (Light light in lights)
        {
            light.intensity *= 0.1f;
        }
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

public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.RemoveEmptyEntries);
        // Ajout de "AlphaValue" dans la liste des clés reconnues
        string[] keys = { "Base Color", "Normal", "Roughness", "Metallic", "Emission", "ColorHex", "EmissionHex", "MetallicValue", "SmoothnessValue", "EmissionIntensity", "AlphaValue" };

        foreach (var m in materials)
        {
            try
            {
                int s = m.IndexOf('"') + 1;
                int e = m.IndexOf('"', s);
                if (s <= 0 || e <= 0) continue;
                string matName = m.Substring(s, e - s);
                var dict = new Dictionary<string, string>();
                foreach (var k in keys)
                {
                    string search = $"\"{k}\": ";
                    if (m.Contains(search))
                    {
                        int vStart = m.IndexOf(search) + search.Length;
                        if (m[vStart] == '"')
                        {
                            vStart++;
                            dict[k] = m.Substring(vStart, m.IndexOf('"', vStart) - vStart);
                        }
                        else
                        {
                            int vEnd = m.IndexOfAny(new char[] { ',', '}', '\n' }, vStart);
                            if (vEnd == -1) vEnd = m.Length;
                            dict[k] = m.Substring(vStart, vEnd - vStart).Trim();
                        }
                    }
                }
                result[matName] = dict;
            }
            catch { }
        }
        return result;
    }
}