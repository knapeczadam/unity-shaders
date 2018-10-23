Shader "Custom/150-159/152_03_Contrast"
{
    Properties 
    {
        [HideInInspector] _MainTex ("Base (RGB)", 2D) = "white" {}
		_Contrast ("Contrast", Range(0, 10)) = 1.0
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
            fixed _Contrast;
            
            fixed3 Contrast(fixed3 color, fixed con)
			{
			    fixed3 AvgLumin = unity_ColorSpaceGrey.rgb;
			    fixed3 conColor = lerp(AvgLumin, color, con);
				return conColor;
			}
    
            fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed4 renderTex = tex2D(_MainTex, i.uv);
				renderTex.rgb = Contrast(renderTex.rgb, _Contrast);
				return renderTex;
			}
            ENDCG
		}
	}
}