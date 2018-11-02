Shader "Custom/050-059/052_01_Scrolling_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-1000, 1000)) = 0
        _ScrollY ("Scroll Y", Range(-1000, 1000)) = 0
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
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            float2 newUv = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
            o.Albedo = tex2D(_MainTex, newUv);
        }
        ENDCG
    }
}   