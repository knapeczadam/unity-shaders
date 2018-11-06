Shader "Custom/180-189/184_09_SGEL_Hologram"
{
    Properties
    {
        _HologramTint ("Hologram tint", Color) = (1, 1, 1, 1)
        _HologramTex ("Hologram texture", 2D) = "white" {}
        _Speed ("Hologram texture scroll speed", Float) = 1.0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        CGPROGRAM
        #pragma surface surf StandardSpecular alpha:blend
        
        fixed4 _HologramTint;
        sampler2D _HologramTex;
        float4 _HologramTex_ST;
        float _Speed;
        
        struct Input
        {
            float2 uv_HologramTex;
            float4 screenPos;
        };
        
        void surf(Input IN, inout SurfaceOutputStandardSpecular o)
        {
            float2 screenUV = IN.screenPos.xy / max(IN.screenPos.w, 1);
            screenUV *= _HologramTex_ST.xy;
            fixed4 hologramCol = tex2D(_HologramTex, screenUV + (_Speed * _Time.y));
            _HologramTint *= (1.0 - hologramCol); 
            o.Albedo = _HologramTint.rgb;
            o.Emission = _HologramTint.rgb;
            o.Alpha = hologramCol.r;
            o.Specular = 0.5;
        }
        ENDCG
    }
}