using UnityEditor;
using UnityEngine;
using Meenphie.Commons;
using UnityEngine.Experimental.Rendering;

public class BakeManagerWindow : EditorWindow
{
    private IBakeOperation[] _lightingOps;
    private MeshArraysBakeOp _meshOp;
    private Vector2 _scroll;

    // Preview state
    private int _prevChannel, _prevSlice, _prevSize = 256;
    private Texture2D _prevTex;
    private int _prevBuiltChannel = -1, _prevBuiltSlice = -1, _prevBuiltSize = -1;
    private bool _tableFold;
    private Vector2 _tableScroll;
    private Color[] _tablePx;
    private int _tableW;

    private void OnProjectChange()
    {
        _prevTex = null; _prevBuiltChannel = -1; _tablePx = null;
        Repaint();
    }

    private void OnDisable()
    {
        if (_prevTex != null) DestroyImmediate(_prevTex);
    }

    [MenuItem("Meenphie/Bake Manager")]
    public static void Open() => GetWindow<BakeManagerWindow>("Bake Manager").minSize = new Vector2(550, 520);

    private void OnEnable()
    {
        _lightingOps = new IBakeOperation[]
        {
            new LightmapBakeOp(),
            new ReflectionProbeBakeOp(),
        };
        _meshOp = new MeshArraysBakeOp();
    }

    private void OnGUI()
    {
        EditorGUILayout.Space(4);
        EditorGUILayout.LabelField("Bake Manager", EditorStyles.boldLabel);
        EditorGUILayout.LabelField("Lightmaps, Probes, Texture Arrays + Material Table (UV0 / UV2 / UV4).", EditorStyles.miniLabel);
        EditorGUILayout.Space(8);

        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("Bake All", GUILayout.Height(32)))
        {
            if (EditorUtility.DisplayDialog("Bake All",
                "Lance TOUS les bakes (Lightmaps → Probes → Mesh Arrays),\n" +
                "puis applique les meshes/matériaux partagés sur la scène.", "Bake", "Cancel"))
                BakeAll();
        }
        if (GUILayout.Button("Apply to Scene", GUILayout.Height(32)))
        {
            MeshArrayBaker.Apply();
            LightingEditorScene.RebuildLightData();
        }

