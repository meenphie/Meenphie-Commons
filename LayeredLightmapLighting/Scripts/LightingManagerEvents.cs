#if UNITY_EDITOR
using System;

public static class LightingManagerEvents
{
    public static event Action EditorPreviewRefreshRequested;

    public static void RaisePreviewRefresh()
    {
        EditorPreviewRefreshRequested?.Invoke();
    }
}
#endif
