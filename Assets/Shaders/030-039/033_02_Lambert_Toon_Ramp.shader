Shader "Custom/030-039/033_02_Lambert_Toon_Ramp"
{
    Properties
    {
        _RampTex ("Ramp texture", 2D) = "white" {}
        _RampRange ("Ramp range", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _RampTex;
        fixed _RampRange;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float NdotV = dot(o.Normal, IN.viewDir) - _RampRange;
            o.Albedo = tex2D(_RampTex, float2(NdotV, NdotV)).rgb;
        }
        ENDCG
    }
}   