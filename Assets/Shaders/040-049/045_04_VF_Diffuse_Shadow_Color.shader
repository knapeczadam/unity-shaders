Shader "Custom/040-049/045_04_VF_Diffuse_Shadow_Color"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _ShadowColor ("Shadow Color", Color) = (1, 1, 1, 1)
        _ShadowIntensity ("Shadow intensity", Range(0.0, 1.0)) = 1.0
    }
    
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
        
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            
            #include "UnityLightingCommon.cginc"
            #include "Lighting.cginc" 
            #include "AutoLight.cginc"
            
            sampler2D _MainTex;
            fixed4 _ShadowColor;
            float _ShadowIntensity;
            
            struct appdata 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                fixed3 diff : COLOR0; 
                SHADOW_COORDS(1)
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float NdotL = saturate(dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = _LightColor0.rgb * NdotL;
                TRANSFER_SHADOW(o)

                return o;
            }

            fixed4 frag (v2f i) : SV_TARGET
            {
                 fixed4 col = tex2D(_MainTex, i.uv);
                 fixed shadow = SHADOW_ATTENUATION(i);
                 fixed lerpWeight = min(_ShadowIntensity, 1.0 - shadow);
                 col.rgb = i.diff * lerp(col.rgb, _ShadowColor.rgb, lerpWeight);
                 return col;
             }
            ENDCG
        }
        
        Pass
        {
            Tags { "LightMode" = "ShadowCaster" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct v2f 
            { 
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
}   