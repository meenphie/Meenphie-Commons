using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Profiling;

/// <summary>
/// Pure data layer for the Bake Manager: sizes, counts, formatting and scene aggregation.
/// No GUI code in here, so it can be reused (CI report, other windows, tests...).
///
/// Sizes are the runtime memory reported by the Profiler (vertex + index buffers, CPU copy if readable),
/// which is the only meaningful number for meshes that live inside an FBX (disk size is shared by the whole file).
/// </summary>
internal static class BakeStats
{
    private const double MegaByte = 1024.0 * 1024.0;

    public struct MeshInfo
    {
        public int vertices, triangles, subMeshes;
        public long bytes, gpuBufferBytes;
    }

    /// <summary>One row of the Meshes tab: one ORIGINAL mesh and every renderer that uses it.</summary>
    public sealed class MeshRow
    {
        public Mesh mesh;
        public string name, path;
        public MeshInfo info;
        public MeshInfo baked;
        public int bakedMeshes;
        public List<MeshArrayBaker.RendererReport> users;
        public int eligibleCount, appliedCount, skippedCount;
        public string reason;
    }

    public sealed class SceneStats
    {
        public int renderers, eligible, applied, skipped;
        public int sourceMaterials, sharedMaterials;
        public int subBefore, subNow;
        public int meshesBefore, meshesNow;
        public long vertsBefore, vertsNow, trisBefore, trisNow;
        public long meshBytesBefore, meshBytesNow;
        public long meshGpuBytesBefore, meshGpuBytesNow;
        public bool anyApplied;
        public List<KeyValuePair<string, int>> skipReasons = new List<KeyValuePair<string, int>>();

        public string SkipSummary() => string.Join(" · ", skipReasons.Select(kv => $"{kv.Key} {kv.Value}"));
    }

    public static string Mb(long bytes)
    {
        if (bytes <= 0) return "0 MB";
        double mb = bytes / MegaByte;
        return mb < 0.01 ? "<0.01 MB" : mb.ToString("0.00") + " MB";
    }

    public static string Count(long n) => n.ToString("N0");

    /// <summary>"-33%", "+12%", "no change" or "n/a".</summary>
    public static string Delta(long before, long after)
    {
        if (before <= 0) return "n/a";
        double pct = (after - before) * 100.0 / before;
        if (System.Math.Abs(pct) < 0.5) return "no change";
        return (pct > 0 ? "+" : "") + pct.ToString("0") + "%";
    }

    public static long RuntimeBytes(Object o) => o != null ? Profiler.GetRuntimeMemorySizeLong(o) : 0L;

    public static long FileBytes(string assetPath)
    {
        if (string.IsNullOrEmpty(assetPath)) return 0L;
        try
        {
            var fi = new FileInfo(assetPath);
            return fi.Exists ? fi.Length : 0L;
        }
        catch (IOException e)
        {
            Debug.LogWarning($"[BakeManager] Could not read asset size for '{assetPath}': {e.Message}");
            return 0L;
        }
        catch (System.UnauthorizedAccessException e)
        {
            Debug.LogWarning($"[BakeManager] Could not read asset size for '{assetPath}': {e.Message}");
            return 0L;
        }
    }

    public static MeshInfo Describe(Mesh m)
    {
        if (m == null) return default(MeshInfo);
        int tris = 0;
        for (int i = 0; i < m.subMeshCount; i++)
            if (m.GetTopology(i) == MeshTopology.Triangles)
                tris += (int)(m.GetIndexCount(i) / 3);

        long gpuBufferBytes = 0;
        for (int stream = 0; stream < m.vertexBufferCount; stream++)
            gpuBufferBytes += (long)m.GetVertexBufferStride(stream) * m.vertexCount;
        long indexCount = 0;
        for (int i = 0; i < m.subMeshCount; i++)
            indexCount += (long)m.GetIndexCount(i);
        gpuBufferBytes += indexCount * (m.indexFormat == UnityEngine.Rendering.IndexFormat.UInt32 ? 4L : 2L);

        return new MeshInfo
        {
            vertices = m.vertexCount,
            triangles = tris,
            subMeshes = m.subMeshCount,
            bytes = Profiler.GetRuntimeMemorySizeLong(m),
            gpuBufferBytes = gpuBufferBytes
        };
    }

