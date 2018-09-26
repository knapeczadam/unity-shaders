Shader "Custom/70-79/76_06_Rotation_Matrix_Z"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            void example()
            {
                float x, y, z;
                
                float theta;
                
                float4x4 rotationMatrixZ = float4x4
                (
                    cos(theta), -sin(theta), 0, 0,
                    sin(theta),  cos(theta), 0, 0,
                             0,           0, 1, 0,
                             0,           0, 0, 1
                );
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_full v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                o.pos = UnityObjectToClipPos(v.vertex);
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