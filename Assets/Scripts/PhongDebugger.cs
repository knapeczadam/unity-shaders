using System.Collections.Generic;
using UnityEngine;

public class PhongDebugger : MonoBehaviour
{
    public Transform light;
    [Range(-1.0f, 1.0f)]
    public float lightDirX = 1.0f;
    [Range(0.0f, 1.0f)]
    public float lightDirY = 1.0f;
    [Range(-1.0f, 1.0f)]
    public float lightDirZ = 1.0f;
    
    [Space]

    public float theta;
    public float angle;

    private Vector3 _normal = Vector3.up;
    private Vector3 _lightDir;
    private Vector3 _oldLightDir;
    
    private List<GameObject> _lines = new List<GameObject>();
    
    private void OnEnable()
    {
        lightDirX = lightDirY = lightDirZ = 1.0f;
        _oldLightDir = Vector3.zero;
    }

    void Update()
    {
        _lightDir = new Vector3(lightDirX, lightDirY, lightDirZ);
        light.rotation = Quaternion.LookRotation(_lightDir);

        if (!_lightDir.Equals(_oldLightDir))
        {
            _oldLightDir = _lightDir;
            
            Clear();
            
            _lightDir.Normalize();
            Vector3 negativeLightDir = -_lightDir;
            theta = Vector3.Dot(_lightDir, _normal);
            angle = Mathf.Acos(theta) * Mathf.Rad2Deg;
            Vector3 projection = theta  * _normal;
            Vector3 reflection = negativeLightDir + 2 * projection;
            
            GameObject l1 = DrawingHelper.DrawLine(light.position, light.position + negativeLightDir, Color.yellow);
            GameObject l2 = DrawingHelper.DrawLine(light.position + _lightDir, light.position + projection, Color.red);
            GameObject l3 = DrawingHelper.DrawLine(light.position + negativeLightDir, light.position + reflection, Color.red);
            GameObject l4 = DrawingHelper.DrawLine(light.position, light.position + reflection, Color.green);
            
            _lines.Add(l1);
            _lines.Add(l2);
            _lines.Add(l3);
            _lines.Add(l4);
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