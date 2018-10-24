Shader "Custom/150-159/153_Blending"
{
    Properties 
    {
        [HideInInspector] _MainTex ("Base (RGB)", 2D) = "white" {}
        _Layer ("Layer", 2D) = "white" {}
		[KeywordEnum(Add, Subtract, ReverseSubtract, Min, Max, Multiply, Screen, Overlay, Darken, Lighten, ColorDodge, ColorBurn, HardLight, SoftLight, Difference, Exclusion)] _BlendOp ("Blend operation", Int) = 0
		_Opacity ("Opacity", Range(0, 1)) = 1.0
	}
	
	SubShader 
	{
	    Pass
	    {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma shader_feature _BLENDOP_ADD _BLENDOP_SUBTRACT _BLENDOP_REVERSESUBTRACT _BLENDOP_MIN _BLENDOP_MAX _BLENDOP_MULTIPLY _BLENDOP_SCREEN _BLENDOP_OVERLAY _BLENDOP_DARKEN _BLENDOP_LIGHTEN _BLENDOP_COLORDODGE _BLENDOP_COLORBURN _BLENDOP_HARDLIGHT _BLENDOP_SOFTLIGHT _BLENDOP_DIFFERENCE _BLENDOP_EXCLUSION
            
            #include "UnityCG.cginc"
            #include "153_Blending.cginc"
    
            sampler2D _MainTex;
            sampler2D _Layer;
            fixed _Opacity;
            
            fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed3 b = tex2D(_MainTex, i.uv).rgb;
				fixed3 s = tex2D(_Layer, i.uv).rgb;
				fixed3 r;
				
				#if _BLENDOP_ADD
				    r = bo_add(b, s);
				#elif _BLENDOP_SUBTRACT
				    r = bo_subtract(b, s);
				#elif  _BLENDOP_REVERSESUBTRACT
				    r = bo_reverseSubtract(b, s);
				#elif _BLENDOP_MIN
				    r = bo_min(b, s);
				#elif _BLENDOP_MAX
				    r = bo_max(b, s);
				#elif _BLENDOP_MULTIPLY
				    r = bo_multiply(b, s);
				#elif _BLENDOP_SCREEN
				    r = bo_screen(b, s);
				#elif _BLENDOP_OVERLAY
				    r = bo_overlay(b, s);
				#elif _BLENDOP_DARKEN
				    r = bo_darken(b, s);
				#elif _BLENDOP_LIGHTEN
				    r = bo_lighten(b, s);
				#elif _BLENDOP_COLORDODGE
				    r = bo_colorDodge(b, s);
				#elif _BLENDOP_COLORBURN
				    r = bo_colorBurn(b, s);
				#elif _BLENDOP_HARDLIGHT
				    r = bo_hardLight(b, s);
				#elif _BLENDOP_SOFTLIGHT
				    r = bo_softLight(b, s);
				#elif _BLENDOP_DIFFERENCE
				    r = bo_difference(b, s);
				#elif _BLENDOP_EXCLUSION
				    r = bo_exclusion(b, s);
				#endif
				
				fixed3 renderTex = lerp(b, r, _Opacity);
				return fixed4(renderTex, 1);
			}
            ENDCG
		}
	}
}