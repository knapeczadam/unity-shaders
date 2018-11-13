Shader "Custom/070-079/078_01_UI_Simple_Toggle"
{
    Properties
    {
        [Toggle] _Invert ("Invert?", Float) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature _INVERT_ON
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            #if _INVERT_ON
                o.Albedo = 0;
            #else
                o.Albedo = 1;
            #endif
        }
        ENDCG
    }
}   