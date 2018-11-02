Shader "Custom/020-029/020_Rim_Lighting"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _RimPow ("Rim power", Range(0.01, 10.0)) = 0.01
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        fixed _RimPow;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            float rim = 1.0 - saturate(dot(IN.viewDir, o.Normal));
            o.Emission = _Color  * pow(rim, _RimPow * (sin(_Time.w) * 0.5 + 0.5));   
        }
        ENDCG
    }
}