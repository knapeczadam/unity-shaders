Shader "Custom/070-079/075_02_WST_1"
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
                float3 worldTangent : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldTangent = normalize(mul(v.tangent.xyz, (float3x3) unity_ObjectToWorld)); // v.tangent -> float1x3
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return float4(i.worldTangent, 1);
            }
            ENDCG
        }
    }
}   