Shader "Custom/030-039/036_01_Blending_Default"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend Off

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
    Fallback "Diffuse"
}