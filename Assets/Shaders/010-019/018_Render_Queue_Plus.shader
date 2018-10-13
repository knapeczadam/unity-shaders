Shader "Custom/010-019/018_Render_Queue_Plus"
{
    Properties 
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        Tags { "Queue" = "Geometry+1" }
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