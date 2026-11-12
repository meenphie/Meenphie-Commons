using System;
using System.Collections.Generic;
using System.Globalization;
using Unity.Collections;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

public static partial class MeshArrayBaker
{
    private const int MaxPcRes = 2048;

    private static readonly HashSet<string> TargetShaders = new HashSet<string>
    {
        "Meenphie/Standard/Opaque",
        "Meenphie/Standard/Transparent/Alpha",
        "Meenphie/Standard/Transparent/Cutout",
        "Meenphie/Standard/Transparent/Additive"
    };

    private sealed class Channel
    {
        public readonly string Name;
        public readonly string TexProp;
        public readonly string MgrField;
        public readonly string GlobalName;
        public readonly string PathPC;
        public readonly string PathQuest;
        public readonly string NamesPath;
        public readonly string ArrayName;
        public readonly bool Srgb;
        public readonly bool IsNormal;
        public readonly Color32 Fallback;
        public List<Texture2D> Textures = new List<Texture2D>();
        public readonly Dictionary<Texture2D, int> Index = new Dictionary<Texture2D, int>();
        public readonly Dictionary<Hash128, int> HashIndex = new Dictionary<Hash128, int>();

        public Channel(string name, string texProp, string mgrField, string globalName,
            string folder, string arrayName, bool srgb, bool isNormal, Color32 fallback)
        {
            Name = name;
            TexProp = texProp;
            MgrField = mgrField;
            GlobalName = globalName;
            PathPC = folder + arrayName + "_PC.asset";
            PathQuest = folder + arrayName + "_Quest.asset";
            NamesPath = folder + arrayName + "_Slices.txt";
            ArrayName = arrayName;
            Srgb = srgb;
            IsNormal = isNormal;
            Fallback = fallback;
        }
    }

    private static readonly Channel[] Channels =
    {
        new Channel("Diffuse", "_MainTex", "diffuseArray", "_UdonDiffuseArray",
            BakePaths.Diffuse, "DiffuseArray", true, false, new Color32(255, 255, 255, 255)),
        new Channel("Normal", "_BumpMap", "normalArray", "_UdonNormalArray",
            BakePaths.Normal, "NormalArray", false, true, new Color32(128, 128, 255, 255)),
        new Channel("Metallic", "_MetallicMap", "metallicArray", "_UdonMetallicArray",
            BakePaths.Metallic, "MetallicArray", false, false, new Color32(0, 0, 0, 255)),
        new Channel("Roughness", "_GlossinessMap", "roughnessArray", "_UdonRoughnessArray",
            BakePaths.Roughness, "RoughnessArray", false, false, new Color32(0, 0, 0, 255)),
        new Channel("Emission", "_EmissionMap", "emissionArray", "_UdonEmissionArray",
            BakePaths.Emission, "EmissionArray", true, false, new Color32(255, 255, 255, 255))
    };

    public static bool IsRedChannel(int channel) =>
        Channels[channel].Name == "Metallic" || Channels[channel].Name == "Roughness";

    private static Texture2D GetTex(Material material, string property)
    {
        return material != null && material.HasProperty(property)
            ? material.GetTexture(property) as Texture2D
            : null;
    }


