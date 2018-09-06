Shader "Custom/00_02_Properties"
{   
    Properties
    {
        _Int ("Integer", Int) = 1
        _Float ("Float", Float) = 1.0
        _Vector4 ("Vector4", Vector) = (1, 1, 1, 1)
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Range ("Range", Range(0.0, 1.0)) = 0.5
        _2DTex ("2D texture", 2D) = "white" {}
        _3DTex ("3D texture", 3D) = "black" {}
        _CubeTex ("Cube texture", CUBE) = "gray" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        int _Int;
        float _Float;
        float4 _Vector4;
        fixed4 _Color;
        float _Range;
        sampler2D _2DTex;
        sampler2D_float _2DTex_float;
        sampler2D_half _2DTex_half;
        sampler3D _3DTex;
        sampler3D_float _3DTex_float;
        sampler3D_half _3DTex_half;
        samplerCUBE _CubeTex;
        samplerCUBE_float _CubeTex_float;
        samplerCUBE_half _CubeTex_half;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
    Fallback Off
}