    public static Mesh CurrentMesh(MeshArrayBaker.RendererReport r)
    {
        if (r.renderer == null) return null;
        if (r.renderer is SkinnedMeshRenderer skinnedRenderer)
            return skinnedRenderer.sharedMesh;
        var mf = r.renderer.GetComponent<MeshFilter>();
        return mf != null ? mf.sharedMesh : null;
    }

    public static SceneStats Compute(List<MeshArrayBaker.RendererReport> scan)
    {
        var s = new SceneStats { renderers = scan.Count };
        var eligible = scan.Where(r => r.eligible).ToList();

        s.eligible = eligible.Count;
        s.applied = eligible.Count(r => r.applied);
        s.skipped = s.renderers - s.eligible;
        s.anyApplied = s.applied > 0;

        s.sourceMaterials = eligible.Where(r => r.originalMaterials != null)
                                    .SelectMany(r => r.originalMaterials)
                                    .Where(m => m != null).Distinct().Count();

        s.sharedMaterials = eligible.Where(r => r.sharedMaterialPaths != null)
                                    .SelectMany(r => r.sharedMaterialPaths).Distinct().Count();
        if (s.sharedMaterials == 0)
            s.sharedMaterials = eligible.Select(r => r.sharedMaterialPath).Distinct().Count();

        var before = new HashSet<Mesh>();
        var now = new HashSet<Mesh>();
        foreach (var r in eligible)
        {
            if (r.originalMesh != null)
            {
                before.Add(r.originalMesh);
                s.subBefore += r.originalMesh.subMeshCount;
            }

            var cur = r.applied ? CurrentMesh(r) : r.originalMesh;
            if (cur != null) now.Add(cur);

            if (r.applied && cur != null)
                s.subNow += cur.subMeshCount;
            else
                s.subNow += r.sharedMaterialPaths != null ? System.Math.Max(1, r.sharedMaterialPaths.Distinct().Count()) : 1;
        }

        Sum(before, out s.meshesBefore, out s.vertsBefore, out s.trisBefore, out s.meshBytesBefore, out s.meshGpuBytesBefore);
        Sum(now, out s.meshesNow, out s.vertsNow, out s.trisNow, out s.meshBytesNow, out s.meshGpuBytesNow);

        s.skipReasons = scan.Where(r => !r.eligible)
                            .GroupBy(r => r.reason ?? "unknown")
                            .OrderByDescending(g => g.Count())
                            .Select(g => new KeyValuePair<string, int>(g.Key, g.Count()))
                            .ToList();
        return s;
    }

    public static List<MeshRow> BuildMeshRows(List<MeshArrayBaker.RendererReport> scan)
    {
        var rows = new List<MeshRow>();
        foreach (var g in scan.Where(r => r.originalMesh != null).GroupBy(r => r.originalMesh))
        {
            var users = g.ToList();
            var row = new MeshRow
            {
                mesh = g.Key,
                name = g.Key.name,
                path = AssetDatabase.GetAssetPath(g.Key),
                info = Describe(g.Key),
                users = users
            };
            row.eligibleCount = users.Count(u => u.eligible);
            row.skippedCount = users.Count - row.eligibleCount;
            row.appliedCount = users.Count(u => u.eligible && u.applied);
            row.reason = users.Where(u => !u.eligible).Select(u => u.reason).FirstOrDefault();
            if (row.reason == null && row.skippedCount > 0) row.reason = "unknown";

            var bakedMeshes = users.Where(u => u.eligible && u.applied)
                                   .Select(u => CurrentMesh(u))
                                   .Where(m => m != null).Distinct().ToList();
            Sum(bakedMeshes, out row.bakedMeshes, out long v, out long t, out long b, out long gpu);
            row.baked = new MeshInfo
            {
                vertices = (int)v,
                triangles = (int)t,
                bytes = b,
                gpuBufferBytes = gpu,
                subMeshes = bakedMeshes.Sum(m => m.subMeshCount)
            };

            rows.Add(row);
        }
        return rows;
    }

    private static void Sum(IEnumerable<Mesh> meshes, out int count, out long verts, out long tris, out long bytes, out long gpuBufferBytes)
    {
        count = 0; verts = 0; tris = 0; bytes = 0; gpuBufferBytes = 0;
        foreach (var m in meshes)
        {
            var i = Describe(m);
            count++;
            verts += i.vertices;
            tris += i.triangles;
            bytes += i.bytes;
            gpuBufferBytes += i.gpuBufferBytes;
        }
    }
}
