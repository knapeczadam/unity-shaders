Shader "Custom/070-079/075_05_TBN_2"
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
                o.worldNormal = normalize(mul(v.normal, (float3x3) unity_WorldToObject)); // v.normal -> float1x3
                o.worldTangent = normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)); // v.tangent -> float3x1
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * v.tangent.w * unity_WorldTransformParams.w;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                float3x3 TBN = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal); // CreateTangentToWorldPerVertex
                return fixed4(TBN[0].r, TBN[1].g, TBN[2].b, 1);
            }
            ENDCG
        }
    }
}   