Shader "Custom/030-039/036_08_Blending_Cull_Off"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Cull Off

        Pass
        {
            SetTexture [_MainTex] { combine texture }
        }
    }
}