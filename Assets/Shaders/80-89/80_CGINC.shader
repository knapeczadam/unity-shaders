Shader "Custom/80-89/80_CGINC"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        #include "UnityCG.cginc"
        #include "80_CGINC.cginc"
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float a, b, c, d;
            a = 6;
            b = 28;
            c = add(a, b);
            d = multiply(a, b);
            o.Albedo = UNITY_PI > (d - c) / getTheAnswer() ? 1 : 0;  
        }
        ENDCG
    }
    Fallback "Diffuse"
}   