    private static Vector4[] ReadParams(Material material)
    {
        bool linear = QualitySettings.activeColorSpace == ColorSpace.Linear;

        Color color = ReadColor(material, "_DiffuseColor", Color.white);
        Color subsurface = ReadColor(material, "_SubsurfaceColor", Color.white);
        Color emission = ReadColor(material, "_EmissionColor", Color.white);

        if (linear)
        {
            color = color.linear;
            subsurface = subsurface.linear;
        }

        bool hasNormalMap =
            material.IsKeywordEnabled("_BUMPMAP") &&
            GetTex(material, "_BumpMap") != null;

        bool hasEmissionMap =
            GetTex(material, "_EmissionMap") != null;

        bool hasDiffuseMap =
            GetTex(material, "_MainTex") != null;

        return new[]
        {
        new Vector4(
            color.r, color.g, color.b, color.a),

        new Vector4(
            subsurface.r, subsurface.g, subsurface.b,
            ReadFloat(material, "_Thickness", 0f)),

        new Vector4(
            emission.r, emission.g, emission.b,
            ReadFloat(material, "_EmissionIntensity", 0f)),

        new Vector4(
            ReadFloat(material, "_Metallic", 0f),
            ReadFloat(material, "_Glossiness", 0.5f),
            material.IsKeywordEnabled("_METALLICMAP") ? 1f : 0f,
            material.IsKeywordEnabled("_GLOSSINESSMAP") ? 1f : 0f),

        new Vector4(
            ReadFloat(material, "_Anisotropy", 0f),
            hasNormalMap ? 1f : 0f,
            hasEmissionMap ? 1f : 0f,
            hasDiffuseMap ? 1f : 0f)
    };
    }

    private static Color ReadColor(Material material, string property, Color fallback)
    {
        return material != null && material.HasProperty(property)
            ? material.GetColor(property)
            : fallback;
    }

    private static float ReadFloat(Material material, string property, float fallback)
    {
        return material != null && material.HasProperty(property)
            ? material.GetFloat(property)
            : fallback;
    }

    private static Texture2DArray BuildArray(Channel channel, int resolution, string name)
    {
        resolution = Mathf.Max(4, resolution);
        bool questArray = name.EndsWith("_Quest", StringComparison.Ordinal);

        // =========================================================
        // CHOIX DU FORMAT DE COMPRESSION
        // =========================================================
        // Lu depuis les TextureImporter des textures du canal (override plateforme ou Automatic).
        // Fallbacks : Quest ASTC_6x6, PC BC7. La normal PC reste en BC5 (décodage shader).
        TextureFormat format;
        if (questArray)
        {
            format = ImporterFormat.Resolve(channel.Name + " Quest", channel.Textures,
                ImporterFormat.Quest, TextureFormat.ASTC_6x6, ImporterFormat.IsAstcLdr);
        }
        else if (channel.IsNormal)
        {
            format = TextureFormat.BC5;
        }
        else
        {
            bool redOnly = channel.Name == "Metallic" || channel.Name == "Roughness";
            format = ImporterFormat.Resolve(channel.Name + " PC", channel.Textures,
                ImporterFormat.PC, TextureFormat.BC7,
                redOnly ? (System.Func<TextureFormat, bool>)ImporterFormat.IsPcRed : ImporterFormat.IsPcColor);
        }

        int fallbackSlice = channel.Textures.Count;
        var array = new Texture2DArray(
            resolution, resolution, channel.Textures.Count + 1, format, true, !channel.Srgb)
        {
            name = name,
            filterMode = FilterMode.Trilinear,
            wrapMode = TextureWrapMode.Repeat,
            anisoLevel = 1
        };

        try
        {
            for (int slice = 0; slice <= fallbackSlice; slice++)
            {
                Texture2D source = slice == fallbackSlice ? null : channel.Textures[slice];
                Texture2D resized = CreateSlice(source, resolution, channel);
                try
                {
                    EditorUtility.CompressTexture(resized, format, 100);
                    for (int mip = 0; mip < array.mipmapCount; mip++)
                        Graphics.CopyTexture(resized, 0, mip, array, slice, mip);
                }
                finally
                {
                    UnityEngine.Object.DestroyImmediate(resized);
                }
            }

            return array;
        }
        catch
        {
            UnityEngine.Object.DestroyImmediate(array);
            throw;
        }
    }

