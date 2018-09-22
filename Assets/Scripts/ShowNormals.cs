using System.Collections.Generic;
using UnityEngine;

public class ShowNormals : MonoBehaviour
{
    public bool faceNormal;
    public float normalLength;

    private List<GameObject> lines = new List<GameObject>();
    private MeshFilter _meshFilter;

    void OnEnable()
    {
        _meshFilter = GetComponent<MeshFilter>();
        
        if (!_meshFilter)
        {
            return;
        }

        Mesh mesh = _meshFilter.mesh;

        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;

        Vector3 modNormal = new Vector3(normals[0].x, normals[0].y, normals[0].z);
        normalLength = modNormal.magnitude;

        if (faceNormal)
        {
            int[] indices = mesh.triangles;
            for(int i = 0; i < mesh.triangles.Length;)
            {
                Vector3 a = vertices[indices[i++]];
                Vector3 b = vertices[indices[i++]];
                Vector3 c = vertices[indices[i++]];
                Vector3 pos = ((a + b + c) / 3);
                
                Vector3 side1 = b - a;
                Vector3 side2 = c - a;
                
                Vector3 perp = Vector3.Cross(side1, side2);
                float perpLength = perp.magnitude;
                perp /= perpLength;
                
                pos.x *= transform.lossyScale.x;
                pos.y *= transform.lossyScale.y;
                pos.z *= transform.lossyScale.z;

                Vector3 start = transform.position + transform.rotation *pos;
                Vector3 end = start + transform.rotation * perp;
                
                GameObject line = DrawingHelper.DrawLine(start, end, Color.red);
                lines.Add(line);
            }
        }
        else
        {
            for (var i = 0; i < normals.Length; i++)
            {
                Vector3 pos = vertices[i];
                Vector3 normal = normals[i];
                
                pos.x *= transform.lossyScale.x;
                pos.y *= transform.lossyScale.y;
                pos.z *= transform.lossyScale.z;
                
                Vector3 start = transform.position + transform.rotation * pos;
                Vector3 end = start + transform.rotation * normal;
    
                GameObject line = DrawingHelper.DrawLine(start, end, Color.red);
                lines.Add(line);
            }
        }
    }

    private void OnDisable()
    {
        lines.ForEach(Destroy);
        lines.Clear();
    }
}