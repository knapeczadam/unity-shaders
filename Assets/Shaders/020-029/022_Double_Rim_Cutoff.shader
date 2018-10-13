Shader "Custom/020-029/022_Double_Rim_Cutoff"
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
            half dotp = dot(normalize(IN.viewDir), o.Normal);
            half rim = 1 - saturate(dotp);
            o.Emission = rim > 0.5 ? _SinTime : rim > 0.3 ? _CosTime : 0;   
        }
        ENDCG
    }
    Fallback "Diffuse"
}