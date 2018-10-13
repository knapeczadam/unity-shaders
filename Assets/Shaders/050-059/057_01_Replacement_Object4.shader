Shader "Custom/050-059/057_01_Replacement_Object4"
{
    SubShader
    {   
        Tags { "Dark Side" = "Black" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(0.666, 0.666, 0.666, 1);
        }
        ENDCG
    }
}   