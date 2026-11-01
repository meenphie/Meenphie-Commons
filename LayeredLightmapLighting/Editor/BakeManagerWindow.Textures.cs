using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using Meenphie.Commons;

/// <summary>
/// Textures tab: one entry per channel (Albedo, Normal, ...) showing every slice of the array with its usage count,
/// the array memory vs the source textures it replaces, and, as the last entry, the material table.
/// </summary>
public partial class BakeManagerWindow
{
    private sealed class ChannelData
    {
        public Texture2DArray array;
        public string[] names;
        public Dictionary<string, int> usage;
        public long arrayBytes;
        public long diskBytes;
        public int sourceCount;
        public long sourceBytes = -1;
    }

    private int _channel;
    private int _thumbSize = 110;
    private int _selectedSlice = -1;
    private int _selectedColumn = -1;

    private ChannelData Channel(int i)
    {
        var names = ChannelNames;
        if (_channels == null || _channels.Length != names.Length) _channels = new ChannelData[names.Length];
        if (_channels[i] != null) return _channels[i];

        var cd = new ChannelData
        {
            array = MeshArrayBaker.LoadArray(i),
            names = MeshArrayBaker.LoadSliceNames(i) ?? new string[0],
            usage = new Dictionary<string, int>()
        };
        cd.arrayBytes = BakeStats.RuntimeBytes(cd.array);
        cd.diskBytes = cd.array != null ? BakeStats.FileBytes(AssetDatabase.GetAssetPath(cd.array)) : 0L;

        string prop = ChannelTexProps[i];
        foreach (var m in EligibleMaterials())
        {
            if (!m.HasProperty(prop)) continue;
            string p = AssetDatabase.GetAssetPath(m.GetTexture(prop));
            if (string.IsNullOrEmpty(p)) continue;
            cd.usage.TryGetValue(p, out int c);
            cd.usage[p] = c + 1;
        }
        return _channels[i] = cd;
    }

    private IEnumerable<Material> EligibleMaterials() =>
        Scan().Where(r => r.eligible && r.originalMaterials != null)
              .SelectMany(r => r.originalMaterials).Where(m => m != null).Distinct();

    private static void EnsureSourceStats(ChannelData cd)
    {
        if (cd.sourceBytes >= 0) return;
        long total = 0;
        int n = 0;
        foreach (var p in cd.usage.Keys)
        {
            var t = AssetDatabase.LoadAssetAtPath<Texture>(p);
            if (t == null) continue;
            total += BakeStats.RuntimeBytes(t);
            n++;
        }
        cd.sourceBytes = total;
        cd.sourceCount = n;
    }

    private void DrawTexturesTab()
    {
        var names = ChannelNames;
        var labels = new string[names.Length + 1];
        for (int i = 0; i < names.Length; i++)
        {
            var c = Channel(i);
            labels[i] = c.array != null ? $"{names[i]} ({c.array.depth})" : names[i];
        }
        labels[names.Length] = "Material table";

        _channel = Mathf.Clamp(GUILayout.Toolbar(_channel, labels, GUILayout.Height(26)), 0, names.Length);
        GUILayout.Space(4);

        if (_channel == names.Length) DrawMaterialTable();
        else DrawArrayChannel(_channel);
    }

    private void DrawArrayChannel(int idx)
    {
        var names = ChannelNames;
        var ch = Channel(idx);
        if (ch.array == null)
        {
            Callout(Tone.Neutral, $"{names[idx]}: no array (no texture on any material, or not baked).");
            return;
        }

        var arr = ch.array;
        EnsureSourceStats(ch);
        int unused = ch.names.Count(p => !string.IsNullOrEmpty(p) && !ch.usage.ContainsKey(p));

        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            StatRow("Array", $"{arr.width}x{arr.height} · {arr.depth} slices · {arr.graphicsFormat}");
            StatRow("Memory", $"{BakeStats.Mb(ch.arrayBytes)} runtime · {BakeStats.Mb(ch.diskBytes)} on disk");
            StatRow("Sources", $"{ch.sourceCount} texture(s) · {BakeStats.Mb(ch.sourceBytes)} runtime (before baking)");
            StatRow("Slices", unused > 0 ? $"{arr.depth - unused} used · {unused} unused (rebake to clean up)" : $"{arr.depth} used");
        }

        GUILayout.Space(4);
        using (new EditorGUILayout.HorizontalScope())
        {
            GUILayout.Label("Thumbnail size", _muted, GUILayout.Width(110));
            _thumbSize = Mathf.RoundToInt(GUILayout.HorizontalSlider(_thumbSize, 64, 192, GUILayout.Width(160)));
            GUILayout.FlexibleSpace();
        }
        GUILayout.Space(2);

