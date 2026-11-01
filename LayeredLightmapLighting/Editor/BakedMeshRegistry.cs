using System;
using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Remembers the ORIGINAL mesh + materials of every renderer that was baked.
///
/// Two keys per entry:
///  - id    : GlobalObjectId (stable in Edit mode, serializable). NOT reliable in Play mode:
///            the scene is reloaded from a backup, so the same renderer gets another id.
///  - altId : scene path + hierarchy path (sibling index + name of every ancestor).
///            Identical between Edit and Play, because Play mode instantiates the saved scene as is.
///
/// Lookup tries id first, then altId. altId is (re)written by Register in Edit mode only,
/// so existing entries get their altId the next time Apply runs.
/// Must live in an Editor assembly.
/// </summary>
public class BakedMeshRegistry : ScriptableObject
{
    [Serializable]
    public class Entry
    {
        public string id;
        public string altId;
        public Mesh originalMesh;
        public Material[] originalMaterials;
    }

    public List<Entry> entries = new List<Entry>();

    [NonSerialized] private Dictionary<string, Entry> _map;
    [NonSerialized] private Dictionary<string, Entry> _altMap;
    [NonSerialized] private int _mapCount = -1;

    public static string IdOf(Component c) => GlobalObjectId.GetGlobalObjectIdSlow(c).ToString();

    /// <summary>Scene path + "/siblingIndex:name" for every ancestor. Stable between Edit and Play.</summary>
    public static string AltIdOf(Component c)
    {
        if (c == null) return null;
        var sb = new StringBuilder();
        for (var t = c.transform; t != null; t = t.parent)
            sb.Insert(0, "/" + t.GetSiblingIndex() + ":" + t.name);
        sb.Insert(0, c.gameObject.scene.path);
        return sb.ToString();
    }

    private void EnsureMap()
    {
        if (_map != null && _altMap != null && _mapCount == entries.Count) return;
        _map = new Dictionary<string, Entry>();
        _altMap = new Dictionary<string, Entry>();
        foreach (var e in entries)
        {
            if (e == null) continue;
            if (!string.IsNullOrEmpty(e.id)) _map[e.id] = e;
            if (!string.IsNullOrEmpty(e.altId)) _altMap[e.altId] = e;
        }
        _mapCount = entries.Count;
    }

    public bool TryGet(string id, out Entry entry)
    {
        EnsureMap();
        return _map.TryGetValue(id, out entry);
    }

    /// <summary>GlobalObjectId first, then scene/hierarchy path (the one that survives Play mode).</summary>
    public bool TryGet(Component c, out Entry entry)
    {
        EnsureMap();
        entry = null;
        if (c == null) return false;
        if (_map.TryGetValue(IdOf(c), out entry)) return true;
        var alt = AltIdOf(c);
        return !string.IsNullOrEmpty(alt) && _altMap.TryGetValue(alt, out entry);
    }

    /// <summary>Keeps the absolute original: a second Register for the same renderer is ignored
    /// (it only refreshes altId, in Edit mode).</summary>
    public void Register(Component c, Mesh mesh, Material[] mats)
    {
        EnsureMap();
        bool editMode = !EditorApplication.isPlayingOrWillChangePlaymode;
        var alt = AltIdOf(c);

        if (TryGet(c, out var existing))
        {
            if (editMode && existing.altId != alt)
            {
                if (!string.IsNullOrEmpty(existing.altId)) _altMap.Remove(existing.altId);
                existing.altId = alt;
                if (!string.IsNullOrEmpty(alt)) _altMap[alt] = existing;
                EditorUtility.SetDirty(this);
            }
            return;
        }

        var e = new Entry { id = IdOf(c), altId = alt, originalMesh = mesh, originalMaterials = (Material[])mats.Clone() };
        entries.Add(e);
        _map[e.id] = e;
        if (!string.IsNullOrEmpty(alt)) _altMap[alt] = e;
        _mapCount = entries.Count;
        EditorUtility.SetDirty(this);
    }

    /// <summary>Kept for callers that only have an id (no altId is recorded).</summary>
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
        _altMap = null;
    }
}