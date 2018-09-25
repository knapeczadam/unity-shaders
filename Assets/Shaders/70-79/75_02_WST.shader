// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/70-79/75_02_WST"
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
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 tangentWorld : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.tangentWorld = normalize(mul(v.tangent, unity_ObjectToWorld));
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return i.tangentWorld;
            }
            ENDCG
        }
    }
}   