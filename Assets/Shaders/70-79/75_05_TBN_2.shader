// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/70-79/75_05_TBN_2"
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
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 normalWorld : TEXCOORD0;
                float4 tangentWorld : TEXCOORD1;
                float3 binormalWorld : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normalWorld = float4(normalize(mul(normalize(v.normal.xyz), (float3x3) unity_WorldToObject)), v.normal.w);
                o.tangentWorld = float4(normalize(mul((float3x3) unity_ObjectToWorld, v.tangent.xyz)), v.tangent.w);
                o.binormalWorld = normalize(cross(o.normalWorld, o.tangentWorld) * o.tangentWorld.w);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                float3x3 TBN = float3x3(i.tangentWorld.xyz, i.binormalWorld, i.normalWorld.xyz); 
                
                return 1.0;
            }
            ENDCG
        }
    }
}   