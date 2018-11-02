Shader "Custom/070-079/078_01_UI"
{
    Properties
    {
        [Toggle] _Invert ("Invert?", Float) = 0
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
                o.Albedo.rgb = 0;
            #else
                o.Albedo.rgb = 1;
            #endif
        }
        ENDCG
    }
}   