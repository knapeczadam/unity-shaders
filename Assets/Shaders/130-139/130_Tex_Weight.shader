Shader "Custom/130-139/130_Tex_Weight"
{
    Properties 
    {
        _Tex1 ("Texture 1", 2D) = "white" {}
        _Tex2 ("Texture 2", 2D) = "white" {}
        _TexWeight ("Texture weight", Range(0.0, 1.0)) = 0.0
        
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
            
            fixed _TexWeight;
            
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
                fixed4 t1 = tex2D(_Tex1, i.uv);
                fixed4 t2 = tex2D(_Tex2, i.uv);
                fixed4 col = t1 * (1 - _TexWeight) + t2 * _TexWeight;
                //col = lerp(t1, t2, _TexWeight);
                return col;
            }
            ENDCG
        }
    }
}