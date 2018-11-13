Shader "Custom/050-059/053_02_Plasma_VF"
{
    SubShader
	{
	    Pass
		{
		    CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 vertexColor: COLOR0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col;
				UNITY_INITIALIZE_OUTPUT(fixed4, col);

				const float PI = UNITY_PI;
	            float _Speed = 10 ;
                _CosTime *= 40;
                
                float _Scale1 = abs(_CosTime.x);
                float _Scale2 = abs(_CosTime.y);
                float _Scale3 = abs(_CosTime.z);
                float _Scale4 = abs(_CosTime.w);

	            float t = _Time.x * _Speed;
	            
	            float xpos = i.vertex.x * 0.001;
	            float ypos = i.vertex.y * 0.001;
	          
	            //vertical
	            float c = sin(xpos * _Scale1 + t);

	            //horizontal
	            c += sin(ypos * _Scale2 + t);

	            //diagonal
	            c += sin(_Scale3 * ( xpos * sin(t / 2.0) + ypos * cos(t / 3)) + t);

	            //circular
	            float c1 = pow(xpos + 0.5 * sin(t / 5), 2);
	            float c2 = pow(ypos + 0.5 * cos(t / 3), 2);
	            c += sin(sqrt(_Scale4 * (c1 + c2) + 1 + t));

	            col.r = sin(c / 4.0 * PI);
	            col.g = sin(c / 4.0 * PI + 2 * PI / 4);
	            col.b = sin(c / 4.0 * PI + 4 * PI / 4);
				return col;
			}
			ENDCG
		}
	}
}   