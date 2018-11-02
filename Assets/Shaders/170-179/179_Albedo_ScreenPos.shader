Shader "Custom/170-179/179_Albedo_ScreenPos"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 screenPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.screenPos;
        }
        ENDCG
    }
}