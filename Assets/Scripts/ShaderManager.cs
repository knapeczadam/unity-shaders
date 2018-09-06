using System.IO;
using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class ShaderManager : MonoBehaviour
{
    public void OpenShader()
    {
        string path = Path.Combine(Application.dataPath, "Shaders",
            (ModelSceneControl.s_Selected.transform.GetComponent<Renderer>().material.shader.name.Substring(7) +
             ".shader"));
        if (File.Exists(path))
        {
            System.Diagnostics.Process.Start(path);
        }
    }
}