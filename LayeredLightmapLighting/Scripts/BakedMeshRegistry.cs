using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Remembers the ORIGINAL mesh + materials of every renderer that was baked.
/// Keyed by GlobalObjectId (stable, serializable) instead of a scene Renderer reference
/// (scene references inside an asset are not persisted reliably).
/// Must live in an Editor assembly.
/// </summary>
public class BakedMeshRegistry : ScriptableObject
{
    [Serializable]
    public class Entry
    {
        public string id;
        public Mesh originalMesh;
        public Material[] originalMaterials;
    }

    public List<Entry> entries = new List<Entry>();

    [NonSerialized] private Dictionary<string, Entry> _map;
    [NonSerialized] private int _mapCount = -1;

    public static string IdOf(Component c) => GlobalObjectId.GetGlobalObjectIdSlow(c).ToString();

    private void EnsureMap()
    {
        if (_map != null && _mapCount == entries.Count) return;
        _map = new Dictionary<string, Entry>();
        foreach (var e in entries)
            if (e != null && !string.IsNullOrEmpty(e.id)) _map[e.id] = e;
        _mapCount = entries.Count;
    }

    public bool TryGet(string id, out Entry entry)
    {
        EnsureMap();
        return _map.TryGetValue(id, out entry);
    }

    /// <summary>Keeps the absolute original: a second Register for the same id is ignored.</summary>
    public void Register(string id, Mesh mesh, Material[] mats)
    {
        EnsureMap();
        if (_map.ContainsKey(id)) return;
        var e = new Entry { id = id, originalMesh = mesh, originalMaterials = (Material[])mats.Clone() };
        entries.Add(e);
        _map[id] = e;
        _mapCount = entries.Count;
    }

    public void RemoveWhere(Predicate<Entry> match)
    {
        entries.RemoveAll(match);
        _map = null;
    }
}