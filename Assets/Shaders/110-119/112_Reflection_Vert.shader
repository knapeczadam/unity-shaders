Shader "Custom/110-119/112_Reflection_Vert" 
{
	Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Diffuse ("Diffuse %", Range(0, 1)) = 1
        _SpecularMap ("Specular map", 2d) = "white" {}
        _SpecularFactor ("Specular %", Range(0, 1)) = 1
        _SpecularPower ("Specular power", Float) = 100
        _AmbientFactor ("Ambient %", Range(0, 1)) = 0
        _ReflectionFactor ("Reflection %", Range(0, 1)) = 1
        _Cube ("Cube map", CUBE) = "" {}
        _Detail ("Reflection detail", Range(1, 9)) = 1.0
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
			float4 _MainTex_ST;
            
            float _Diffuse;
            float4 _LightColor0;
            
            sampler2D _SpecularMap;
            float4 _SpecularMap_ST;
            float _SpecularFactor;
            float _SpecularPower;
            
            float _AmbientFactor;
            
            samplerCUBE _Cube;
            half _Detail;
            float _ReflectionExposure;
            float _ReflectionFactor;
            
            float3 DiffuseLambert(float3 normalVal, float3 lightDir, float3 lightColor, float diffuseFactor, float attenuation)
            {
                return lightColor * diffuseFactor * attenuation * saturate(dot(normalVal, lightDir));
            }
            
            float SpecularBlinnPhong(float3 normalDir, float3 lightDir, float3 worldSpaceViewDir, float3 specularColor, float specularFactor, float attenuation, float specularPower)
            {
                float3 halfwayDir = normalize(lightDir + worldSpaceViewDir);
                return specularColor * specularFactor * attenuation * pow(saturate(dot(normalDir, halfwayDir)), specularPower);
            }
            
            float3 IBLRefl(samplerCUBE cubeMap, half detail, float3 worldReflection, float exposure, float reflectionFactor)
            {
                float4 cubeMapColor = texCUBElod(cubeMap, float4(worldReflection, detail)).rgba;
                return reflectionFactor * cubeMapColor.rgb * (cubeMapColor.a * exposure);
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
                float4 surfaceColor : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                
                o.normalWorld = float4(normalize(mul(normalize(v.normal.xyz), (float3x3) unity_WorldToObject)), v.normal.w);
                
                o.tangentWorld = float4(normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)), v.tangent.w);
                o.binormalWorld = normalize(cross(o.normalWorld, o.tangentWorld) * v.tangent.w);
                
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.xyz;
                float attenuation = 1;
                float3 diffuseColor = DiffuseLambert(o.normalWorld, lightDir, lightColor, _Diffuse, attenuation);
                
                float4 specularMap = tex2Dlod(_SpecularMap, float4(o.texcoord.xy, 0, 0));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 worldSpaceViewDir = normalize(_WorldSpaceCameraPos - o.posWorld);
                float3 specularColor = SpecularBlinnPhong(o.normalWorld, lightDir, worldSpaceViewDir, specularMap.rgb, _SpecularFactor, attenuation, _SpecularPower);
                
                float3 ambientColor = _AmbientFactor * UNITY_LIGHTMODEL_AMBIENT;
                
                float3 mainTexCol = tex2Dlod(_MainTex, float4(o.texcoord.xy, 0, 0));
                
                o.surfaceColor = float4(mainTexCol * diffuseColor + specularColor + ambientColor, 1);
                
                float3 worldReflection = reflect(-worldSpaceViewDir, o.normalWorld.xyz);
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
