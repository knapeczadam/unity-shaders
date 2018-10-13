Shader "Custom/000-009/005_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Range ("Range", Range(0, 10)) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        float _Range;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Range;
        }
        ENDCG
    }
    Fallback "Diffuse"
}