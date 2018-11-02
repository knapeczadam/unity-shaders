Shader "Custom/000-009/002_Emission"
{
    Properties
    {
        _EmissionColor ("Emission Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _EmissionColor;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = _EmissionColor.rgb;        
        }
        ENDCG
    }
}