    private static Texture2D CreateSlice(Texture2D source, int resolution, Channel channel)
    {
        var result = new Texture2D(resolution, resolution, TextureFormat.RGBA32, true, !channel.Srgb)
        {
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Bilinear
        };

        if (source == null)
        {
            var pixels = new Color32[resolution * resolution];
            for (int i = 0; i < pixels.Length; i++) pixels[i] = channel.Fallback;
            result.SetPixels32(pixels);
            result.Apply(true, false);
            return result;
        }

        RenderTextureReadWrite readWrite = channel.Srgb
            ? RenderTextureReadWrite.sRGB
            : RenderTextureReadWrite.Linear;
        RenderTexture rt = RenderTexture.GetTemporary(
            resolution, resolution, 0, RenderTextureFormat.ARGB32, readWrite);
        RenderTexture previous = RenderTexture.active;
        try
        {
            Graphics.Blit(source, rt);
            RenderTexture.active = rt;
            result.ReadPixels(new Rect(0, 0, resolution, resolution), 0, 0, false);
            result.Apply(true, false);
            return result;
        }
        catch
        {
            UnityEngine.Object.DestroyImmediate(result);
            throw;
        }
        finally
        {
            RenderTexture.active = previous;
            RenderTexture.ReleaseTemporary(rt);
        }
    }

