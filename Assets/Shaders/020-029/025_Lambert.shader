Shader "Custom/020-029/025_Lambert"
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
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
}   