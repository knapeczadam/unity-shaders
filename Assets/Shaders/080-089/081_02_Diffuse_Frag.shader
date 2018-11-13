Shader "Custom/080-089/081_02_Diffuse_Frag"
{
    Properties
    {
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _DiffuseFactor ("Diffuse %", Range(0.0, 1.0)) = 1.0
    }
    
    SubShader
    {
        Pass 
        {
            Tags { "LightMode" = "ForwardBase" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _BumpMap;
            
            float _DiffuseFactor;
            fixed4 _LightColor0;
            
            float3 WorldNormalFromNormalMap(sampler2D normalMap, float2 uv, float3 worldTangent, float3 worldBinormal, float3 worldNormal)
            {
		        fixed3 normal = UnpackNormal(tex2D(normalMap, uv));
		        float3x3 TBN = float3x3(worldTangent, worldBinormal, worldNormal);
		        return normalize(mul(normal, TBN));	
            }
            
            fixed3 DiffuseLambert(float3 normal, float3 lightDir, half atten, fixed3 lightColor, float diffuseFactor)
            {
                fixed diff = saturate(dot(normal, lightDir));
                return lightColor * (diff * atten) * diffuseFactor;
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord : TEXCOORD0;
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
                o.uv = v.texcoord;
                
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * tangentSign; 
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET  
            {
                float3 worldNormalAtPixel = WorldNormalFromNormalMap(_BumpMap, i.uv, i.worldTangent, i.worldBinormal, i.worldNormal);
                
                float3 lightDir = _WorldSpaceLightPos0.xyz;
                fixed3 lightColor = _LightColor0.rgb;
                half attenuation = 1;
                fixed3 diffuseColor = DiffuseLambert(worldNormalAtPixel, lightDir, attenuation, lightColor, _DiffuseFactor);
                return fixed4(diffuseColor, 1);
            }
            ENDCG
        }
    }
}   