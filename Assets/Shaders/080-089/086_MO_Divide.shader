Shader "Custom/080-089/086_MO_Divide" 
{
	Properties
	{
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		_Tex1("Texture Sample 1", 2D) = "white" {}
		_Tex2("Texture Sample 2", 2D) = "white" {}
		[Toggle] _Inverse ("Inverse", Float) = 0
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Standard
		#pragma shader_feature _INVERSE_ON 
		
		sampler2D _Tex1;
		float4 _Tex1_ST;
		sampler2D _Tex2;
		float4 _Tex2_ST;

		struct Input
		{
			float2 uv_texcoord;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float2 uv_Tex1 = IN.uv_texcoord * _Tex1_ST.xy + _Tex1_ST.zw;
			float2 uv_Tex2 = IN.uv_texcoord * _Tex2_ST.xy + _Tex2_ST.zw;
			#if _INVERSE_ON
			    o.Albedo = tex2D(_Tex1, uv_Tex1) / tex2D( _Tex2, uv_Tex2);
            #else
                o.Albedo = tex2D( _Tex2, uv_Tex2) / tex2D(_Tex1, uv_Tex1);
            #endif
		}
		ENDCG
	}
}
