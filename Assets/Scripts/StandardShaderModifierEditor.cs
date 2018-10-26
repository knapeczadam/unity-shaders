using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(StandardShaderModifier))]
public class StandardShaderModifierEditor : Editor
{
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        StandardShaderModifier scriptName = (StandardShaderModifier) target;
        if (GUILayout.Button(scriptName.GetEnableButtonLabel()))
        {
            scriptName.EnableKeyword();
        }
    }
}