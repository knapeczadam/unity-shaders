Shader "Custom/060-069/067_Feather"
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
            
            float drawCircle(float2 uv, float2 center, float radius)
            {
                float circle = (pow((uv.x - center.x), 2) + pow((uv.y - center.y), 2)); 
                float rSq = pow(radius, 2);
                if (circle <= rSq) 
                {
                    return smoothstep(rSq, rSq - _Time.y % 2, circle);
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
                col.rgb = abs(_SinTime);
                col.a = drawCircle(i.texcoord.xy, float2(0.5, 0.5), 0.5);
                return col;
            }
            ENDCG
        }
    }
}   