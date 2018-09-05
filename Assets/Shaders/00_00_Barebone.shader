Shader "Custom/00_00_Barebone"
{   
    SubShader
    {
        CGPROGRAM
        #pragma surface pickAName Lambert
        
        struct Input
        {
            int structInputHasNoMembers;
        };
        
        void pickAName(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
}