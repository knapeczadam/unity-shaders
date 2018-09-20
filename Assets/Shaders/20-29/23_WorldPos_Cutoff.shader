Shader "Custom/20-29/23_WorldPos_Cutoff"
{
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            o.Emission = IN.worldPos.y > 1 ? abs(_SinTime) : abs(_CosTime);
        }
        ENDCG
    }
    Fallback "Diffuse"
}