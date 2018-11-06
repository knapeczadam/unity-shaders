Shader "Custom/180-189/184_03_SGEL_Scrolling_Texture_Overlay"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _OverlayTex ("Overlay texture", 2D) = "white" {}
        _ScrollSpeed ("Scroll speed", Float) = 1.0
        _LerpAmount ("Lerp amount", Range(0.0, 1.0)) = 1.0
        
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard
        
        #include "UnityCG.cginc"
            
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _EmissionMap;
        sampler2D _MetallicGlossMap;
        
        sampler2D _OverlayTex;
        float _ScrollSpeed;
        float _LerpAmount;
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_OverlayTex;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed3 overlay = tex2D(_OverlayTex, IN.uv_OverlayTex + (_Time.y * _ScrollSpeed)).rgb;
            fixed3 mainTex = tex2D(_MainTex, IN.uv_MainTex).rgb; 
            o.Albedo = lerp(mainTex, overlay, _LerpAmount);
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Alpha = 1.0;
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb;
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}