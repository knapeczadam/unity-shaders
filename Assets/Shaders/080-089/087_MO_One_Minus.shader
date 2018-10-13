Shader "Custom/080-089/087_MO_One_Minus" 
{
	Properties
	{
		_MainTex ("Texture Sample", 2D) = "white" {}
		[Toggle] _Inverse ("Inverse", Float) = 0
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Standard
		#pragma shader_feature _INVERSE_ON 
		
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			#if _INVERSE_ON
			    o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            #else
                o.Albedo = 1.0 - tex2D(_MainTex, IN.uv_MainTex);
            #endif
		}
		ENDCG
	}
}