    private static Mesh BuildBakedMesh(Resolved resolved, Dictionary<Material, int> materialIds)
    {
        Mesh source = resolved.origMesh;
        Vector3[] sourceVertices;
        Vector3[] sourceNormals;
        Vector4[] sourceTangents;
        Color32[] sourceColors;
        var sourceUvs = new List<Vector4>[8];
        var bakedUvs = new List<Vector4>[8];
        bool hasNormals;
        bool hasTangents;
        bool hasColors;
        bool hasBoneWeights = source.bindposes.Length > 0;
        byte[] sourceBonesPerVertex = Array.Empty<byte>();
        BoneWeight1[] sourceBoneWeights = Array.Empty<BoneWeight1>();
        int[] sourceBoneWeightOffsets = Array.Empty<int>();
        int[][] sourceIndices = new int[source.subMeshCount][];

        if (hasBoneWeights)
        {
            using (var bonesPerVertex = source.GetBonesPerVertex())
                sourceBonesPerVertex = bonesPerVertex.ToArray();
            using (var boneWeights = source.GetAllBoneWeights())
                sourceBoneWeights = boneWeights.ToArray();

            sourceBoneWeightOffsets = new int[source.vertexCount + 1];
            for (int i = 0; i < source.vertexCount; i++)
                sourceBoneWeightOffsets[i + 1] = sourceBoneWeightOffsets[i] + sourceBonesPerVertex[i];
        }

        using (Mesh.MeshDataArray meshDataArray = MeshUtility.AcquireReadOnlyMeshData(source))
        {
            Mesh.MeshData meshData = meshDataArray[0];
            sourceVertices = ReadMeshData<Vector3>(source.vertexCount, meshData.GetVertices);

            hasNormals = source.HasVertexAttribute(VertexAttribute.Normal);
            sourceNormals = hasNormals
                ? ReadMeshData<Vector3>(source.vertexCount, meshData.GetNormals)
                : Array.Empty<Vector3>();

            hasTangents = source.HasVertexAttribute(VertexAttribute.Tangent);
            sourceTangents = hasTangents
                ? ReadMeshData<Vector4>(source.vertexCount, meshData.GetTangents)
                : Array.Empty<Vector4>();

            hasColors = source.HasVertexAttribute(VertexAttribute.Color);
            sourceColors = hasColors
                ? ReadMeshData<Color32>(source.vertexCount, meshData.GetColors)
                : Array.Empty<Color32>();

            for (int channel = 0; channel < sourceUvs.Length; channel++)
            {
                var uv = new List<Vector4>();
                VertexAttribute attribute = (VertexAttribute)((int)VertexAttribute.TexCoord0 + channel);
                if (source.HasVertexAttribute(attribute))
                {
                    using (var nativeUvs = new NativeArray<Vector4>(source.vertexCount, Allocator.Temp))
                    {
                        meshData.GetUVs(channel, nativeUvs);
                        uv.AddRange(nativeUvs.ToArray());
                    }
                }
                sourceUvs[channel] = uv;
                bakedUvs[channel] = new List<Vector4>();
            }

            for (int submesh = 0; submesh < source.subMeshCount; submesh++)
            {
                int indexCount = meshData.GetSubMesh(submesh).indexCount;
                sourceIndices[submesh] = ReadMeshData<int>(indexCount,
                    (indices) => meshData.GetIndices(indices, submesh, true));
            }
        }

        var vertices = new List<Vector3>();
        var normals = new List<Vector3>();
        var tangents = new List<Vector4>();
        var colors = new List<Color32>();
        var bakedBonesPerVertex = new List<byte>();
        var bakedBoneWeights = new List<BoneWeight1>();
        var bakedSourceIndices = new List<int>();
        var subIndices = new List<int>[resolved.matPaths.Length];
        var materialPathIndices = new Dictionary<string, int>();
        for (int i = 0; i < resolved.matPaths.Length; i++)
        {
            subIndices[i] = new List<int>();
            materialPathIndices.Add(resolved.matPaths[i], i);
        }

        for (int submesh = 0; submesh < source.subMeshCount; submesh++)
        {
            Material material = resolved.origMats[submesh];
            if (!materialIds.TryGetValue(material, out int materialColumn))
                throw new InvalidOperationException($"No material-table column was generated for '{material.name}'.");
            if (!materialPathIndices.TryGetValue(resolved.submeshMatPaths[submesh], out int outputSubmesh))
                throw new InvalidOperationException($"No output submesh was generated for '{material.name}'.");

            int diffuse = GetSlice(Channels[0], material);
            int normal = GetSlice(Channels[1], material);
            int metallic = GetSlice(Channels[2], material);
            int roughness = GetSlice(Channels[3], material);
            int emission = GetSlice(Channels[4], material);

            var remap = new Dictionary<int, int>();
            foreach (int sourceIndex in sourceIndices[submesh])
            {
                if (!remap.TryGetValue(sourceIndex, out int bakedIndex))
                {
                    bakedIndex = vertices.Count;
                    remap.Add(sourceIndex, bakedIndex);
                    vertices.Add(sourceVertices[sourceIndex]);
                    if (hasNormals) normals.Add(sourceNormals[sourceIndex]);
                    if (hasTangents) tangents.Add(sourceTangents[sourceIndex]);
                    if (hasColors) colors.Add(sourceColors[sourceIndex]);
                    bakedSourceIndices.Add(sourceIndex);

                    if (hasBoneWeights)
                    {
                        byte boneCount = sourceBonesPerVertex[sourceIndex];
                        bakedBonesPerVertex.Add(boneCount);
                        int weightOffset = sourceBoneWeightOffsets[sourceIndex];
                        for (int i = 0; i < boneCount; i++)
                            bakedBoneWeights.Add(sourceBoneWeights[weightOffset + i]);
                    }

                    for (int channel = 0; channel < sourceUvs.Length; channel++)
                    {
                        Vector4 uv = sourceUvs[channel].Count == source.vertexCount
                            ? sourceUvs[channel][sourceIndex]
                            : Vector4.zero;

                        if (channel == 2)
                        {
                            uv.z = emission;
                            uv.w = materialColumn;
                        }
                        else if (channel == 3)
                        {
                            uv = new Vector4(diffuse, normal, metallic, roughness);
                        }
                        else if (channel == 7)
                        {
                            uv = resolved.reflectionProbeIndex >= 0
                                ? new Vector4(resolved.reflectionProbeIndex + 1, 0f, 0f, 0f)
                                : Vector4.zero;
                        }

                        bakedUvs[channel].Add(uv);
                    }
                }

                subIndices[outputSubmesh].Add(bakedIndex);
            }
        }

        var baked = new Mesh
        {
            name = source.name + "_Baked",
            indexFormat = vertices.Count > 65535 ? UnityEngine.Rendering.IndexFormat.UInt32 : UnityEngine.Rendering.IndexFormat.UInt16,
            bounds = source.bounds
        };
        baked.SetVertices(vertices);
        if (hasNormals) baked.SetNormals(normals);
        if (hasTangents) baked.SetTangents(tangents);
        if (hasColors) baked.SetColors(colors);
        if (hasBoneWeights)
        {
            baked.bindposes = source.bindposes;
            using (var bonesPerVertex = new NativeArray<byte>(bakedBonesPerVertex.ToArray(), Allocator.Temp))
            using (var boneWeights = new NativeArray<BoneWeight1>(bakedBoneWeights.ToArray(), Allocator.Temp))
                baked.SetBoneWeights(bonesPerVertex, boneWeights);
        }
        for (int channel = 0; channel < bakedUvs.Length; channel++)
            if (bakedUvs[channel].Count > 0) baked.SetUVs(channel, bakedUvs[channel]);

        baked.subMeshCount = subIndices.Length;
        for (int i = 0; i < subIndices.Length; i++)
            baked.SetIndices(subIndices[i], MeshTopology.Triangles, i, false);

        for (int shape = 0; shape < source.blendShapeCount; shape++)
        {
            string shapeName = source.GetBlendShapeName(shape);
            int frameCount = source.GetBlendShapeFrameCount(shape);
            for (int frame = 0; frame < frameCount; frame++)
            {
                var sourceDeltaVertices = new Vector3[source.vertexCount];
                var sourceDeltaNormals = new Vector3[source.vertexCount];
                var sourceDeltaTangents = new Vector3[source.vertexCount];
                source.GetBlendShapeFrameVertices(
                    shape, frame, sourceDeltaVertices, sourceDeltaNormals, sourceDeltaTangents);

                var deltaVertices = new Vector3[bakedSourceIndices.Count];
                var deltaNormals = new Vector3[bakedSourceIndices.Count];
                var deltaTangents = new Vector3[bakedSourceIndices.Count];
                for (int i = 0; i < bakedSourceIndices.Count; i++)
                {
                    int sourceIndex = bakedSourceIndices[i];
                    deltaVertices[i] = sourceDeltaVertices[sourceIndex];
                    deltaNormals[i] = sourceDeltaNormals[sourceIndex];
                    deltaTangents[i] = sourceDeltaTangents[sourceIndex];
                }

                baked.AddBlendShapeFrame(
                    shapeName, source.GetBlendShapeFrameWeight(shape, frame),
                    deltaVertices, deltaNormals, deltaTangents);
            }
        }

        return baked;
    }

