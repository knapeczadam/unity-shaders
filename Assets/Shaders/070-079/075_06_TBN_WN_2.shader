Shader "Custom/070-079/075_06_TBN_WN_2"
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
                float3 worldNormal : TEXCOORD1;
                float3 worldTangent : TEXCOORD2;
                float3 worldBinormal : TEXCOORD3;
            };
            
            float3 normalFromColor(float4 col)
            {
                #if defined(UNITY_NO_DXT5nm)
                    return col.xyz * 2 - 1;
                #else
                    float3 normVal;
                    normVal = float3(col.a * 2 - 1, col.g * 2 - 1, 0.0);
                    normVal.z = sqrt(1 - dot(normVal, normVal));
                    return normVal;
                #endif
            }
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
                o.worldNormal = normalize(mul(v.normal, (float3x3) unity_WorldToObject)); // v.normal -> float1x3
                o.worldTangent = normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)); // v.tangent -> float3x1
                o.worldBinormal =  cross(o.worldNormal, o.worldTangent) * v.tangent.w * unity_WorldTransformParams.w;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                float4 col = tex2D(_BumpMap, i.uv);
                
                float3 norm = normalFromColor(col);
                
                float3x3 TBN = float3x3(i.worldTangent, i.worldBinormal, i.worldNormal);
                float4 worldNorm = float4(normalize(mul(norm, TBN)), 1);
                
                return worldNorm;
            }
            ENDCG
        }
    }
}   