using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    // Updated Menu Item Name
    [MenuItem("Meenphie/Specular Light/Bake Speculars")]
    public static void BakeAllHierarchies()
    {
        // 1. Find ALL managers in the scene
        SpecularLightManager[] allManagers = Object.FindObjectsByType<SpecularLightManager>(FindObjectsSortMode.None);

        if (allManagers.Length == 0)
        {
            Debug.LogWarning("No SpecularLightManagers found in the scene.");
            return;
        }

        int managersUpdated = 0;

        // 2. Loop through each manager individually
        foreach (SpecularLightManager manager in allManagers)
        {
            if (manager == null) continue;

            // --- A. Find components specific to THIS hierarchy ---
            Light[] sceneLights = manager.GetComponentsInChildren<Light>(true);
            MeshRenderer[] childRenderers = manager.GetComponentsInChildren<MeshRenderer>(true);

            // Assign the renderers to the manager so Udon knows who to target
            manager.targetRenderers = childRenderers;

            // --- B. The Baking Logic (Same math, applied per manager) ---
            List<Vector4> finalPosRange = new List<Vector4>();
            List<Vector4> finalColorInt = new List<Vector4>();
            List<Vector4> finalRightWidth = new List<Vector4>();
            List<Vector4> finalUpHeight = new List<Vector4>();
            List<float> groupMaxIntensity = new List<float>();

            float mergeThresholdSq = 0.5f;

            foreach (Light l in sceneLights)
            {
                if (l.type == LightType.Directional || !l.enabled || l.renderMode == LightRenderMode.ForceVertex) continue;

                Vector3 pos = l.transform.position;
                float individualIntensity = l.intensity;

                // Handle Area Light Range vs Point Light Range
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

                float w = (l.type == LightType.Area) ? l.areaSize.x * 0.5f : 0.01f;
                float h = (l.type == LightType.Area) ? l.areaSize.y * 0.5f : 0.01f;

                bool merged = false;

                // Try to merge with existing light groups in this specific manager
                for (int i = 0; i < finalPosRange.Count; i++)
                {
                    if (Vector3.SqrMagnitude((Vector3)finalPosRange[i] - pos) < mergeThresholdSq)
                    {
                        float currentSum = finalColorInt[i].w;
                        float newSum = currentSum + individualIntensity;

                        if (individualIntensity > groupMaxIntensity[i])
                        {
                            // New dominant light
                            finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                            finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                            finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                            float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                            finalColorInt[i] = new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, newSum);

                            groupMaxIntensity[i] = individualIntensity;
                        }
                        else
                        {
                            // Merging into existing dominant light
                            Vector4 c = finalColorInt[i]; c.w = newSum; finalColorInt[i] = c;
                            Vector4 p = finalPosRange[i]; p.w = Mathf.Max(p.w, rawRange); finalPosRange[i] = p;
                            Vector4 rw = finalRightWidth[i]; rw.w = Mathf.Max(rw.w, w); finalRightWidth[i] = rw;
                            Vector4 uh = finalUpHeight[i]; uh.w = Mathf.Max(uh.w, h); finalUpHeight[i] = uh;
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
                    groupMaxIntensity.Add(individualIntensity);
                }
            }

            // --- C. Save Data ---
            Undo.RecordObject(manager, "Bake Lights");
            manager.bakedPositions = finalPosRange.ToArray();
            manager.bakedColors = finalColorInt.ToArray();
            manager.bakedRight = finalRightWidth.ToArray();
            manager.bakedUp = finalUpHeight.ToArray();

            EditorUtility.SetDirty(manager);
            managersUpdated++;

            Debug.Log($"Baked <b>{manager.name}</b>: {finalPosRange.Count} lights found, applied to {childRenderers.Length} renderers.");
        }

        Debug.Log($"<color=green><b>SUCCESS:</b></color> Updated {managersUpdated} managers in the scene.");
    }

    [MenuItem("Meenphie/Specular Light/Clear All Baked Data")]
    public static void ClearAllLights()
    {
        SpecularLightManager[] allManagers = Object.FindObjectsByType<SpecularLightManager>(FindObjectsSortMode.None);

        foreach (SpecularLightManager manager in allManagers)
        {
            Undo.RecordObject(manager, "Clear Specular Data");

            // Wipe the baked arrays
            manager.bakedPositions = new Vector4[0];
            manager.bakedColors = new Vector4[0];
            manager.bakedRight = new Vector4[0];
            manager.bakedUp = new Vector4[0];

            // Optional: If you want to force the renderers to clear immediately in-editor
            if (manager.targetRenderers != null)
            {
                MaterialPropertyBlock emptyBlock = new MaterialPropertyBlock();
                foreach (MeshRenderer renderer in manager.targetRenderers)
                {
                    if (renderer != null) renderer.SetPropertyBlock(emptyBlock);
                }
            }

            EditorUtility.SetDirty(manager);
        }

        Debug.Log("<color=orange><b>All Specular Light data has been cleared from the scene.</b></color>");
    }
}