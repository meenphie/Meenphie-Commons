using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

namespace Meenphie.Commons
{
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
            List<Vector4> finalDirAngle = new List<Vector4>(); // Nouvelle liste pour Directions
            List<float> groupMaxIntensity = new List<float>();

            float mergeThresholdSq = 0.5f;

            foreach (Light l in sceneLights)
            {
                if (l.type == LightType.Directional || !l.enabled || l.renderMode == LightRenderMode.ForceVertex) continue;

                Vector3 pos = l.transform.position;
                float individualIntensity = l.intensity;

                // --- EXACT RANGE FIX ---
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

                // Dimensions
                float w = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
                float h = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;

                // --- NOUVEAU : CALCUL DIRECTION / ANGLE ---
                Vector3 forward = l.transform.forward;
                float cosOuter = -1.0f; // Défaut : Point light (360°)
                if (l.type == LightType.Spot) cosOuter = Mathf.Cos(l.spotAngle * 0.5f * Mathf.Deg2Rad);
                else if (l.type == LightType.Area) cosOuter = 0.0f; // Rectangle (180°)

                bool merged = false;

                for (int i = 0; i < finalPosRange.Count; i++)
                {
                    float dist = Vector3.Distance((Vector3)finalPosRange[i], pos);

                    if (dist * dist < mergeThresholdSq)
                    {
                        float currentSum = finalColorInt[i].w;
                        float newSum = currentSum + individualIntensity;

                        if (individualIntensity > groupMaxIntensity[i])
                        {
                            // Nouvelle dominante
                            finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                            finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                            finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);
                            finalDirAngle[i] = new Vector4(forward.x, forward.y, forward.z, cosOuter);

                            float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                            finalColorInt[i] = new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, newSum);

                            groupMaxIntensity[i] = individualIntensity;
                        }
                        else
                        {
                            // Pas dominante : Update intensité et couleur
                            Vector4 c = finalColorInt[i];
                            c.w = newSum;

                            float weight = individualIntensity / newSum;
                            c.x = Mathf.Lerp(c.x, l.color.r, weight);
                            c.y = Mathf.Lerp(c.y, l.color.g, weight);
                            c.z = Mathf.Lerp(c.z, l.color.b, weight);
                            finalColorInt[i] = c;

                            // Extension du range
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
                    finalPosRange.Add(new Vector4(pos.x, pos.y, pos.z, rawRange));
                    float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                    finalColorInt.Add(new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, individualIntensity));
                    finalRightWidth.Add(new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w));
                    finalUpHeight.Add(new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h));
                    finalDirAngle.Add(new Vector4(forward.x, forward.y, forward.z, cosOuter));
                    groupMaxIntensity.Add(individualIntensity);
                }
            }

            Undo.RecordObject(manager, "Bake All Lights");
            manager.bakedPositions = finalPosRange.ToArray();
            manager.bakedColors = finalColorInt.ToArray();
            manager.bakedRight = finalRightWidth.ToArray();
            manager.bakedUp = finalUpHeight.ToArray();
            manager.bakedDirections = finalDirAngle.ToArray(); // Assignation finale
            EditorUtility.SetDirty(manager);

            Debug.Log($"Baked {finalPosRange.Count} groups.");
        }
    }
}