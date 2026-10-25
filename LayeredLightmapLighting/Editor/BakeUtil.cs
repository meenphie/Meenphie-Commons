using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

public static class BakeUtil
{
    public static void SaveOrReplace(Object newAsset, string path)
    {
        var existing = AssetDatabase.LoadAssetAtPath<Object>(path);
        if (existing != null) { EditorUtility.CopySerialized(newAsset, existing); Object.DestroyImmediate(newAsset); }
        else AssetDatabase.CreateAsset(newAsset, path);
    }

    public static (GraphicsFormat gfx, TextureFormat tex) BestSrgbFormat()
        => SystemInfo.SupportsTextureFormat(TextureFormat.BC7)
            ? (GraphicsFormat.RGBA_BC7_SRGB, TextureFormat.BC7)
            : (GraphicsFormat.RGBA_DXT5_SRGB, TextureFormat.DXT5);

    public static string SizeOnDisk(string path)
    {
        var full = System.IO.Path.GetFullPath(path);
        if (!System.IO.File.Exists(full)) return "?";
        return $"{new System.IO.FileInfo(full).Length / (1024f * 1024f):F1} MB";
    }
}