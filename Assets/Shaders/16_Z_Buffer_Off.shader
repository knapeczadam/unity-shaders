Shader "Custom/16_Z_Buffer_Off"
{
    Properties 
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        ZWrite Off
    
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