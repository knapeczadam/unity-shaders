Shader "Custom/050-059/057_01_Replacement_Object2"
{
    SubShader
    {   
        Tags { "RenderType" = "Magenta" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed3(0, 1, 0);
        }
        ENDCG
    }
}   