Shader "Custom/140-149/149_Camera_Depth"
{
    Properties 
	{
		_DepthPower("Depth Power", Range(0.0, 1.0)) = 1.0
	}

	SubShader 
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			fixed _DepthPower;
			sampler2D _CameraDepthTexture;

			fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, i.uv.xy);
				return pow(Linear01Depth(depth), _DepthPower);
			}
		ENDCG
		}
	}
}