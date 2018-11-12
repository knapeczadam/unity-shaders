Shader "Custom/070-079/076_04_Rotation_Matrix_X"
{
    Properties
    {
        _DegreeX ("X-axis rotation in degree", Range(0.0, 360.0)) = 0.0
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _DegreeX;
            
            float4 rotateX(float4 vertex)
            {
                float theta = radians(_DegreeX);
                theta = radians(_Time.x * 360.0);
                
                float4x4 rotationMatrixX = float4x4
                (
                    1,          0,           0, 0,
                    0, cos(theta), -sin(theta), 0,
                    0, sin(theta),  cos(theta), 0,
                    0,          0,            0, 1
                );
                
                return mul(rotationMatrixX, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(rotateX(v.vertex));
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}   