Shader "Custom/180-189/184_02_SGEL_Color_Rim"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _RimColor ("Rim color", Color) = (1, 1, 1, 1)
        _RimPower ("Rim power", Float) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard
        
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _EmissionMap;
        sampler2D _MetallicGlossMap;
        
        fixed4 _RimColor;
        float _RimPower;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Alpha = 1.0;
            float rim = 1.0 - dot(o.Normal, IN.viewDir);
            rim = smoothstep(1.0 - _RimPower, 1.0, rim);
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb + _RimColor.rgb * rim;
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}