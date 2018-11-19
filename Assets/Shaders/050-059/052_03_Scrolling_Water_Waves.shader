Shader "Custom/050-059/052_03_Scrolling_Water_Waves"
{
    Properties
    {
		_MainTex ("Water", 2D) = "white" {}
		_FoamTex ("Foam", 2D) = "white" {}
		_ScrollX ("Scroll X", Range(-1.0, 1.0)) = 0.0
        _ScrollY ("Scroll Y", Range(-1.0, 1.0)) = 0.0
	}
	
	SubShader 
	{
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 

		sampler2D _MainTex;
		sampler2D _FoamTex;
		float _ScrollX;
		float _ScrollY;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void vert(inout appdata_full v) 
		{
		    float3 p = v.vertex.xyz;
            p.y = sin(p.x + _Time.y);
			v.vertex.xyz = p;
        }

		void surf(Input IN, inout SurfaceOutput o) 
		{
			_ScrollX *= _Time.y;
			_ScrollY *= _Time.y;
			float2 scroll = float2(_ScrollX, _ScrollY);
			fixed4 water = tex2D(_MainTex, IN.uv_MainTex + scroll / 2.0);
			fixed4 foam = tex2D(_FoamTex, IN.uv_MainTex + scroll);
			o.Albedo = (water.rgb + foam.rgb) / 2.0;
		}
		ENDCG
	}
}