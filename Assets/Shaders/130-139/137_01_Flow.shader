Shader "Custom/130-139/137_01_Flow"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _FlowMap ("Flow map", 2D) = "white" {}
        _FlowIntensity ("Flow intesnsity", Range(0.0, 0.1)) = 0.0
        _Speed ("Speed", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            sampler2D _FlowMap;
            fixed _FlowIntensity;
            fixed _Speed;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
                
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed4 f = tex2D(_FlowMap, i.uv);
                f *= 2 - 1;
                float2 direction = float2(0, _Time.y * _Speed);
                fixed4 col = tex2D(_MainTex, i.uv + f.xy * _FlowIntensity + direction);
                return col;
            }
            ENDCG
        }
    }
}