        if (Event.current.type == EventType.Layout) PumpThumbs(arr, idx);

        bool srgb = MeshArrayBaker.IsSrgbChannel(idx);
        int n = arr.depth;
        float cell = _thumbSize, labelH = 40f, pad = 6f;
        var area = BeginGrid(n, cell, cell + labelH, pad, out int cols);
        var e = Event.current;

        for (int i = 0; i < n; i++)
        {
            var r = CellRect(area, i, cols, cell, cell + labelH, pad);
            var texRect = new Rect(r.x, r.y, cell, cell);
            string path = i < ch.names.Length ? (ch.names[i] ?? "") : "";
            ch.usage.TryGetValue(path, out int uses);
            bool hover = r.Contains(e.mousePosition);

            if (e.type == EventType.Repaint)
            {
                EditorGUI.DrawRect(r, i == _selectedSlice ? CellSel : hover ? CellHot : CellBg);
                if (_thumbs.TryGetValue(ThumbKey(idx, i), out var tex) && tex != null)
                    GUI.DrawTexture(texRect, tex, ScaleMode.ScaleToFit, false);
                else
                    EditorGUI.DrawRect(texRect, new Color(0, 0, 0, 0.25f));

                string display = string.IsNullOrEmpty(path) ? "(unknown: rebake)" : Path.GetFileNameWithoutExtension(path);
                string usageText = string.IsNullOrEmpty(path) ? "" : uses == 0 ? "unused" : uses == 1 ? "1 material" : $"{uses} materials";
                GUI.Label(new Rect(r.x + 4, r.y + cell + 2, cell - 8, 18), $"#{i} {display}", _cellLabel);
                GUI.Label(new Rect(r.x + 4, r.y + cell + 20, cell - 8, 18), usageText, _cellSub);
            }

            GUI.Label(r, new GUIContent("", string.IsNullOrEmpty(path) ? "Source unknown, rebake" : $"{path}\nUsed by {uses} material(s)"));

            if (e.type == EventType.MouseDown && e.button == 0 && r.Contains(e.mousePosition))
            {
                _selectedSlice = i;
                var obj = string.IsNullOrEmpty(path) ? null : AssetDatabase.LoadAssetAtPath<Object>(path);
                if (obj != null)
                {
                    EditorGUIUtility.PingObject(obj);
                    if (e.clickCount == 2) Selection.activeObject = obj;
                }
                e.Use();
                Repaint();
            }
        }

        GUILayout.Space(2);
        if (_selectedSlice >= 0 && _selectedSlice < n)
        {
            string p = _selectedSlice < ch.names.Length ? ch.names[_selectedSlice] : "(source unknown)";
            GUILayout.Label($"#{_selectedSlice}  {p}", _bold);
        }
        else
            GUILayout.Label("Click a slice to ping its source texture (double-click to select it).", _muted);

