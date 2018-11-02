Shader "Custom/070-079/078_04_UI"
{
    Properties
    {
        [Enum(One,1, Two,2, Three,3, Four,4, Five,5, Six,6, Seven,7)] _Value ("Name/value pairs", Float) = 1
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed _Value;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1 / _Value;
        }
        ENDCG
    }
}   