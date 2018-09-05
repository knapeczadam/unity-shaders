Shader "Custom/00_01_Basic_Data_Types"
{   
    SubShader
    {
        CGPROGRAM
        #pragma surface pickAName Lambert
        
        float _32Bits;
        half _16Bits;
        fixed _11Bits;
        int integer;
        
        struct Input
        {
            int structInputHasNoMembers;
        };
        
        void pickAName(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
    Fallback "Diffuse"
}