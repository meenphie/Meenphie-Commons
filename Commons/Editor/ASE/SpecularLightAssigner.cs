using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    [MenuItem("Meenphie/Specular Light/Bake")]
    public static void BakeLights()
    {
        // Récupération du manager
        SpecularLightManager manager = Object.FindObjectOfType<SpecularLightManager>();
        if (manager == null)
        {
            Debug.LogWarning("Aucun SpecularLightManager trouvé dans la scène.");
            return;
        }

        // Récupération de toutes les lumières
        Light[] sceneLights = Object.FindObjectsByType<Light>(FindObjectsSortMode.None);

        // Listes finales
        List<Vector4> finalPosRange = new List<Vector4>();
        List<Vector4> finalColorInt = new List<Vector4>();
        List<Vector4> finalRightWidth = new List<Vector4>();
        List<Vector4> finalUpHeight = new List<Vector4>();
        List<float> groupMaxIntensity = new List<float>();

        float mergeThresholdSq = 0.1f; // distance au carré pour fusionner les lumières proches

        foreach (Light l in sceneLights)
        {
            if (l.type == LightType.Directional || !l.enabled) continue;

            Vector3 pos = l.transform.position;
            float range = l.range;
            float lightIntensity = l.intensity * Mathf.Max(l.color.r, l.color.g, l.color.b);

            float w = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
            float h = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;

            bool merged = false;

            for (int i = 0; i < finalPosRange.Count; i++)
            {
                if (Vector3.SqrMagnitude((Vector3)finalPosRange[i] - pos) < mergeThresholdSq)
                {
                    Vector4 p = finalPosRange[i];
                    Vector4 c = finalColorInt[i];
                    Vector4 r = finalRightWidth[i];
                    Vector4 u = finalUpHeight[i];

                    // 1. Calculate the new total intensity for the whole group
                    float currentTotalIntensity = c.w;
                    float combinedIntensity = currentTotalIntensity + lightIntensity;

                    if (lightIntensity > groupMaxIntensity[i])
                    {
                        // 2. New dominant light: Update spatial data and normalized color
                        p = new Vector4(pos.x, pos.y, pos.z, range);
                        r = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                        u = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b);
                        c = new Vector4(
                            l.color.r / Mathf.Max(maxRGB, 0.001f),
                            l.color.g / Mathf.Max(maxRGB, 0.001f),
                            l.color.b / Mathf.Max(maxRGB, 0.001f),
                            combinedIntensity // Keep the accumulated sum
                        );

                        groupMaxIntensity[i] = lightIntensity; // Track peak for future comparisons
                    }
                    else
                    {
                        // 3. Not dominant: Just expand bounds and add to the sum
                        r.w = Mathf.Max(r.w, w);
                        u.w = Mathf.Max(u.w, h);
                        p.w = Mathf.Max(p.w, range);
                        c.w = combinedIntensity; // Add this light's power to the total
                    }

                    finalPosRange[i] = p;
                    finalColorInt[i] = c;
                    finalRightWidth[i] = r;
                    finalUpHeight[i] = u;

                    merged = true;
                    break;
                }
            }

            if (!merged)
            {
                // Nouvelle lumière indépendante
                finalPosRange.Add(new Vector4(pos.x, pos.y, pos.z, range));

                float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b);
                finalColorInt.Add(new Vector4(
                    l.color.r / Mathf.Max(maxRGB, 0.001f),
                    l.color.g / Mathf.Max(maxRGB, 0.001f),
                    l.color.b / Mathf.Max(maxRGB, 0.001f),
                    lightIntensity
                ));

                finalRightWidth.Add(new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w));
                finalUpHeight.Add(new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h));
                groupMaxIntensity.Add(lightIntensity);
            }
        }

        // Sauvegarde dans le manager
        Undo.RecordObject(manager, "Bake All Lights");
        manager.bakedPositions = finalPosRange.ToArray();
        manager.bakedColors = finalColorInt.ToArray();
        manager.bakedRight = finalRightWidth.ToArray();
        manager.bakedUp = finalUpHeight.ToArray();
        EditorUtility.SetDirty(manager);

        Debug.Log($"Baked {finalPosRange.Count} lights. Fusion par intensité dominante corrigée !");
    }
}
