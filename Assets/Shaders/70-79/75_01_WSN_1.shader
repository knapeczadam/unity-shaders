// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/70-79/75_01_WSN_1"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 normalWorld : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normalWorld = normalize(mul(normalize(v.normal), unity_WorldToObject)); // v.normal -> float1x4
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return i.normalWorld;
            }
            ENDCG
        }
    }
}   