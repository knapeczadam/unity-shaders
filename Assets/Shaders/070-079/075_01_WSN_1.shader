Shader "Custom/070-079/075_01_WSN_1"
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
                float3 normal : NORMAL;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                // UnityObjectToWorldNormal(v.normal) -> UNITY_ASSUME_UNIFORM_SCALING = true
                o.worldNormal = normalize(mul((float3x3) unity_ObjectToWorld, v.normal)); // v.normal -> float3x1
                
                return o;
            }
            
            float4 frag(vertexOuput i) : SV_TARGET
            {
                return float4(i.worldNormal, 1);
            }
            ENDCG
        }
    }
}   