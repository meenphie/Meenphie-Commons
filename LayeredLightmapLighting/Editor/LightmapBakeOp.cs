using UnityEditor;
using UnityEngine;
using Meenphie.Commons;

public class LightmapBakeOp : IBakeOperation
{
    public string DisplayName => "Lightmaps + Cookies";
    public bool   IsBaked     => AssetDatabase.LoadAssetAtPath<Texture2DArray>(
                                    BakePaths.Lightmaps + "LightmapLayerArray_PC.asset") != null;

    public string GetStatus()
    {
        if (!IsBaked) return "Not baked";
        var arr = AssetDatabase.LoadAssetAtPath<Texture2DArray>(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");
        return $"{arr.depth} slices · {arr.width}px · {BakeUtil.SizeOnDisk(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset")}";
    }

    public (int count, bool warn) GetSliceInfo()
    {
        if (!IsBaked) return (0, false);
        var arr = AssetDatabase.LoadAssetAtPath<Texture2DArray>(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");
        return (arr.depth, arr.depth > 32);
    }

    public void Bake()   => LightmapArrayBuilder.AutoAssignLightLayers();

    public void Delete()
    {
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "LightmapLayerArray_PC.asset");
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "LightmapLayerArray_Quest.asset");
        AssetDatabase.DeleteAsset(BakePaths.Lightmaps + "CookieArray.asset");

        var mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr != null)
        {
            Undo.RecordObject(mgr, "Delete Lightmap Bake");
            mgr.lightLayerArrayPC    = null;
            mgr.lightLayerArrayQuest = null;
            mgr.cookieArray          = null;
            EditorUtility.SetDirty(mgr);
        }
        Shader.SetGlobalTexture("_UdonLightLayerArray", null);
        Shader.SetGlobalTexture("_UdonCookieArray", null);
        Shader.SetGlobalFloat("_UdonCookieArrayValid", 0f);
        AssetDatabase.Refresh();
    }
}