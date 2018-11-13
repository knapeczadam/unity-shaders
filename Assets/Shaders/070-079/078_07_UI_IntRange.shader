Shader "Custom/070-079/078_07_UI_IntRange"
{
    Properties
    {
        [IntRange] _Alpha1 ("Alpha 1", Range(0.0, 255.0)) = 0.0
        _Alpha2 ("Alpha 2", Range(0.0, 255.0)) = 0.0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        
        fixed _Alpha1;
        fixed _Alpha2;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1;
            o.Alpha = (_Alpha1 / 255.0) * (_Alpha2 / 255.0);
        }
        ENDCG
    }
}   