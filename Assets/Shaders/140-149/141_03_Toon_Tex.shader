Shader "Custom/140-149/141_03_Toon_Tex"
{
    Properties
    {
        _MainTex("Main texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Pass
        {   
            Tags { "LightMode" = "ForwardBase" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            
            fixed4 toonShading(float3 N)
            {
                float3 L = normalize(_WorldSpaceLightPos0.xyz);
                float angle = dot(N, L) * 0.5 + 0.5;
                return tex2D(_MainTex, angle);
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
                float3 normal : NORMAL;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
                float3 worldNormal : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }
                
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return toonShading(i.worldNormal);
            }
            ENDCG
        }
    }
}