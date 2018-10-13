Shader "Custom/090-099/090_MO_Power" 
{
	Properties
	{
		_MainTex ("Texture Sample", 2D) = "white" {}
		_Lower ("Lower than 1", Range(0.01, 1.0)) = 0.01
		_Higher ("Higher than 1", Range(1.01, 10.0)) = 1.01
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf StandardSpecular
		    
		sampler2D _MainTex;
		float _Lower;
		float _Higher;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandardSpecular o)
		{
			o.Albedo = pow(tex2D(_MainTex, IN.uv_MainTex), _Lower);
			o.Specular = pow(tex2D(_MainTex, IN.uv_MainTex), _Higher);
		}
		ENDCG
	}
}
