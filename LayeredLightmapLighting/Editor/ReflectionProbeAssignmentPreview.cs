using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

[InitializeOnLoad]
internal static class ReflectionProbeAssignmentPreview
{
    private const double RebuildDebounceSeconds = 0.25d;

    private sealed class RendererState
    {
        public Renderer renderer;
        public MaterialPropertyBlock rendererBlock;
        public MaterialPropertyBlock[] materialBlocks;
    }

    private static readonly int PreviewEnabledId =
        Shader.PropertyToID("_UdonReflectionProbePreviewEnabled");
    private static readonly int PreviewAssignmentId =
        Shader.PropertyToID("_UdonReflectionProbePreviewAssignment");
    private static readonly List<RendererState> RendererStates = new List<RendererState>();
    private static bool _rebuildQueued;
    private static double _lastRebuildRequestTime;

    static ReflectionProbeAssignmentPreview()
    {
        EditorApplication.delayCall += Rebuild;
        EditorApplication.hierarchyChanged += QueueRebuild;
        EditorApplication.projectChanged += QueueRebuild;
        Undo.undoRedoPerformed += QueueRebuild;
        Undo.postprocessModifications += OnPostprocessModifications;
        EditorSceneManager.sceneOpened += OnSceneOpened;
        EditorSceneManager.sceneSaving += OnSceneSaving;
        EditorSceneManager.sceneSaved += OnSceneSaved;
        EditorApplication.playModeStateChanged += OnPlayModeStateChanged;
        AssemblyReloadEvents.beforeAssemblyReload += Clear;
        EditorApplication.quitting += Clear;
    }

    public static void Rebuild()
    {
        _rebuildQueued = false;
        Clear();
        if (Application.isPlaying)
            return;
        if (EditorApplication.isCompiling || EditorApplication.isUpdating)
        {
            QueueRebuild();
            return;
        }

        MeshArrayBaker.ReflectionProbePlan plan = MeshArrayBaker.CreateReflectionProbePlan();
        foreach (KeyValuePair<Renderer, int> assignment in plan.Assignments)
        {
            Renderer renderer = assignment.Key;
            if (renderer == null) continue;

            var originalRendererBlock = new MaterialPropertyBlock();
            renderer.GetPropertyBlock(originalRendererBlock);
            var rendererBlock = new MaterialPropertyBlock();
            renderer.GetPropertyBlock(rendererBlock);
            var state = new RendererState
            {
                renderer = renderer,
                rendererBlock = originalRendererBlock,
                materialBlocks = new MaterialPropertyBlock[renderer.sharedMaterials.Length]
            };

            SetAssignment(rendererBlock, assignment.Value);
            renderer.SetPropertyBlock(rendererBlock);

            for (int i = 0; i < state.materialBlocks.Length; i++)
            {
                var originalMaterialBlock = new MaterialPropertyBlock();
                renderer.GetPropertyBlock(originalMaterialBlock, i);
                var materialBlock = new MaterialPropertyBlock();
                renderer.GetPropertyBlock(materialBlock, i);
                state.materialBlocks[i] = originalMaterialBlock;
                SetAssignment(materialBlock, assignment.Value);
                renderer.SetPropertyBlock(materialBlock, i);
            }

            RendererStates.Add(state);
        }

        SceneView.RepaintAll();
    }

    public static void Refresh() => QueueRebuild();

    public static void Clear()
    {
        foreach (RendererState state in RendererStates)
        {
            if (state.renderer == null) continue;

            state.renderer.SetPropertyBlock(state.rendererBlock);
            for (int i = 0; i < state.materialBlocks.Length; i++)
                if (i < state.renderer.sharedMaterials.Length)
                    state.renderer.SetPropertyBlock(state.materialBlocks[i], i);
        }

        RendererStates.Clear();
        SceneView.RepaintAll();
    }

    private static void SetAssignment(MaterialPropertyBlock block, int probeIndex)
    {
        block.SetFloat(PreviewEnabledId, 1f);
        block.SetFloat(PreviewAssignmentId, probeIndex >= 0 ? probeIndex + 1f : 0f);
    }

    private static void QueueRebuild()
    {
        if (EditorApplication.isPlayingOrWillChangePlaymode)
            return;

        _lastRebuildRequestTime = EditorApplication.timeSinceStartup;
        if (_rebuildQueued) return;

        _rebuildQueued = true;
        EditorApplication.update += WaitForRebuild;
    }

    private static void WaitForRebuild()
    {
        if (EditorApplication.isPlayingOrWillChangePlaymode)
        {
            _rebuildQueued = false;
            EditorApplication.update -= WaitForRebuild;
            return;
        }

        if (EditorApplication.isCompiling || EditorApplication.isUpdating)
            return;

        if (EditorApplication.timeSinceStartup - _lastRebuildRequestTime < RebuildDebounceSeconds)
            return;

        _rebuildQueued = false;
        EditorApplication.update -= WaitForRebuild;
        Rebuild();
    }

    private static void OnSceneOpened(UnityEngine.SceneManagement.Scene scene, OpenSceneMode mode) =>
        QueueRebuild();

    private static void OnSceneSaving(UnityEngine.SceneManagement.Scene scene, string path) =>
        Clear();

    private static void OnSceneSaved(UnityEngine.SceneManagement.Scene scene) =>
        QueueRebuild();

    private static UndoPropertyModification[] OnPostprocessModifications(
        UndoPropertyModification[] modifications)
    {
        QueueRebuild();
        return modifications;
    }

    private static void OnPlayModeStateChanged(PlayModeStateChange state)
    {
        if (state == PlayModeStateChange.ExitingEditMode)
            Clear();
        else if (state == PlayModeStateChange.EnteredEditMode)
            QueueRebuild();
    }
}

internal sealed class ReflectionProbeAssignmentPreviewSaveGuard : AssetModificationProcessor
{
    private static string[] OnWillSaveAssets(string[] paths)
    {
        ReflectionProbeAssignmentPreview.Clear();
        EditorApplication.delayCall += ReflectionProbeAssignmentPreview.Rebuild;
        return paths;
    }
}
