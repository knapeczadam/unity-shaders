Shader "Custom/100-109/105_MO_Sign" 
{
	SubShader
	{
		CGPROGRAM
		#pragma surface surf Unlit
		
		inline half4 LightingUnlit(SurfaceOutput s, half3 lightDir, half atten)
		{
			return half4 (0, 0, 0, s.Alpha);
		}

		struct Input
		{
			float3 worldPos;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
            o.Emission = sign(IN.worldPos.x * IN.worldPos.z);
		}
		ENDCG
	}
}
