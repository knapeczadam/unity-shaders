Shader "Custom/120-129/124_Depth_Texture"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _DepthTex ("Depth texture", 2D) = "white" {}
        _FogStart ("Fog start", Range(0, 20)) = 0
        _FogEnd ("Fog end", Range(0.1, 20)) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            sampler2D _DepthTex;
            float4 _DepthTex_ST;
            
            half _FogStart;
            half _FogEnd;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0;
                fixed depth : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                half4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.depth = saturate((distance(worldPos.xyz, _WorldSpaceCameraPos.xyz) - _FogStart) / _FogEnd);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed4 mainTex = tex2D(_MainTex, i.texcoord);
                fixed4 depthTex = tex2D(_DepthTex, i.texcoord * _DepthTex_ST.xy + _DepthTex_ST.zw);
                fixed3 finalCol = lerp(mainTex, depthTex, i.depth);
                return fixed4(finalCol, 1.0);
            }
            ENDCG
        }
    }
}