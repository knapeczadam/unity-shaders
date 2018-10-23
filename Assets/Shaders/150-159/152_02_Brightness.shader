Shader "Custom/150-159/152_02_Brightness"
{
    Properties 
    {
        [HideInInspector] _MainTex ("Base (RGB)", 2D) = "white" {}
		_Brightness ("Brightness", Range(0, 10)) = 1.0
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
            fixed _Brightness;
            
            fixed3 Brightness(fixed3 color, fixed brt)
			{
				return color * brt;
			}
    
            fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed4 renderTex = tex2D(_MainTex, i.uv);
				renderTex.rgb = Brightness(renderTex.rgb, _Brightness);
				return renderTex;
			}
            ENDCG
		}
	}
}