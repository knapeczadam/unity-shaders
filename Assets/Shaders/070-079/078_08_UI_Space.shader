Shader "Custom/070-079/078_08_UI_Space"
{
    Properties
    {
        _Prop1 ("Prop1", Int) = 0
        [Space] _Prop2 ("Prop2 - Space before me", Float) = 0.0
        _Prop3 ("Prop3", Float) = 0.0
        [Space] _Prop4 ("Prop4 - Space before me", Float) = 0.0
        _Prop5 ("Prop5", Range(0, 1)) = 0
        [Space(1000)] _Prop6 ("Prop6 - Large space before me", 2D) = "white" {}
        _Prop7 ("Prop7", Range(0, 1)) = 0
        _Prop9 ("Prop8", Float) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1;
        }
        ENDCG
    }
}   