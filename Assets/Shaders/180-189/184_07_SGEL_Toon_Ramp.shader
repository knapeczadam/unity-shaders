Shader "Custom/180-189/184_07_SGEL_Toon_Ramp"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _LightDir ("Light direction", Vector) = (1, 1, 1, 1)
        _RampTex ("Ramp texture", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Unlit
        
        sampler2D _MainTex;
        sampler2D _EmissionMap;
        float4 _LightDir;
        sampler2D _RampTex;
        
        inline half4 LightingUnlit(SurfaceOutput s, half3 lightDir, half atten)
		{
			return half4 (0, 0, 0, s.Alpha);
		}
		
		float remap(float inVal, float2 inMinMax, float2 outMinMax)
		{
		    return outMinMax.x + (inVal - inMinMax.x) * (outMinMax.y - outMinMax.x) / (inMinMax.y - inMinMax.x);
		}
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 mainCol = tex2D(_MainTex, IN.uv_MainTex);
            float2 rampUV = remap(dot(o.Normal, _LightDir.xyz), float2(-1.0, 1.0), float2(0.0, 1.0));
            fixed4 rampCol = tex2D(_RampTex, rampUV); 
            o.Albedo = mainCol.rgb * rampCol.rgb + tex2D(_EmissionMap, IN.uv_MainTex).rgb;
            o.Alpha = 1.0;
        }
        ENDCG
    }
}