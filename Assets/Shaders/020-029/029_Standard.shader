Shader "Custom/020-029/029_Standard"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _MetallicGlossMap ("Metallic (R) and Smoothness (A)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0.0, 1.0)) = 0.5
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Standard
        
        fixed4 _Color;
        sampler2D _MetallicGlossMap;
        half _Glossiness;
        
        struct Input
        {
            float2 uv_MetallicGlossMap;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o) 
        {
            o.Albedo = _Color.rgb;
            fixed4 metallicGlossCol = tex2D(_MetallicGlossMap, IN.uv_MetallicGlossMap);
            o.Metallic = metallicGlossCol.r;
            o.Smoothness = metallicGlossCol.a * _Glossiness;
        }
        ENDCG
    }
}   