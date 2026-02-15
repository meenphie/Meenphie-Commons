using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

public class SpecularLightBaker : EditorWindow
{
    [MenuItem("Meenphie/Specular Light/Bake Selected Hierarchy")]
    public static void BakeLights()
    {
        GameObject selected = Selection.activeGameObject;
        if (selected == null)
        {
            Debug.LogWarning("Please select the root object (e.g. 'Kitchen') containing the SpecularLightManager.");
            return;
        }

        SpecularLightManager manager = selected.GetComponent<SpecularLightManager>();
        if (manager == null)
        {
            Debug.LogWarning($"No SpecularLightManager found on {selected.name}.");
            return;
        }

        // 1. Find Lights ONLY in children of this manager
        Light[] sceneLights = manager.GetComponentsInChildren<Light>(true);

        // 2. Find Renderers ONLY in children (to isolate the effect)
        MeshRenderer[] childRenderers = manager.GetComponentsInChildren<MeshRenderer>(true);
        manager.targetRenderers = childRenderers;

        // --- Standard Baking Logic (Same as before) ---
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

            for (int i = 0; i < finalPosRange.Count; i++)
            {
                if (Vector3.SqrMagnitude((Vector3)finalPosRange[i] - pos) < mergeThresholdSq)
                {
                    float currentSum = finalColorInt[i].w;
                    float newSum = currentSum + individualIntensity;

                    if (individualIntensity > groupMaxIntensity[i])
                    {
                        finalPosRange[i] = new Vector4(pos.x, pos.y, pos.z, rawRange);
                        finalRightWidth[i] = new Vector4(l.transform.right.x, l.transform.right.y, l.transform.right.z, w);
                        finalUpHeight[i] = new Vector4(l.transform.up.x, l.transform.up.y, l.transform.up.z, h);

                        float maxRGB = Mathf.Max(l.color.r, l.color.g, l.color.b, 0.001f);
                        finalColorInt[i] = new Vector4(l.color.r / maxRGB, l.color.g / maxRGB, l.color.b / maxRGB, newSum);

                        groupMaxIntensity[i] = individualIntensity;
                    }
                    else
                    {
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

        Undo.RecordObject(manager, "Bake Hierarchy Lights");
        manager.bakedPositions = finalPosRange.ToArray();
        manager.bakedColors = finalColorInt.ToArray();
        manager.bakedRight = finalRightWidth.ToArray();
        manager.bakedUp = finalUpHeight.ToArray();
        
        Debug.Log($"<color=cyan><b>Baked {finalPosRange.Count} lights for '{selected.name}'</b></color>. Assigned to {childRenderers.Length} renderers.");
        EditorUtility.SetDirty(manager);
    }
}