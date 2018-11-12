Shader "Custom/050-059/059_11_Glitch_Speed"
{
    Properties
    {
        _Speed ("Speed", Float) = 1
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float _Speed;

            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(float4 vertex : POSITION)
            {
                v2f o;
                vertex.x += sin(_Time.y * _Speed);
                o.pos = UnityObjectToClipPos(vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return _SinTime;
            }
            ENDCG
        }
    }
}   