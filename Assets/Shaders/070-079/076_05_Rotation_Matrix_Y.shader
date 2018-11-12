Shader "Custom/070-079/076_05_Rotation_Matrix_Y"
{
    Properties
    {
        _DegreeY ("Y-axis rotation in degree", Range(0.0, 360.0)) = 0.0
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _DegreeY;
            
            float4 rotateY(float4 vertex)
            {
                float theta = radians(_DegreeY);
                theta = radians(_Time.x * 360.0);
                
                float4x4 rotationMatrixY = float4x4
                (
                    cos(theta), 0, sin(theta), 0,
                             0, 1,          0, 0,
                   -sin(theta), 0, cos(theta), 0,
                             0, 0,          0, 1
                );
                
                return mul(rotationMatrixY, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(rotateY(v.vertex));
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