Shader "Custom/030-039/036_05_Blending_Soft_Additive"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend OneMinusDstColor One

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}