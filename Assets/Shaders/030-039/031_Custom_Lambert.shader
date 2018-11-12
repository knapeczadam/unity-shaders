Shader "Custom/030-039/031_Custom_Lambert"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf BasicLambert
        
        fixed4 _Color;
        
        fixed4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            fixed4 c;
            
            half NdotL = dot(s.Normal, lightDir);
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            
            return c;
        }
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
}   