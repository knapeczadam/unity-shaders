Shader "Custom/130-139/136_Offset"
{
    SubShader
    {
        Offset -100, -1
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
                return 1;
            }
            ENDCG
        }
    }
}