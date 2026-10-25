using UnityEditor;

public static class BakePaths
{
    public const string Root             = "Assets/Ligne 13/Scenes/LayeredLightmapLighting/";

    public const string Albedo           = Root + "Albedo/";
    public const string Roughness        = Root + "Roughness/";
    public const string Normal           = Root + "Normal/";
    public const string Metallic         = Root + "Metallic/";
    public const string Emission         = Root + "Emission/";
    public const string Lightmaps        = Root + "Lightmaps/";
    public const string ReflectionProbes = Root + "ReflectionProbes/";
    public const string Cookies          = Root + "Cookies/";

    // Centralised outputs
    public const string Meshes           = Root + "Meshes/";
    public const string Materials        = Root + "Materials/";
    public const string Tables           = Root + "Tables/";   // MaterialTable.asset

    public static void EnsureAll()
    {
        foreach (var p in new[] {
            Albedo, Roughness, Normal, Metallic, Emission,
            Lightmaps, ReflectionProbes, Cookies, Meshes, Materials, Tables
        }) Ensure(p);
    }

    public static void Ensure(string path)
    {
        path = path.TrimEnd('/');
        if (string.IsNullOrEmpty(path) || path == "Assets" || AssetDatabase.IsValidFolder(path)) return;
        var parent = System.IO.Path.GetDirectoryName(path).Replace('\\', '/');
        Ensure(parent);
        AssetDatabase.CreateFolder(parent, System.IO.Path.GetFileName(path));
    }
}