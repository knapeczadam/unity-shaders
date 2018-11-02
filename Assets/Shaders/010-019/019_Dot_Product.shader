Shader "Custom/010-019/019_Dot_Product"
{
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            float VdotN = saturate(dot(IN.viewDir, o.Normal));
            VdotN = (sin(_Time.w) * 0.5 + 0.5) * 1.0 - VdotN;
            o.Albedo = abs(VdotN) * _SinTime;   
        }
        ENDCG
    }
}