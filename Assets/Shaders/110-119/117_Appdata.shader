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
            
            struct vertexInput
            {
                // this is a valid empty struct - of course it's meaningless
                // not required to contain any members - Input struct in surface shader is exception
            };
            
            struct contentIsImportantNotTheStructName
            {
                float4 vertex : POSITION;
            };
            
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
            
            vertexInput vert(vertexInput v)
            {
                vertexInput o;
                //o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(vertexInput i) : SV_TARGET
            {
                return fixed4(1, 1, 1, 1);
            }
            ENDCG
        }
    }
}