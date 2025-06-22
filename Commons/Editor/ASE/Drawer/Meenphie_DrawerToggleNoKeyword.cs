﻿
using UnityEngine;
using UnityEditor;
using System;

namespace Meenphie.Drawers
{

public class Meenphie_DrawerToggleNoKeyword : MaterialPropertyDrawer
    {

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            bool value = (prop.floatValue != 0.0f);

            EditorGUI.BeginChangeCheck();
            {
                EditorGUI.showMixedValue = prop.hasMixedValue;
                value = EditorGUI.Toggle(position, label, value);
                EditorGUI.showMixedValue = false;
            }
            if (EditorGUI.EndChangeCheck())
            {
                prop.floatValue = value ? 1.0f : 0.0f;
            }
        }
    }

}