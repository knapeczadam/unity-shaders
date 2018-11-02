Shader "Custom/030-039/033_01_Custom_Toon_Ramp"
{
    Properties
    {
        _RampTex ("Ramp texture", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp
        
        sampler2D _RampTex;
        
        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float4 c;
            
            c.rgb = s.Albedo * _LightColor0.rgb;
            c.a = s.Alpha;
            
            return c;
        }
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float NdotV = dot(o.Normal, IN.viewDir);
            o.Albedo = tex2D(_RampTex, float2(NdotV, NdotV)).rgb;
        }
        ENDCG
    }
}   