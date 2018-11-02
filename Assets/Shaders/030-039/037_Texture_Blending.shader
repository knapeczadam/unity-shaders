Shader "Custom/030-039/037_Texture_Blending"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _DecalTex ("Decal", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _DecalTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D(_DecalTex, IN.uv_MainTex);
            o.Albedo = a.r > sin(_Time.y) * 0.5 + 0.5 ? a.rgb : b.rgb;
//            o.Albedo = lerp(a, b, sin(_Time.y) * 0.5 + 0.5);
        }
        ENDCG
    }
}   