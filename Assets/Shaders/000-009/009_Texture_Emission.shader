Shader "Custom/000-009/009_Texture_Emission"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _IllumTex ("Illumination (RGB)", 2D) = "black" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _IllumTex;
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_IllumTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Emission= tex2D(_IllumTex, IN.uv_IllumTex).rgb * (sin(_Time.w) * 0.5 + 0.5);
        }
        ENDCG
    }
}