Shader "Custom/120-129/128_Color_Scattering"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Offset ("Offset", Range(0.001, 0.01)) = 0.001
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            float _Offset;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
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
                o.uv = v.texcoord;
                return o;
            }
                
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed3 col;
                col.r = tex2D(_MainTex, i.uv + _Offset).r;
                col.g = tex2D(_MainTex, i.uv).g;
                col.b = tex2D(_MainTex, i.uv - _Offset).b;
                return fixed4(col, 1);
            }
            ENDCG
        }
    }
}