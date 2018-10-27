// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Custom/160-169/164_04_Reflective_Bumped_Diffuse" 
{
    Properties 
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _ReflectColor ("Reflection Color", Color) = (1, 1, 1, 0.5)
        _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
        _Cube ("Reflection Cubemap", Cube) = "_Skybox" { }
        _BumpMap ("Normalmap", 2D) = "bump" {}
    }
    
    SubShader 
    {
        Tags { "RenderType" = "Opaque" }
        
        LOD 300
    
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        fixed4 _ReflectColor;
        sampler2D _MainTex;
        samplerCUBE _Cube;
        sampler2D _BumpMap;
        
        struct Input 
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 worldRefl;
            INTERNAL_DATA
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 c = tex * _Color;
            o.Albedo = c.rgb;
        
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
        
            float3 worldRefl = WorldReflectionVector(IN, o.Normal);
            fixed4 reflcol = texCUBE(_Cube, worldRefl);
            reflcol *= tex.a;
            o.Emission = reflcol.rgb * _ReflectColor.rgb;
            o.Alpha = reflcol.a * _ReflectColor.a;
        }
        ENDCG
    }
    FallBack "Legacy Shaders/Reflective/VertexLit"
}