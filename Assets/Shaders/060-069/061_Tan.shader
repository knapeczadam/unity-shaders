Shader "Custom/060-069/061_Tan"
{
    Properties
    {
        _Multiplier ("Multiplier", Int) = 1
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            int _Multiplier;
            
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
                col.rgb = fixed3(1, 0, 0);
                col.a = tan(i.texcoord.x * _Multiplier);
                return col;
            }
            ENDCG
        }
    }
}   