using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    [MenuItem("Meenphie/Specular Light/Bake")]
    public static void BakeLights()
    {
        SpecularLightManager manager = Object.FindObjectOfType<SpecularLightManager>();
        if (manager == null)
        {
            Debug.LogWarning("Aucun SpecularLightManager trouvé.");
            return;
        }

        Light[] sceneLights = Object.FindObjectsByType<Light>(FindObjectsSortMode.None);

        List<Vector4> finalPosRange = new List<Vector4>();
        List<Vector4> finalColorInt = new List<Vector4>();
        List<Vector4> finalRightWidth = new List<Vector4>();
        List<Vector4> finalUpHeight = new List<Vector4>();
        List<float> groupMaxIntensity = new List<float>();

        float mergeThresholdSq = 0.5f; // Adjust this for grouping distance

        foreach (Light l in sceneLights)
        {
            // Skip directional lights or disabled lights
            if (l.type == LightType.Directional || !l.enabled || l.renderMode == LightRenderMode.ForceVertex) continue;

            Vector3 pos = l.transform.position;
            float individualIntensity = l.intensity;

            // --- EXACT RANGE FIX ---
            // l.range for Area Lights returns Range + Shape Radius. 
            // SerializedObject pulls the literal value from the UI.
            float rawRange;
            if (l.type == LightType.Area)
            {
                SerializedObject so = new SerializedObject(l);
                rawRange = so.FindProperty("m_Range").floatValue;
            }
            else
            {
                rawRange = l.range;
            }

            // Determine dimensions (Radius for points, Half-extents for area)
            float w = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
            float h = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;

            bool merged = false;

            // Try to find a group to merge into
            for (int i = 0; i < finalPosRange.Count; i++)
            {
                if (Vector3.SqrMagnitude((Vector3)finalPosRange[i] - pos) < mergeThresholdSq)
                {
                    // 1. SUM the intensity immediately
                    float currentSum = finalColorInt[i].w;
                    float newSum = currentSum + individualIntensity;

                    // 2. Determine if this light is the new "Dominant" source for the group
                    if (individualIntensity > groupMaxIntensity[i])
                    {
                        // Update Group Position, Orientation, and exact Range
                        finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                        finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                        finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                        // Update dominant color (normalized) but keep the SUMMED intensity in W
                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                        finalColorInt[i] = new Vector4(
                            l.color.r / maxRGB,
                            l.color.g / maxRGB,
                            l.color.b / maxRGB,
                            newSum
                        );

                        groupMaxIntensity[i] = individualIntensity;
                    }
                    else
                    {
                        // Not dominant: Just update the sum and ensure the range/size covers the new light
                        Vector4 c = finalColorInt[i];
                        c.w = newSum;
                        finalColorInt[i] = c;

                        // We keep the largest range/dimensions found in the group
                        Vector4 p = finalPosRange[i];
                        p.w = Mathf.Max(p.w, rawRange);
                        finalPosRange[i] = p;

                        Vector4 rw = finalRightWidth[i];
                        rw.w = Mathf.Max(rw.w, w);
                        finalRightWidth[i] = rw;

                        Vector4 uh = finalUpHeight[i];
                        uh.w = Mathf.Max(uh.w, h);
                        finalUpHeight[i] = uh;
                    }

                    merged = true;
                    break;
                }
            }

            if (!merged)
            {
                // Add as a new light group
                finalPosRange.Add(new Vector4(pos.x, pos.y, pos.z, rawRange));

                float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                finalColorInt.Add(new Vector4(
                    l.color.r / maxRGB,
                    l.color.g / maxRGB,
                    l.color.b / maxRGB,
                    individualIntensity
                ));

                finalRightWidth.Add(new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w));
                finalUpHeight.Add(new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h));
                groupMaxIntensity.Add(individualIntensity);
            }
        }

        Undo.RecordObject(manager, "Bake All Lights");
        manager.bakedPositions = finalPosRange.ToArray();
        manager.bakedColors = finalColorInt.ToArray();
        manager.bakedRight = finalRightWidth.ToArray();
        manager.bakedUp = finalUpHeight.ToArray();
        EditorUtility.SetDirty(manager);

        Debug.Log($"Baked {finalPosRange.Count} groups. Intensity is summed, Range is exact.");
    }
}