Shader "Custom/040-049/042_01_VF_Color_World"
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
                float4 vertex : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.vertex = v.vertex;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {   
                return i.vertex; 
            }
            ENDCG
        }
    }
}   