Shader "Custom/050-059/052_02_Scrolling_Water"
{
    Properties
    {
        _MainTex ("Water", 2D) = "white" {}
        _FoamTex ("Foam", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-1.0, 1.0)) = 0.0
        _ScrollY ("Scroll Y", Range(-1.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _FoamTex;
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
            fixed4 water = tex2D(_MainTex, IN.uv_MainTex + scroll / 2.0);
            fixed4 foam = tex2D(_FoamTex, IN.uv_MainTex + scroll);
            o.Albedo = water.rgb * foam.rgb;
        }
        ENDCG
    }
}   