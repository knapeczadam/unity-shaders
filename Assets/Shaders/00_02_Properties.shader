Shader "Custom/00_02_Properties"
{   
    Properties
    {
        _Int ("Integer", Int) = 1
        _Float ("Float", Float) = 1.0
        _Vector4 ("Vector4", Vector) = (1, 1, 1, 1)
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Range ("Range", Range(0, 1)) = 0.5
        _2DTex ("2D texture", 2D) = "white" {}
        _3DTex ("3D texture", 3D) = "black" {}
        _CubeTex ("Cube texture", CUBE) = "gray" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface pickAName Lambert
        
        struct Input
        {
            int structInputHasNoMembers;
        };
        
        void pickAName(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
    Fallback "Diffuse"
}