Shader "Custom/010-019/014_Albedo_Normal_WorldRefl"
{
    Properties 
    {
        _BumpMap ("Bump Texture", 2D) = "bump" {}
        _EnvMap ("Environment Map", CUBE) = "" {}
        [Toggle(SWITCH_ORDER)] _switchOrder("Switch order", Float) = 0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        #pragma shader_feature SWITCH_ORDER
        
        sampler2D _BumpMap;
        samplerCUBE _EnvMap;

        struct Input
        {
            float2 uv_BumpMap;
            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            #if SWITCH_ORDER
                o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)) * (_SinTime.w * 0.5 + 0.5);
                o.Albedo = texCUBE(_EnvMap, WorldReflectionVector(IN, o.Normal)).rgb;
            #else
                o.Albedo = texCUBE(_EnvMap, WorldReflectionVector(IN, o.Normal)).rgb;
                o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)) * (_SinTime.w * 0.5 + 0.5);
            #endif
        }
        ENDCG
    }
}