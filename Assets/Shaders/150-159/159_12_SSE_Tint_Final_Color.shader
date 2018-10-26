Shader "Custom/150-159/159_12_SSE_Tint_Final_Color"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ColorTint ("Tint", Color) = (1.0, 0.6, 0.6, 1.0)
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        #pragma surface surf Lambert finalcolor:mycolor
        
        sampler2D _MainTex;
        fixed4 _ColorTint;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void mycolor (Input IN, SurfaceOutput o, inout fixed4 color)
        {
            color *= _ColorTint;
        }
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    Fallback "Diffuse"
}