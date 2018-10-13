Shader "Custom/030-039/032_04_Alpha_Channel_Transparent_Shadow"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        AlphaTest Greater 0.5
        
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
    Fallback "Transparent/Cutout/VertexLit"
}   