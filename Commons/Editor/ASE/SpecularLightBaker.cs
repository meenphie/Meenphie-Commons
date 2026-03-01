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
                // On calcule la distance entre la lumière actuelle et le centre du groupe existant
                float dist = Vector3.Distance((Vector3)finalPosRange[i], pos);

                if (dist * dist < mergeThresholdSq)
                {
                    float currentSum = finalColorInt[i].w;
                    float newSum = currentSum + individualIntensity;

                    if (individualIntensity > groupMaxIntensity[i])
                    {
                        // Nouvelle dominante : on prend sa forme et son orientation
                        finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                        finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                        finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                        finalColorInt[i] = new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, newSum);

                        groupMaxIntensity[i] = individualIntensity;
                    }
                    else
                    {
                        // Pas la dominante : on ne touche pas à la forme (.w)
                        // Mais on met à jour l'intensité totale
                        Vector4 c = finalColorInt[i];
                        c.w = newSum;

                        // OPTIONNEL : Mélange de couleur simple (pour ne pas ignorer la couleur des petites lights)
                        // On fait un lerp léger vers la nouvelle couleur basé sur son importance relative
                        float weight = individualIntensity / newSum;
                        c.x = Mathf.Lerp(c.x, l.color.r, weight);
                        c.y = Mathf.Lerp(c.y, l.color.g, weight);
                        c.z = Mathf.Lerp(c.z, l.color.b, weight);

                        finalColorInt[i] = c;

                        // On étend le Range pour couvrir la nouvelle lumière
                        Vector4 p = finalPosRange[i];
                        p.w = Mathf.Max(p.w, dist + rawRange);
                        finalPosRange[i] = p;
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