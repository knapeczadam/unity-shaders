Shader "Custom/110-119/118_V2F"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            //#include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct vertexOutput
            {
                // this is a valid empty struct - does it make any sense?
            };
            
            struct v2f {};
            
            struct vertexToFragment
            {
                float4 pos : SV_POSITION;
            };
            
            struct v2f_img
            {
                float4 pos : SV_POSITION;
                half2 uv   : TEXCOORD0;
            };
            
            struct v2f_vertex_lit
            {
                float2 uv : TEXCOORD0;
                fixed4 diff	 : COLOR0;
                fixed4 spec	 : COLOR1;
            };
            
            vertexOutput vert(float vertex : POSITION)
            {
                vertexOutput o; // initialization not declaration!
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                return 1;
            }
            ENDCG
        }
    }
}