    private static T[] ReadMeshData<T>(int count, Action<NativeArray<T>> read)
        where T : struct
    {
        using (var data = new NativeArray<T>(count, Allocator.Temp))
        {
            read(data);
            return data.ToArray();
        }
    }

    private static int GetSlice(Channel channel, Material material)
    {
        Texture2D texture = GetTex(material, channel.TexProp);
        if (texture == null) return channel.Textures.Count;

        // 1. Cherche par référence exacte
        if (channel.Index.TryGetValue(texture, out int index)) return index;

        // 2. Cherche par hash de contenu (si c'est un doublon)
        var hash = texture.imageContentsHash;
        if (hash.isValid && channel.HashIndex.TryGetValue(hash, out index)) return index;

        // 3. Fallback (ne devrait pas arriver si le bake s'est bien passé)
        return channel.Textures.Count;
    }

    private static void ConfigureShared(Material material)
    {
        material.EnableKeyword("_UDON_MESH_ARRAYS_ON");
        SetKeyword(material, "_BUMPMAP", Channels[1].Textures.Count > 0);
        SetKeyword(material, "_METALLICMAP", Channels[2].Textures.Count > 0);
        SetKeyword(material, "_GLOSSINESSMAP", Channels[3].Textures.Count > 0);

        SetTextureIfPresent(material, "_MainTex", null);
        SetTextureIfPresent(material, "_BumpMap", null);
        SetTextureIfPresent(material, "_MetallicMap", null);
        SetTextureIfPresent(material, "_GlossinessMap", null);
        SetTextureIfPresent(material, "_EmissionMap", null);
        SetColorIfPresent(material, "_DiffuseColor", Color.white);
        SetColorIfPresent(material, "_SubsurfaceColor", Color.white);
        SetFloatIfPresent(material, "_Thickness", 0f);
        SetFloatIfPresent(material, "_Metallic", 0f);
        SetFloatIfPresent(material, "_Glossiness", 0.5f);
        SetFloatIfPresent(material, "_Anisotropy", 0f);
        SetColorIfPresent(material, "_EmissionColor", Color.black);
        SetFloatIfPresent(material, "_EmissionIntensity", 0f);
        EditorUtility.SetDirty(material);
    }

