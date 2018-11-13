Shader "Custom/050-059/052_03_Scrolling_Water_Waves"
{
    Properties
    {
		_MainTex ("Water", 2D) = "white" {}
		_FoamTex ("Foam", 2D) = "white" {}
		_ScrollX ("Scroll X", Range(-5, 5)) = 1
		_ScrollY ("Scroll Y", Range(-5, 5)) = 1
		_Freq ("Frequency", Range(0, 5)) = 1
      	_Speed ("Speed", Range(0, 100)) = 1
      	_Amp ("Amplitude", Range(0, 1)) = 1
	}
	
	SubShader 
	{
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 

		sampler2D _MainTex;
		sampler2D _FoamTex;
		float _ScrollX;
		float _ScrollY;
		float _Freq;
      	float _Speed;
      	float _Amp;

		struct Input 
		{
			float2 uv_MainTex;
			float3 vertColor;
		};

		struct appdata 
		{
		    float4 vertex: POSITION;
		    float3 normal: NORMAL;
		    float4 texcoord: TEXCOORD0;
		    float4 texcoord1: TEXCOORD2;
		    float4 texcoord2: TEXCOORD3;
        };

		void vert(inout appdata v, out Input o) 
		{
		    UNITY_INITIALIZE_OUTPUT(Input, o);
		    float t = _Time * _Speed;
		    
		    //float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp;
		    float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t * 2 + v.vertex.x * _Freq * 2) * _Amp;
		    float waveHeightZ = sin(t + v.vertex.z * _Freq) * _Amp + sin(t * 2 + v.vertex.z * _Freq * 2) * _Amp;
		    
		    //v.vertex.y = v.vertex.y + waveHeight;
		    v.vertex.y = v.vertex.y + waveHeight + waveHeightZ;
		    
		    v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
		    
		    //o.vertColor = 1;
		    //o.vertColor = waveHeight + 2;
        }

		void surf(Input IN, inout SurfaceOutput o) 
		{
			_ScrollX *= _Time.x;// * _Speed;
			_ScrollY *= _Time.y;// * _Speed;
			float3 water = tex2D(_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY));
			float3 foam = tex2D(_FoamTex, IN.uv_MainTex + float2(_ScrollX / 2.0, _ScrollY / 2.0));
			o.Albedo = (water + foam) / 2.0;
		}
		ENDCG
	}
}