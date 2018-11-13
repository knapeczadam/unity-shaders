Shader "Custom/070-079/075_02_WST_2"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float3 worldTangent : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldTangent = normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)); // v.tangent -> float3x1
                //o.worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return fixed4(i.worldTangent * 0.5 + 0.5, 1);
            }
            ENDCG
        }
    }
}   