    private static void SetKeyword(Material material, string keyword, bool enabled)
    {
        if (enabled) material.EnableKeyword(keyword);
        else material.DisableKeyword(keyword);
    }

    private static void SetTextureIfPresent(Material material, string property, Texture texture)
    {
        if (material.HasProperty(property)) material.SetTexture(property, texture);
    }

    private static void SetColorIfPresent(Material material, string property, Color value)
    {
        if (material.HasProperty(property)) material.SetColor(property, value);
    }

    private static void SetFloatIfPresent(Material material, string property, float value)
    {
        if (material.HasProperty(property)) material.SetFloat(property, value);
    }

    private static string VariantName(Material material)
    {
        return "Shared_" + BakeUtil.ShortHash(MatKey(material));
    }

    private static string MatKey(Material material)
    {
        var key = new System.Text.StringBuilder();

        // 1. Shader
        key.Append(material.shader != null ? material.shader.name : "<no shader>");

        // 2. Render Queue (crucial pour le tri des transparences)
        key.Append('|').Append(material.renderQueue.ToString());

        // 3. Keywords d'état de rendu
        foreach (string keyword in new[] {
            "_DIFFUSE_ON", "_SPECULARS_ON", "_REFLECTIONS_ON",
            "_UV_UV0", "_UV_UV2", "_EMISSIONUV_UV0", "_EMISSIONUV_UV2",
            "_ALPHATEST_ON"
        })
            key.Append('|').Append(material.IsKeywordEnabled(keyword) ? '1' : '0');

        // 4. Floats qui modifient le rendu
        AppendFloat(key, material, "_LightGroupMask");
        AppendFloat(key, material, "_Offset");
        AppendFloat(key, material, "_MaskClipValue");
        AppendFloat(key, material, "_IsDynamicMesh");

        return key.ToString();
    }

    private static void AppendFloat(System.Text.StringBuilder key, Material material, string property)
    {
        if (material.HasProperty(property))
            key.Append('|').Append(material.GetFloat(property).ToString("R", CultureInfo.InvariantCulture));
    }

    // Utilisé uniquement pour le nom du mesh. 
    // Doit inclure les couleurs/textures pour ne pas fusionner deux meshes de couleurs différentes.
    private static string MeshMatKey(Material material)
    {
        var key = new System.Text.StringBuilder(MatKey(material));
        var p = ReadParams(material); // Ajoute les couleurs, textures, métallic, etc.

        foreach (var v in p)
            key.Append('|').Append(v.x).Append(',').Append(v.y).Append(',').Append(v.z).Append(',').Append(v.w);

        return key.ToString();
    }

}

public sealed class MeshArraysBakeOp : IBakeOperation
{
    public string DisplayName => "Mesh Arrays + Materials";
    public bool IsBaked => MeshArrayBaker.IsBaked;
    public string GetStatus() => MeshArrayBaker.Status();
    public (int count, bool warn) GetSliceInfo() => MeshArrayBaker.SliceInfo();
    public void Bake() => MeshArrayBaker.Bake();
    public void Bake(MeshArrayBaker.ReflectionProbePlan probePlan) => MeshArrayBaker.Bake(probePlan);
    public void Delete() => MeshArrayBaker.DeleteAll();
}
