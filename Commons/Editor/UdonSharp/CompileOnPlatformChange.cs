using UnityEditor;
using UnityEditor.Build;
using UdonSharp;

namespace Meenphie.Commons
{
    public class CompileOnPlatformChange : IActiveBuildTargetChanged
    {
        public int callbackOrder { get { return 0; } }
        public void OnActiveBuildTargetChanged(BuildTarget previousTarget, BuildTarget newTarget)
        {
            UdonSharpProgramAsset.CompileAllCsPrograms(true);
        }
    }
}