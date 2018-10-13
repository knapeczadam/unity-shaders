Shader "Custom/020-029/024_Striped_WorldPos_Cutoff"
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
            fixed4 x = frac(IN.worldPos.x * 10 * _SinTime.x * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            fixed4 y = frac(IN.worldPos.y * 10 * _SinTime.y * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            fixed4 z = frac(IN.worldPos.z * 10 * _SinTime.z * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            o.Emission = x * y * z;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   