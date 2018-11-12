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
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                fixed4 col;
                col.r = smoothstep(_CosTime.x, -_CosTime.x, i.uv.x * i.uv.y);
                col.g = smoothstep(_CosTime.y, -_CosTime.y, i.uv.x * i.uv.y);
                col.b = smoothstep(_CosTime.z, -_CosTime.z, i.uv.x * i.uv.y);
                col.a = smoothstep(_CosTime.w, -_CosTime.w, i.uv.x * i.uv.y);
                col.rgb *= abs(_SinTime);
                return col;
            }
            ENDCG
        }
    }
}   