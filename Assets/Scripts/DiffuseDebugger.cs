using System.Collections.Generic;
using UnityEngine;

public class DiffuseDebugger : MonoBehaviour
{
    public Transform light;
    public Vector3 lightDir = Vector3.up;
    private Vector3 _oldLightDir;
    
    private MeshFilter _meshFilter;
    private Mesh _mesh;
    private Vector3[] _normals;
    private Vector3[] _vertices;
    
    private List<GameObject> _lines = new List<GameObject>();
    
    void Start()
    {
        _meshFilter = GetComponent<MeshFilter>();
        _mesh = _meshFilter.sharedMesh;
        _vertices = _mesh.vertices;
        _normals = _mesh.normals;
    }

    private void OnEnable()
    {
        lightDir = Vector3.up;
        _oldLightDir = Vector3.zero;
    }

    void Update()
    {
        
        light.rotation = Quaternion.LookRotation(lightDir);

        if (!lightDir.Equals(_oldLightDir))
        {
            _oldLightDir = lightDir;
            Clear();
            CalculateDiffuseReflection();
        }
    }
    
    private void CalculateDiffuseReflection()
    {
        for (var i = 0; i < _vertices.Length; i++)
        {
            Vector3 pos = _vertices[i];
            Vector3 normal = _normals[i];

            float id = Vector3.Dot(normal, lightDir.normalized);
            if (id >= 0)
            {
                pos.x *= transform.lossyScale.x;
                pos.y *= transform.lossyScale.y;
                pos.z *= transform.lossyScale.z;
                
                Vector3 start = transform.position + transform.rotation * pos;
                Vector3 end = start + transform.rotation * normal;
    
                GameObject line = DrawingHelper.DrawLine(start, end, Color.yellow * id, 0.01f * id);
                _lines.Add(line);
            }

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