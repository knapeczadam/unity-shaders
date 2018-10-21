Shader "Custom/030-039/036_06_Blending_Multiplicative"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
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
    Fallback "Diffuse"
}