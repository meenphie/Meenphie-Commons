using UnityEditor;
using UnityEngine;
using Meenphie.Commons;

public class ReflectionProbeBakeOp : IBakeOperation
{
    public string DisplayName => "Reflection Probes";
    public bool   IsBaked     => AssetDatabase.LoadAssetAtPath<CubemapArray>(
                                    BakePaths.ReflectionProbes + "ReflectionProbeArray_PC.asset") != null;

    public string GetStatus()
    {
        if (!IsBaked) return "Not baked";
        var mgr = Object.FindObjectOfType<LightingManager>();
        int n   = mgr != null ? mgr.reflectionProbeCount : 0;
        return $"{n} probes · {BakeUtil.SizeOnDisk(BakePaths.ReflectionProbes + "ReflectionProbeArray_PC.asset")}";
    }

    public (int count, bool warn) GetSliceInfo()
    {
        if (!IsBaked) return (0, false);
        var mgr = Object.FindObjectOfType<LightingManager>();
        int n   = mgr != null ? mgr.reflectionProbeCount : 0;
        return (n, n > 16);
    }

    public void Bake()   => ReflectionProbeArrayBuilder.Build();

    public void Delete()
    {
        AssetDatabase.DeleteAsset(BakePaths.ReflectionProbes + "ReflectionProbeArray_PC.asset");
        AssetDatabase.DeleteAsset(BakePaths.ReflectionProbes + "ReflectionProbeArray_Quest.asset");

        var mgr = Object.FindObjectOfType<LightingManager>();
        if (mgr != null)
        {
            Undo.RecordObject(mgr, "Delete Reflection Probe Bake");
            mgr.reflectionProbeArrayPC    = null;
            mgr.reflectionProbeArrayQuest = null;
            mgr.reflectionProbeCount      = 0;
            mgr.reflectionProbeMaxMip     = 0;
            EditorUtility.SetDirty(mgr);
        }
        Shader.SetGlobalTexture("_UdonReflectionProbeArray", null);
        Shader.SetGlobalFloat("_UdonReflectionArrayValid", 0f);
        Shader.SetGlobalFloat("_UdonReflectionProbeCount", 0f);
        AssetDatabase.Refresh();
    }
}