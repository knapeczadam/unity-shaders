using UnityEngine;

public class MatrixDeugger : MonoBehaviour
{
    public SkinnedMeshRenderer skinnedMeshRenderer;
    
    [Header("NORMAL")]
    public Matrix4x4 unity_WorldToObject;
    public Vector3 normal;
    public Vector3 normal1x3; // OK if UNITY_ASSUME_UNIFORM_SCALING is true
    public Vector3 normal3x1; // OK if UNITY_ASSUME_UNIFORM_SCALING is false
    
    [Header("TANGENT")]
    public Matrix4x4 unity_ObjectToWorld;
    public Vector4 tangent;
    public Vector4 tangent1x4NOK;
    public Vector4 tangent4x1OK;
    
    private void OnEnable()
    {
        Mesh mesh = skinnedMeshRenderer.sharedMesh;

        normal = mesh.normals[Random.Range(0, mesh.normals.Length - 1)];
        tangent = mesh.tangents[Random.Range(0, mesh.tangents.Length - 1)];
        
        unity_WorldToObject = skinnedMeshRenderer.worldToLocalMatrix;
        unity_ObjectToWorld = skinnedMeshRenderer.localToWorldMatrix; // gameObject.transform.localToWorldMatrix
        
        // NORMAL 3x3
        Matrix1x3 n1 = new Matrix1x3(normal);
        normal1x3 = mul(n1, unity_WorldToObject);
        Matrix3x1 n2 = new Matrix3x1(normal);
        normal3x1 = mul(unity_ObjectToWorld, n2); // unity_WorldToObject.MultiplyVector(normal);
        
        // TANGENT 4x4
        Matrix1x4 t3 = new Matrix1x4(tangent);
        tangent1x4NOK = mul(t3, unity_ObjectToWorld);
        Matrix4x1 t4 = new Matrix4x1(tangent);
        tangent4x1OK = mul(unity_ObjectToWorld, t4);

        Vector3 a = new Vector3(1, 2, 3);
//        Vector4 a = new Vector4(1, 2, 3, 4);
        Matrix1x3 b = new Matrix1x3(a);
//        Matrix1x4 b = new Matrix1x4(a);
        Matrix3x1 c = new Matrix3x1(a);    
//        Matrix4x1 c = new Matrix4x1(a);    
        
        Matrix3x3 m = new Matrix3x3(new Vector3(1, 3, 1), new Vector3(2, 2, 2), new Vector3(3, 1, 3));
//        Matrix4x4 m = new Matrix4x4(new Vector4(1, 4, 1, 4), new Vector4(2, 3, 2, 3), new Vector4(3, 2, 3, 2), new Vector4(4, 1, 4, 1));

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
    
    static Vector3 mul(Vector3 v, Matrix3x3 M) // float3 mul(float3 v, float3x3 M); ~ float1x3 mul(float1x3 A, float3x3 B);
    {
        Vector4 vector3 = new Vector3();
        vector3.x = (float) ((double) M.m00 * (double) v.x + (double) M.m01 * (double) v.y + (double) M.m02 * (double) v.z);
        vector3.y = (float) ((double) M.m10 * (double) v.x + (double) M.m11 * (double) v.y + (double) M.m12 * (double) v.z);
        vector3.z = (float) ((double) M.m20 * (double) v.x + (double) M.m21 * (double) v.y + (double) M.m22 * (double) v.z);
        return vector3;
    }
    
    static Matrix1x3 mul(Matrix1x3 A, Matrix3x3 B) // float1x3 mul(float1x3 A, float3x3 B);
    {
        Matrix1x3 result = new Matrix1x3();
        result.m00 = (float) ((double) A.m00 * (double) B.m00 + (double) A.m01 * (double) B.m10 + (double) A.m02 * (double) B.m20);
        result.m01 = (float) ((double) A.m00 * (double) B.m01 + (double) A.m01 * (double) B.m11 + (double) A.m02 * (double) B.m21);
        result.m02 = (float) ((double) A.m00 * (double) B.m02 + (double) A.m01 * (double) B.m12 + (double) A.m02 * (double) B.m22);
        return result;
    }
    
    static Matrix3x1 mul(Matrix3x3 A, Matrix3x1 B) // float3x1 mul(float3x3 A, float3x1 B);
    {
        Matrix3x1 result = new Matrix3x1();
        result.m00 = (float) ((double) A.m00 * (double) B.m00 + (double) A.m01 * (double) B.m10 + (double) A.m02 * (double) B.m20);
        result.m10 = (float) ((double) A.m10 * (double) B.m00 + (double) A.m11 * (double) B.m10 + (double) A.m12 * (double) B.m20);
        result.m20 = (float) ((double) A.m20 * (double) B.m00 + (double) A.m21 * (double) B.m10 + (double) A.m22 * (double) B.m20);
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

        public Matrix1x4(Vector4 row)
        {
            this.m00 = row.x;
            this.m01 = row.y;
            this.m02 = row.z;
            this.m03 = row.w;
        }

        public override string ToString()
        {
            return $"0:{m00}\t1:{m01}\t2:{m02}\t3:{m03}\n";
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
        
        public Matrix4x1(Vector4 col)
        {
            this.m00 = col.x;
            this.m10 = col.y;
            this.m20 = col.z;
            this.m30 = col.w;
        }
        
        public override string ToString()
        {
            return $"0:{m00}\n1:{m10}\n2:{m20}\n3:{m30}\n";
        }
        
        public static implicit operator Vector4(Matrix4x1 m)
        {
            return new Vector4(m.m00, m.m10, m.m20, m.m30);
        }
    }
    
    class Matrix1x3
    {
        public float m00;
        public float m01;
        public float m02;

        public Matrix1x3()
        {
            
        }

        public Matrix1x3(Vector3 row)
        {
            this.m00 = row.x;
            this.m01 = row.y;
            this.m02 = row.z;
        }

        public override string ToString()
        {
            return $"0:{m00}\t1:{m01}\t2:{m02}\n";
        }
        
        public static implicit operator Vector3(Matrix1x3 m)
        {
            return new Vector3(m.m00, m.m01, m.m02);
        }
    }
    
    class Matrix3x1
    {
        public float m00;
        public float m10;
        public float m20;

        public Matrix3x1()
        {
            
        }
        
        public Matrix3x1(Vector3 col)
        {
            this.m00 = col.x;
            this.m10 = col.y;
            this.m20 = col.z;
        }
        
        public override string ToString()
        {
            return $"0:{m00}\n1:{m10}\n2:{m20}\n";
        }
        
        public static implicit operator Vector3(Matrix3x1 m)
        {
            return new Vector3(m.m00, m.m10, m.m20);
        }
    }
    
    class Matrix3x3
    {
        private static readonly Matrix3x3 zeroMatrix = new Matrix3x3(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f));
        private static readonly Matrix3x3 identityMatrix = new Matrix3x3(new Vector3(1f, 0.0f, 0.0f), new Vector3(0.0f, 1f, 0.0f), new Vector3(0.0f, 0.0f, 1f));
        public float m00;
        public float m10;
        public float m20;
        public float m01;
        public float m11;
        public float m21;
        public float m02;
        public float m12;
        public float m22;

        public Matrix3x3(Vector3 column0, Vector3 column1, Vector3 column2)
        {
            this.m00 = column0.x;
            this.m01 = column1.x;
            this.m02 = column2.x;
            this.m10 = column0.y;
            this.m11 = column1.y;
            this.m12 = column2.y;
            this.m20 = column0.z;
            this.m21 = column1.z;
            this.m22 = column2.z;
        }
        
        public static Matrix3x3 zero
        {
            get
            {
                return Matrix3x3.zeroMatrix;
            }
        }
        
        public override string ToString()
        {
            return $"0:{m00}\t1:{m01}\t2:{m02}\t3:{m10}\n4:{m11}\t5:{m12}\t6:{m20}\t7:{m21}\n8:{m22}\n";
        }
        
        public static Matrix3x3 identity
        {
            get
            {
                return Matrix3x3.identityMatrix;
            }
        }
        
        public static implicit operator Matrix3x3(Matrix4x4 m)
        {
            return new Matrix3x3(new Vector3(m.m00, m.m01, m.m02), new Vector3(m.m03, m.m10, m.m11), new Vector3(m.m12, m.m13, m.m20));
        }
    }
}