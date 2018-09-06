using System.IO;
using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class ShaderManager : MonoBehaviour
{
    public void OpenShader()
    {
        Renderer renderer = ModelSceneControl.s_Selected.transform.GetComponent<Renderer>();
        if (renderer == null)
        {
            return;
        }

        string path = Path.Combine(Application.dataPath, "Shaders", (renderer.material.shader.name.Substring(7) + ".shader"));
        
        if (File.Exists(path))
        {
            System.Diagnostics.Process.Start(path);
        }
    }
}