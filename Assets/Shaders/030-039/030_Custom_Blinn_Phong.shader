Shader "Custom/030-039/030_Custom_Blinn_Phong"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf BasicBlinn
        
        fixed4 _Color;
        
        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half4 c;
            half3 h = normalize(lightDir + viewDir);
            half diff = saturate(dot(s.Normal, lightDir));
            float nh = saturate(dot(s.Normal, h));
            float spec = pow(nh, 48.0);
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
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