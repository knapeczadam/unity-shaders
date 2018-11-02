Shader "Custom/050-059/058_03_Gradient_Y"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {   
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            fixed4 _Color;
            
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
            
            fixed4 frag(vertexInput i) : SV_TARGET
            {
                fixed4 c;
                c.rgb = _Color.rgb;
                c.a = i.texcoord.y;
                return c;
            }
            ENDCG
        }
    }
}   