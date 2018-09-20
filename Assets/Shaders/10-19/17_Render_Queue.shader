Shader "Custom/10-19/17_Render_Queue"
{
    Properties 
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        Tags { "Queue" = "Geometry" }
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