Shader "Custom/050-059/059_18_Glitch_Amount"
{
    Properties
    {
        _Speed ("Speed", Float) = 1
        _Amplitude ("Amplitude", Float) = 1
        _Distance ("Distance", Float) = 1
        _Amount ("Amount", Float) = 1
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

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                v.vertex.x += sin(_Time.y * _Speed + v.vertex.y * _Amplitude) * _Distance * _Amount;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return 0;
            }
            ENDCG
        }
    }
}   