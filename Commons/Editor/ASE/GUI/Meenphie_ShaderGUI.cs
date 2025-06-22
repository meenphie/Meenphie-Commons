
using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Meenphie.Drawers;

public class Meenphie_ShaderGUI : ShaderGUI
{
    bool showCategory = true;
    bool showAdvanced = true;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var material0 = materialEditor.target as Material;

        DrawDynamicInspector(material0, materialEditor, props);
    }

    void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var customPropsList = new List<MaterialProperty>();
        //var customSpaces = new List<int>();
        //var customCategories = new List<int>();

        for (int i = 0; i < props.Length; i++)
        {
            var prop = props[i];

#if UNITY_6000_2_OR_NEWER
            if (prop.propertyFlags == UnityEngine.Rendering.ShaderPropertyFlags.HideInInspector)
#else
            if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
#endif
                continue;

            if (prop.name == "unity_Lightmaps")
                continue;
            if (prop.name == "unity_LightmapsInd")
                continue;
            if (prop.name == "unity_ShadowMasks")
                continue;
            if (prop.name == "_SpecularHighlights")
                continue;
            if (prop.name == "_GlossyReflections")
                continue;

            #region [Lightmapping]
            if (material.HasProperty("_LIGHTMAPPINGMODE"))
            {
                if (material.GetInt("_LIGHTMAPPINGMODE") == 0)
                {
                    if (prop.name == "_RNMX0")
                        continue;
                    if (prop.name == "_RNMY0")
                        continue;
                    if (prop.name == "_RNMZ0")
                        continue;
                    if (prop.name == "_RNMX1")
                        continue;
                    if (prop.name == "_RNMY1")
                        continue;
                    if (prop.name == "_RNMZ1")
                        continue;
                    if (prop.name == "_LightmapLerp")
                        continue;
                    if (prop.name == "_RNMScale")
                        continue;

                }

                else if (material.GetInt("_LIGHTMAPPINGMODE") == 1)
                {
                    if (prop.name == "_Lightmap")
                        continue;
                    if (prop.name == "_RNMX1")
                        continue;
                    if (prop.name == "_RNMY1")
                        continue;
                    if (prop.name == "_RNMZ1")
                        continue;
                    if (prop.name == "_LightmapLerp")
                        continue;
                }

                else if (material.GetInt("_LIGHTMAPPINGMODE") == 2)
                {
                    if (prop.name == "_Lightmap")
                        continue;
                }
            }
            #endregion [Lightmapping]

            #region [Smoothness BIRP Specular]
            if (material.HasProperty("_Smoothnesstexturechannel"))
            {
                if (material.GetInt("_Smoothnesstexturechannel") == 0)
                {
                    if (prop.name == "_Glossiness")
                        continue;
                }
            }
            if (material.HasProperty("_Smoothnesstexturechannel"))
            {
                if (material.GetInt("_Smoothnesstexturechannel") == 1)
                {
                    if (prop.name == "_GlossMapScale")
                        continue;
                }
            }
            #endregion [Smoothness BIRP Specular]

            #region [Smoothness BIRP Metallic]
            if (material.HasProperty("_SmoothnesstexturechannelM"))
            {
                if (material.GetInt("_SmoothnesstexturechannelM") == 0)
                {
                    if (prop.name == "_Glossiness")
                        continue;
                }
            }
            if (material.HasProperty("_SmoothnesstexturechannelM"))
            {
                if (material.GetInt("_SmoothnesstexturechannelM") == 1)
                {
                    if (prop.name == "_GlossMapScale")
                        continue;
                }
            }
            #endregion [Smoothness BIRP Metallic]

            #region [CATEGORY INDEX and SPACES]
            int categoryIndex = 1;

            //customPropsList.Add(prop);

            if (prop.name.Contains("_CATEGORY"))
            {
                categoryIndex++;

                customPropsList.Add(prop);

                if (material.GetInt(prop.name) == 0)
                {
                    showCategory = false;
                    //customCategories.Add(-categoryIndex);
                }
                else
                {
                    showCategory = true;
                    //customCategories.Add(categoryIndex);

                    categoryIndex++;
                }
            }
            else
            {
                if (showCategory)
                {
                    customPropsList.Add(prop);
                    //customCategories.Add(categoryIndex);
                }
            }

        }

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var prop = customPropsList[i];

            //GUILayout.Space(customSpaces[i]);

            materialEditor.ShaderProperty(prop, prop.displayName);

        }
        #endregion [CATEGORY INDEX and SPACES]

        #region [CATEGORY - ADVANCED SETTINGS]

        showAdvanced = Meenphie_Drawers.DrawInspectorCategory("ADVANCED SETTINGS", showAdvanced, true, 0, 0, material);

        if (showAdvanced)
        {
            material = materialEditor.target as Material;

            if (material.HasProperty("_SpecularHighlights"))
            {
                var specProp = FindProperty("_SpecularHighlights", props);
                materialEditor.ShaderProperty(specProp, "Specular Highlights");
            }

            if (material.HasProperty("_GlossyReflections"))
            {
                var reflProp = FindProperty("_GlossyReflections", props);
                materialEditor.ShaderProperty(reflProp, "Glossy Reflections");
            }

            materialEditor.EnableInstancingField();
            materialEditor.DoubleSidedGIField();
            materialEditor.RenderQueueField();
        }

        #endregion [CATEGORY - ADVANCED SETTINGS]
    }
}