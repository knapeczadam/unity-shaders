Shader "Custom/05_Texture"
{
    Properties
    {
        _Texture ("Texture", 2D) = "black" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _Texture;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Texture, IN.uv_MainTex);
        }
        ENDCG
    }
    Fallback "Diffuse"
}