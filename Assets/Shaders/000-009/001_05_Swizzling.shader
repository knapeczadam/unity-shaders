Shader "Custom/000-009/001_05_Swizzling"
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
            _Color = _Color.brga;
            o.Albedo = _Color;        
        }
        ENDCG
    }
}