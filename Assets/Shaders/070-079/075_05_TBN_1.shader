Shader "Custom/070-079/075_05_TBN_1"
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
                o.worldNormal = normalize(mul((float3x3) unity_ObjectToWorld, v.normal)); // v.normal -> float3x1
                o.worldTangent = normalize(mul(v.tangent.xyz, (float3x3) unity_ObjectToWorld)); // v.tangent -> float1x3
                o.worldBinormal = normalize(cross(o.worldNormal, o.worldTangent) * v.tangent.w);
                
                return o;
            }
            
            float3x3 frag(vertexOuput i) : COLOR
            {
                float3x3 TBN = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal); 
                
                return TBN;
            }
            ENDCG
        }
    }
}   