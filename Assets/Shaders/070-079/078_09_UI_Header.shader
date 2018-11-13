Shader "Custom/070-079/078_09_UI_Header"
{
    Properties
    {
        [Header(Group 1)] _Prop1 ("Prop1", Float) = 0.0
        [Header(Group 2)] _Prop2 ("Prop2", Range(0, 1)) = 0
        [Header(Group 3)] _Prop3 ("Prop3", 2D) = "white" {}
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