Shader "Custom/160-169/167_06_Debug_Flipped_Normals" 
{
    Properties 
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    
    SubShader 
    {
        Pass 
        {   
            Cull Back
            SetTexture [_MainTex]
        }

        Pass 
        {
            Cull Front
            Color (1, 0, 1, 1)
        }
    }
}