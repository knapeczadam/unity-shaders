// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Custom/160-169/164_07_Reflective_Parallax_Specular" 
{
    Properties 
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
        [PowerSlider(5.0)] _Shininess ("Shininess", Range (0.01, 1)) = 0.078125
        _ReflectColor ("Reflection Color", Color) = (1, 1, 1, 0.5)
        _Parallax ("Height", Range (0.005, 0.08)) = 0.02
        _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
        _Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
        _BumpMap ("Normalmap", 2D) = "bump" { }
        _ParallaxMap ("Heightmap (A)", 2D) = "black" {}
    }
    
    SubShader 
    {
        Tags { "RenderType" = "Opaque" }
        
        LOD 600
    
        CGPROGRAM
        #pragma surface surf BlinnPhong
        #pragma target 3.0
        
        fixed4 _Color;
        half _Shininess;
        fixed4 _ReflectColor;
        float _Parallax;
        sampler2D _MainTex;
        samplerCUBE _Cube;
        sampler2D _BumpMap;
        sampler2D _ParallaxMap;
        
        struct Input 
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 worldRefl;
            float3 viewDir;
            INTERNAL_DATA
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            half h = tex2D(_ParallaxMap, IN.uv_BumpMap).w;
            float2 offset = ParallaxOffset(h, _Parallax, IN.viewDir);
            IN.uv_MainTex += offset;
            IN.uv_BumpMap += offset;
        
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = tex.rgb * _Color.rgb;
            o.Gloss = tex.a;
            o.Specular = _Shininess;
        
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
        
            float3 worldRefl = WorldReflectionVector(IN, o.Normal);
            fixed4 reflcol = texCUBE(_Cube, worldRefl);
            reflcol *= tex.a;
            o.Emission = reflcol.rgb * _ReflectColor.rgb;
            o.Alpha = reflcol.a * _ReflectColor.a;
        }
        ENDCG
    }
    FallBack "Legacy Shaders/Reflective/Bumped Specular"
}