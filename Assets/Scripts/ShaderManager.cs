using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class ShaderManager : MonoBehaviour
{

    public Material material;
    public bool setScreenSize;
    public List<NamedColor> colors = new List<NamedColor>();
    public List<NamedVector> vectors = new List<NamedVector>();
    public List<NamedFloat> floats = new List<NamedFloat>();
    
    public void OpenShader()
    {
        Renderer renderer = ModelSceneControl.s_Selected.transform.GetComponent<Renderer>();
        if (renderer == null)
        {
            return;
        }

        foreach (Material material in renderer.materials)
        {
            string[] shaderName = material.shader.name.Split('/');
            string path = Path.Combine(Application.dataPath, "Shaders", shaderName[1], (shaderName[2] + ".shader"));
            
            if (File.Exists(path))
            {
                System.Diagnostics.Process.Start(path);
            }
        }
    }

    private void Update()
    {
        if (material)
        {
            if (setScreenSize)
            {
                SetScreenSize();
            }
            
            if (colors.Count > 0)
            {
                foreach (NamedColor namedColor in colors)
                {
                    material.SetColor(namedColor.name, namedColor.value);
                }    
            }
    
            if (vectors.Count > 0)
            {
                foreach (NamedVector namedVector in vectors)
                {
                    if (namedVector.transform)
                    {
                        material.SetVector(namedVector.name, namedVector.transform.position);
                    }
                    else
                    {
                        material.SetVector(namedVector.name, namedVector.value);
                    }
                }
                
            }
    
            if (floats.Count > 0)
            {
                foreach (NamedFloat namedFloat in floats)
                {
                    material.SetFloat(namedFloat.name, namedFloat.value);
                }
            }
        }
    }

    public void SetScreenSize()
    {
        material.SetInt("_Width", Screen.width);
        material.SetInt("_Height", Screen.height);
    }

    [Serializable]
    public struct NamedColor
    {
        public string name;
        public Color value;
    }

    [Serializable]
    public struct NamedVector
    {
        public string name;
        public Vector4 value;
        public Transform transform;
    }
    
    [Serializable]
    public struct NamedFloat
    {
        public string name;
        public float value;
    }
}