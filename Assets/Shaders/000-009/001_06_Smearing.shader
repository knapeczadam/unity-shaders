Shader "Custom/000-009/001_06_Smearing"
{
    Properties
    {
        _Color ("Main Color", Range(0.0, 1.0)) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed _Color;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color;        
        }
        ENDCG
    }
}