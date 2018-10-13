Shader "Custom/030-039/031_02_Lambert_Toon_Ramp"
{
    Properties
    {
        _RampTex ("Ramp texture", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _RampTex;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float diff = dot (o.Normal, IN.viewDir);
            float h = diff - 0.1;
            float2 rh = h;
            o.Albedo = tex2D(_RampTex, rh);
        }
        ENDCG
    }
    Fallback "Diffuse"
}   