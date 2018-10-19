Shader "Custom/140-149/146_Banded"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _NormalMap ("Normal map", 2D) = "bump" {}
        _LightSteps ("Light steps", Range(1.0, 256.0)) = 1.0
    }
	SubShader
	{
	    CGPROGRAM
	    #pragma surface surf Banded
	    
	    sampler2D _MainTex;
	    sampler2D _NormalMap;
	    fixed _LightSteps;
	    
	    fixed4 LightingBanded(SurfaceOutput s, half3 lightDir, half atten)
        {
            fixed4 c;
            fixed NdotL = saturate(dot(s.Normal ,lightDir));
            fixed lightBandsMultiplier = _LightSteps / 256;
            fixed lightBandsAdditive = _LightSteps / 2;
            fixed bandedNdotL = (floor((NdotL * 256 + lightBandsAdditive) / _LightSteps)) * lightBandsMultiplier;
            c.rgb = s.Albedo * _LightColor0.rgb * atten * bandedNdotL;
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