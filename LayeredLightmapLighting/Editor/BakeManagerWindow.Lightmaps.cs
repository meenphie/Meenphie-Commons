using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public partial class BakeManagerWindow
{
    private readonly Dictionary<int, Texture2D> _lightmapThumbs = new Dictionary<int, Texture2D>();
    private int _selectedLightmapSlice = -1;
    private int _selectedCookieSlice = -1;

    // ── VUE DES LIGHTMAPS ──────────────────────────────────────────────────────
    private void DrawLightmapArray()
    {
        var mgr = Object.FindObjectOfType<LightingManager>();
        Texture2DArray arr = mgr != null ? mgr.lightLayerArrayPC : null;

        if (arr == null)
        {
            Callout(Tone.Neutral, "No Lightmap Array baked. Run the Lightmap Bake first.");
            return;
        }

        long bytes = BakeStats.RuntimeBytes(arr);
        long diskBytes = BakeStats.FileBytes(AssetDatabase.GetAssetPath(arr));

        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            StatRow("Array PC", $"{arr.width}x{arr.height} · {arr.depth} slices · {arr.graphicsFormat}");
            StatRow("Memory", $"{BakeStats.Mb(bytes)} runtime · {BakeStats.Mb(diskBytes)} on disk");
            StatRow("Groups", $"{mgr.lightmapGroupCount} zone(s) (First slices are Masks, following are Lightmaps)");
        }
        GUILayout.Space(4);

        if (Event.current.type == EventType.Layout) PumpLightmapThumbs(arr);
        
        float cell = 110f, labelH = 40f, pad = 6f;
        var area = BeginGrid(arr.depth, cell, cell + labelH, pad, out int cols);
        var e = Event.current;

        for (int i = 0; i < arr.depth; i++)
        {
            var r = CellRect(area, i, cols, cell, cell + labelH, pad);
            var texRect = new Rect(r.x, r.y, cell, cell);

            if (e.type == EventType.Repaint)
            {
                bool hover = r.Contains(e.mousePosition);
                EditorGUI.DrawRect(r, i == _selectedLightmapSlice ? CellSel : hover ? CellHot : CellBg);
                
                if (_lightmapThumbs.TryGetValue(ThumbKey(100, i), out var tex) && tex != null)
                    GUI.DrawTexture(texRect, tex, ScaleMode.ScaleToFit, false);
                else
                    EditorGUI.DrawRect(texRect, new Color(0, 0, 0, 0.25f));

                // On détermine si c'est un masque ou une lightmap
                bool isMask = i < mgr.lightmapGroupCount;
                string type = isMask ? "Mask" : "Lightmap";
                
                // On essaie de retrouver le nom de la lumière associée
                string lightName = "Unknown";
                if (!isMask && mgr.childLightLayerSlices != null)
                {
                    int targetSlice = i - mgr.lightmapGroupCount;
                    for (int l = 0; l < mgr.childLightLayerSlices.Length; l++)
                    {
                        if (mgr.childLightLayerSlices[l] == targetSlice && l < mgr.childLights.Length && mgr.childLights[l] != null)
                        {
                            lightName = mgr.childLights[l].name;
                            break;
                        }
                    }
                }

                GUI.Label(new Rect(r.x + 4, r.y + cell + 2, cell - 8, 18), $"#{i} {type}", _cellLabel);
                GUI.Label(new Rect(r.x + 4, r.y + cell + 20, cell - 8, 18), lightName, _cellSub);
            }

            if (e.type == EventType.MouseDown && e.button == 0 && r.Contains(e.mousePosition))
            {
                _selectedLightmapSlice = i;
                e.Use();
                Repaint();
            }
        }

        if (_selectedLightmapSlice >= 0 && _selectedLightmapSlice < arr.depth)
        {
            GUILayout.Space(4);
            GUILayout.Label($"Selected Slice #{_selectedLightmapSlice}", _bold);
        }
    }

    private void PumpLightmapThumbs(Texture2DArray arr)
    {
        int budget = ThumbBudgetPerPass;
        for (int i = 0; i < arr.depth; i++)
        {
            int key = ThumbKey(100, i);
            if (_lightmapThumbs.TryGetValue(key, out var t) && t != null) continue;
            if (budget-- <= 0) { Repaint(); return; }
            
            // BC6H / ASTC_HDR sont linéaires, on force srgb = false
            _lightmapThumbs[key] = BuildArrayPreview(arr, i, ThumbRes, false);
        }
    }

    // ── VUE DES COOKIES ────────────────────────────────────────────────────────
    private void DrawCookieArray()
    {
        var mgr = Object.FindObjectOfType<LightingManager>();
        Texture2DArray arr = mgr != null ? mgr.cookieArray : null;

        if (arr == null)
        {
            Callout(Tone.Neutral, "No Cookie Array baked. Run the Lightmap Bake first.");
            return;
        }

        long bytes = BakeStats.RuntimeBytes(arr);
        
        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            StatRow("Array", $"{arr.width}x{arr.height} · {arr.depth} slices · {arr.graphicsFormat}");
            StatRow("Memory", $"{BakeStats.Mb(bytes)} runtime");
        }
        GUILayout.Space(4);

        if (Event.current.type == EventType.Layout) PumpCookieThumbs(arr);

        float cell = 110f, labelH = 20f, pad = 6f;
        var area = BeginGrid(arr.depth, cell, cell + labelH, pad, out int cols);
        var e = Event.current;

        for (int i = 0; i < arr.depth; i++)
        {
            var r = CellRect(area, i, cols, cell, cell + labelH, pad);
            var texRect = new Rect(r.x, r.y, cell, cell);

            if (e.type == EventType.Repaint)
            {
                bool hover = r.Contains(e.mousePosition);
                EditorGUI.DrawRect(r, i == _selectedCookieSlice ? CellSel : hover ? CellHot : CellBg);
                
                if (_lightmapThumbs.TryGetValue(ThumbKey(200, i), out var tex) && tex != null)
                    GUI.DrawTexture(texRect, tex, ScaleMode.ScaleToFit, false);
                else
                    EditorGUI.DrawRect(texRect, new Color(0, 0, 0, 0.25f));

                // On cherche la lumière qui utilise ce cookie
                string lightName = "Unknown";
                if (mgr.childLightCookieSlice != null)
                {
                    for (int l = 0; l < mgr.childLightCookieSlice.Length; l++)
                    {
                        if (mgr.childLightCookieSlice[l] == i && l < mgr.childLights.Length && mgr.childLights[l] != null)
                        {
                            lightName = mgr.childLights[l].name;
                            break;
                        }
                    }
                }

                GUI.Label(new Rect(r.x + 4, r.y + cell + 2, cell - 8, 18), $"#{i} {lightName}", _cellLabel);
            }

            if (e.type == EventType.MouseDown && e.button == 0 && r.Contains(e.mousePosition))
            {
                _selectedCookieSlice = i;
                e.Use();
                Repaint();
            }
        }
    }

    private void PumpCookieThumbs(Texture2DArray arr)
    {
        int budget = ThumbBudgetPerPass;
        for (int i = 0; i < arr.depth; i++)
        {
            int key = ThumbKey(200, i);
            if (_lightmapThumbs.TryGetValue(key, out var t) && t != null) continue;
            if (budget-- <= 0) { Repaint(); return; }
            
            // RFloat = niveaux de gris, linéaire
            _lightmapThumbs[key] = BuildArrayPreview(arr, i, ThumbRes, false);
        }
    }

    // ── UTILITAIRE DE PREVIEW ──────────────────────────────────────────────────
    private static Texture2D BuildArrayPreview(Texture2DArray arr, int slice, int size, bool srgb)
    {
        int mip = Mathf.Clamp(Mathf.FloorToInt(Mathf.Log(Mathf.Max(1f, arr.width / (float)size), 2f)), 0, Mathf.Max(0, arr.mipmapCount - 1));
        int w = Mathf.Max(1, arr.width >> mip), h = Mathf.Max(1, arr.height >> mip);

        var tmp = new Texture2D(w, h, arr.graphicsFormat, UnityEngine.Experimental.Rendering.TextureCreationFlags.None);
        Graphics.CopyTexture(arr, slice, mip, tmp, 0, 0);

        var rt = RenderTexture.GetTemporary(size, size, 0, RenderTextureFormat.ARGB32,
            srgb ? RenderTextureReadWrite.sRGB : RenderTextureReadWrite.Linear);
        var prev = RenderTexture.active;
        try
        {
            Graphics.Blit(tmp, rt);
            var outTex = new Texture2D(size, size, TextureFormat.RGBA32, false, !srgb)
                { hideFlags = HideFlags.HideAndDontSave };
            RenderTexture.active = rt;
            outTex.ReadPixels(new Rect(0, 0, size, size), 0, 0, false);
            outTex.Apply(false);
            return outTex;
        }
        finally
        {
            RenderTexture.active = prev;
            RenderTexture.ReleaseTemporary(rt);
            Object.DestroyImmediate(tmp);
        }
    }

    private void ClearLightmapThumbs()
    {
        foreach (var t in _lightmapThumbs.Values) if (t != null) Object.DestroyImmediate(t);
        _lightmapThumbs.Clear();
    }
}