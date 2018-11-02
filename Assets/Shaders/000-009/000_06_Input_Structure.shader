Shader "Custom/000-009/000_06_Input_Structure"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float4 color : COLOR; 
            float4 screenPos;
            float2 uv_FirstTex;
            float2 uv2_SecondTex;
            float3 viewDir;
            float3 worldNormal; // INTERNAL_DATA
            float3 worldPos;
            float3 worldRefl; // INTERNAL_DATA
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
        
        }
        ENDCG
    }
}