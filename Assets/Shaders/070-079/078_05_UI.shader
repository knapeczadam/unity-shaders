Shader "Custom/070-079/078_05_UI"
{
    Properties
    {
        [KeywordEnum(A, B, C, D, E, F, G, H, I)] _Alphabet ("Alphabet", Float) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma multi_compile _ALPHABET_A _ALPHABET_B _ALPHABET_C _ALPHABET_D _ALPHABET_E _ALPHABET_F _ALPHABET_G _ALPHABET_H _ALPHABET_I
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   