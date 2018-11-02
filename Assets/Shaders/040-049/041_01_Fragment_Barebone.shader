Shader "Custom/040-049/041_01_Fragment_Barebone"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput 
            {
            
            };
            
            struct vertexOuput 
            {
            
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return 1;
            }
            ENDCG
        }
    }
}