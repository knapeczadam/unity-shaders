Shader "Custom/160-169/168_05_Inline_Sampler_States" 
{
    Properties
    {
        _MainTex ("Sprite Texture", 2D) = "white" {}
    }
    
    SubShader 
    {
        Cull Off
        Blend One OneMinusSrcAlpha
        
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5
            
            Texture2D _MainTex;
            float4 _MainTex_ST;
            SamplerState Smp_ClampU_RepeatV_Point;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 col = _MainTex.Sample(Smp_ClampU_RepeatV_Point, i.uv);
                return col;
            }
            ENDCG
        }
    }
}