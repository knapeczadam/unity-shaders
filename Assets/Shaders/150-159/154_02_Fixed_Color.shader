Shader "Custom/150-159/154_02_Fixed_Color"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        Pass
        {
            Color [_Color]
        }
    }
}