        if (MeshArrayBaker.IsNormalChannel(idx))
            GUILayout.Label("Normal: Z is reconstructed for display.", _muted);
        if (MeshArrayBaker.IsRedChannel(idx))
            GUILayout.Label("Metallic / Roughness: red channel (R) shown in red.", _muted);
        else if (!srgb && !MeshArrayBaker.IsNormalChannel(idx))
            GUILayout.Label("Single channel shown as grey.", _muted);
    }

    private static int ThumbKey(int channel, int slice) => channel * 100000 + slice;

    /// <summary>Builds a few missing thumbnails per pass and keeps repainting until the channel is complete.</summary>
    private void PumpThumbs(Texture2DArray arr, int channel)
    {
        int budget = ThumbBudgetPerPass;
        bool srgb = MeshArrayBaker.IsSrgbChannel(channel);
        bool normal = MeshArrayBaker.IsNormalChannel(channel);
        bool redChannel = MeshArrayBaker.IsRedChannel(channel);
        for (int i = 0; i < arr.depth; i++)
        {
            int key = ThumbKey(channel, i);
            if (_thumbs.TryGetValue(key, out var t) && t != null) continue;
            if (budget-- <= 0) { Repaint(); return; }
            _thumbs[key] = BuildPreview(arr, i, ThumbRes, srgb, normal, redChannel);
        }
    }

    private static Texture2D BuildPreview(
        Texture2DArray arr, int slice, int size, bool srgb, bool normal, bool redChannel)
    {
        int mip = Mathf.Clamp(Mathf.FloorToInt(Mathf.Log(Mathf.Max(1f, arr.width / (float)size), 2f)), 0, Mathf.Max(0, arr.mipmapCount - 1));
        int w = Mathf.Max(1, arr.width >> mip), h = Mathf.Max(1, arr.height >> mip);

        var tmp = new Texture2D(w, h, arr.graphicsFormat, TextureCreationFlags.None);
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

            if (normal || !srgb)
            {
                var px = outTex.GetPixels32();
                for (int i = 0; i < px.Length; i++)
                {
                    var c = px[i];
                    if (normal)
                    {
                        float x = c.r / 255f * 2f - 1f, y = c.g / 255f * 2f - 1f;
                        float z = Mathf.Sqrt(Mathf.Clamp01(1f - x * x - y * y));
                        px[i] = new Color32(c.r, c.g, (byte)Mathf.RoundToInt((z * 0.5f + 0.5f) * 255f), 255);
                    }
                    else if (redChannel) px[i] = new Color32(c.r, 0, 0, 255);
                    else px[i] = new Color32(c.r, c.r, c.r, 255);
                }
                outTex.SetPixels32(px);
            }
            outTex.Apply(false);
            return outTex;
        }
        finally
        {
            RenderTexture.active = prev;
            RenderTexture.ReleaseTemporary(rt);
            DestroyImmediate(tmp);
        }
    }

    private void DrawMaterialTable()
    {
        var t = MeshArrayBaker.LoadTable();
        if (t == null)
        {
            Callout(Tone.Neutral, "No material table baked.");
            return;
        }
        if (_tablePx == null) { _tablePx = t.GetPixels(); _tableW = t.width; }

        using (new EditorGUILayout.VerticalScope(EditorStyles.helpBox))
        {
            StatRow("Table", $"{_tableW} column(s), one per distinct material");
            StatRow("Memory", $"{BakeStats.Mb(TableBytes())} runtime · {BakeStats.Mb(BakeStats.FileBytes(AssetDatabase.GetAssetPath(t)))} on disk");
            StatRow("Legend", "Top: color · bottom left: subsurface · bottom right: emission");
        }
        GUILayout.Space(4);

        if (_selectedColumn >= 0 && _selectedColumn < _tableW)
        {
            int x = _selectedColumn;
            Color c1 = _tablePx[_tableW + x], c2 = _tablePx[2 * _tableW + x], c3 = _tablePx[3 * _tableW + x];
            GUILayout.Label($"#{x}   thickness {c1.a:F2} · emission ×{c2.a:F2} · metallic {c3.r:F2} · roughness {c3.g:F2}", _bold);
        }
        else
            GUILayout.Label("Click a cell for its values.", _muted);

        GUILayout.Space(2);

        const float size = 56f, labelH = 20f, pad = 4f;
        int count = Mathf.Min(_tableW, 1000);
        var area = BeginGrid(count, size, size + labelH, pad, out int cols);
        var e = Event.current;

        for (int x = 0; x < count; x++)
        {
            var r = CellRect(area, x, cols, size, size + labelH, pad);
            Color c0 = _tablePx[x], c1 = _tablePx[_tableW + x], c2 = _tablePx[2 * _tableW + x], c3 = _tablePx[3 * _tableW + x];

            if (e.type == EventType.Repaint)
            {
                bool hover = r.Contains(e.mousePosition);
                EditorGUI.DrawRect(r, x == _selectedColumn ? CellSel : hover ? CellHot : CellBg);

                var top = new Rect(r.x + 2, r.y + 2, size - 4, (size - 4) * 0.6f);
                var bl = new Rect(r.x + 2, top.yMax, (size - 4) * 0.5f, (size - 4) * 0.4f);
                var br = new Rect(bl.xMax, top.yMax, (size - 4) * 0.5f, (size - 4) * 0.4f);
                EditorGUI.DrawRect(top, ToDisplay(c0));
                EditorGUI.DrawRect(bl, ToDisplay(c1));
                EditorGUI.DrawRect(br, c2.a > 0.001f ? ToDisplay(c2) : new Color(0.1f, 0.1f, 0.1f, 1f));

                GUI.Label(new Rect(r.x + 4, r.y + size, size - 6, labelH), "#" + x, _cellLabel);
            }

            GUI.Label(r, new GUIContent("", $"#{x}\nColor {c0}\nSubsurface {c1}\nEmission {c2}\nMetallic {c3.r:F2} · Roughness {c3.g:F2}"));

            if (e.type == EventType.MouseDown && e.button == 0 && r.Contains(e.mousePosition))
            {
                _selectedColumn = x;
                e.Use();
                Repaint();
            }
        }
        if (_tableW > count)
            GUILayout.Label($"… {_tableW - count} more", _muted);
    }
}
