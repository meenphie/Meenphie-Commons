using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

public static class BakeUtil
{
    // ── Assets ────────────────────────────────────────────────
    public static void SaveOrReplace(Object newAsset, string path)
    {
        var existing = AssetDatabase.LoadAssetAtPath<Object>(path);
        if (existing != null) { EditorUtility.CopySerialized(newAsset, existing); Object.DestroyImmediate(newAsset); }
        else AssetDatabase.CreateAsset(newAsset, path);
    }

    public static T LoadOrCreate<T>(string path) where T : ScriptableObject
    {
        var asset = AssetDatabase.LoadAssetAtPath<T>(path);
        if (asset != null) return asset;
        asset = ScriptableObject.CreateInstance<T>();
        AssetDatabase.CreateAsset(asset, path);
        return asset;
    }

    /// <summary>Supprime les assets de <paramref name="filter"/> dans <paramref name="folder"/> absents de <paramref name="keep"/>.</summary>
    public static void DeleteUnused(string folder, HashSet<string> keep, string filter)
    {
        var f = folder.TrimEnd('/');
        if (!AssetDatabase.IsValidFolder(f)) return;
        foreach (var g in AssetDatabase.FindAssets(filter, new[] { f }))
        {
            var p = AssetDatabase.GUIDToAssetPath(g);
            if (!keep.Contains(p)) AssetDatabase.DeleteAsset(p);
        }
    }

    // ── Formats ───────────────────────────────────────────────
    public static (GraphicsFormat gfx, TextureFormat tex) BestSrgbFormat()
        => SystemInfo.SupportsTextureFormat(TextureFormat.BC7)
            ? (GraphicsFormat.RGBA_BC7_SRGB, TextureFormat.BC7)
            : (GraphicsFormat.RGBA_DXT5_SRGB, TextureFormat.DXT5);

    // ── Size ──────────────────────────────────────────────────
    public static string SizeOnDisk(string path)
    {
        var full = Path.GetFullPath(path);
        return File.Exists(full) ? $"{new FileInfo(full).Length / (1024f * 1024f):F1} MB" : "?";
    }

    public static long SizeOnDiskBytes(string path)
    {
        var full = Path.GetFullPath(path);
        return File.Exists(full) ? new FileInfo(full).Length : 0;
    }

    // ── Filenames ─────────────────────────────────────────────
    public static string SafeFileName(string s) =>
        string.Join("_", s.Replace('/', '_').Split(Path.GetInvalidFileNameChars()));

    public static string ShortHash(string s)
    {
        using (var md5 = MD5.Create())
        {
            var b = md5.ComputeHash(Encoding.UTF8.GetBytes(s));
            return System.BitConverter.ToString(b, 0, 4).Replace("-", "").ToLowerInvariant();
        }
    }

    // ── Scene ─────────────────────────────────────────────────
    public static bool EnsureScenesSaved()
    {
        for (int i = 0; i < SceneManager.sceneCount; i++)
        {
            var s = SceneManager.GetSceneAt(i);
            if (s.isLoaded && string.IsNullOrEmpty(s.path))
            {
                Debug.LogError("[Bake] Save the scene first (renderer ids need a saved scene).");
                return false;
            }
        }
        return true;
    }

    // ── Reflection: LightingManager ───────────────────────────
    public static void SetManagerField(string field, Object value)
    {
        var mgr = Object.FindObjectsOfType<MonoBehaviour>()
                        .FirstOrDefault(m => m != null && m.GetType().Name == "LightingManager");
        if (mgr == null) return;
        var so = new SerializedObject(mgr);
        var prop = so.FindProperty(field);
        if (prop == null) { Debug.LogWarning($"[Bake] LightingManager has no field '{field}'."); return; }
        prop.objectReferenceValue = value;
        so.ApplyModifiedProperties();
    }
}