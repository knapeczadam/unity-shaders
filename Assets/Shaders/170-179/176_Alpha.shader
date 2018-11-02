Shader "Custom/170-179/176_Alpha"
{
    Properties
    {
        _Alpha ("Alpha", Range(0, 1)) = 1
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert alpha
        
        fixed _Alpha;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Alpha = _Alpha;        
        }
        ENDCG
    }
}