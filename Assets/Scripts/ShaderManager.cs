using System.IO;
using UnityEngine;
using UnityStandardAssets.SceneUtils;

public class ShaderManager : MonoBehaviour{
	
	public void OpenShader()
	{
		System.Diagnostics.Process.Start(Path.Combine(Application.dataPath, "Shaders", (ModelSceneControl.s_Selected.transform.GetComponent<Renderer>().material.shader.name.Substring(7) + ".shader")));
	}
}
