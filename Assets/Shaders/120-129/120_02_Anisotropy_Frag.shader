Shader "Custom/120-129/120_02_Anisotropy_Frag"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _TangentMap ("Tangent Map", 2D) = "black" {}
        _Cube ("Cube Map", CUBE) = "" {}
        _DiffuseFactor ("Diffuse %", Range(0.0, 1.0)) = 1.0
        _SpecularFactor ("Specular %", Range(0.0, 1.0)) = 1.0
        _SpecularPower ("Specular power", Range(0.01, 128.0)) = 100.0
        _AmbientFactor ("Ambient %", Range(0.0, 1.0)) = 0.0
        _ReflectionFactor ("Reflection %", Range(0.0, 1.0)) = 1.0
        _Detail ("Reflection detail", Range(1.0, 9.0)) = 1.0
        _ReflectionExposure ("HDR Exposure", Float) = 1.0
        _AnisoU ("Aniso U", Float) = 1.0
        _AnisoV ("Aniso V", Float) = 1.0
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
            
            sampler2D _MainTex;
            sampler2D _BumpMap;
            
            float _DiffuseFactor;
            fixed4 _LightColor0;
            
            float _SpecularFactor;
            float _SpecularPower;
            
            float _AmbientFactor;
            
            samplerCUBE _Cube;
            half _Detail;
            float _ReflectionExposure;
            float _ReflectionFactor;
            
            sampler2D _TangentMap;
            float4 _TangentMap_ST;
            float _AnisoU;
            float _AnisoV;
            
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
            
            float3 IBLRefl(samplerCUBE cubeMap, float3 worldReflection, half detail, float exposure, float reflectionFactor)
            {
                float4 cubeMapColor = texCUBE(cubeMap, float4(worldReflection, detail)).rgba;
                return cubeMapColor.rgb * (cubeMapColor.a * exposure) * reflectionFactor;
            }
            
            float AshikhminShirleyPremoze_BRDF(float nU, float nV, float3 tangent, float3 normal, float3 lightDir, float3 viewDir, float reflectionFactor)
            {
                const float pi = UNITY_PI;
                float3 halfwayVector = normalize(lightDir + viewDir);
                float3 NdotH = dot(normal, halfwayVector);
                float3 NdotL = dot(normal, lightDir);
                float3 NdotV = dot(normal, viewDir);
                float3 HdotT = dot(halfwayVector, tangent);
                float3 HdotB = dot(halfwayVector, cross(tangent, normal));
                float3 VdotH = dot(viewDir, halfwayVector);
                 
                float power = nU * pow(HdotT, 2) + nV * pow(HdotB, 2);
                power /= 1.0 - pow(NdotH, 2);
                
                float spec = sqrt((nU + 1) * (nV + 1)) * pow(NdotH, power);
                spec /= 8.0 * pi * VdotH * max(NdotL, NdotV);
                
                float Fresnel = reflectionFactor + (1.0 - reflectionFactor) * pow((1.0 - VdotH), 5);
                
                spec *= Fresnel;
                
                return spec; 
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
                float3 worldPos : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;
                float3 worldTangent : TEXCOORD4;
                float3 worldBinormal : TEXCOORD5;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                o.worldBinormal = cross(o.worldNormal, o.worldTangent) * tangentSign;
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET  
            {
                float3 worldNormalAtPixel = WorldNormalFromNormalMap(_BumpMap, i.uv, i.worldTangent, i.worldBinormal, i.worldNormal);
                
                half attenuation = 1;
                
                float3 lightDir = _WorldSpaceLightPos0.xyz;
                fixed3 lightColor = _LightColor0.rgb;
                fixed3 diffuseColor = DiffuseLambert(worldNormalAtPixel, lightDir, attenuation, lightColor, _DiffuseFactor);
                
                float3 worldSpaceViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                
                float4 tangentMap = tex2D(_TangentMap, i.uv * _TangentMap_ST.xy + _TangentMap_ST.zw);
                float3 specularColor = AshikhminShirleyPremoze_BRDF(_AnisoU, _AnisoV, tangentMap.xyz, worldNormalAtPixel, lightDir, worldSpaceViewDir, _ReflectionFactor);
                
                fixed3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb * _AmbientFactor;
                
                fixed3 mainTexCol = tex2D(_MainTex, i.uv).rgb;
                
                float3 worldReflection = reflect(-worldSpaceViewDir, worldNormalAtPixel);
                float3 reflectionColor = IBLRefl(_Cube, worldReflection, _Detail, _ReflectionExposure, _ReflectionFactor);
                
                fixed3 surfaceColor = mainTexCol * diffuseColor + specularColor + ambientColor;
                surfaceColor *= reflectionColor; 
                
                return fixed4(surfaceColor, 1);
            }
            ENDCG
        }
    }
}