using UnityEngine;
using UnityEditor;
using System;
using Random = UnityEngine.Random;

public class CustomMaterialPropertyDrawer : MaterialPropertyDrawer
{
    public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
    {
        bool value = (prop.colorValue != Color.white);

        EditorGUI.BeginChangeCheck();
        EditorGUI.showMixedValue = prop.hasMixedValue;
        label = "Trust me, I'm a label.";
        value = EditorGUI.Toggle(position, label, value);
        
        EditorGUI.HelpBox(new Rect(position.x, position.y + 150, position.width, position.height), "Help me!", MessageType.Info);
        
        EditorGUI.showMixedValue = false;
        if (EditorGUI.EndChangeCheck())
        {
            prop.colorValue = value ? new Color(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f)) : Color.white;
        }
    }
}