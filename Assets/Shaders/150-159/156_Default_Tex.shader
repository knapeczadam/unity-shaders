Shader "Custom/150-159/156_Default_Tex"
{
    Properties
    {
        [HideInInspector] _Tex1 ("Texture 1 - empty", 2D) = "" {} // Legacy brackets. Not necessary to use them but it's a convention. You could remove it if you want.
        [HideInInspector] _Tex2 ("Texture 2 - white", 2D) = "white" {}
        [HideInInspector] _Tex3 ("Texture 3 - black", 2D) = "black" {}
        [HideInInspector] _Tex4 ("Texture 4 - gray", 2D) = "gray" {}
        [HideInInspector] _Tex5 ("Texture 5 - bump", 2D) = "bump" {}
        [HideInInspector] _Tex6 ("Texture 6 - red", 2D) = "red" {}
        [KeywordEnum(Empty, White, Black, Gray, Bump, Red)] _DefaultValue ("Default 2D texture values", Int) = 0 
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature _DEFAULTVALUE_EMPTY _DEFAULTVALUE_WHITE _DEFAULTVALUE_BLACK _DEFAULTVALUE_GRAY _DEFAULTVALUE_BUMP _DEFAULTVALUE_RED
            
            sampler2D _Tex1;
            sampler2D _Tex2;
            sampler2D _Tex3;
            sampler2D _Tex4;
            sampler2D _Tex5;
            sampler2D _Tex6;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                
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
                #if _DEFAULTVALUE_EMPTY
                    return tex2D(_Tex1, i.uv);
                #elif _DEFAULTVALUE_WHITE
                    return tex2D(_Tex2, i.uv);
                #elif _DEFAULTVALUE_BLACK
                    return tex2D(_Tex3, i.uv);
                #elif _DEFAULTVALUE_GRAY
                    return tex2D(_Tex4, i.uv);
                #elif _DEFAULTVALUE_BUMP
                    return tex2D(_Tex5, i.uv);
                #elif _DEFAULTVALUE_RED
                    return tex2D(_Tex6, i.uv);
                #endif
            }
            ENDCG
        }
    }
}