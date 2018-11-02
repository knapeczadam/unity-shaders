Shader "Custom/060-069/066_Smoothstep"
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
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                fixed4 col;
                col.r = smoothstep(_CosTime.x, -_CosTime.x, i.texcoord.x * i.texcoord.y);
                col.g = smoothstep(_CosTime.y, -_CosTime.y, i.texcoord.x * i.texcoord.y);
                col.b = smoothstep(_CosTime.z, -_CosTime.z, i.texcoord.x * i.texcoord.y);
                col.a = smoothstep(_CosTime.w, -_CosTime.w, i.texcoord.x * i.texcoord.y);
                col.rgb *= abs(_SinTime);
                return col;
            }
            ENDCG
        }
    }
}   