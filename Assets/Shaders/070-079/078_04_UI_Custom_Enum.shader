Shader "Custom/070-079/078_04_UI_Custom_Enum"
{
    Properties
    {
        [Enum(One,1.0, Two,2.0, Three,3.0, Four,4.0, Five,5.0, Six,6.0, Seven,7.0)] _Value ("Name/value pairs", Float) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float _Value;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1.0 / _Value;
        }
        ENDCG
    }
}   