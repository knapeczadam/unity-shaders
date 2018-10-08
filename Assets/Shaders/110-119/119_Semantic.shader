Shader "Custom/110-119/119_Semantic"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            //#include "UnityCG.cginc"
            
            struct appdata
            {
                float4 semantic_is_important_not_the_member_name : POSITION; // uppercase
                float2 texcoord : texcoord0; // lowercase
                float3 normal : nOrMaL; // mixed
                float4 mrT : TANGENT;
                // float4 canBeCustom : NOPE;
                // float4 I_am_a_member_without_semantic_and_I_cant_exist_without_semantic_in_vertex_or_fragment_struct;  // Input struct in surface shader is exception
            };
            
            struct v2f
            {
                float4 pos : SV_poSITion;
                float2 uv : TEXCOORD0;
                float4 I_am_a_member_with_custom_semantic : TEXCOORD1;
                fixed4 a_custom_semantic_here : COLOR2;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.semantic_is_important_not_the_member_name);
                o.uv = v.texcoord;
                o.I_am_a_member_with_custom_semantic = 4.2;
                o.a_custom_semantic_here = 1.82;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET // COLOR <- Direct3D 9 equivalent semantic
            {
                return 0.69;
            }
            ENDCG
        }
    }
}