Shader "Custom/160-169/167_01_Debug_UV" 
{
    SubShader 
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
    
            struct appdata 
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
    
            struct v2f 
            {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
            };
            
            v2f vert(appdata v) 
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = float4(v.texcoord.xy, 0, 0);
                return o;
            }
            
            half4 frag(v2f i) : SV_TARGET 
            {
                half4 c = frac(i.uv);
                if (any(saturate(i.uv) - i.uv))
                {
                    c.b = 0.5;
                }
                return c;
            }
            ENDCG
        }
    }
}