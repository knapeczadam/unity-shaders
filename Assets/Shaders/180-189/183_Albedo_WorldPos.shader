Shader "Custom/180-189/183_Albedo_WorldPos"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 worldPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.worldPos;
        }
        ENDCG
    }
}