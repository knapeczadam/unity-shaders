Shader "Custom/070-079/075_06_TBN_WN_1"
{
    Properties
    {
        _BumpMap ("Normal Map", 2D) = "bump" {}
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldNormal : TEXCOORD2;
                float3 worldTangent : TEXCOORD3;
                float3 worldBinormal : TEXCOORD4;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
                o.worldNormal = normalize(mul((float3x3) unity_ObjectToWorld, v.normal)); // v.normal -> float3x1
                o.worldTangent = normalize(mul(v.tangent.xyz, (float3x3) unity_ObjectToWorld)); // v.tangent -> float1x3
                fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * tangentSign;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed3 normal = UnpackNormal(tex2D(_BumpMap, i.uv));
                float3x3 TBN = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal);
                float3 worldNormal = normalize(mul(normal, TBN));
                return fixed4(worldNormal * 0.5 + 0.5, 1);
            }
            ENDCG
        }
    }
}   