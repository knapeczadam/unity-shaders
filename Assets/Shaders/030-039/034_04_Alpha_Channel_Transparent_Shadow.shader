Shader "Custom/030-039/034_04_Alpha_Channel_Transparent_Shadow"
{
    Properties
    {
        _MainTex ("Albedo (RGB) and Transparency (A)", 2D) = "white" {}
        _Cutoff ("Alpha Cutoff", Range(0.0, 1.0)) = 1.0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        CGPROGRAM
        #pragma surface surf Lambert alphatest:_Cutoff addshadow
        
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