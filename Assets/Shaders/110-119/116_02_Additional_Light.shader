Shader "Custom/110-119/116_02_Additional_Light" 
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Color ("Diffuse Material Color", Color) = (1,1,1,1)
        _Diffuse ("Diffuse %", Range(0, 1)) = 1
        _SpecColor ("Specular Material Color", Color) = (1,1,1,1) 
        _SpecularFactor ("Specular %", Range(0, 1)) = 1
        _SpecularPower ("Specular power", Float) = 100
    }
    
    SubShader 
    {
        Pass
        {
            Tags { "LightMode" = "ForwardBase" } 
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            
            #include "UnityCG.cginc"
            #include "116_02_Additional_Light.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float _Diffuse;
            float4 _LightColor0; 
            
            float4 _Color; 
            float4 _SpecColor; 
            float _SpecularFactor;
            float _SpecularPower;
            
            struct vertexInput 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                float4 finalColor = fixed4(1, 1, 1, _Color.a);
                float3 viewDirection = normalize(_WorldSpaceCameraPos - i.worldPos); // UnityWorldSpaceViewDir
                
                float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - i.worldPos; // UnityWorldSpaceLightDir ?
                float distance = length(vertexToLightSource);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.w, _WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.worldPos));
                float attenuation = lerp(_WorldSpaceLightPos0.w, 1.0, 1.0 / distance); 
                
                float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb;
                float3 diffuseReflection = DiffuseLambert(i.worldNormal, lightDirection, _LightColor0, _Diffuse, attenuation);
                float3 specularReflection = SpecularBlinnPhong(i.worldNormal, lightDirection, viewDirection, _SpecColor, _SpecularFactor, attenuation, _SpecularPower);
                
                finalColor.rgb = tex2D(_MainTex, i.uv) * _Color.rgb;
                finalColor.rgb *= ambientLighting + diffuseReflection + specularReflection;
                
                return finalColor;
            }
            ENDCG
        }
        
        Pass 
        {
            Tags { "LightMode" = "ForwardAdd" } 
            
            Blend One One 
            
            CGPROGRAM
            
            #pragma vertex vert 
            #pragma fragment frag 
            
            #include "UnityCG.cginc"
            #include "116_02_Additional_Light.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float _Diffuse;
            float4 _LightColor0; 
            
            float4 _Color; 
            float4 _SpecColor; 
            float _SpecularFactor;
            float _SpecularPower;
            
            struct vertexInput 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                float4 finalColor = fixed4(1, 1, 1, _Color.a);
                float3 viewDirection = normalize(_WorldSpaceCameraPos - i.worldPos);
                
                float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - i.worldPos;
                float distance = length(vertexToLightSource);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.w, _WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.worldPos));
                float attenuation = lerp(_WorldSpaceLightPos0.w, 1.0, 1.0 / distance); 
                
                float3 diffuseReflection = DiffuseLambert(i.worldNormal, lightDirection, _LightColor0, _Diffuse, attenuation);
                float3 specularReflection = SpecularBlinnPhong(i.worldNormal, lightDirection, viewDirection, _SpecColor, _SpecularFactor, attenuation, _SpecularPower);
                
                finalColor.rgb = tex2D(_MainTex, i.uv) * _Color.rgb;
                finalColor.rgb *= diffuseReflection + specularReflection;
                
                return finalColor;
            }
            ENDCG
        }
    }
}
