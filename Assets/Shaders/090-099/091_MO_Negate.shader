Shader "Custom/090-099/091_MO_Neg" 
{
	Properties
	{
		[Toggle] _Inverse ("Inverse", Float) = 0
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Unlit
		#pragma shader_feature _INVERSE_ON
		
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
			#if _INVERSE_ON
                o.Emission = (IN.worldPos.x * IN.worldPos.z);
            #else
                o.Emission = -(IN.worldPos.x * IN.worldPos.z);
            #endif
		}
		ENDCG
	}
}
