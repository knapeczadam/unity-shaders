Shader "Custom/000-009/007_WorldRefl"
{
    Properties
    {
        _Environment ("Cube map", CUBE) = "black" {}
        [Toggle(ENABLE_EMISSION)] _isEmissive("Is emissive", Float) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature ENABLE_EMISSION
        
        samplerCUBE _Environment;
        
        struct Input
        {
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {   
            #ifdef ENABLE_EMISSION
                o.Emission = texCUBE(_Environment, IN.worldRefl);
            #else
                o.Albedo = texCUBE(_Environment, IN.worldRefl);
            #endif
        }
        ENDCG
    }
    Fallback "Diffuse"
}