Shader "Custom/030-039/035_01_Hologram"
{
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            rim = pow(rim, 10 * abs(_SinTime.x));
            o.Emission = _SinTime * rim * 10;
            o.Alpha = rim;
        }
        ENDCG
    }
    Fallback "Diffuse"
}