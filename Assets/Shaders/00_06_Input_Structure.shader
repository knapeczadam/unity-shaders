Shader "Custom/00_06_Input_Structure"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv2_MainTex;
            float3 viewDir;
            float3 worldNormal; // INTERNAL_DATA
            float3 worldPos;
            float3 worldRefl; // INTERNAL_DATA
            float4 color : COLOR; 
            float4 screenPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
        
        }
        ENDCG
    }
    Fallback Off
}