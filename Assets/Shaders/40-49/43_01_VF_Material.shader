Shader "Custom/40-49/43_01_VF_Material"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv.x = o.uv.x * _SinTime.x;
                o.uv.y = o.uv.y * _SinTime.x;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 c;
                c = tex2D(_MainTex, i.uv);
                return c;
            }
            ENDCG
        }
    }
}   