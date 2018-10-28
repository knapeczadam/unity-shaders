Shader "Custom/160-169/166_03_VFSE_World_Space_Normals" 
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct v2f 
            {
                half3 worldNormal : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert(float4 vertex : POSITION, float3 normal : NORMAL)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.worldNormal = UnityObjectToWorldNormal(normal);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 c = 0;
                c.rgb = i.worldNormal * 0.5 + 0.5;
                return c;
            }
            ENDCG
        }
    }
}