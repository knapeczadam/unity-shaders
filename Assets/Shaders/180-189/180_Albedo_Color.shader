Shader "Custom/180-189/180_Albedo_Color"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float4 color : COLOR;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.color.rgb;
        }
        ENDCG
    }
}