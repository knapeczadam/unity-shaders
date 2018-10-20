Shader "Custom/120-129/129_01_Grayscale"
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
            
            fixed grayScale(fixed3 c)
            {
                return c.r * 0.299 + c.g * 0.587 + c.b * 0.114;
            }
            
            sampler2D _MainTex;
            
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
                fixed4 col = tex2D(_MainTex, i.uv);
                col.rgb = grayScale(col.rgb);
                return fixed4(col.rgb, 1);
            }
            ENDCG
        }
    }
}