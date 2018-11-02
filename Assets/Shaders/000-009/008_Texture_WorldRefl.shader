Shader "Custom/000-009/008_Texture_WorldRefl"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _EnvMap ("Environment Map", CUBE) = "" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        samplerCUBE _EnvMap;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Emission = texCUBE(_EnvMap, IN.worldRefl).rgb;
        }
        ENDCG
    }
}