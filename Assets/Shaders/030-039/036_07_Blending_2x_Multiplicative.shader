Shader "Custom/030-039/036_07_Blending_2x_Multiplicative"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend DstColor SrcColor

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}