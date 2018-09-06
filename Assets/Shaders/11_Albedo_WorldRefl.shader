Shader "Custom/11_Albedo_WorldRefl"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.worldRefl;
        }
        ENDCG
    }
    Fallback "Diffuse"
}