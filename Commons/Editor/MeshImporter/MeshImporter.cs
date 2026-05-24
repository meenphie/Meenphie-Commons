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
        AssetDatabase.Refresh();
        Process(true);
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Process
    // ─────────────────────────────────────────────────────────────────────────

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

    // ─────────────────────────────────────────────────────────────────────────
    // Apply
    // ─────────────────────────────────────────────────────────────────────────

    private static bool Apply(Material mat, Dictionary<string, string> data)
    {
        // 1. Base Color & Alpha
        string colorHex = GetValue(data, "ColorHex", "FFFFFF");
        if (ColorUtility.TryParseHtmlString("#" + colorHex, out Color c))
        {
            c.a = ParseF(GetValue(data, "AlphaValue", "1.0"));
            mat.SetColor("_Color", c);
        }

        // 2. Metallic & Smoothness
        mat.SetFloat("_Metallic", ParseF(GetValue(data, "MetallicValue", "0")));
        mat.SetFloat("_Glossiness", ParseF(GetValue(data, "RoughnessValue", "0.5")));

        // 3. Emission
        string emHex = GetValue(data, "EmissionHex", "000000");
        float intensity = ParseF(GetValue(data, "EmissionIntensity", "1.0"));

        if (ColorUtility.TryParseHtmlString("#" + emHex, out Color ec))
        {
            mat.SetColor("_EmissionColor", ec);
            if (mat.HasProperty("_EmissionIntensity")) mat.SetFloat("_EmissionIntensity", intensity);

            if (intensity > 0.001f || !emHex.Equals("000000")) mat.EnableKeyword("_EMISSIONENABLED_ON");
            else mat.DisableKeyword("_EMISSIONENABLED_ON");
        }

        // 4. Textures — toujours setter, null si absent du JSON ou texture introuvable
        SetTex(mat, data, "Base Color", "_MainTex");
        SetTex(mat, data, "Normal", "_BumpMap", "_NORMALMAP", isNormal: true);
        SetTex(mat, data, "Roughness", "_GlossinessMap");
        SetTex(mat, data, "Emission", "_EmissionMap");

        return true;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Clear
    // ─────────────────────────────────────────────────────────────────────────

    private static bool Clear(Material mat)
    {
        string[] texProps = { "_MainTex", "_BumpMap", "_MetallicMap", "_GlossinessMap", "_EmissionMap" };
        foreach (var p in texProps)
            if (mat.HasProperty(p)) mat.SetTexture(p, null);

        mat.SetColor("_Color", Color.white);
        mat.SetColor("_EmissionColor", Color.black);
        mat.SetFloat("_Metallic", 0);
        mat.SetFloat("_Glossiness", 0);
        mat.DisableKeyword("_NORMALMAP");
        return true;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SetTex — null la propriété si clé absente ou texture introuvable
    // ─────────────────────────────────────────────────────────────────────────

    private static bool SetTex(Material mat, Dictionary<string, string> data,
                                string key, string prop,
                                string keyword = "", bool isNormal = false)
    {
        if (!mat.HasProperty(prop)) return false;

        // Clé absente ou vide → on null + disable keyword
        if (!data.TryGetValue(key, out string fileName) || string.IsNullOrEmpty(fileName))
        {
            mat.SetTexture(prop, null);
            if (!string.IsNullOrEmpty(keyword)) mat.DisableKeyword(keyword);
            return false;
        }

        Texture2D tex = FindAndFixTex(fileName, isNormal);

        // Texture introuvable → idem, on null
        if (tex == null)
        {
            mat.SetTexture(prop, null);
            if (!string.IsNullOrEmpty(keyword)) mat.DisableKeyword(keyword);
            Debug.LogWarning($"{TAG} Texture introuvable : {fileName} (prop: {prop})");
            return false;
        }

        mat.SetTexture(prop, tex);
        if (!string.IsNullOrEmpty(keyword)) mat.EnableKeyword(keyword);
        return true;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // FindAndFixTex
    // ─────────────────────────────────────────────────────────────────────────

    private static Texture2D FindAndFixTex(string fileName, bool isNormal)
    {
        string nameOnly = Path.GetFileNameWithoutExtension(fileName);
        string[] guids = AssetDatabase.FindAssets(nameOnly + " t:Texture");

        foreach (var g in guids)
        {
            string p = AssetDatabase.GUIDToAssetPath(g);
            if (!Path.GetFileName(p).Equals(fileName, System.StringComparison.OrdinalIgnoreCase)) continue;

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

        return null;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Helpers
    // ─────────────────────────────────────────────────────────────────────────

    private static string GetValue(Dictionary<string, string> dict, string key, string defaultValue)
        => dict.ContainsKey(key) ? dict[key] : defaultValue;

    private static float ParseF(string s)
        => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 0;

    // ─────────────────────────────────────────────────────────────────────────
    // OnPostprocessModel
    // ─────────────────────────────────────────────────────────────────────────

    // ─────────────────────────────────────────────────────────────────────────
    // OnPostprocessModel
    // ─────────────────────────────────────────────────────────────────────────

    void OnPostprocessModel(GameObject g)
    {
        // 1. Packing des UVs
        foreach (MeshFilter filter in g.GetComponentsInChildren<MeshFilter>())
        {
            if (filter.sharedMesh != null) ApplyPacking(filter.sharedMesh);
        }

        // 2. Traitement des lumières
        string projectRoot = Path.GetDirectoryName(Application.dataPath);
        string lightsJsonPath = Path.Combine(projectRoot, "Blender", "lights_map.json");
        Dictionary<string, Dictionary<string, string>> lightsData = null;

        // Charger le JSON des lumières s'il existe
        if (File.Exists(lightsJsonPath))
        {
            lightsData = SimpleJsonParser.Parse(File.ReadAllText(lightsJsonPath));
        }

        // Appliquer les données aux lumières du modèle
        foreach (Light light in g.GetComponentsInChildren<Light>())
        {
            // Ton réglage d'intensité de base
            light.intensity *= 0.1f;

            // Si c'est une Area Light et qu'on a des données JSON correspondantes
            if (light.type == LightType.Area && lightsData != null && lightsData.ContainsKey(light.name))
            {
                var lData = lightsData[light.name];

                float sizeX = ParseF(GetValue(lData, "size_x", "1.0"));
                float sizeY = ParseF(GetValue(lData, "size_y", "1.0"));

                // Assigne la taille de l'Area Light
                light.areaSize = new Vector2(sizeX, sizeY);

                // Optionnel : Tu pourrais aussi surcharger l'intensité ici si tu le souhaites
                // light.intensity = ParseF(GetValue(lData, "intensity", "1.0"));
            }
        }
    }

    private void ApplyPacking(Mesh mesh)
    {
        var uv0 = new List<Vector2>();
        var uv1 = new List<Vector2>();

        mesh.GetUVs(0, uv0);
        mesh.GetUVs(1, uv1);

        if (uv0.Count == 0) return;

        // S'assurer que uv1 a la même longueur que uv0
        if (uv1.Count != uv0.Count)
            uv1 = new List<Vector2>(new Vector2[uv0.Count]);

        // Pack uv0 (xy) + uv1 (zw) dans un seul canal Vector4
        var packed = uv0.Zip(uv1, (a, b) => new Vector4(a.x, a.y, b.x, b.y)).ToList();

        mesh.SetUVs(0, packed);
        mesh.SetUVs(1, uv1);
    }
}