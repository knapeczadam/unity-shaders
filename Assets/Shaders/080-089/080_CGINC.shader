Shader "Custom/080-089/080_CGINC"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        #include "UnityCG.cginc"
        #include "080_CGINC.cginc"
        
        struct Input
        {
            fixed _;
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
}   