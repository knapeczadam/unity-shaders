Shader "Custom/000-009/001_04_Blue_Channel"
{
    Properties
    {
        _Color ("Albedo Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo.b = _Color.b;        
        }
        ENDCG
    }
    Fallback "Diffuse"
}