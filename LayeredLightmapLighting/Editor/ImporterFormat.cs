using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Lit le format de compression choisi dans le TextureImporter des textures sources
/// (override de plateforme si présent, sinon format "Automatic" calculé par Unity)
/// et le traduit en TextureFormat pour la construction des arrays.
///
/// Un array n'a qu'un seul format : on retient le format de plus haute qualité parmi
/// les textures du canal (pas le plus fréquent). À qualité égale, la première texture
/// (ordre de la liste) gagne. Un warning est loggé si les formats diffèrent.
/// Les formats refusés par le prédicat "accept" sont ignorés ; si aucun n'est accepté,
/// on utilise le fallback.
/// </summary>
internal static class ImporterFormat
{
    public const string PC = "Standalone";
    public const string Quest = "Android";

    // ── Prédicats d'acceptation ─────────────────────────────────────────────
    // PC LDR 4 canaux (diffuse, emission) : DXT1 refusé (pas d'alpha propre).
    public static bool IsPcColor(TextureFormat f) => f == TextureFormat.BC7 || f == TextureFormat.DXT5;
    // PC canal rouge seul (metallic, roughness)
    public static bool IsPcRed(TextureFormat f) => IsPcColor(f) || f == TextureFormat.BC4;
    // PC HDR (lightmaps) : BC7 ne gère pas le HDR
    public static bool IsPcHdr(TextureFormat f) => f == TextureFormat.BC6H || f == TextureFormat.RGBAHalf;
    // Quest : pas de BCn
    public static bool IsAstcLdr(TextureFormat f) =>
        f == TextureFormat.ASTC_4x4 || f == TextureFormat.ASTC_6x6 || f == TextureFormat.ASTC_8x8;
    public static bool IsAstcHdr(TextureFormat f) =>
        f == TextureFormat.ASTC_HDR_4x4 || f == TextureFormat.ASTC_HDR_6x6 || f == TextureFormat.ASTC_HDR_8x8
        || f == TextureFormat.RGBAHalf;

    public static TextureFormat Resolve(string label, IEnumerable<Texture2D> textures, string platform,
        TextureFormat fallback, Func<TextureFormat, bool> accept)
    {
        var counts = new Dictionary<TextureFormat, int>();
        TextureFormat best = fallback;
        int bestRank = int.MinValue;

        if (textures != null)
        {
            foreach (var t in textures)
            {
                if (t == null) continue;
                string path = AssetDatabase.GetAssetPath(t);
                if (string.IsNullOrEmpty(path)) continue;
                var imp = AssetImporter.GetAtPath(path) as TextureImporter;
                if (imp == null) continue;

                var s = imp.GetPlatformTextureSettings(platform);
                TextureImporterFormat f = (s.overridden && s.format != TextureImporterFormat.Automatic)
                    ? s.format
                    : imp.GetAutomaticFormat(platform);

                TextureFormat? tf = Map(f);
                if (!tf.HasValue || !accept(tf.Value)) continue;

                counts[tf.Value] = counts.TryGetValue(tf.Value, out int n) ? n + 1 : 1;
                int rank = Rank(tf.Value);
                if (rank > bestRank) { best = tf.Value; bestRank = rank; }
            }
        }

        if (counts.Count == 0)
            Debug.Log($"[ImporterFormat] {label} ({platform}) : aucun format importer exploitable, fallback {fallback}.");
        else if (counts.Count > 1)
            Debug.LogWarning($"[ImporterFormat] {label} ({platform}) : formats mixtes ["
                + string.Join(", ", counts.Select(kv => $"{kv.Key}×{kv.Value}"))
                + $"], retenu {best} (qualité la plus haute).");
        else
            Debug.Log($"[ImporterFormat] {label} ({platform}) : {best} ×{counts[best]}");

        return best;
    }

    // Conversion explicite (on évite le cast d'enum brut, dont les valeurs ne sont pas garanties identiques).
    private static TextureFormat? Map(TextureImporterFormat f)
    {
        switch (f)
        {
            case TextureImporterFormat.BC7: return TextureFormat.BC7;
            case TextureImporterFormat.BC6H: return TextureFormat.BC6H;
            case TextureImporterFormat.BC5: return TextureFormat.BC5;
            case TextureImporterFormat.BC4: return TextureFormat.BC4;
            case TextureImporterFormat.DXT5: return TextureFormat.DXT5;
            case TextureImporterFormat.DXT1: return TextureFormat.DXT1;
            case TextureImporterFormat.ASTC_4x4: return TextureFormat.ASTC_4x4;
            case TextureImporterFormat.ASTC_6x6: return TextureFormat.ASTC_6x6;
            case TextureImporterFormat.ASTC_8x8: return TextureFormat.ASTC_8x8;
            case TextureImporterFormat.ASTC_HDR_4x4: return TextureFormat.ASTC_HDR_4x4;
            case TextureImporterFormat.ASTC_HDR_6x6: return TextureFormat.ASTC_HDR_6x6;
            case TextureImporterFormat.ASTC_HDR_8x8: return TextureFormat.ASTC_HDR_8x8;
            case TextureImporterFormat.RGBAHalf: return TextureFormat.RGBAHalf;
            default: return null;
        }
    }

    // Plus grand = meilleure qualité.
    private static int Rank(TextureFormat f)
    {
        switch (f)
        {
            case TextureFormat.RGBAHalf: return 200;
            case TextureFormat.BC7:
            case TextureFormat.BC6H:
            case TextureFormat.ASTC_HDR_4x4: return 100;
            case TextureFormat.ASTC_4x4: return 95;
            case TextureFormat.BC4:
            case TextureFormat.BC5: return 80;
            case TextureFormat.DXT5: return 70;
            case TextureFormat.ASTC_6x6:
            case TextureFormat.ASTC_HDR_6x6: return 60;
            case TextureFormat.ASTC_8x8:
            case TextureFormat.ASTC_HDR_8x8: return 40;
            case TextureFormat.DXT1: return 30;
            default: return 0;
        }
    }
}
