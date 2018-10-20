Shader "Custom/120-129/129_02_Grayscale_RenderTexture"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Luminosity ("Luminosity", Range(0.0, 1.0)) = 1.0
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
            fixed _Luminosity;
            
            fixed grayScale(fixed3 c)
            {
                return c.r * 0.299 + c.g * 0.587 + c.b * 0.114;
            }
            
            fixed4 frag(v2f_img i) : SV_TARGET
            {
                fixed4 renderTex = tex2D(_MainTex, i.uv);
                fixed luminosity = grayScale(renderTex.rgb);
                fixed4 finalColor = lerp(renderTex, luminosity, _Luminosity);
                renderTex.rgb = finalColor.rgb; 
                return renderTex;
            }
            ENDCG
        }
    }
}