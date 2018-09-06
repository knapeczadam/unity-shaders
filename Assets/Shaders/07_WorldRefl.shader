Shader "Custom/07_WorldRefl"
{
    Properties
    {
        _Cube ("Cube map", CUBE) = "black" {}
        [Toggle(ENABLE_EMISSION)] _isEmissive("Is emissive", Float) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature ENABLE_EMISSION
        
        samplerCUBE _Cube;
        
        struct Input
        {
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {   
            #ifdef ENABLE_EMISSION
                o.Emission= texCUBE(_Cube, IN.worldRefl);
            #endif
        }
        ENDCG
    }
    Fallback "Diffuse"
}
