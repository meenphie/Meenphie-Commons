using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

/// <summary>Preview tab: Enabled / Disabled toggle per baked input (see BakePreview).</summary>
public partial class BakeManagerWindow
{
    private bool _previewReapply;
    private List<Material> _previewMats;

    /// <summary>Shared material assets used by the eligible renderers (what the preview toggles act on).</summary>
    private List<Material> PreviewTargets()
    {
        if (_previewMats != null) return _previewMats;
        return _previewMats = Scan()
            .Where(r => r.eligible && !string.IsNullOrEmpty(r.sharedMaterialPath))
            .Select(r => r.sharedMaterialPath).Distinct()
            .Select(p => AssetDatabase.LoadAssetAtPath<Material>(p))
            .Where(m => m != null)
            .ToList();
    }

    /// <summary>Called from InvalidateAll: shared materials / globals may have been rewritten by a bake or an apply.</summary>
    private void InvalidatePreview()
    {
        _previewMats = null;
        _previewReapply = true;
    }

    /// <summary>Called at the top of OnGUI: re-applies the disabled toggles once, on Layout, after an invalidate.</summary>
    private void TickPreview()
    {
        if (!_previewReapply || Event.current.type != EventType.Layout) return;
        _previewReapply = false;
        if (!BakePreview.AnyDisabled && !BakePreview.HasSuspended) return;   // no Scan() when nothing to re-apply

        var mats = PreviewTargets();
        BakePreview.Resume(mats);     // toggles that were suspended around a bake / apply / delete
        BakePreview.Reapply(mats);    // toggles still disabled (project change, rewritten materials)
    }

    private void DrawPreviewTab()
    {
        BakePreview.DrawGUI(PreviewTargets());
    }
}
