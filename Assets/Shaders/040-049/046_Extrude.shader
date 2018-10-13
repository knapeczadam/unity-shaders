Shader "Custom/040-049/046_Extrude"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert addshadow
        
        fixed4 _Color;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color;
        }
        
        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * abs(_SinTime.w) * 0.1;
        }
        ENDCG
        
//        Pass
//        {
//            Tags { "LightMode" = "ShadowCaster" }
//            
//            CGPROGRAM
//            #pragma vertex vert
//            #pragma fragment frag
//            #pragma multi_compile_shadowcaster
//            
//            #include "UnityCG.cginc"
//            
//            struct v2f
//            {
//                V2F_SHADOW_CASTER;
//            };
//            
//            v2f vert(appdata_full v)
//            {
//                v2f o;
//                v.vertex.xyz += v.normal * abs(_SinTime.w) * 0.1;
//                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
//                return o;
//            }
//            
//            fixed4 frag(v2f i) : SV_TARGET
//            {
//                SHADOW_CASTER_FRAGMENT(i)
//            }
//            ENDCG
//        }
    }
    Fallback "Diffuse"
}   