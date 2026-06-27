#if UNITY_EDITOR && UDONSHARP
using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.Linq;

[InitializeOnLoad]
public static class LayeredLightingReflectionProbeCleanBake
{
    // ── Constants – tweak these to match your default/bake values ──
    private const float DefaultSpeculars = 1f;
    private const float DefaultReflections = 1f;
    private const float DefaultMaskedLights = 0f;

    private const float BakeSpeculars = 0f;
    private const float BakeReflections = 0f;
    private const float BakeMaskedLights = 1f;

    // ── Automation ──
    static LayeredLightingReflectionProbeCleanBake()
    {
        Lightmapping.bakeStarted += OnBakeStarted;
        Lightmapping.bakeCompleted += OnBakeCompleted;
        EditorApplication.update += PollBakeState;
    }

    private static bool wasRunning;

    private static void PollBakeState()
    {
        bool isRunning = Lightmapping.isRunning;
        if (isRunning && !wasRunning) OnBakeStarted();
        else if (!isRunning && wasRunning) OnBakeCompleted();
        wasRunning = isRunning;
    }

    private static void OnBakeStarted() => ApplyToAllMaterials(BakeSpeculars, BakeReflections, BakeMaskedLights,
        specularKeyword: false, reflectionKeyword: false, maskedKeyword: true);

    private static void OnBakeCompleted() => ApplyToAllMaterials(DefaultSpeculars, DefaultReflections, DefaultMaskedLights,
        specularKeyword: true, reflectionKeyword: true, maskedKeyword: false);

    // ── Core function ──
    private static void ApplyToAllMaterials(float speculars, float reflections, float maskedLights,
                                            bool specularKeyword, bool reflectionKeyword, bool maskedKeyword)
    {
        // Use Object.FindObjectsOfType with explicit generic parameter
        var renderers = Object.FindObjectsOfType<Renderer>();
        var materials = renderers
            .SelectMany(r => r.sharedMaterials)
            .Where(m => m != null)
            .Distinct();

        int changed = 0;

        foreach (var mat in materials)
        {
            bool modified = false;

            if (mat.HasProperty("_Speculars"))
            {
                mat.SetFloat("_Speculars", speculars);
                modified = true;
            }
            if (mat.HasProperty("_Reflections"))
            {
                mat.SetFloat("_Reflections", reflections);
                modified = true;
            }
            if (mat.HasProperty("_DiffuseMaskedLights"))
            {
                mat.SetFloat("_DiffuseMaskedLights", maskedLights);
                modified = true;
            }

            if (mat.HasProperty("_Speculars"))
            {
                if (specularKeyword) mat.EnableKeyword("_SPECULARS_ON");
                else mat.DisableKeyword("_SPECULARS_ON");
                modified = true;
            }
            if (mat.HasProperty("_Reflections"))
            {
                if (reflectionKeyword) mat.EnableKeyword("_REFLECTIONS_ON");
                else mat.DisableKeyword("_REFLECTIONS_ON");
                modified = true;
            }
            if (mat.HasProperty("_DiffuseMaskedLights"))
            {
                if (maskedKeyword) mat.EnableKeyword("_DIFFUSEMASKEDLIGHTS_ON");
                else mat.DisableKeyword("_DIFFUSEMASKEDLIGHTS_ON");
                modified = true;
            }

            if (modified) changed++;
        }

        string mode = speculars == 0f ? "Bake" : "Restore";
        Debug.Log($"<b>[Clean Bake]</b> {mode}: applied values to {changed} materials.");
    }

    [MenuItem("Meenphie/Layered Lighting/Bake/Force Bake Mode")]
    private static void DebugBake() => OnBakeStarted();

    [MenuItem("Meenphie/Layered Lighting/Bake/Force Restore Mode")]
    private static void DebugRestore() => OnBakeCompleted();
}
#endif