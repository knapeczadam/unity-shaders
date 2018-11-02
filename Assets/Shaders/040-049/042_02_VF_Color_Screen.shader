Shader "Custom/040-049/042_02_VF_Color_Screen"
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
                fixed4 c = 1;
                c.r = i.pos.x / _ScreenParams.x; 
                c.g = i.pos.y / _ScreenParams.y; 
                c.b = i.pos.z / ((_ScreenParams.x + _ScreenParams.y)  / 2.0); 
                return c;
            }
            ENDCG
        }
    }
}   