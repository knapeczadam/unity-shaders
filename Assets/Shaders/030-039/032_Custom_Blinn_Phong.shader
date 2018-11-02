Shader "Custom/030-039/032_Custom_Blinn_Phong"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Shininess ("Shininess", Range (1.0, 100.0)) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf BasicBlinnPhong
        
        fixed4 _Color;
        half _Shininess;
        
        half4 LightingBasicBlinnPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half4 c;
            
            half3 h = normalize(lightDir + viewDir);
            half diff = saturate(dot(s.Normal, lightDir));
            float nh = saturate(dot(s.Normal, h));
            float spec = pow(nh, _Shininess);
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            
            return c;
        }
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color;
        }
        ENDCG
    }
}   