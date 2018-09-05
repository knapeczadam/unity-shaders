Shader "Custom/01_06_Smearing"
{
    Properties
    {
        _Range ("Range", Range(0, 1)) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float _Range;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Range;        
        }
        ENDCG
    }
    Fallback "Diffuse"
}