Shader "Custom/050-059/059_18_Glitch_Amount"
{
    Properties
    {
        _Speed ("Speed", Float) = 1.0
        _Amplitude ("Amplitude", Float) = 1.0
        _Distance ("Distance", Float) = 1.0
        _Amount ("Amount", Float) = 1.0
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float _Speed;
            float _Amplitude;
            float _Distance;
            float _Amount;

            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(float4 vertex : POSITION)
            {
                v2f o;
                vertex.x += sin(_Time.y * _Speed + vertex.y * _Amplitude) * _Distance * _Amount;
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