Shader "Custom/050-059/059_33_Glitch_YX_Div"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
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
                v.vertex.y /= sin(_Time.y + v.vertex.x);
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