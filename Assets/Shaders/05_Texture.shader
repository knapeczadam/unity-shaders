Shader "Custom/05_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    }
    Fallback "Diffuse"
}