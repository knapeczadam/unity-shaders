Shader "Custom/030-039/030_Specular"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _SpecGlossMap ("Specular (RGB) and Smoothness (A)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0.0, 1.0)) = 0.5
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf StandardSpecular
        
        fixed4 _Color;
        sampler2D _SpecGlossMap;
        half _Glossiness;
        
        struct Input
        {
            float2 uv_SpecGlossMap;
        };
        
        void surf(Input IN, inout SurfaceOutputStandardSpecular o) 
        {
            o.Albedo = _Color.rgb;
            fixed4 specGlossCol = tex2D(_SpecGlossMap, IN.uv_SpecGlossMap);
            o.Specular = specGlossCol.rgb;
            o.Smoothness = specGlossCol.a * _Glossiness;
        }
        ENDCG
    }
}   