Shader "Custom/10-19/15_Z_Buffer_On"
{
    Properties 
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        ZWrite On
    
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = _Color;
        }
        ENDCG
    }
    Fallback "Diffuse"
}