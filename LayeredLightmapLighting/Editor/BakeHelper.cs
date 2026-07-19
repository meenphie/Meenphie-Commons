using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEditor;

[InitializeOnLoad]
public static class BakeHelper
{
    // ── Bake toggle values ─────────────────────────────────────────────────
    private const float DEFAULT_SPECULARS = 1f;
    private const float DEFAULT_REFLECTIONS = 1f;
    private const float DEFAULT_MASKED_LIGHTS = 0f;

    private const float BAKE_SPECULARS = 0f;
    private const float BAKE_REFLECTIONS = 0f;
    private const float BAKE_MASKED_LIGHTS = 1f;

    // ── Property & keyword names ───────────────────────────────────────────
    private static readonly string[] _floatProperties = { "_Speculars", "_Reflections", "_DiffuseMaskedLights" };
    private static readonly string[] _shaderKeywords = { "_SPECULARS_ON", "_REFLECTIONS_ON", "_DIFFUSEMASKEDLIGHTS_ON" };

    // ── Lifecycle ────────────────────────────────────────────────────────────
    static BakeHelper()
    {
        Lightmapping.bakeStarted += OnBakeStarted;
        Lightmapping.bakeCompleted += OnBakeCompleted;
        EditorApplication.update += PollBakeState;
    }

    // ── Bake state polling ───────────────────────────────────────────────────
    private static bool _wasRunning;

    private static void PollBakeState()
    {
        bool isRunning = Lightmapping.isRunning;
        if (isRunning && !_wasRunning) OnBakeStarted();
        else if (!isRunning && _wasRunning) OnBakeCompleted();
        _wasRunning = isRunning;
    }

    // ── Event handlers ───────────────────────────────────────────────────────
    private static void OnBakeStarted() => ApplyToAllMaterials(
        BAKE_SPECULARS, BAKE_REFLECTIONS, BAKE_MASKED_LIGHTS,
        specularKeyword: false, reflectionKeyword: false, maskedKeyword: true);

    private static void OnBakeCompleted() => ApplyToAllMaterials(
        DEFAULT_SPECULARS, DEFAULT_REFLECTIONS, DEFAULT_MASKED_LIGHTS,
        specularKeyword: true, reflectionKeyword: true, maskedKeyword: false);

    // ── Core application ─────────────────────────────────────────────────────
    private static void ApplyToAllMaterials(float speculars, float reflections, float maskedLights,
                                            bool specularKeyword, bool reflectionKeyword, bool maskedKeyword)
    {
        bool[] keywordStates = { specularKeyword, reflectionKeyword, maskedKeyword };
        float[] floatValues = { speculars, reflections, maskedLights };

        var renderers = Object.FindObjectsOfType<Renderer>();
        var materials = renderers
            .SelectMany(r => r.sharedMaterials)
            .Where(m => m != null)
            .Distinct();

        int changed = 0;

        foreach (Material mat in materials)
        {
            bool modified = false;

            for (int i = 0; i < _floatProperties.Length; i++)
            {
                string prop = _floatProperties[i];
                if (!mat.HasProperty(prop)) continue;

                mat.SetFloat(prop, floatValues[i]);

                string kw = _shaderKeywords[i];
                if (keywordStates[i]) mat.EnableKeyword(kw);
                else mat.DisableKeyword(kw);

                modified = true;
            }

            if (modified) changed++;
        }

        string mode = (speculars == 0f) ? "Bake" : "Restore";
        Debug.Log($"<b>[Clean Bake]</b> {mode}: applied values to {changed} materials.");
    }

    // ── Debug menu items ─────────────────────────────────────────────────────
    [MenuItem("Meenphie/Layered Lighting/Bake/Force Bake Mode")]
    private static void DebugBake() => OnBakeStarted();

    [MenuItem("Meenphie/Layered Lighting/Bake/Force Restore Mode")]
    private static void DebugRestore() => OnBakeCompleted();
}