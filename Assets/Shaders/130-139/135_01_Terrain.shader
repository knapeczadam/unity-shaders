Shader "Custom/130-139/135_01_Terrain"
{
    Properties 
    {
        _Tex1 ("Texture 1 - (R)", 2D) = "white" {}
        _Tex2 ("Texture 2 - (G)", 2D) = "white" {}
        _Tex3 ("Texture 3 - (B)", 2D) = "white" {}
        _Tex4 ("Texture 4 - (A)", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag   
            
            sampler2D _Tex1;
            sampler2D _Tex2;
            sampler2D _Tex3;
            sampler2D _Tex4;
            sampler2D _Mask;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2  uv : TEXCOORD0;
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
                fixed4 col;
                fixed4 t1 = tex2D(_Tex1, i.uv);
                fixed4 t2 = tex2D(_Tex2, i.uv);
                fixed4 t3 = tex2D(_Tex3, i.uv);
                fixed4 t4 = tex2D(_Tex4, i.uv);
                fixed4 m = tex2D(_Mask, i.uv);
                col = t1 * m.r + t2 * m.g + t3 * m.b + t4 * m.a;
                return col;
            }
            ENDCG
        }
    }
}