Shader "Custom/030-039/036_06_Blending_Multiplicative"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend DstColor Zero

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}