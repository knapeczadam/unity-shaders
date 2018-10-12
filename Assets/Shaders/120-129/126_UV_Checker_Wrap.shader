Shader "Custom/120-129/126_UV_Checker_Wrap"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}