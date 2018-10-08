Shader "Custom/110-119/118_V2F"
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
            
            //#include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                // this is a valid empty struct - does it make any sense?
            };
            
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
            
            vertexOutput vert(appdata v)
            {
                vertexOutput o; // initialization not declaration!
//                o.pos = UnityObjectToClipPos(v.vertex);
//                o.uv = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                return 1; //tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}