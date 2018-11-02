Shader "Custom/000-009/001_02_Red_Channel"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo.r = _Color.r;        
        }
        ENDCG
    }
}