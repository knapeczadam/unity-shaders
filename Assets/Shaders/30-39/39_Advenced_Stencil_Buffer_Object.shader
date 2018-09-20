Shader "Custom/30-39/39_Advenced_Stencil_Buffer_Object"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SRef ("Stencil Ref", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp ("Stencil Comp", Int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil Op", Int) = 0
    }
    
    SubShader
    {
        Pass
        {
            Stencil
            {
                Ref [_SRef]
                Comp [_SComp]
                Pass [_SOp]
            }
            
            SetTexture [_MainTex] { combine texture }
        }
    }
    // Fallback "Diffuse"
}   