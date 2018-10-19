Shader "Custom/140-149/148_Oren_Nayer"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Roughness ("Roughness", Range(0.0, 1.0)) = 1.0
    }
	SubShader
	{
	    CGPROGRAM
	    #pragma surface surf OrenNayer
	    
	    fixed4 _Color;
	    fixed _Roughness;
	    
	    fixed4 LightingOrenNayer(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            fixed4 c;
            fixed roughness = _Roughness;
            fixed roughnessSqr = roughness * roughness;
            fixed3 o_n_fraction = roughnessSqr / (roughnessSqr + fixed3(0.33, 0.13, 0.09));
            fixed3 oren_nayar = fixed3(1, 0, 0) + fixed3(-0.5, 0.17, 0.45) * o_n_fraction;
            fixed cos_ndotl = saturate(dot(s.Normal, lightDir));
            fixed cos_ndotv = saturate(dot(s.Normal, viewDir));
            fixed oren_nayar_s = saturate(dot(lightDir, viewDir)) - cos_ndotl * cos_ndotv;
            oren_nayar_s /= lerp(max(cos_ndotl, cos_ndotv), 1, step(oren_nayar_s, 0));
            fixed3 oren_nayar_final = cos_ndotl * (oren_nayar.x + s.Albedo * oren_nayar.y + oren_nayar.z * oren_nayar_s);
            c.rgb = s.Albedo * _LightColor0.rgb * atten * oren_nayar_final;
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
}