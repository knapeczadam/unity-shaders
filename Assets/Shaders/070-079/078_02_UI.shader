Shader "Custom/070-079/078_02_UI"
{
    Properties
    {
        [Toggle(ENABLE_FANCY)] _Fancy ("Fancy?", Float) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature ENABLE_FANCY
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            #if ENABLE_FANCY
                o.Albedo = abs(_SinTime);
            #else
                o.Albedo = 0.5;
            #endif
        }
        ENDCG
    }
    Fallback "Diffuse"
}   