        if (GUILayout.Button("Delete All", GUILayout.Height(32)))
        {
            if (EditorUtility.DisplayDialog("Delete All",
                "Restaure les meshes/matériaux d'origine puis supprime TOUS les assets générés ?", "Delete", "Cancel"))
                DeleteAll();
        }
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("Restore Originals (keep assets)", GUILayout.Height(24)))
            MeshArrayBaker.Restore();

        if (GUILayout.Button("Revert Prefab Mesh & Materials", GUILayout.Height(24)))
        {
            if (EditorUtility.DisplayDialog("Revert Prefab",
                "Restaure le Mesh ET les Matériaux d'origine des Prefabs (ex: FBX) ?\n\n" +
                "⚠️ Seuls le MeshFilter et les Matériaux seront restaurés.", "Revert", "Cancel"))
                RevertPrefabMeshAndMaterials();
        }
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.Space(10);
        _scroll = EditorGUILayout.BeginScrollView(_scroll);

        DrawSectionHeader("LIGHTING & PROBES");
        foreach (var op in _lightingOps) DrawRow(op);

        EditorGUILayout.Space(10);
        DrawSectionHeader("MESH ARRAYS + MATERIAL TABLE");
        EditorGUILayout.HelpBox(
            "Un seul bake produit les arrays (Albedo/Normal/Metallic/Roughness/Emission), la table de matériaux et les meshes. " +
            "Un Rebake relit toujours les originaux et ré-applique si la scène est déjà appliquée. " +
            "Utilise le keyword _UDON_MESH_ARRAYS_ON dans ASE.", MessageType.Info);
        DrawRow(_meshOp);

        EditorGUILayout.Space(10);
        DrawPreview();
        DrawTable();

        EditorGUILayout.EndScrollView();
    }

    // ───────────────────────── Preview ─────────────────────────

    private void DrawPreview()
    {
        DrawSectionHeader("PREVIEW");
        var names = MeshArrayBaker.ChannelNames;
        _prevChannel = GUILayout.Toolbar(_prevChannel, names);

        var arr = MeshArrayBaker.LoadArray(_prevChannel);
        if (arr == null)
        {
            EditorGUILayout.HelpBox($"{names[_prevChannel]} : pas d'array (aucune texture, ou pas baké).", MessageType.None);
            return;
        }

        _prevSlice = Mathf.Clamp(_prevSlice, 0, arr.depth - 1);
        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("◀", GUILayout.Width(28))) _prevSlice = (_prevSlice - 1 + arr.depth) % arr.depth;
        _prevSlice = EditorGUILayout.IntSlider(_prevSlice, 0, arr.depth - 1);
        if (GUILayout.Button("▶", GUILayout.Width(28))) _prevSlice = (_prevSlice + 1) % arr.depth;
        _prevSize = EditorGUILayout.IntPopup(_prevSize, new[] { "128", "256", "512" }, new[] { 128, 256, 512 }, GUILayout.Width(60));
        EditorGUILayout.EndHorizontal();

        var sliceNames = MeshArrayBaker.LoadSliceNames(_prevChannel);
        string src = _prevSlice < sliceNames.Length ? sliceNames[_prevSlice] : "(source inconnue : Rebake)";
        EditorGUILayout.LabelField($"{arr.width}x{arr.height} · {arr.depth} slices · {arr.graphicsFormat}", EditorStyles.miniLabel);
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField(src, EditorStyles.miniLabel);
        using (new EditorGUI.DisabledScope(_prevSlice >= sliceNames.Length))
            if (GUILayout.Button("Ping", GUILayout.Width(50)))
            {
                var o = AssetDatabase.LoadAssetAtPath<Object>(src);
                if (o != null) EditorGUIUtility.PingObject(o);
            }
        EditorGUILayout.EndHorizontal();

        if (_prevTex == null || _prevBuiltChannel != _prevChannel || _prevBuiltSlice != _prevSlice || _prevBuiltSize != _prevSize)
        {
            if (_prevTex != null) DestroyImmediate(_prevTex);
            _prevTex = BuildPreview(arr, _prevSlice, _prevSize,
                MeshArrayBaker.IsSrgbChannel(_prevChannel), MeshArrayBaker.IsNormalChannel(_prevChannel));
            _prevBuiltChannel = _prevChannel; _prevBuiltSlice = _prevSlice; _prevBuiltSize = _prevSize;
        }

        if (_prevTex != null)
        {
            var r = GUILayoutUtility.GetRect(_prevSize, _prevSize, GUILayout.ExpandWidth(false));
            EditorGUI.DrawPreviewTexture(r, _prevTex, null, ScaleMode.ScaleToFit);
        }
        if (MeshArrayBaker.IsNormalChannel(_prevChannel))
            EditorGUILayout.LabelField("Normal : Z reconstruit pour l'affichage.", EditorStyles.miniLabel);
    }

    private static Texture2D BuildPreview(Texture2DArray arr, int slice, int size, bool srgb, bool normal)
    {
        // GPU copy of one slice into a standalone texture (same compressed format), then decode to RGBA32.
        var tmp = new Texture2D(arr.width, arr.height, arr.graphicsFormat, TextureCreationFlags.None);
        Graphics.CopyTexture(arr, slice, 0, tmp, 0, 0);

        var rt = RenderTexture.GetTemporary(size, size, 0, RenderTextureFormat.ARGB32,
            srgb ? RenderTextureReadWrite.sRGB : RenderTextureReadWrite.Linear);
        var prev = RenderTexture.active;
        Graphics.Blit(tmp, rt);
        var outTex = new Texture2D(size, size, TextureFormat.RGBA32, false, !srgb) { hideFlags = HideFlags.HideAndDontSave };
        RenderTexture.active = rt;
        outTex.ReadPixels(new Rect(0, 0, size, size), 0, 0, false);
        RenderTexture.active = prev;
        RenderTexture.ReleaseTemporary(rt);
        DestroyImmediate(tmp);

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
                else px[i] = new Color32(c.r, c.r, c.r, 255);   // single channel (BC4) -> grey
            }
            outTex.SetPixels32(px);
        }
        outTex.Apply(false);
        return outTex;
    }

    private void DrawTable()
    {
        _tableFold = EditorGUILayout.Foldout(_tableFold, "Material table", true);
        if (!_tableFold) return;

        var t = MeshArrayBaker.LoadTable();
        if (t == null) { EditorGUILayout.HelpBox("Pas de table baké.", MessageType.None); return; }
        if (_tablePx == null) { _tablePx = t.GetPixels(); _tableW = t.width; }

        EditorGUILayout.LabelField($"{_tableW} colonnes (1 par matériau distinct)", EditorStyles.miniLabel);
        _tableScroll = EditorGUILayout.BeginScrollView(_tableScroll, GUILayout.Height(200));
        int shown = Mathf.Min(_tableW, 300);
        for (int x = 0; x < shown; x++)
        {
            Color c0 = _tablePx[0 * _tableW + x], c1 = _tablePx[1 * _tableW + x];
            Color c2 = _tablePx[2 * _tableW + x], c3 = _tablePx[3 * _tableW + x];

            EditorGUILayout.BeginHorizontal();
            GUILayout.Label("#" + x, GUILayout.Width(36));
            Swatch(c0);   // _Color
            Swatch(c1);   // subsurface
            Swatch(c2);   // emission
            GUILayout.Label($"thick {c1.a:F2} · emis ×{c2.a:F2} · M {c3.r:F2} · R {c3.g:F2}", EditorStyles.miniLabel);
            EditorGUILayout.EndHorizontal();
        }
        if (_tableW > shown) EditorGUILayout.LabelField($"… {_tableW - shown} de plus", EditorStyles.miniLabel);
        EditorGUILayout.EndScrollView();
        EditorGUILayout.LabelField("Pastilles : Color · Subsurface · Emission", EditorStyles.miniLabel);
    }

    private static void Swatch(Color linear)
    {
        var r = GUILayoutUtility.GetRect(34, 16, GUILayout.Width(34));
        var g = linear.gamma; g.a = 1f;
        EditorGUI.DrawRect(r, g);
    }

    private static void DrawSectionHeader(string title)
    {
        EditorGUILayout.LabelField(title, EditorStyles.boldLabel);
        EditorGUILayout.Space(2);
    }

    private static void DrawRow(IBakeOperation op)
    {
        EditorGUILayout.BeginVertical("box");

        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField(op.DisplayName, EditorStyles.boldLabel, GUILayout.Width(220));
        GUILayout.FlexibleSpace();
        var (count, warn) = op.GetSliceInfo();
        if (warn)
        {
            GUILayout.Label(EditorGUIUtility.IconContent("console.warnicon.sml"), GUILayout.Width(20));
            EditorGUILayout.LabelField($"{count} slices (trop !)", EditorStyles.miniLabel, GUILayout.Width(140));
        }
        else if (count > 0)
            EditorGUILayout.LabelField($"{count} slices max", EditorStyles.miniLabel, GUILayout.Width(140));
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.LabelField(op.GetStatus(), EditorStyles.miniLabel);
        EditorGUILayout.Space(4);

        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button(op.IsBaked ? "Rebake" : "Bake", GUILayout.Width(80)))
        {
            op.Bake();
            LightingEditorScene.RebuildLightData();
        }

        if (op is MeshArraysBakeOp)
        {
            using (new EditorGUI.DisabledScope(!op.IsBaked))
                if (GUILayout.Button("Apply", GUILayout.Width(80)))
                {
                    MeshArrayBaker.Apply();
                    LightingEditorScene.RebuildLightData();
                }
        }

        using (new EditorGUI.DisabledScope(!op.IsBaked))
            if (GUILayout.Button("Delete", GUILayout.Width(80)))
                if (EditorUtility.DisplayDialog($"Delete {op.DisplayName}", "Confirmer la suppression ?", "Delete", "Cancel"))
                {
                    op.Delete();
                    LightingEditorScene.RebuildLightData();
                }

        EditorGUILayout.EndHorizontal();

        EditorGUILayout.EndVertical();
        EditorGUILayout.Space(2);
    }

    private void BakeAll()
    {
        try
        {
            foreach (var op in _lightingOps)
            {
                EditorUtility.DisplayProgressBar("Bake All", $"Lighting : {op.DisplayName}...", 0.1f);
                op.Bake();
            }
        }
        finally { EditorUtility.ClearProgressBar(); }

        _meshOp.Bake();
        MeshArrayBaker.Apply();
        LightingEditorScene.RebuildLightData();
    }

    private void DeleteAll()
    {
        if (!MeshArrayBaker.DeleteAll()) return;
        foreach (var op in _lightingOps) op.Delete();
        AssetDatabase.Refresh();
        LightingEditorScene.RebuildLightData();
    }

    private void RevertPrefabMeshAndMaterials()
    {
        int count = 0;
        foreach (var r in Object.FindObjectsOfType<MeshRenderer>())
        {
            if (!PrefabUtility.IsPartOfPrefabInstance(r.gameObject)) continue;

            var mf = r.GetComponent<MeshFilter>();
            if (mf != null)
            {
                var mfSO = new SerializedObject(mf);
                var meshProp = mfSO.FindProperty("m_Mesh");
                if (meshProp != null) PrefabUtility.RevertPropertyOverride(meshProp, InteractionMode.UserAction);
            }

            var rSO = new SerializedObject(r);
            var matsProp = rSO.FindProperty("m_Materials");
            if (matsProp != null) PrefabUtility.RevertPropertyOverride(matsProp, InteractionMode.UserAction);
            count++;
        }
        Debug.Log($"[BakeManager] Revert terminé : Mesh et Matériaux restaurés sur {count} objets.");
    }
}