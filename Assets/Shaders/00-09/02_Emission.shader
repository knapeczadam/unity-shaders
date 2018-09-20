Shader "Custom/00-09/02_Emission"
{
    Properties
    {
        _Color ("Emission Color", Color) = (1, 1, 1, 1)
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
            o.Emission = _Color;        
        }
        ENDCG
    }
    Fallback "Diffuse"
}