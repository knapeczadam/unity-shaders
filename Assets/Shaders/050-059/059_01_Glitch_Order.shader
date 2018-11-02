Shader "Custom/050-059/059_01_Glitch_Order"
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
                o.vertex = UnityObjectToClipPos(v.vertex);
                v.vertex.x += sin(_Time.y);
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