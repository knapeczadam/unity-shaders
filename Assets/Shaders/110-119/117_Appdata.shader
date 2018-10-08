Shader "Custom/110-119/117_Appdata"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            //#include "UnityCG.cginc"
            
            struct appdata_base
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            
            struct appdata_tan
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 tangent : TANGENT;
            };
            
            struct appdata_full
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 tangent : TANGENT;
                float4 color : COLOR;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return fixed4(1, 1, 1, 1);
            }
            ENDCG
        }
    }
}