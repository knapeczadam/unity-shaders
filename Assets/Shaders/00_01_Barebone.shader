Shader "Custom/00_01_Barebone"
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