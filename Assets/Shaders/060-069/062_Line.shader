Shader "Custom/060-069/062_Line"
{
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float drawLine(float2 uv, float start, float width)
            {
                if (uv.x > start && uv.x < start + width)
                {
                    return 1;
                }
                return 0;
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy;
                return o;
            }
            
            fixed4 frag(vertexOutput i) : COLOR
            {
                fixed4 col;
                col.rgb = fixed3(0, 1, 0);
                col.a = drawLine(i.texcoord.xy, abs(_SinTime.y), 0.01);
                return col;
            }
            ENDCG
        }
    }
}   