Shader "Custom/00-09/01_05_Swizzling"
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
            _Color = _Color.brga;
            o.Albedo = _Color;        
        }
        ENDCG
    }
    Fallback "Diffuse"
}