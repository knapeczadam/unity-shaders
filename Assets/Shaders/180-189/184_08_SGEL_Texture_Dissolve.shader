Shader "Custom/180-189/184_08_SGEL_Texture_Dissolve"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _DissolveTex ("Dissolve texture", 2D) = "white" {}
        _DissolveAmount ("Dissolve amount", Range(0.0, 1.0)) = 1.0
        _EdgeColor ("Edge color", Color) = (1, 1, 1, 1)
        _EdgeWidth ("Edge width", Float) = 1.0
    }
    
    SubShader
    {
        Cull Off
        
        CGPROGRAM
        #pragma surface surf Standard
        
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _EmissionMap;
        sampler2D _MetallicGlossMap;
        
        sampler2D _DissolveTex;
        float _DissolveAmount;
        fixed4 _EdgeColor;
        float _EdgeWidth;
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DissolveTex;
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed dissolveCol = tex2D(_DissolveTex, IN.uv_DissolveTex).r;
            fixed dissolveTreshold = step(dissolveCol, _DissolveAmount);
            _EdgeColor *= (step(dissolveCol, _DissolveAmount + _EdgeWidth) - dissolveTreshold);
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb + _EdgeColor.rgb;
            o.Alpha = 0.5;
            clip(o.Alpha - dissolveTreshold);
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}