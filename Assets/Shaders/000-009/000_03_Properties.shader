Shader "Custom/000-009/000_03_Properties"
{   
    Properties
    {
        _Int ("Int", Int) = 1
        _Float ("Float", Float) = 1.0
        _Vector4 ("Vector", Vector) = (1, 1, 1, 1)
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Range ("Range", Range(0.0, 1.0)) = 0.5
        _2D ("2D", 2D) = "white" {}
        _3D ("3D", 3D) = "" {}
        _Cube ("Cube", CUBE) = "" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        int _Int;
        float _Float;
        float4 _Vector;
        fixed4 _Color;
        float _Range;
        sampler1D _1D;
        sampler2D _2D;
        sampler2D_float _2D_float;
        sampler2D_half _2D_half;
        sampler3D _3D;
        sampler3D_float _3D_float;
        sampler3D_half _3D_half;
        samplerCUBE _Cube;
        samplerCUBE_float _Cube_float;
        samplerCUBE_half _Cube_half;
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
}