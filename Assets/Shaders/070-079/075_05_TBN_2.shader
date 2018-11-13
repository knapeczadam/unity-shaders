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
                float3 worldNormal : TEXCOORD2;
                float3 worldTangent : TEXCOORD3;
                float3 worldBinormal : TEXCOORD4;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = normalize(mul(v.normal, (float3x3) unity_WorldToObject)); // v.normal -> float1x3
                o.worldTangent = normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)); // v.tangent -> float3x1
                fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * tangentSign;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                float3x3 TBN = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal); // ~CreateTangentToWorldPerVertex
                fixed3 debugTBN = normalize(fixed3(TBN[0].x, TBN[1].y, TBN[2].z)); 
                return fixed4(debugTBN, 1);
            }
            ENDCG
        }
    }
}   