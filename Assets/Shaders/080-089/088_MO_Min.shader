Shader "Custom/080-089/088_MO_Min" 
{
	Properties
	{
		_MainTex ("Texture Sample", 2D) = "white" {}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Standard
		
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
            o.Albedo = min(tex2D(_MainTex, IN.uv_MainTex), 0.5);
		}
		ENDCG
	}
}
