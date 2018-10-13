using System.Collections.Generic;
using UnityEngine;

public class BlinnPhongDebugger : MonoBehaviour
{
	[Range(0.0f, 200.0f)]
	public float specularPower = 100.0f;
	
	[Header("LIGHT")]
	public Transform light;
	[Range(-1.0f, 1.0f)]
	public float lightDirX = 1.0f;
	[Range(0.0f, 1.0f)]
	public float lightDirY = 1.0f;
	[Range(-1.0f, 1.0f)]
	public float lightDirZ = 1.0f;
	
	[Header("VIEW")]
	public Transform view;
	[Range(-1.0f, 1.0f)]
	public float viewDirX = 1.0f;
	[Range(0.0f, 1.0f)]
	public float viewDirY = 1.0f;
	[Range(-1.0f, 1.0f)]
	public float viewDirZ = 0.0f;
	
	[Header("PHONG")]
	public float specularAngle1;
	public float specular1;
	private float _theta;
	
	[Header("BLINN-PHONG")]
	public float specularAngle2;
	public float specular2;

	private Vector3 _normal = Vector3.up;
	
	private Vector3 _lightDir;
	private Vector3 _oldLightDir;
	
	private Vector3 _viewDir;
	private Vector3 _oldViewDir;
    
	private List<GameObject> _lines = new List<GameObject>();
    
	private void OnEnable()
	{
		lightDirX = lightDirY = lightDirZ = 1.0f;
		_oldLightDir = Vector3.zero;
		
		viewDirX = viewDirY = 1.0f;
		viewDirZ = 0;
		_oldViewDir = Vector3.zero;
	}

	void Update()
	{
		_lightDir = new Vector3(lightDirX, lightDirY, lightDirZ);
		_viewDir = new Vector3(viewDirX, viewDirY, viewDirZ);
		
		light.rotation = Quaternion.LookRotation(_lightDir);
		view.rotation = Quaternion.LookRotation(_viewDir);

		if (!_lightDir.Equals(_oldLightDir) || !_viewDir.Equals(_oldViewDir))
		{
			_oldLightDir = _lightDir;
			_oldViewDir = _viewDir;
			
			Clear();
			
            _lightDir.Normalize();
			Vector3 negativeLightDir = -_lightDir;
			_theta = Vector3.Dot(_lightDir, _normal);
			Vector3 projection = _theta  * _normal;
			Vector3 reflection = negativeLightDir + 2 * projection;
			specularAngle1 = Mathf.Max(0, Vector3.Dot(reflection, _viewDir));
			specular1 = Mathf.Pow(specularAngle1, specularPower / 4.0f);
			
			Vector3 halfway = (_lightDir + _viewDir).normalized;
			specularAngle2 = Mathf.Max(0, Vector3.Dot(halfway, _normal));
			specular2 = Mathf.Pow(specularAngle2, specularPower);
            
			GameObject l1 = DrawingHelper.DrawLine(light.position, light.position + negativeLightDir, Color.yellow);
			GameObject l2 = DrawingHelper.DrawLine(light.position + _lightDir, light.position + projection, Color.red);
			GameObject l3 = DrawingHelper.DrawLine(light.position + negativeLightDir, light.position + reflection, Color.red);
			GameObject l4 = DrawingHelper.DrawLine(light.position, light.position + reflection, Color.green);
			GameObject l5 = DrawingHelper.DrawLine(light.position, light.position + halfway, Color.cyan);
            
			_lines.Add(l1);
			_lines.Add(l2);
			_lines.Add(l3);
			_lines.Add(l4);
			_lines.Add(l5);
		}
	}
    
	private void Clear()
	{
		_lines.ForEach(Destroy);
		_lines.Clear();
	}

	private void OnDisable()
	{
		Clear();
	}
}
