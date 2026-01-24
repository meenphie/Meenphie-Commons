using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class FakeLightBaker : EditorWindow
{
    [MenuItem("Meenphie/Lights/Bake Final")]
    public static void BakeLights()
    {
        // Récupération du manager
        FakeLightManager manager = Object.FindObjectOfType<FakeLightManager>();
        if (manager == null)
        {
            Debug.LogWarning("Aucun FakeLightManager trouvé dans la scène.");
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
                    // Lumière proche déjà existante
                    Vector4 p = finalPosRange[i];
                    Vector4 c = finalColorInt[i];
                    Vector4 r = finalRightWidth[i];
                    Vector4 u = finalUpHeight[i];

                    if (lightIntensity > groupMaxIntensity[i])
                    {
                        // Nouvelle lumière dominante, on remplace tout
                        p = new Vector4(pos.x, pos.y, pos.z, range);
                        r = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                        u = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b);
                        c = new Vector4(
                            l.color.r / Mathf.Max(maxRGB, 0.001f),
                            l.color.g / Mathf.Max(maxRGB, 0.001f),
                            l.color.b / Mathf.Max(maxRGB, 0.001f),
                            lightIntensity
                        );

                        groupMaxIntensity[i] = lightIntensity;
                    }
                    else
                    {
                        // Sinon, on cumule juste les valeurs secondaires
                        r.w = Mathf.Max(r.w, w);
                        u.w = Mathf.Max(u.w, h);
                        c.w += lightIntensity;
                        p.w = Mathf.Max(p.w, range);
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
