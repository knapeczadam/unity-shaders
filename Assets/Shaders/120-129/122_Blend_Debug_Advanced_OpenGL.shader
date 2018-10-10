Shader "Custom/120-129/122_Blend_Debug_Advanced_OpenGL"
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
                float4 vertex : POSITION;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                #if !defined(GL_KHR_blend_equation_advanced) && !defined(GL_NV_blend_equation_advanced)
                    return fixed4(1, 0, 0, 1);
                #else
                    return fixed4(0, 1, 0, 1);
                #endif
            }
            ENDCG
        }
    }
}