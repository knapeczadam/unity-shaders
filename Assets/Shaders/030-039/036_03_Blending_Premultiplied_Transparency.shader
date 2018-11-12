Shader "Custom/030-039/036_03_Blending_Premultiplied_Transparency"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend One OneMinusSrcAlpha

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}