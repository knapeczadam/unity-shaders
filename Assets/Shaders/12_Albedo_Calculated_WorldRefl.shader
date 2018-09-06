Shader "Custom/12_Albedo_Calculated_WorldRefl"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
            float3 worldNormal;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = reflect(-IN.viewDir, IN.worldNormal);
        }
        ENDCG
    }
    Fallback "Diffuse"
}