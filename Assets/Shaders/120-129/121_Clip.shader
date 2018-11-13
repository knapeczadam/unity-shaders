Shader "Custom/120-129/121_Clip"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _CutoutThresh ("Cutout threshold", Range(0.0, 2.0)) = 0.0
        [Toggle] _Invert ("Invert?", Float) = 0
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature _INVERT_ON 
            
			sampler2D _MainTex;
			float4 _MainTex_ST;
            
            float _CutoutThresh;
            
            samplerCUBE _Cube;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 vertPos : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.vertPos = v.vertex;
                o.uv = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                #if _INVERT_ON
                    if (i.vertPos.y > _CutoutThresh) discard;
                #else
                    clip(i.vertPos.y - _CutoutThresh);
                #endif
                return col;
            }
            ENDCG
        }
    }
}