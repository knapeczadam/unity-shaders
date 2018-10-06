Shader "Custom/80-89/82_Diffuse_Frag"
{
    Properties
    {
        _NormalMap ("Normal map", 2D) = "bump" {}
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
            
            sampler2D _NormalMap;
            float4 _NormalMap_ST;
            
            float _Diffuse;
            float4 _LightColor0;
            
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
                float4 normalWorld : TEXCOORD1;
                float4 tangentWorld : TEXCOORD2;
                float3 binormalWorld : TEXCOORD3;
                float4 normalTexCoord : TEXCOORD4;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy;
                
                o.normalWorld = float4(normalize(mul(normalize(v.normal.xyz), (float3x3) unity_WorldToObject)), v.normal.w);
                
                o.normalTexCoord.xy = v.texcoord.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
                o.tangentWorld = float4(normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)), v.tangent.w);
                o.binormalWorld = normalize(cross(o.normalWorld, o.tangentWorld) * v.tangent.w);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : SV_TARGET  
            {
                float3 worldNormalAtPixel = WorldNormalFromNormalMap(_NormalMap, i.normalTexCoord.xy, i.tangentWorld.xyz, i.binormalWorld.xyz, i.normalWorld.xyz);
                
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.xyz;
                float attenuation = 1;
                return float4(DiffuseLambert(worldNormalAtPixel, lightDir, lightColor, _Diffuse, attenuation), 1);
            }
            ENDCG
        }
    }
}   