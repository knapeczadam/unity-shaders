Shader "Custom/120-129/120_Anisotropy_Frag"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _NormalMap ("Normal map", 2D) = "bump" {}
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
            
            sampler2D _NormalMap;
            float4 _NormalMap_ST;
            
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
            
            float3 normalFromColor (float4 colorVal)
            {
	            #if defined(UNITY_NO_DXT5nm)
		            return colorVal.xyz * 2 - 1;
	            #else
                    float3 normalVal;
                    normalVal = float3 (colorVal.a * 2.0 - 1.0,
                                colorVal.g * 2.0 - 1.0,
                                0.0);
                    normalVal.z = sqrt(1.0 - dot(normalVal, normalVal));
                    return normalVal;
	            #endif
            }
            
            float3 WorldNormalFromNormalMap(sampler2D normalMap, float2 normalTexCoord, float3 tangentWorld, float3 binormalWorld, float3 normalWorld)
            {
		        float4 colorAtPixel = tex2D(normalMap, normalTexCoord);
		
		        float3 normalAtPixel = normalFromColor(colorAtPixel);
		
		        float3x3 TBNWorld = float3x3(tangentWorld, binormalWorld, normalWorld);
		        return normalize(mul(normalAtPixel, TBNWorld));	
            }
            
            float3 DiffuseLambert(float3 normalVal, float3 lightDir, float3 lightColor, float diffuseFactor, float attenuation)
            {
                return lightColor * diffuseFactor * attenuation * saturate(dot(normalVal, lightDir));
            }
            
            float3 IBLRefl(samplerCUBE cubeMap, half detail, float3 worldReflection, float exposure, float reflectionFactor)
            {
                float4 cubeMapColor = texCUBElod(cubeMap, float4(worldReflection, detail)).rgba;
                return reflectionFactor * cubeMapColor.rgb * (cubeMapColor.a * exposure);
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
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float4 normalWorld : TEXCOORD2;
                float4 tangentWorld : TEXCOORD3;
                float3 binormalWorld : TEXCOORD4;
                float4 normalTexCoord : TEXCOORD5;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                
                o.normalWorld = float4(normalize(mul(normalize(v.normal.xyz), (float3x3) unity_WorldToObject)), v.normal.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                
                o.normalTexCoord.xy = v.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
                o.tangentWorld = float4(normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)), v.tangent.w);
                o.binormalWorld = normalize(cross(o.normalWorld, o.tangentWorld) * v.tangent.w);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : SV_TARGET  
            {
                float4 finalColor = float4(0, 0, 0, 1);
                
                float3 worldNormalAtPixel = WorldNormalFromNormalMap(_NormalMap, i.normalTexCoord.xy, i.tangentWorld.xyz, i.binormalWorld.xyz, i.normalWorld.xyz);
                
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.xyz;
                float attenuation = 1;
                float3 diffuseColor = DiffuseLambert(worldNormalAtPixel, lightDir, lightColor, _Diffuse, attenuation);
                
                float3 worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.posWorld);
                
                float4 tangentMap = tex2D(_TangentMap, i.texcoord.xy * _TangentMap_ST.xy + _TangentMap_ST.zw);
                float3 specularColor = AshikhminShirleyPremoze_BRDF(_AnisoU, _AnisoV, tangentMap.xyz, worldNormalAtPixel, lightDir, worldSpaceViewDir, _ReflectionFactor);
                
                float3 ambientColor = _AmbientFactor * UNITY_LIGHTMODEL_AMBIENT;
                
                float3 mainTexCol = tex2D(_MainTex, i.texcoord.xy);
                
                float3 worldReflection = reflect(-worldSpaceViewDir, worldNormalAtPixel);
                float3 reflectionColor = IBLRefl(_Cube, _Detail, worldReflection, _ReflectionExposure, _ReflectionFactor);
                
                finalColor.rgb = mainTexCol * diffuseColor + specularColor + ambientColor;
                finalColor.rgb *= reflectionColor; 
                
                return finalColor;
            }
            ENDCG
        }
    }
}