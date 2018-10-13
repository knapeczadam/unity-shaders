Shader "Custom/070-079/079_01_Multi"
{
    Properties
    {
        [KeywordEnum(Good, Bad, Ugly)] _The ("The", Float) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma multi_compile _THE_GOOD _THE_BAD _THE_UGLY
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            #if _THE_GOOD
                o.Albedo = fixed3(1, 1, 0);
            #elif _THE_BAD
                o.Albedo = 1;
            #else
                o.Albedo = 0;
            #endif
        }
        ENDCG
    }
    Fallback "Diffuse"
}   