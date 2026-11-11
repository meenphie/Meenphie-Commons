using UnityEditor;
using UnityEngine;

public class LightmapBakeOp : IBakeOperation
{
    public string DisplayName => "Lightmaps + Cookies";
    private Texture2DArray _cachedAsset; // Add this cache field

    public bool IsBaked => _cachedAsset != null || AssetDatabase.LoadAssetAtPath<Texture2DArray>(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset") != null;

    public string GetStatus()
    {
        if (_cachedAsset == null) _cachedAsset = AssetDatabase.LoadAssetAtPath<Texture2DArray>(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");

        if (_cachedAsset == null) return "Not baked";
        return $"{_cachedAsset.depth} slices · {_cachedAsset.width}px · {BakeUtil.SizeOnDisk(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset")}";
    }

    public (int count, bool warn) GetSliceInfo()
    {
        if (_cachedAsset == null) _cachedAsset = AssetDatabase.LoadAssetAtPath<Texture2DArray>(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");

        if (_cachedAsset == null) return (0, false);
        return (_cachedAsset.depth, _cachedAsset.depth > 32);
    }

    public void Bake() => LightmapArrayBuilder.AutoAssignLightLayers();
    public void Delete()
    {
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "LightmapLayerArray_Quest.asset");
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "CookieArray.asset");

        var mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr != null)
        {
            Undo.RecordObject(mgr, "Delete Lightmap Bake");
            mgr.lightLayerArrayPC = null;
            mgr.lightLayerArrayQuest = null;
            mgr.cookieArray = null;
            EditorUtility.SetDirty(mgr);
        }
        Shader.SetGlobalTexture("_UdonLightmapArray", null);
        Shader.SetGlobalTexture("_UdonCookieArray", null);
        Shader.SetGlobalFloat("_UdonCookieArrayValid", 0f);
        AssetDatabase.Refresh();
    }
}