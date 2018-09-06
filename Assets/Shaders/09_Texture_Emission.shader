Shader "Custom/09_Texture_Emission"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}
        _Emission ("Emission", 2D) = "black" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _Texture;
        sampler2D _Emission;
        
        struct Input
        {
            float2 uv_Texture;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Texture, IN.uv_Texture);
            o.Emission= tex2D(_Emission, IN.uv_Texture) * _SinTime.w;
        }
        ENDCG
    }
    Fallback "Diffuse"
}