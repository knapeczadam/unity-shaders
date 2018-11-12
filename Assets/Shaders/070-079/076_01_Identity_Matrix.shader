Shader "Custom/070-079/076_01_Identity_Matrix"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 doNothing(float4 vertex)
            {
                float4x4 identityMatrix = float4x4
                (
                    1, 0, 0, 0,
                    0, 1, 0, 0,
                    0, 0, 1, 0,
                    0, 0, 0, 1
                );
                
                return mul(identityMatrix, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(doNothing(v.vertex));
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