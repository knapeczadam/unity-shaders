Shader "Custom/020-029/026_Blinn_Phong"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
        [PowerSlider(5.0)] _Shininess ("Shininess", Range (0.01, 1.0)) = 0.01
        _Gloss ("Glossiness", Range(0.0, 1.0)) = 0.5
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf BlinnPhong
        
        fixed4 _Color;
        half _Shininess;
        fixed _Gloss;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = _Color;
            o.Specular = _Shininess;
            o.Gloss = _Gloss;
        }
        ENDCG
    }
}   