Shader "Custom/40-49/45_03_VF_Diffuse_Shadow"
{
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ShadowCaster" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            
            struct v2f
            {
                V2F_SHADOW_CASTER;
            };
            
            v2f vert(appdata v)
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