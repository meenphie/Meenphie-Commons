using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    [MenuItem("Meenphie/Specular Light/Bake")]
    public static void BakeLights()
    {
        // 1. Recherche du Manager par nom de type (pour bypasser les problèmes d'Assembly)
        Component manager = null;
        foreach (var comp in Object.FindObjectsByType<Component>(FindObjectsSortMode.None))
        {
            if (comp != null && comp.GetType().Name == "SpecularLightManager")
            {
                manager = comp;
                break;
            }
        }

        if (manager == null)
        {
            Debug.LogError("SpecularLightManager introuvable dans la scène. Vérifiez que le script est bien attaché à un GameObject.");
            return;
        }

        // 2. Collecte des lumières
        Light[] sceneLights = Object.FindObjectsByType<Light>(FindObjectsSortMode.None);
        List<Vector4> finalPosRange = new();
        List<Vector4> finalColorInt = new();
        List<Vector4> finalRightWidth = new();
        List<Vector4> finalUpHeight = new();
        List<Vector4> finalDirAngle = new();
        List<float> groupMaxIntensity = new();

        float mergeThresholdSq = 0.5f;

        foreach (Light l in sceneLights)
        {
            if (!l.enabled || l.type == LightType.Directional || l.renderMode == LightRenderMode.ForceVertex)
                continue;

            Vector3 pos = l.transform.position;
            float intensity = l.intensity;
            
            // Calcul du Range (Fix Area Lights)
            float rawRange = l.range;
            if (l.type == LightType.Area)
            {
                SerializedObject soLight = new SerializedObject(l);
                rawRange = soLight.FindProperty("m_Range").floatValue;
            }

            float width = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
            float height = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;
            Vector3 forward = l.transform.forward;

            float cosOuter = -1.0f;
            if (l.type == LightType.Spot)
                cosOuter = Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad);
            else if (l.type == LightType.Area)
                cosOuter = 0.0f;

            bool merged = false;
            for (int i = 0; i < finalPosRange.Count; i++)
            {
                float distSq = ((Vector3)finalPosRange[i] - pos).sqrMagnitude;
                if (distSq < mergeThresholdSq)
                {
                    float currentSum = finalColorInt[i].w;
                    float newSum = currentSum + intensity;

                    if (intensity > groupMaxIntensity[i])
                    {
                        finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                        finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width);
                        finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height);
                        finalDirAngle[i] = new Vector4(forward.x, forward.y, forward.z, cosOuter);

                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                        finalColorInt[i] = new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, newSum);
                        groupMaxIntensity[i] = intensity;
                    }
                    else
                    {
                        Vector4 c = finalColorInt[i];
                        c.w = newSum;
                        float weight = intensity / newSum;
                        c.x = Mathf.Lerp(c.x, l.color.r, weight);
                        c.y = Mathf.Lerp(c.y, l.color.g, weight);
                        c.z = Mathf.Lerp(c.z, l.color.b, weight);
                        finalColorInt[i] = c;

                        Vector4 p = finalPosRange[i];
                        p.w = Mathf.Max(p.w, Mathf.Sqrt(distSq) + rawRange);
                        finalPosRange[i] = p;
                    }
                    merged = true;
                    break;
                }
            }

            if (!merged)
            {
                float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                finalPosRange.Add(new Vector4(pos.x, pos.y, pos.z, rawRange));
                finalColorInt.Add(new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, intensity));
                finalRightWidth.Add(new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, width));
                finalUpHeight.Add(new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, height));
                finalDirAngle.Add(new Vector4(forward.x, forward.y, forward.z, cosOuter));
                groupMaxIntensity.Add(intensity);
            }
        }

        // 3. Application des données via SerializedProperties (Évite les erreurs de type SetValue)
        SerializedObject soManager = new SerializedObject(manager);
        
        FillProperty(soManager.FindProperty("bakedPositions"), finalPosRange);
        FillProperty(soManager.FindProperty("bakedColors"), finalColorInt);
        FillProperty(soManager.FindProperty("bakedRight"), finalRightWidth);
        FillProperty(soManager.FindProperty("bakedUp"), finalUpHeight);
        FillProperty(soManager.FindProperty("bakedDirections"), finalDirAngle);

        soManager.ApplyModifiedProperties();
        EditorUtility.SetDirty(manager);

        Debug.Log($"[Bake Success] {finalPosRange.Count} groupes de lumières enregistrés.");
    }

    private static void FillProperty(SerializedProperty arrayProp, List<Vector4> values)
    {
        if (arrayProp == null) return;
        
        arrayProp.ClearArray();
        for (int i = 0; i < values.Count; i++)
        {
            arrayProp.InsertArrayElementAtIndex(i);
            arrayProp.GetArrayElementAtIndex(i).vector4Value = values[i];
        }
    }
}