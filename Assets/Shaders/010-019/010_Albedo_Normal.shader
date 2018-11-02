Shader "Custom/010-019/010_Albedo_Normal"
{
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
            o.Albedo = o.Normal;
        }
        ENDCG
    }
}