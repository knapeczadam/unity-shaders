Shader "Custom/000-009/003_Albedo_Emission"
{
    Properties
    {
        _AlbedoColor ("Albedo Color", Color) = (1, 1, 1, 1)
        _EmissionColor ("Emission Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _AlbedoColor;
        fixed4 _EmissionColor;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _AlbedoColor;
            o.Emission = _EmissionColor;
        }
        ENDCG
    }
    Fallback "Diffuse"
}