using System.Collections.Generic;
using UnityEngine;

public class ShowNormals : MonoBehaviour
{
    [Range(-10, 10)] public float nx;

    [Range(-10, 10)] public float ny;

    [Range(-10, 10)] public float nz;

    //to display length
    public float normal_length;

    private List<GameObject> lines = new List<GameObject>();

    void OnEnable()
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;

        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;

        Vector3 modNormal = new Vector3(normals[0].x * nx, normals[0].y * ny, normals[0].z * nz);
        normal_length = modNormal.magnitude;

        for (var i = 0; i < normals.Length; i++)
        {
            Vector3 pos = vertices[i];
            // lossyScale is the global scale of the object
            pos.x *= transform.lossyScale.x;
            pos.y *= transform.lossyScale.y;
            pos.z *= transform.lossyScale.z;
            // Need to rotate the vertex before moving it
            Vector3 posRot = transform.position + transform.rotation * pos;
            normals[i].x *= nx;
            normals[i].y *= ny;
            normals[i].z *= nz;

            GameObject line = DrawingHelper.DrawLine(pos, posRot + transform.rotation * normals[i], Color.red);
            lines.Add(line);
        }
    }

    private void OnDisable()
    {
        lines.ForEach(Destroy);
        lines.Clear();
    }
}