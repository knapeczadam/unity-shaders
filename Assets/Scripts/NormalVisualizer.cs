using System.Collections.Generic;
using UnityEngine;

public class NormalVisualizer : MonoBehaviour
{
    public enum NormalType
    {
        Vertex,
        Face,
        Tangent,
        Binormal
    }

    public NormalType type = NormalType.Vertex;
    public float normalLength;

    private List<GameObject> lines = new List<GameObject>();
    private MeshFilter _meshFilter;

    private Vector3[] vertices;
    private int[] triangles;
    private Vector3[] normals;
    private Vector4[] tangents;

    void OnEnable()
    {
        _meshFilter = GetComponent<MeshFilter>();

        if (!_meshFilter)
        {
            return;
        }

        Mesh mesh = _meshFilter.sharedMesh;

        vertices = mesh.vertices;
        triangles = mesh.triangles;
        normals = mesh.normals;
        tangents = mesh.tangents;

        Vector3 modNormal = new Vector3(normals[0].x, normals[0].y, normals[0].z);
        normalLength = modNormal.magnitude;

        switch (type)
        {
            case NormalType.Vertex:
                ShowVertexNormals();
                break;
            case NormalType.Face:
                ShowFaceNormals();
                break;
            case NormalType.Tangent:
                ShowTangentNormals();
                break;
            case NormalType.Binormal:
                ShowBinormals();
                break;
        }
    }

    private void ShowVertexNormals()
    {
        for (var i = 0; i < vertices.Length; i++)
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

    private void ShowFaceNormals()
    {
        for (int i = 0; i < triangles.Length;)
        {
            Vector3 a = vertices[triangles[i++]];
            Vector3 b = vertices[triangles[i++]];
            Vector3 c = vertices[triangles[i++]];
            Vector3 pos = ((a + b + c) / 3);

            Vector3 side1 = b - a;
            Vector3 side2 = c - a;

            Vector3 perp = Vector3.Cross(side1, side2);
            float perpLength = perp.magnitude;
            perp /= perpLength;

            pos.x *= transform.lossyScale.x;
            pos.y *= transform.lossyScale.y;
            pos.z *= transform.lossyScale.z;

            Vector3 start = transform.position + transform.rotation * pos;
            Vector3 end = start + transform.rotation * perp;

            GameObject line = DrawingHelper.DrawLine(start, end, Color.red);
            lines.Add(line);
        }
    }

    private void ShowTangentNormals()
    {
        for (var i = 0; i < vertices.Length; i++)
        {
            Vector3 pos = vertices[i];
            Vector3 tangent = tangents[i];

            pos.x *= transform.lossyScale.x;
            pos.y *= transform.lossyScale.y;
            pos.z *= transform.lossyScale.z;

            Vector3 start = transform.position + transform.rotation * pos;
            Vector3 end = start + transform.rotation * tangent;

            GameObject line = DrawingHelper.DrawLine(start, end, Color.red);
            lines.Add(line);
        }
    }

    private void ShowBinormals()
    {
        for (var i = 0; i < vertices.Length; i++)
        {
            Vector3 pos = vertices[i];
            Vector3 binormal = Vector3.Cross(normals[i], tangents[i]) * tangents[i][3];

            pos.x *= transform.lossyScale.x;
            pos.y *= transform.lossyScale.y;
            pos.z *= transform.lossyScale.z;

            Vector3 start = transform.position + transform.rotation * pos;
            Vector3 end = start + transform.rotation * binormal;

            GameObject line = DrawingHelper.DrawLine(start, end, Color.red);
            lines.Add(line);
        }
    }

    private void OnDisable()
    {
        lines.ForEach(Destroy);
        lines.Clear();
    }
}