Shader "Custom/10-19/19_Dot_Product"
{
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            half dotp = dot(IN.viewDir, o.Normal);
            dotp += (saturate(_SinTime.w) * (1 - dotp - dotp));
            o.Albedo = fixed3(dotp, dotp, dotp) * _SinTime;   
        }
        ENDCG
    }
    Fallback "Diffuse"
}