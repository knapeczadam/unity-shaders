Shader "Custom/140-149/145_Half_Lambert"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _NormalMap ("Normal map", 2D) = "bump" {}
        _DiffuseWrap ("Wrap value", Range(0.5, 1.0)) = 0.5
    }
	SubShader
	{
	    CGPROGRAM
	    #pragma surface surf HalfLambert
	    
	    sampler2D _MainTex;
	    sampler2D _NormalMap;
	    fixed _DiffuseWrap;
	    
	    fixed4 LightingHalfLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            fixed4 c;
            fixed NdotL = saturate(dot(s.Normal ,lightDir));
            fixed halfDiff = pow(NdotL * _DiffuseWrap + (1 - _DiffuseWrap), 2);
            c.rgb = s.Albedo * halfDiff * atten;
            c.a = s.Alpha;
            return c;
        }
        
	    struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
        }
        ENDCG
	}
}