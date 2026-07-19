
using UnityEngine;
using UnityEditor;
using System;

namespace Meenphie.Drawers
{

    public class Meenphie_DrawerTextureSingleLine : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();
            EditorGUI.showMixedValue = prop.hasMixedValue;

            Texture value = editor.TexturePropertyMiniThumbnail(position, prop, label, string.Empty);
           
            EditorGUI.showMixedValue = false;
            if (EditorGUI.EndChangeCheck())
            {
                prop.textureValue = value;
            }
        }
    }
}