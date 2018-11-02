Shader "Custom/170-179/177_Specular"
{
    Properties
    {
        _SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
        [PowerSlider(5.0)] _Shininess ("Shininess", Range (0.01, 1.0)) = 0.01
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf BlinnPhong
        
        half _Shininess;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Specular = _Shininess;
            o.Gloss = 1; 
        }
        ENDCG
    }
}