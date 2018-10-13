Shader "Custom/050-059/059_17_Glitch_Distance"
{
    Properties
    {
        _Speed ("Speed", Float) = 1
        _Amplitude ("Amplitude", Float) = 1
        _Distance ("Distance", Float) = 1
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
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                v.vertex.x += sin(_Time.y * _Speed + v.vertex.y * _Amplitude) * _Distance;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}   