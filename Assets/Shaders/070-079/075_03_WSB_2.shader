Shader "Custom/070-079/075_03_WSB_2"
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
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldTangent : TEXCOORD1;
                float3 worldBinormal : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = normalize(mul(v.normal, (float3x3) unity_WorldToObject)); // v.normal -> float3x1
                o.worldTangent = normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)); // v.tangent.xyz -> float3x1
                o.worldBinormal = normalize(cross(o.worldNormal, o.worldTangent) * v.tangent.w);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return float4(i.worldBinormal, 1);
            }
            ENDCG
        }
    }
}   