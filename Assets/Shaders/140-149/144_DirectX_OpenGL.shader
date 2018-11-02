Shader "Custom/140-149/144_DirectX_OpenGL"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_TARGET
			{
                #if UNITY_UV_STARTS_AT_TOP
                    return fixed4(0, 1, 0, 1);
                #else
                    return fixed4(0, 0, 1, 1);
                #endif
			}
			ENDCG
		}
	}
}