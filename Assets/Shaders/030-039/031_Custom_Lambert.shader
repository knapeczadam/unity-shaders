Shader "Custom/020-029/031_Custom_Lambert"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf BasicLambert
        
        fixed4 _Color;
        
        half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            half4 c;
            half NdotL = dot(s.Normal, lightDir);
            c.rgb = s.Albedo * _LightColor0 * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   