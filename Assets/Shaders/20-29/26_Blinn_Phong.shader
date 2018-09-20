Shader "Custom/20-29/26_Blinn_Phong"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _SpecColor ("Specular color", Color) = (1, 1, 1, 1)
        _Spec ("Specular", Range(0, 1)) = 0.5
        _Gloss ("Glossiness", Range(0, 1)) = 0.5
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf BlinnPhong
        
        fixed4 _Color;
        half _Spec;
        fixed _Gloss;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = _Color;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   