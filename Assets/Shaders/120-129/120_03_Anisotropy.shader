Shader "Custom/120-129/120_03_Anisotropy"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _MainTex ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
        _SpecularTex ("Specular (R) Gloss (G) Anisotropic Mask (B)", 2D) = "gray" {}
        _BumpMap ("Normal (Normal)", 2D) = "bump" {}
        _AnisoTex ("Anisotropic Direction (Normal)", 2D) = "bump" {}
        _AnisoOffset ("Anisotropic Highlight Offset", Range(-1.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Aniso
        
        sampler2D _MainTex;
        sampler2D _SpecularTex;
        sampler2D _BumpMap; 
        sampler2D _AnisoTex;
        float _AnisoOffset; 
        
        struct SurfaceOutputAniso
        {
            fixed3 Albedo;
            fixed3 Normal;
            half3 Emission;
            fixed Alpha;
            half Specular;
            fixed Gloss;
            fixed4 AnisoDir;
        };
        
        fixed4 LightingAniso(SurfaceOutputAniso s, fixed3 lightDir, fixed3 viewDir, fixed atten)
        {
            fixed4 c;
            fixed3 h = normalize(lightDir + viewDir);
            float NdotL = saturate(dot(s.Normal, lightDir));
            fixed HdotA = dot(normalize(s.Normal + s.AnisoDir.rgb), h);
            float aniso = saturate(sin(radians((HdotA + _AnisoOffset) * 180)));
            float spec = saturate(dot(s.Normal, h));
            spec = saturate(pow(lerp(spec, aniso, s.AnisoDir.a), s.Gloss * 128) * s.Specular);
            c.rgb = ((s.Albedo * _LightColor0.rgb * NdotL) + (_LightColor0.rgb * spec)) * atten;
            c.a = s.Alpha;
            return c;
        }
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_AnisoTex;
        };
        
        void surf(Input IN, inout SurfaceOutputAniso o)
        {
            fixed4 albedo = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = albedo.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Alpha = albedo.a;
            fixed3 spec = tex2D(_SpecularTex, IN.uv_MainTex).rgb;
            o.Specular = spec.r;
            o.Gloss = spec.g;
            o.AnisoDir = fixed4(UnpackNormal(tex2D(_AnisoTex, IN.uv_AnisoTex)), spec.b);
        }
        ENDCG
    }
}