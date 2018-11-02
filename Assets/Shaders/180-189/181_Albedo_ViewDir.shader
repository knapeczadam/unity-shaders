Shader "Custom/180-189/181_Albedo_ViewDir"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = IN.viewDir;
        }
        ENDCG
    }
}