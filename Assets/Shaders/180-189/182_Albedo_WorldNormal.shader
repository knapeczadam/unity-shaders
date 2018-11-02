Shader "Custom/180-189/182_Albedo_WorldNormal"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 worldNormal;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.worldNormal;
        }
        ENDCG
    }
}