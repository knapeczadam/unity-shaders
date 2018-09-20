using System;
using System.IO;
using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class ShaderManager : MonoBehaviour
{

    public Material material;
    
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

    public void SetScreenSize()
    {
        material.SetInt("_Width", Screen.width);
        material.SetInt("_Height", Screen.height);
    }

    private void OnEnable()
    {
        if (material)
        {
            SetScreenSize();
        }
    }
}