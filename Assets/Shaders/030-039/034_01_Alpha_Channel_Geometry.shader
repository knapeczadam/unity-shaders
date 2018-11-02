Shader "Custom/030-039/034_01_Alpha_Channel_Geometry"
{
    Properties
    {
        _MainTex ("Albedo (RGB) and Transparency (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Geometry" }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;   
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {   
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
}   