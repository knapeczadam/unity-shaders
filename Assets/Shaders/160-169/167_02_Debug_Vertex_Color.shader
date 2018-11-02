Shader "Custom/160-169/167_02_Debug_Vertex_Color" 
{
    SubShader 
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
    
            struct appdata 
            {
                float4 vertex : POSITION;
                fixed4 color : COLOR;
            };
    
            struct v2f 
            {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };
            
            v2f vert(appdata v) 
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
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