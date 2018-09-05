Shader "Custom/07_WorldRefl"
{
    Properties
    {
        _Cube ("Texture", CUBE) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        samplerCUBE _Cube;
        
        struct Input
        {
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission= texCUBE(_Cube, IN.worldRefl).rgb;
        }
        ENDCG
    }
    Fallback "Diffuse"
}
