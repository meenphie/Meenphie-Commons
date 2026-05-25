using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    private const int   MAX_LIGHTS         = 32;
    private const float MERGE_THRESHOLD_SQ = 0.5f;
    private const float DIR_CONFLICT_DOT   = 0.5f; // below → directions too divergent → bidirectional area

    // --- SHARED ---
    private static Component FindManager()
    {
        foreach (var comp in Object.FindObjectsByType<Component>(FindObjectsSortMode.None))
        {
            if (comp != null && comp.GetType().Name == "SpecularLightManager")
                return comp;
        }
        Debug.LogError("SpecularLightManager not found in scene.");
        return null;
    }

    private static void PushToShader(
        List<Vector4> positions,
        List<Vector3> colors,      // FIX 3: was List<Vector4>
        List<Vector4> right,
        List<Vector4> up,
        List<Vector4> directions)
    {
        Vector4[] posArr   = new Vector4[MAX_LIGHTS];
        Vector4[] colArr   = new Vector4[MAX_LIGHTS]; // SetGlobalVectorArray needs Vector4; w=0 is fine
        Vector4[] rightArr = new Vector4[MAX_LIGHTS];
        Vector4[] upArr    = new Vector4[MAX_LIGHTS];
        Vector4[] dirArr   = new Vector4[MAX_LIGHTS];

        int count = Mathf.Min(colors.Count, MAX_LIGHTS);
        for (int i = 0; i < count; i++)
        {
            posArr[i]   = positions[i];
            colArr[i]   = colors[i];   // implicit Vector3 → Vector4 with w=0
            rightArr[i] = right[i];
            upArr[i]    = up[i];
            dirArr[i]   = directions[i];
        }

        Shader.SetGlobalVectorArray("_UdonSpecularLightPos",   posArr);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol",   colArr);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", rightArr);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp",    upArr);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir",   dirArr);
        Shader.SetGlobalFloat("_UdonSpecularLightCount", (float)count);
    }

    private static void ClearShader()
    {
        Vector4[] empty = new Vector4[MAX_LIGHTS];
        Shader.SetGlobalVectorArray("_UdonSpecularLightPos",   empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightCol",   empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightRight", empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightUp",    empty);
        Shader.SetGlobalVectorArray("_UdonSpecularLightDir",   empty);
        Shader.SetGlobalFloat("_UdonSpecularLightCount", 0f);
    }

    // --- BAKE ---
    [MenuItem("Meenphie/Specular Light/Bake")]
    public static void BakeLights()
    {
        Component manager = FindManager();
        if (manager == null) return;

        Light[] sceneLights = Object.FindObjectsByType<Light>(FindObjectsSortMode.None);

        List<Vector4> finalPosRange     = new();
        List<Vector3> finalColorInt     = new(); // FIX 3: was List<Vector4>; stores rgb*intensity directly
        List<Vector4> finalRightWidth   = new();
        List<Vector4> finalUpHeight     = new();
        List<Vector4> finalDirAngle     = new();
        List<float>   groupMaxIntensity = new();

        foreach (Light l in sceneLights)
        {
            if (!l.enabled || l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex)
                continue;

            Vector3 pos       = l.transform.position;
            float   intensity = l.intensity;

            float rawRange = l.range;
            if (l.type == LightType.Area)
            {
                SerializedObject soLight = new SerializedObject(l);
                rawRange = soLight.FindProperty("m_Range").floatValue;
            }

            float   width    = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
            float   height   = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;
            Vector3 forward  = l.transform.forward;
            float   cosOuter = (l.type == LightType.Spot)
                ? Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad)
                : (l.type == LightType.Area ? 0.0f : -1.0f);

            bool merged = false;
            for (int i = 0; i < finalPosRange.Count; i++)
            {
                float distSq = ((Vector3)finalPosRange[i] - pos).sqrMagnitude;
                if (distSq >= MERGE_THRESHOLD_SQ) continue;

                Vector3 existingForward = new Vector3(
                    finalDirAngle[i].x,
                    finalDirAngle[i].y,
                    finalDirAngle[i].z);

                bool isAlreadyOmni      = finalDirAngle[i].w < -0.1f;
                bool directionsConflict = !isAlreadyOmni &&
                                          Vector3.Dot(existingForward, forward) < DIR_CONFLICT_DOT;

                float currentMax = groupMaxIntensity[i];
                float newMax     = Mathf.Max(currentMax, intensity);

                if (intensity > currentMax)
                {
                    finalPosRange[i]   = new Vector4(pos.x, pos.y, pos.z, rawRange);
                    finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                    finalUpHeight[i]   = new Vector4(l.transform.up.x,    l.transform.up.y,    l.transform.up.z,    height);

                    float resolvedCosOuter = directionsConflict ? -0.5f : cosOuter;
                    finalDirAngle[i] = new Vector4(forward.x, forward.y, forward.z, resolvedCosOuter);

                    // FIX 3: store color*intensity directly, no normalization needed
                    finalColorInt[i]     = new Vector3(l.color.r, l.color.g, l.color.b) * newMax;
                    groupMaxIntensity[i] = newMax;
                }
                else
                {
                    if (directionsConflict)
                    {
                        Vector4 d = finalDirAngle[i];
                        finalDirAngle[i] = new Vector4(d.x, d.y, d.z, -0.5f);
                    }

                    // FIX 3: blend pre-multiplied colors directly
                    // weight by relative intensity so brighter lights contribute more
                    float   weight = intensity / (currentMax + intensity);
                    Vector3 c      = finalColorInt[i];
                    Vector3 newCol = new Vector3(l.color.r, l.color.g, l.color.b) * intensity;
                    finalColorInt[i] = Vector3.Lerp(c, newCol, weight);
                    // keep groupMaxIntensity as newMax — intensity is already baked into the color
                    groupMaxIntensity[i] = newMax;
                }

                merged = true;
                break;
            }

            if (!merged)
            {
                // FIX 3: store color*intensity directly
                finalPosRange.Add(new Vector4(pos.x, pos.y, pos.z, rawRange));
                finalColorInt.Add(new Vector3(l.color.r, l.color.g, l.color.b) * intensity);
                finalRightWidth.Add(new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width));
                finalUpHeight.Add(new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height));
                finalDirAngle.Add(new Vector4(forward.x, forward.y, forward.z, cosOuter));
                groupMaxIntensity.Add(intensity);
            }
        }

        // Serialize back to manager
        SerializedObject soManager = new SerializedObject(manager);
        FillPropertyV4(soManager.FindProperty("bakedPositions"),  finalPosRange);
        FillPropertyV3(soManager.FindProperty("bakedColors"),     finalColorInt); // FIX 3: Vector3 property
        FillPropertyV4(soManager.FindProperty("bakedRight"),      finalRightWidth);
        FillPropertyV4(soManager.FindProperty("bakedUp"),         finalUpHeight);
        FillPropertyV4(soManager.FindProperty("bakedDirections"), finalDirAngle);
        soManager.ApplyModifiedProperties();

        EditorUtility.SetDirty(manager);
        AssetDatabase.SaveAssets();

        PushToShader(finalPosRange, finalColorInt, finalRightWidth, finalUpHeight, finalDirAngle);

        Debug.Log($"[Bake Success] {finalPosRange.Count} light groups baked.");
    }

    // --- CLEAR ---
    [MenuItem("Meenphie/Specular Light/Clear Bake")]
    public static void ClearBake()
    {
        Component manager = FindManager();
        if (manager == null) return;

        SerializedObject soManager = new SerializedObject(manager);
        soManager.FindProperty("bakedPositions").ClearArray();
        soManager.FindProperty("bakedColors").ClearArray();
        soManager.FindProperty("bakedRight").ClearArray();
        soManager.FindProperty("bakedUp").ClearArray();
        soManager.FindProperty("bakedDirections").ClearArray();
        soManager.ApplyModifiedProperties();

        EditorUtility.SetDirty(manager);
        AssetDatabase.SaveAssets();

        ClearShader();

        Debug.Log("[Clear Success] Baked specular light data cleared.");
    }

    // --- HELPERS ---
    private static void FillPropertyV4(SerializedProperty arrayProp, List<Vector4> values)
    {
        if (arrayProp == null) return;
        arrayProp.ClearArray();
        for (int i = 0; i < values.Count; i++)
        {
            arrayProp.InsertArrayElementAtIndex(i);
            arrayProp.GetArrayElementAtIndex(i).vector4Value = values[i];
        }
    }

    // FIX 3: separate helper for Vector3 — serialized as vector3Value
    private static void FillPropertyV3(SerializedProperty arrayProp, List<Vector3> values)
    {
        if (arrayProp == null) return;
        arrayProp.ClearArray();
        for (int i = 0; i < values.Count; i++)
        {
            arrayProp.InsertArrayElementAtIndex(i);
            arrayProp.GetArrayElementAtIndex(i).vector3Value = values[i];
        }
    }
}
