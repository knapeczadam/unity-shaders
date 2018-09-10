Shader "Custom/28_Specular"
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
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex);
            o.Specular = _SpecColor;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   