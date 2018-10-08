using UnityEngine;

public class MatrixDeugger : MonoBehaviour
{
    public SkinnedMeshRenderer skinnedMeshRenderer;
    
    [Header("NORMAL")]
    public Matrix4x4 unity_ObjectToWorld;
    public Vector3 normal;
    public Vector4 normalNOK;
    public Vector4 normalOK;
    
    [Header("TANGENT")]
    public Matrix4x4 unity_WorldToObject;
    public Vector4 tangent;
    public Vector4 tangentNOK;
    public Vector4 tangentOK;
    
    private void OnEnable()
    {
        Mesh mesh = skinnedMeshRenderer.sharedMesh;

        normal = mesh.normals[Random.Range(0, mesh.normals.Length - 1)];
        tangent = mesh.tangents[Random.Range(0, mesh.tangents.Length - 1)];
        
        unity_WorldToObject = skinnedMeshRenderer.worldToLocalMatrix;
        unity_ObjectToWorld = skinnedMeshRenderer.localToWorldMatrix;

        Matrix1x4 n1 = new Matrix1x4(normal.x, normal.y, normal.z, 0);
        Matrix4x1 n2 = new Matrix4x1(normal.x, normal.y, normal.z, 0);
        
        Matrix1x4 t1 = new Matrix1x4(tangent.x, tangent.y, tangent.z, tangent.w);
        Matrix4x1 t2 = new Matrix4x1(tangent.x, tangent.y, tangent.z, tangent.w);

        normalNOK = mul(n1, unity_WorldToObject); // Debug.Log(unity_ObjectToWorld.MultiplyVector((Vector4) n1));
        normalOK = mul(unity_WorldToObject, n2);
        
        tangentNOK = mul(t1, unity_ObjectToWorld); // Debug.Log(unity_ObjectToWorld.MultiplyVector((Vector4) t1));
        tangentOK = mul(unity_ObjectToWorld, t2); 
        
        Vector4 a = new Vector4(1, 2, 3, 4);
        Matrix1x4 b = new Matrix1x4(1, 2, 3, 4);
        Matrix4x1 c = new Matrix4x1(1, 2, 3, 4);    
        
        Matrix4x4 m = new Matrix4x4(new Vector4(1, 4, 1, 4), new Vector4(2, 3, 2, 3), new Vector4(3, 2, 3, 2), new Vector4(4, 1, 4, 1));

//        Debug.Log(mul(a, m));
//        Debug.Log(mul(b, m));
//        Debug.Log(mul(m, c));
    }

    static Vector4 mul(Vector4 v, Matrix4x4 M) // float4 mul(float4 v, float4x4 M); ~ float1x4 mul(float1x4 A, float4x4 B);
    {
        Vector4 vector4 = new Vector4();
        vector4.x = (float) ((double) M.m00 * (double) v.x + (double) M.m01 * (double) v.y + (double) M.m02 * (double) v.z + (double) M.m03 * (double) v.w);
        vector4.y = (float) ((double) M.m10 * (double) v.x + (double) M.m11 * (double) v.y + (double) M.m12 * (double) v.z + (double) M.m13 * (double) v.w);
        vector4.z = (float) ((double) M.m20 * (double) v.x + (double) M.m21 * (double) v.y + (double) M.m22 * (double) v.z + (double) M.m23 * (double) v.w);
        vector4.w = (float) ((double) M.m30 * (double) v.x + (double) M.m31 * (double) v.y + (double) M.m32 * (double) v.z + (double) M.m33 * (double) v.w);
        return vector4;
    }
    
    static Matrix1x4 mul(Matrix1x4 A, Matrix4x4 B) // float1x4 mul(float1x4 A, float4x4 B);
    {
        Matrix1x4 result = new Matrix1x4();
        result.m00 = (float) ((double) A.m00 * (double) B.m00 + (double) A.m01 * (double) B.m10 + (double) A.m02 * (double) B.m20 + (double) A.m03 * (double) B.m30);
        result.m01 = (float) ((double) A.m00 * (double) B.m01 + (double) A.m01 * (double) B.m11 + (double) A.m02 * (double) B.m21 + (double) A.m03 * (double) B.m31);
        result.m02 = (float) ((double) A.m00 * (double) B.m02 + (double) A.m01 * (double) B.m12 + (double) A.m02 * (double) B.m22 + (double) A.m03 * (double) B.m32);
        result.m03 = (float) ((double) A.m00 * (double) B.m03 + (double) A.m01 * (double) B.m13 + (double) A.m02 * (double) B.m23 + (double) A.m03 * (double) B.m33);
        return result;
    }
    
    static Matrix4x1 mul(Matrix4x4 A, Matrix4x1 B) // float4x1 mul(float4x4 A, float4x1 B);
    {
        Matrix4x1 result = new Matrix4x1();
        result.m00 = (float) ((double) A.m00 * (double) B.m00 + (double) A.m01 * (double) B.m10 + (double) A.m02 * (double) B.m20 + (double) A.m03 * (double) B.m30);
        result.m10 = (float) ((double) A.m10 * (double) B.m00 + (double) A.m11 * (double) B.m10 + (double) A.m12 * (double) B.m20 + (double) A.m13 * (double) B.m30);
        result.m20 = (float) ((double) A.m20 * (double) B.m00 + (double) A.m21 * (double) B.m10 + (double) A.m22 * (double) B.m20 + (double) A.m23 * (double) B.m30);
        result.m30 = (float) ((double) A.m30 * (double) B.m00 + (double) A.m31 * (double) B.m10 + (double) A.m32 * (double) B.m20 + (double) A.m33 * (double) B.m30);
        return result;
    }

    class Matrix1x4
    {
        public float m00;
        public float m01;
        public float m02;
        public float m03;

        public Matrix1x4()
        {
            
        }

        public Matrix1x4(float m00, float m01, float m02, float m03)
        {
            this.m00 = m00;
            this.m01 = m01;
            this.m02 = m02;
            this.m03 = m03;
        }

        public override string ToString()
        {
            return $"m00: {m00} m01: {m01} m02: {m02} m03: {m03}";
        }
        
        public static implicit operator Vector4(Matrix1x4 m)
        {
            return new Vector4(m.m00, m.m01, m.m02, m.m03);
        }
    }

    class Matrix4x1
    {
        public float m00;
        public float m10;
        public float m20;
        public float m30;

        public Matrix4x1()
        {
            
        }
        
        public Matrix4x1(float m00, float m10, float m20, float m30)
        {
            this.m00 = m00;
            this.m10 = m10;
            this.m20 = m20;
            this.m30 = m30;
        }
        
        public override string ToString()
        {
            return $"m00: {m00} m10: {m10} m20: {m20} m30: {m30}";
        }
        
        public static implicit operator Vector4(Matrix4x1 m)
        {
            return new Vector4(m.m00, m.m10, m.m20, m.m30);
        }
    }
}