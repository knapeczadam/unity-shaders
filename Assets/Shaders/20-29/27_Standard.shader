Shader "Custom/20-29/27_Standard"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Standard
        
        fixed4 _Color;
        sampler2D _MetallicTex;
        half _Metallic;
        
        struct Input
        {
            float2 uv_MetallicTex;
        };
        
        void surf (Input IN, inout SurfaceOutputStandard o) 
        {
            o.Albedo = _Color;
            o.Emission = tex2D (_MetallicTex, IN.uv_MetallicTex) * abs(_SinTime.x);
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex);
            o.Metallic = _Metallic;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   