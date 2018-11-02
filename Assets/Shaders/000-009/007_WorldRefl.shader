Shader "Custom/000-009/007_WorldRefl"
{
    Properties
    {
        _EnvMap ("Environment Map", CUBE) = "" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        samplerCUBE _EnvMap;
        
        struct Input
        {
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {   
            o.Emission = texCUBE(_EnvMap, IN.worldRefl).rgb;
        }
        ENDCG
    }
}