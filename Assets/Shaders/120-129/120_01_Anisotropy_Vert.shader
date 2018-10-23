Shader "Custom/120-129/120_01_Anisotropy_Vert"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Diffuse ("Diffuse %", Range(0, 1)) = 1
        _SpecularFactor ("Specular %", Range(0, 1)) = 1
        _SpecularPower ("Specular power", Float) = 100
        _AmbientFactor ("Ambient %", Range(0, 1)) = 0
        _ReflectionFactor ("Reflection %", Range(0, 1)) = 1
        _Cube ("Cube map", CUBE) = "" {}
        _Detail ("Reflection detail", Range(1, 9)) = 1.0
        _ReflectionExposure ("HDR Exposure", Float) = 1.0
        _TangentMap ("Tangent map", 2D) = "black" {}
        _AnisoU ("Aniso U", Float) = 1
        _AnisoV ("Aniso V", Float) = 1
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
			float4 _MainTex_ST;
            
            float _Diffuse;
            float4 _LightColor0;
            
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
            
            float3 DiffuseLambert(float3 normalVal, float3 lightDir, float3 lightColor, float diffuseFactor, float attenuation)
            {
                return lightColor * diffuseFactor * attenuation * saturate(dot(normalVal, lightDir));
            }
            
            float AshikhminShirleyPremoze_BRDF(float nU, float nV, float3 tangentDir, float3 normalDir, float3 lightDir, float3 viewDir, float reflectionFactor)
            {
                const float pi = UNITY_PI;
                float3 halfwayVector = normalize(lightDir + viewDir);
                float3 NdotH = dot(normalDir, halfwayVector);
                float3 NdotL = dot(normalDir, lightDir);
                float3 NdotV = dot(normalDir, viewDir);
                float3 HdotT = dot(halfwayVector, tangentDir);
                float3 HdotB = dot(halfwayVector, cross(tangentDir, normalDir)); // * tangentDir.w ?
                float3 VdotH = dot(viewDir, halfwayVector);
                 
                float power = nU * pow(HdotT, 2) + nV * pow(HdotB, 2);
                power /= 1.0 - pow(NdotH, 2);
                
                float spec = sqrt((nU + 1) * (nV + 1)) * pow(NdotH, power);
                spec /= 8.0 * pi * VdotH * max(NdotL, NdotV);
                
                float Fresnel = reflectionFactor + (1.0 - reflectionFactor) * pow((1.0 - VdotH), 5);
                
                spec *= Fresnel;
                
                return spec; 
            }
            
            float3 IBLRefl(samplerCUBE cubeMap, half detail, float3 worldReflection, float exposure, float reflectionFactor)
            {
                float4 cubeMapColor = texCUBElod(cubeMap, float4(worldReflection, detail)).rgba;
                return reflectionFactor * cubeMapColor.rgb * (cubeMapColor.a * exposure);
            }
            
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0;
                float4 worldPos : TEXCOORD1;
                float3 worldNormal : TEXCOORD2;
                float4 surfaceColor : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                
                o.texcoord = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.xyz;
                float attenuation = 1;
                float3 diffuseColor = DiffuseLambert(o.worldNormal, lightDir, lightColor, _Diffuse, attenuation);
                
                float3 worldSpaceViewDir = normalize(_WorldSpaceCameraPos - o.worldPos);
                
                float4 tangentMap = tex2Dlod(_TangentMap, float4(v.texcoord * _TangentMap_ST.xy + _TangentMap_ST.zw, 0, 0));
                float3 specularColor = AshikhminShirleyPremoze_BRDF(_AnisoU, _AnisoV, tangentMap.xyz, o.worldNormal, lightDir, worldSpaceViewDir, _ReflectionFactor);
                
                float3 ambientColor = _AmbientFactor * UNITY_LIGHTMODEL_AMBIENT;
                
                float3 mainTexCol = tex2Dlod(_MainTex, float4(o.texcoord.xy, 0, 0));
                
                o.surfaceColor = float4(mainTexCol * diffuseColor + specularColor + ambientColor, 1);
                
                float3 worldReflection = reflect(-worldSpaceViewDir, o.worldNormal);
                o.surfaceColor.rgb *= IBLRefl(_Cube, _Detail, worldReflection, _ReflectionExposure, _ReflectionFactor);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : SV_TARGET
            {
                return i.surfaceColor;
            }
            ENDCG
        }
    }
}