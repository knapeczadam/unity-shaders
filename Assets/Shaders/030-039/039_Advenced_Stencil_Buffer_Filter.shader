Shader "Custom/030-039/039_Advenced_Stencil_Buffer_Filter"
{
    Properties
    {
        _SRef ("Stencil Ref", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp ("Stencil Comp", Int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil Op", Int) = 0
    }
    
    SubShader
    {
        Tags { "Queue" = "Geometry-1" }
        
        ZWrite Off
        ColorMask 0
        
        Pass
        {
            Stencil
            {
                Ref [_SRef]
                Comp [_SComp]
                Pass [_SOp]
            }
        }
    }
}   