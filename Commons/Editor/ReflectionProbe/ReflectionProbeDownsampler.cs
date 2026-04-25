using UnityEngine;
using UnityEditor;
using System.IO;

public class ReflectionProbeDownsampler : EditorWindow
{
    private int targetResolution = 256;
    private int aaFactor = 4;

    private readonly int[] resolutions = { 64, 128, 256, 512, 1024, 2048 };
    private readonly string[] resolutionStrings = { "64", "128", "256", "512", "1024", "2048" };
    private readonly int[] factors = { 1, 2, 4 };
    private readonly string[] factorStrings = { "x1 (Native)", "x2 (SSAA)", "x4 (Extreme)" };

    private Vector2 scrollPos;

    [MenuItem("Meenphie/Reflection Probe Manager")]
    public static void ShowWindow() => GetWindow<ReflectionProbeDownsampler>("AA HDR Probe Baker");

    private void OnGUI()
    {
        GUILayout.Space(15);
        
        // --- CONFIGURATION ---
        using (new GUILayout.VerticalScope(GUI.skin.box))
        {
            GUILayout.Label("LINEAR HDR KAISER WORKFLOW", EditorStyles.boldLabel);
            targetResolution = EditorGUILayout.IntPopup("Target Resolution", targetResolution, resolutionStrings, resolutions);
            aaFactor = EditorGUILayout.IntPopup("AA Factor (Upscale)", aaFactor, factorStrings, factors);

            int bakeRes = Mathf.Min(targetResolution * aaFactor, 4096);
            EditorGUILayout.HelpBox($"Bake: {bakeRes}px HDR\nFilter: Kaiser (Sharp Downsample)\nTarget: {targetResolution}px HDR", MessageType.Info);

            GUILayout.Space(10);

            // --- ACTIONS ---
            if (GUILayout.Button("EXECUTE KAISER CLEAN BAKE", GUILayout.Height(30)))
            {
                ExecuteFullWorkflow();
            }

            if (GUILayout.Button("SET ALL MESH RENDERERS TO SIMPLE", GUILayout.Height(25)))
            {
                SetAllRenderersToSimple();
            }
        }

        GUILayout.Space(10);
        
        // --- LISTE DES PROBES ---
        GUILayout.Label("SCENE PROBES", EditorStyles.boldLabel);
        scrollPos = GUILayout.BeginScrollView(scrollPos);
        ReflectionProbe[] probes = Object.FindObjectsByType<ReflectionProbe>(FindObjectsSortMode.InstanceID);
        
        foreach (var probe in probes)
        {
            using (new GUILayout.HorizontalScope(GUI.skin.box))
            {
                EditorGUILayout.ObjectField(probe, typeof(ReflectionProbe), true);
                if (GUILayout.Button("Bake (Kaiser)", GUILayout.Width(100)))
                {
                    SingleProbeWorkflow(probe);
                }
            }
        }
        GUILayout.EndScrollView();
    }

    private void SetAllRenderersToSimple()
    {
        MeshRenderer[] renderers = Object.FindObjectsByType<MeshRenderer>(FindObjectsSortMode.None);
        Undo.RecordObjects(renderers, "Set Probes to Simple");

        int count = 0;
        foreach (var renderer in renderers)
        {
            if (renderer.reflectionProbeUsage != UnityEngine.Rendering.ReflectionProbeUsage.Simple)
            {
                renderer.reflectionProbeUsage = UnityEngine.Rendering.ReflectionProbeUsage.Simple;
                count++;
            }
        }
        Debug.Log($"[Meenphie] {count} MeshRenderers passés en mode 'Simple'.");
        EditorUtility.DisplayDialog("Succès", $"{count} Renderers modifiés.", "OK");
    }

    // --- LOGIQUE DE BAKE ---
    private void ExecuteFullWorkflow()
    {
        ReflectionProbe[] probes = Object.FindObjectsByType<ReflectionProbe>(FindObjectsSortMode.InstanceID);
        int count = probes.Length;

        for (int i = 0; i < count; i++)
        {
            if (EditorUtility.DisplayCancelableProgressBar("AA Bake", "Clearing Cache...", (float)i / count * 0.2f)) { Cleanup(); return; }
            EraseProbeTexture(probes[i]);
        }
        AssetDatabase.Refresh();

        for (int i = 0; i < count; i++)
        {
            float p = 0.2f + ((float)i / count * 0.8f);
            if (EditorUtility.DisplayCancelableProgressBar("AA Bake", $"Processing {probes[i].name}...", p)) break;
            ProcessProbe(probes[i]);
        }

        Cleanup();
        Debug.Log($"[Meenphie] Bake terminé.");
    }

    private void SingleProbeWorkflow(ReflectionProbe probe)
    {
        EraseProbeTexture(probe);
        AssetDatabase.Refresh();
        ProcessProbe(probe);
        AssetDatabase.Refresh();
    }

    private void EraseProbeTexture(ReflectionProbe probe)
    {
        if (probe.bakedTexture != null)
        {
            string path = AssetDatabase.GetAssetPath(probe.bakedTexture);
            probe.bakedTexture = null;
            if (!string.IsNullOrEmpty(path) && File.Exists(path)) AssetDatabase.DeleteAsset(path);
        }
    }

    private void ProcessProbe(ReflectionProbe probe)
    {
        int captureRes = Mathf.Min(targetResolution * aaFactor, 4096);
        probe.resolution = captureRes;

        string scenePath = probe.gameObject.scene.path;
        string folder = Path.Combine(Path.GetDirectoryName(scenePath), Path.GetFileNameWithoutExtension(scenePath)).Replace("\\", "/");
        if (!AssetDatabase.IsValidFolder(folder)) AssetDatabase.CreateFolder(Path.GetDirectoryName(scenePath), Path.GetFileNameWithoutExtension(scenePath));

        string path = Path.Combine(folder, $"Refl-{probe.name}-{probe.GetInstanceID()}.exr").Replace("\\", "/");

        if (Lightmapping.BakeReflectionProbe(probe, path))
        {
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);
            TextureImporter importer = AssetImporter.GetAtPath(path) as TextureImporter;
            if (importer != null)
            {
                importer.textureType = TextureImporterType.Default;
                importer.textureShape = TextureImporterShape.TextureCube;
                importer.sRGBTexture = false; 
                importer.mipmapEnabled = true;
                importer.mipmapFilter = TextureImporterMipFilter.KaiserFilter; 
                importer.filterMode = FilterMode.Trilinear;
                importer.maxTextureSize = targetResolution;
                importer.textureCompression = TextureImporterCompression.Uncompressed;
                importer.SaveAndReimport();
            }
            probe.resolution = targetResolution;
            EditorUtility.SetDirty(probe);
        }
    }

    private void Cleanup()
    {
        EditorUtility.ClearProgressBar();
        AssetDatabase.Refresh();
    }
}