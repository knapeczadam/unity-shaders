Shader "Custom/070-079/078_06_UI_PowerSlider"
{
    Properties
    {
        _Color ("Linear", Range(0.0, 1.0)) = 0.0
        [PowerSlider(1)] _Color1 ("Non-linear - pow(x, 1)", Range(0.0, 1.0)) = 0.0
        [PowerSlider(2)] _Color2 ("Non-linear - pow(x, 2)", Range(0.0, 1.0)) = 0.0
        [PowerSlider(3)] _Color3 ("Non-linear - pow(x, 3)", Range(0.0, 1.0)) = 0.0
        [PowerSlider(4)] _Color4 ("Non-linear - pow(x, 4)", Range(0.0, 1.0)) = 0.0
        [PowerSlider(5)] _Color5 ("Non-linear - pow(x, 5)", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed _Color2;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color2;
        }
        ENDCG
    }
}   