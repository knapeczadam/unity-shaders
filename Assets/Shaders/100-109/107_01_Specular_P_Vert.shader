Shader "Custom/100-109/107_01_Specular_P_Vert" 
{
	Properties
    {
        _SpecularMap ("Specular Map", 2D) = "white" {}
        _DiffuseFactor ("Diffuse %", Range(0.0, 1.0)) = 1.0
        _SpecularFactor ("Specular %", Range(0.0, 1.0)) = 1.0
        _SpecularPower ("Specular power", Range(0.01, 128.0)) = 100.0
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
            
            float _DiffuseFactor;
            fixed4 _LightColor0;
            
            sampler2D _SpecularMap;
            float _SpecularFactor;
            float _SpecularPower;
            
            fixed3 DiffuseLambert(float3 normal, float3 lightDir, half atten, fixed3 lightColor, float diffuseFactor)
            {
                fixed diff = saturate(dot(normal, lightDir));
                return lightColor * (diff * atten) * diffuseFactor;
            }
            
            fixed3 SpecularPhong(float3 normal, float3 lightDir, float3 viewDir, half atten, fixed3 specularColor, float specularPower, float specularFactor)
            {
                float3 reflection = 2.0 * dot(normal, lightDir) * normal - lightDir; // reflect(-lightDir, normalDir)
                float spec = pow(saturate(dot(reflection, viewDir)), specularPower);
                return specularColor * (spec * atten) * specularFactor;
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
                fixed3 specularColor = SpecularPhong(o.worldNormal, lightDir, worldSpaceViewDir, attenuation, specularMap.rgb, _SpecularPower, _SpecularFactor);
                
                o.surfaceColor = diffuseColor + specularColor;
                
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
