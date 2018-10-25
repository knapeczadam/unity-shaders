Shader "Custom/150-159/155_02_Fixed_Tex"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Pass
        {
            SetTexture [_MainTex] //{ combine texture }
        }
    }
}