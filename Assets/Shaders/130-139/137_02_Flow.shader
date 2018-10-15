Shader "Custom/130-139/137_02_Flow"
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
            
            fixed4 getLayer(half2 uv, float t)
            {
                fixed4 f = tex2D(_FlowMap, uv) * 2 - 1;
                return tex2D(_MainTex, uv + f.xy * _FlowIntensity * t);
            }
            
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
                float t = _Time.y * _Speed;
                float t1 = t % 2;
                float t2 = (t + 1) % 2;
                float w = abs(t % 2 - 1);
                fixed4 c1 = getLayer(i.uv, t1);
                fixed4 c2 = getLayer(i.uv, t2);
                return lerp(c1, c2, w);
            }
            ENDCG
        }
    }
}