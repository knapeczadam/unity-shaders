Shader "Custom/110-119/112_01_Reflection_Vert" 
{
	Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _SpecularMap ("Specular Map", 2D) = "white" {}
        _Cube ("Cube Map", CUBE) = "" {}
        _DiffuseFactor ("Diffuse %", Range(0.0, 1.0)) = 1.0
        _SpecularFactor ("Specular %", Range(0.0, 1.0)) = 1.0
        _SpecularPower ("Specular power", Range(0.01, 128.0)) = 100.0
        _AmbientFactor ("Ambient %", Range(0.0, 1.0)) = 0.0
        _ReflectionFactor ("Reflection %", Range(0.0, 1.0)) = 1.0
        _Detail ("Reflection detail", Range(1.0, 9.0)) = 1.0
        _ReflectionExposure ("HDR Exposure", Float) = 1.0
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
            
            float _DiffuseFactor;
            fixed4 _LightColor0;
            
            sampler2D _SpecularMap;
            float _SpecularFactor;
            float _SpecularPower;
            
            float _AmbientFactor;
            
            samplerCUBE _Cube;
            half _Detail;
            float _ReflectionExposure;
            float _ReflectionFactor;
            
            fixed3 DiffuseLambert(float3 normal, float3 lightDir, half atten, fixed3 lightColor, float diffuseFactor)
            {
                fixed diff = saturate(dot(normal, lightDir));
                return lightColor * (diff * atten) * diffuseFactor;
            }
            
            fixed3 SpecularBlinnPhong(float3 normal, float3 lightDir, float3 viewDir, half atten, fixed3 specularColor, float specularPower, float specularFactor)
            {
                float3 halfwayDir = normalize(lightDir + viewDir);
                float spec = pow(saturate(dot(normal, halfwayDir)), specularPower);
                return specularColor * (spec * atten) * specularFactor;
            }
            
            float3 IBLRefl(samplerCUBE cubeMap, float3 worldReflection, half detail, float exposure, float reflectionFactor)
            {
                float4 cubeMapColor = texCUBElod(cubeMap, float4(worldReflection, detail)).rgba;
                return cubeMapColor.rgb * (cubeMapColor.a * exposure) * reflectionFactor;
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
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;
                fixed3 surfaceColor : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                
                half attenuation = 1;
                
                float3 lightDir = _WorldSpaceLightPos0.xyz;
                fixed3 lightColor = _LightColor0.rgb;
                fixed3 diffuseColor = DiffuseLambert(o.worldNormal, lightDir, attenuation, lightColor, _DiffuseFactor);
                
                fixed4 specularMap = tex2Dlod(_SpecularMap, float4(o.uv, 0, 0));
                float3 worldSpaceViewDir = normalize(UnityWorldSpaceViewDir(o.worldPos));
                fixed3 specularColor = SpecularBlinnPhong(o.worldNormal, lightDir, worldSpaceViewDir, attenuation, specularMap.rgb, _SpecularPower, _SpecularFactor);
                
                fixed3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb * _AmbientFactor;
                
                fixed3 mainTexCol = tex2Dlod(_MainTex, float4(o.uv, 0, 0)).rgb;
                
                float3 worldReflection = reflect(-worldSpaceViewDir, o.worldNormal);
                float3 reflectionColor = IBLRefl(_Cube, worldReflection, _Detail, _ReflectionExposure, _ReflectionFactor);
                
                o.surfaceColor = mainTexCol * diffuseColor + specularColor + ambientColor;
                o.surfaceColor *= reflectionColor;
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return fixed4(i.surfaceColor, 1);
            }
            ENDCG
        }
    }
}