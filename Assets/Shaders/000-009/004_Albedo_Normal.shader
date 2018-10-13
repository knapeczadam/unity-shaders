Shader "Custom/000-009/004_Albedo_Normal"
{
    Properties
    {
        _AlbedoColor ("Albedo Color", Color) = (1, 1, 1, 1)
        _NormalColor ("Normal Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _AlbedoColor;
        fixed4 _NormalColor;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _AlbedoColor;
            o.Normal = _NormalColor;
        }
        ENDCG
    }
    Fallback "Diffuse"
}