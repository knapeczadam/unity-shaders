Shader "Custom/030-039/036_04_Blending_Additive"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend One One

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}