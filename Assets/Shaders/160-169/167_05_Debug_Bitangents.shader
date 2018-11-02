Shader "Custom/160-169/167_05_Debug_Bitangents" 
{
    SubShader 
    {
        Pass 
        {
            Fog { Mode Off }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
    
            struct appdata 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
    
            struct v2f 
            {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };
            
            v2f vert(appdata v) 
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                float3 bitangent = cross(v.normal, v.tangent.xyz) * v.tangent.w;
                o.color.xyz = bitangent * 0.5 + 0.5;
                o.color.w = 1.0;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET 
            { 
                return i.color; 
            }
            ENDCG
        }
    }
}