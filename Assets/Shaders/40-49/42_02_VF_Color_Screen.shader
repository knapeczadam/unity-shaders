Shader "Custom/40-49/42_02_VF_Color_Screen"
{
    Properties
    {
        _Width ("Screen width", Int) = 1
        _Height ("Screen height", Int) = 1
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            int _Width;
            int _Height;
            
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
                return o;
            }
            
            fixed4 frag(vertexOuput i) : COLOR
            {   
                fixed4 c;
                UNITY_INITIALIZE_OUTPUT(fixed4, c);
                c.r = i.pos.x / _Width; 
                c.g = i.pos.y / _Height; 
                c.b = i.pos.z / ((_Width + _Height) / 2.0); 
                return c;
            }
            ENDCG
        }
    }
}   