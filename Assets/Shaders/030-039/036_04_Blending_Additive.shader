Shader "Custom/030-039/036_04_Blending_Additive"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
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
    Fallback "Diffuse"
}