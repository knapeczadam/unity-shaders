Shader "Custom/140-149/147_Minnaert"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _NormalMap ("Normal map", 2D) = "bump" {}
        _Roughness ("Roughness", Range(1.0, 10.0)) = 1.0
    }
	SubShader
	{
	    CGPROGRAM
	    #pragma surface surf Minnaert
	    
	    fixed4 _Color;
	    sampler2D _NormalMap;
	    fixed _Roughness;
	    
	    fixed4 LightingMinnaert(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            fixed4 c;
            fixed NdotL = saturate(dot(s.Normal, lightDir));
            fixed NdotV = saturate(dot(s.Normal, viewDir));
            fixed3 minnaert = saturate(NdotL * pow(NdotL * NdotV, _Roughness));
            c.rgb = s.Albedo * _LightColor0.rgb * atten * minnaert;
            c.a = s.Alpha;
            return c;
        }
        
	    struct Input
        {
            float2 uv_NormalMap;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
        }
        ENDCG
	}
}