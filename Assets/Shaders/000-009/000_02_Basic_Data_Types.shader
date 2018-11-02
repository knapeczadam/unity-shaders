Shader "Custom/000-009/000_02_Basic_Data_Types"
{   
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float _32Bits;
        half _16Bits;
        fixed _11Bits;
        int _integer;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
}