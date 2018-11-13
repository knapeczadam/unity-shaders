Shader "Custom/110-119/119_Semantic"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            //#pragma target 3.0 <- up to 10 interpolators
            //#pragma target 4.0 <- up to 32 interpolators
            
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
                float4 pos : SV_poSITion; // vertex output needs to have the SV_POSITION semantic, and be of a float4 type
                
                // the following members are interpolators/varyings
                float2 uv : TEXCOORD0;
                float4 I_am_a_member_with_custom_semantic : TEXCOORD2;
                fixed4 a_custom_semantic_here : COLOR2; // COLORN semantics on vertex outputs and fragment inputs are for low-precision, 0–1 range data (like simple color values).
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
            
            // SV_TARGET = SV_TARGET0
            // SV_TARGET1, SV_TARGET2 if MRT is used 
            fixed4 frag(v2f i) : SV_TARGET // COLOR <- Direct3D 9 equivalent semantic
            {
                return 0.69; // fragment output
            }
            
            struct fragOutput 
            {
                fixed4 color : SV_TARGET;
            };
            
            fragOutput frag1(v2f i)
            {
                fragOutput o;
                o.color = fixed4(i.uv, 0, 0);
                return o;
            }
            ENDCG
        }
    }
}