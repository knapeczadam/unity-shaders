Shader "Custom/030-039/036_01_Blending_Default"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
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
}