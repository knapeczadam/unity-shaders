Shader "Custom/150-159/152_01_Saturation"
{
    Properties 
    {
        [HideInInspector] _MainTex ("Base (RGB)", 2D) = "white" {}
		_Saturation ("Saturation", Range(0, 10)) = 1.0
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
    
            sampler2D _MainTex;
            fixed _Saturation;
            
            fixed3 Saturation(fixed3 color, fixed sat)
			{
			    half3 LuminanceCoeff = unity_ColorSpaceLuminance.rgb;
			    fixed intensityf = dot(color, LuminanceCoeff);
				fixed3 intensity = intensityf;
				fixed3 satColor = lerp(intensity, color, sat);
				return satColor;
			}
    
            fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed4 renderTex = tex2D(_MainTex, i.uv);
				renderTex.rgb = Saturation(renderTex.rgb, _Saturation);
				return renderTex;
			}
            ENDCG
		}
	}
}