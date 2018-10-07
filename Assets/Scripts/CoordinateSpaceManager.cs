using System.Collections.Generic;
using UnityEngine;

public class CoordinateSpaceManager : MonoBehaviour
{
    public enum CoordinateSpace
    {
        ObjectSpace,
        WorldSpace,
        ViewSpace,
        ProjectionSpace,
        NormalizedDeviceCoordinateSpace,
        TextureSpace
    }
    
    public CoordinateSpace Space = CoordinateSpace.ObjectSpace;
    public Transform startObject;
    public Transform go;
    public Transform point;
    public int indexSelector;

    public Vector4 currentSpace = Vector4.zero;
    
    private MeshFilter _meshFilter;
    private Mesh _mesh;
    private Vector3[] _vertices;

    private int _oldIndex;
    private int _currentIndex;

    private GameObject _line;

    private Matrix4x4 _worldSpaceMatrix;
    private Matrix4x4 _viewMatrix;
    private Matrix4x4 _projectionMatrix;

    private Matrix4x4 _viewSpace;
    private Matrix4x4 _projectionSpace;
    private Matrix4x4 _NDCSpace;

    private Camera _camera;
    private List<GameObject> _cameraLines = new List<GameObject>();

    private void Start()
    {
        _meshFilter = go.GetComponent<MeshFilter>();
        _camera = startObject.GetComponent<Camera>();
        _mesh = _meshFilter.sharedMesh;
        _vertices = _mesh.vertices;
    }

    private void OnEnable()
    {
        _oldIndex = -1;
    }

    void Update()
    {
        _currentIndex = indexSelector;
        {
            if (_oldIndex != _currentIndex)
            {
                _oldIndex = _currentIndex;
                indexSelector = Mathf.Clamp(indexSelector, 0, _vertices.Length - 1);
                point.transform.localPosition = _vertices[indexSelector];
                
                Destroy(_line);
                _line = DrawingHelper.DrawLine(startObject.position, go.position + _vertices[indexSelector], Color.red);

                _worldSpaceMatrix = go.transform.localToWorldMatrix;
                _worldSpaceMatrix.m03 += _vertices[indexSelector].x;
                _worldSpaceMatrix.m13 += _vertices[indexSelector].y;
                _worldSpaceMatrix.m23 += _vertices[indexSelector].z;
                
                if (_camera)
                {
                    _viewMatrix = _camera.worldToCameraMatrix;
                    _projectionMatrix = _camera.projectionMatrix;
                }
                
                switch (Space)
                {
                    case CoordinateSpace.ObjectSpace:
                        currentSpace = _vertices[indexSelector];
                        break;
                    case CoordinateSpace.WorldSpace:
                        currentSpace.x = _worldSpaceMatrix.m03;
                        currentSpace.y = _worldSpaceMatrix.m13;
                        currentSpace.z = _worldSpaceMatrix.m23;
                        break;
                    case CoordinateSpace.ViewSpace:
                        _viewSpace = _viewMatrix * _worldSpaceMatrix;
                        currentSpace.x = _viewSpace.m03;
                        currentSpace.y = _viewSpace.m13;
                        currentSpace.z = _viewSpace.m23;
                        break;
                    case CoordinateSpace.ProjectionSpace:
                        DestroyCameraLines();
                        DrawNearClippingPlane();
                        _projectionSpace = _projectionMatrix * _viewMatrix *  _worldSpaceMatrix;
                        currentSpace.x = _projectionSpace.m03;
                        currentSpace.y = _projectionSpace.m13;
                        currentSpace.z = _projectionSpace.m23;
                        currentSpace.w = _projectionSpace.m33;
                        break;
                    case CoordinateSpace.NormalizedDeviceCoordinateSpace:
                        DestroyCameraLines();
                        DrawNearClippingPlane();
                        _projectionSpace = _projectionMatrix * _viewMatrix *  _worldSpaceMatrix;
                        currentSpace.x = _projectionSpace.m03 / _projectionSpace.m33;
                        currentSpace.y = _projectionSpace.m13 / _projectionSpace.m33;
                        currentSpace.z = _projectionSpace.m23 / _projectionSpace.m33;
                        break;
                    case CoordinateSpace.TextureSpace:
                        DestroyCameraLines();
                        DrawNearClippingPlane();
                        _projectionSpace = _projectionMatrix * _viewMatrix *  _worldSpaceMatrix;
                        currentSpace.x = (_projectionSpace.m03 / _projectionSpace.m33 + 1) * 0.5f;
                        currentSpace.y = (_projectionSpace.m13 / _projectionSpace.m33 + 1) * 0.5f;
                        Debug.Log("The graphics API type and driver version used by the graphics device: " + SystemInfo.graphicsDeviceVersion);
                        Debug.Log("Graphics device shader capability level: " + SystemInfo.graphicsShaderLevel);
                        break;
                }
            }
        }
    }

    private void OnDisable()
    {
        Destroy(_line);
        DestroyCameraLines();
    }

    private void DrawNearClippingPlane()
    {
        Vector3[] frustumCorners = new Vector3[4];
        _camera.CalculateFrustumCorners(_camera.rect, _camera.nearClipPlane, Camera.MonoOrStereoscopicEye.Mono, frustumCorners);

        var BL = _camera.transform.position + _camera.transform.TransformVector(frustumCorners[0]);
        var UL = _camera.transform.position + _camera.transform.TransformVector(frustumCorners[1]);
        var UR = _camera.transform.position + _camera.transform.TransformVector(frustumCorners[2]);
        var BR = _camera.transform.position + _camera.transform.TransformVector(frustumCorners[3]);

        float forwardOffset = 0.01f;

        BL.z += forwardOffset;
        UL.z += forwardOffset;
        UR.z += forwardOffset;
        BR.z += forwardOffset;

        _cameraLines.Add(DrawingHelper.DrawLine(BL, UL, Color.blue));
        _cameraLines.Add(DrawingHelper.DrawLine(UL, UR, Color.blue));
        _cameraLines.Add(DrawingHelper.DrawLine(UR, BR, Color.blue));
        _cameraLines.Add(DrawingHelper.DrawLine(BR, BL, Color.blue));
        
        Vector3 BL_UL = (BL - UL) / 2;
        Vector3 BR_UR = (BR - UR) / 2;
        Vector3 BL_BR = (BL - BR) / 2;
        Vector3 UL_UR = (UL - UR) / 2;
        
        _cameraLines.Add(DrawingHelper.DrawLine(UL + BL_UL, UR + BR_UR, Color.gray, 0.001f));
        _cameraLines.Add(DrawingHelper.DrawLine(BR + BL_BR, UR + UL_UR, Color.gray, 0.001f));
    }

    private void DestroyCameraLines()
    {
        _cameraLines.ForEach(Destroy);
        _cameraLines.Clear();
    }
}