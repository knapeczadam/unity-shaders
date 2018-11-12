Shader "Custom/080-089/081_Diffuse_Vert"
{
    Properties
    {
        _Diffuse ("Diffuse %", Range(0, 1)) = 1
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
            
            float _Diffuse;
            float4 _LightColor0;
            
            float3 DiffuseLambert(float3 normalVal, float3 lightDir, float3 lightColor, float diffuseFactor, float attenuation)
            {
                return lightColor * diffuseFactor * attenuation * saturate(dot(normalVal, lightDir));
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
				float4 surfaceColor : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float attenuation = 1;
                o.surfaceColor = float4(DiffuseLambert(o.worldNormal, lightDir, lightColor, _Diffuse, attenuation), 1);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return i.surfaceColor;
            }
            ENDCG
        }
    }
}   