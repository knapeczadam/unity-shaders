Shader "Custom/180-189/184_06_SGEL_Snow"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _SnowColor ("Snow color", Color) = (1, 1, 1, 1)
        _SnowDir ("Snow direction", Vector) = (1, 1, 1, 1)
        _SnowDepth ("Snow depth",   Float) = 1.0
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
        
        fixed4 _SnowColor;
        float4 _SnowDir;
        float _SnowDepth;
        float _RimPower;
        
        float fresnelEffect(float3 normal, float3 viewDir, float power)
        {
            return pow(1.0 - saturate(dot(normalize(normal), normalize(viewDir))), power);
        }
        
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir; 
            float3 worldNormal; INTERNAL_DATA 
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            float3 worldNormal = WorldNormalVector(IN, o.Normal);
            o.Alpha = 1.0;
            _SnowColor  *= step(_SnowDepth, dot(worldNormal, _SnowDir.xyz));
            fixed4 rimColor = fixed4(1, 1, 1, 1) * fresnelEffect(worldNormal, IN.viewDir, _RimPower);
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb + (_SnowColor.rgb * rimColor.rgb);
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}