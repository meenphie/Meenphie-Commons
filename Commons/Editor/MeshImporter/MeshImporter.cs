using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;
using System.Globalization;

public class MeshImporter : AssetPostprocessor
{
    private const string TAG = "[<color=purple>Meenphie</color>]";

    [MenuItem("Meenphie/Materials/Update All")]
    public static void SyncAll()
    {
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
        // 1. Base Color & Alpha
        string colorHex = GetValue(data, "ColorHex", "FFFFFF");
        if (ColorUtility.TryParseHtmlString("#" + colorHex, out Color c))
        {
            c.a = ParseF(GetValue(data, "AlphaValue", "1.0"));
            mat.SetColor("_Color", c);
        }

        // 2. Metallic & Smoothness
        float metallicValue = ParseF(GetValue(data, "MetallicValue", "0"));
        mat.SetFloat("_Metallic", metallicValue);
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

        // 4. Textures
        SetTex(mat, data, "Base Color", "_MainTex");
        SetTex(mat, data, "Normal", "_BumpMap", "_NORMALMAP", true);
        SetTex(mat, data, "Roughness", "_GlossinessMap");
        
        bool hasMetallicMap = SetTex(mat, data, "Metallic", "_MetallicMap");
        SetTex(mat, data, "Emission", "_EmissionMap");

        // --- 5. SPECULAR / METALLIC LOGIC (Applied to EVERY synced material) ---
        // Logic: Enable reflections if there's a map OR the slider is > 0
        bool shouldEnableReflections = (metallicValue > 0.01f) || hasMetallicMap;
        
        // Debug specifically for potential metals or if manually set
        if (shouldEnableReflections)
        {
            Debug.Log($"{TAG} <color=green>[METALLIC ENABLED]</color> Material: <b>{mat.name}</b> (Val: {metallicValue}, Map: {hasMetallicMap})");
        }

        SetPropertyAndKeyword(mat, "_IsMetallic", shouldEnableReflections);

        return true;
    }

    private static void SetPropertyAndKeyword(Material mat, string propName, bool state)
    {
        if (mat.HasProperty(propName))
        {
            mat.SetFloat(propName, state ? 1.0f : 0.0f);
        }

        if (state) mat.EnableKeyword(propName);
        else mat.DisableKeyword(propName);
    }

    private static string GetValue(Dictionary<string, string> dict, string key, string defaultValue)
    {
        return dict.ContainsKey(key) ? dict[key] : defaultValue;
    }

    private static bool SetTex(Material mat, Dictionary<string, string> data, string key, string prop, string keyword = "", bool isNormal = false)
    {
        if (!data.ContainsKey(key)) return false;
        string fileName = data[key];
        
        if (string.IsNullOrEmpty(fileName)) return false;

        Texture2D tex = FindAndFixTex(fileName, isNormal);

        if (tex == null) return false;

        if (mat.GetTexture(prop) != tex)
        {
            mat.SetTexture(prop, tex);
            if (!string.IsNullOrEmpty(keyword))
            {
                if (tex != null) mat.EnableKeyword(keyword);
                else mat.DisableKeyword(keyword);
            }
        }
        return true;
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
        mat.SetFloat("_Metallic", 0);
        mat.SetFloat("_Glossiness", 0);
        mat.DisableKeyword("_NORMALMAP");
        mat.DisableKeyword("_IsMetallic");
        return true;
    }

    private static float ParseF(string s) => float.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out float r) ? r : 0;

    void OnPostprocessModel(GameObject g)
    {
        foreach (MeshFilter filter in g.GetComponentsInChildren<MeshFilter>())
        {
            if (filter.sharedMesh != null) ApplyPacking(filter.sharedMesh);
        }
        Light[] lights = g.GetComponentsInChildren<Light>();
        foreach (Light light in lights) light.intensity *= 0.5f;
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
    }
}