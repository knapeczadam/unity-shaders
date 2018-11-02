Shader "Custom/040-049/043_03_VF_GrabPass"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        GrabPass {}
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            sampler2D _GrabTexture;
            float4 _MainTex_ST;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 c;
                c = tex2D(_GrabTexture, i.uv);
                return c;
            }
            ENDCG
        }
    }
}   