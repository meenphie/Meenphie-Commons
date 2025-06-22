using UnityEditor;
using UnityEditor.Build;
using UdonSharp;

public class CompileOnPlatformChange : IActiveBuildTargetChanged
{
    public int callbackOrder { get { return 0; } }
    public void OnActiveBuildTargetChanged(BuildTarget previousTarget, BuildTarget newTarget)
    {
        UdonSharpProgramAsset.CompileAllCsPrograms(true);
    }
}