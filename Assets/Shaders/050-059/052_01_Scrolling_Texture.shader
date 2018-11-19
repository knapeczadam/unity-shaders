Shader "Custom/050-059/052_01_Scrolling_Texture"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _ScrollX ("Scroll X", Float) = 0.0
        _ScrollY ("Scroll Y", Float) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        float _ScrollX;
        float _ScrollY;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time.y;
            _ScrollY *= _Time.y;
            float2 scroll = float2(_ScrollX, _ScrollY);
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex + scroll).rgb;
        }
        ENDCG
    }
}   