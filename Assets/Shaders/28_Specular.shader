Shader "Custom/20-29/28_Specular"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecColor ("Specular", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf StandardSpecular
        
        fixed4 _Color;
        sampler2D _MetallicTex;
        
        struct Input
        {
            float2 uv_MetallicTex;
        };
        
        void surf (Input IN, inout SurfaceOutputStandardSpecular o) 
        {
            o.Albedo = _Color;
            half smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex);
            smoothness += (saturate(abs(_SinTime.w)) * (0.9 - smoothness - smoothness));
            o.Smoothness = smoothness;
            o.Specular = _SpecColor;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   