Shader "Custom/70-79/75_01_WSN_2"
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
                // UnityObjectToWorldNormal(v.normal) -> UNITY_ASSUME_UNIFORM_SCALING = false
                o.worldNormal = normalize(mul(v.normal, (float3x3) unity_WorldToObject)); // v.normal -> float1x3
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return float4(i.worldNormal, 1);
            }
            ENDCG
        }
    }
}   