Shader "Custom/030-039/036_02_Blending_Traditional_Transparency"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}