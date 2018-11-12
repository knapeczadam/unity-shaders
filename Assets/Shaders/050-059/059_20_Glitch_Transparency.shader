Shader "Custom/050-059/059_20_Glitch_Transparency"
{
    Properties
    {
        _MainTex ("Albedo Texture", 2D) = "white" {}
        _Transparency ("Transparency", Range(0.0, 1.0)) = 1.0
        _Speed ("Speed", Float) = 1.0
        _Amplitude ("Amplitude", Float) = 1.0
        _Distance ("Distance", Float) = 1.0
        _Amount ("Amount", Float) = 1.0
    }
    
    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float _Transparency;
            
            float _Speed;
            float _Amplitude;
            float _Distance;
            float _Amount;

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
                v.vertex.x += sin(_Time.y * _Speed + v.vertex.y * _Amplitude) * _Distance * _Amount;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = _Transparency;
                return col;
            }
            ENDCG
        }
    }
}   