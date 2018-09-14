Shader "Custom/10-19/14_Albedo_Normal_WorldRefl"
{
    Properties 
    {
        _Bump ("Bump Texture", 2D) = "bump" {}
        _Cube ("Cube Map", CUBE) = "white" {}
        [Toggle(SWITCH_ORDER)] _switchOrder("Switch order", Float) = 0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature SWITCH_ORDER
        
        sampler2D _Bump;
        samplerCUBE _Cube;

        struct Input
        {
            float2 uv_Bump;
            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            #ifdef SWITCH_ORDER
                o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump)) * _SinTime.x;
                o.Albedo = texCUBE (_Cube, WorldReflectionVector (IN, o.Normal));
            #else
                o.Albedo = texCUBE (_Cube, WorldReflectionVector (IN, o.Normal));
                o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump)) * _SinTime.x;
            #endif
        }
        ENDCG
    }
    Fallback "Diffuse"
}