Shader "Custom/40-49/46_Extrude"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        fixed4 _Color;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color;
        }
        
        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * abs(_SinTime.w) * 0.1;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   