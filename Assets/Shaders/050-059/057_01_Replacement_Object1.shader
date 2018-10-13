Shader "Custom/050-059/057_01_Replacement_Object1"
{
    SubShader
    {   
        Tags { "RenderType" = "Cyan" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(1, 0, 0, 1);
        }
        ENDCG
    }
}   