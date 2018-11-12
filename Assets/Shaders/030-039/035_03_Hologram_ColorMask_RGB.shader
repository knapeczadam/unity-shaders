Shader "Custom/030-039/035_02_Hologram_ColorMask_RGB"
{
    Properties
    {
        _RimPow ("Rim power", Range(0.01, 10.0)) = 0.01
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Pass
        {
            ColorMask RGB
        }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        
        fixed _RimPow;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float rim = 1.0 - saturate(dot(IN.viewDir, o.Normal));
            rim = pow(rim, _RimPow * sin(_Time.w) * 0.5 + 0.5);
            o.Alpha = rim;
            o.Emission = _SinTime * rim;
        }
        ENDCG
    }
}