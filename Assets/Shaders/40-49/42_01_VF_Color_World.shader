Shader "Custom/40-49/42_01_VF_Color_World"
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
                float4 color : COLOR;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color.r = v.vertex.x;
                o.color.g = v.vertex.y;
                o.color.b = v.vertex.z;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : COLOR
            {   
                fixed4 c = i.color; 
                return c;
            }
            ENDCG
        }
    }
}   