Shader "Custom/110-119/115_Shadow_Mapping" 
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ShadowCaster" }
            
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput
            {
                float4 vertex : POSITION;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return 0;
            }
            ENDCG
        }
        
        Pass 
        {
            Tags { "LightMode" = "ForwardBase" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			sampler2D _ShadowMapTexture;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
                float4 shadowCoord : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.shadowCoord = ComputeScreenPos(o.pos);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed4 col = tex2D(_MainTex, i.texcoord);
                col.rgb *= tex2D(_ShadowMapTexture, i.shadowCoord).a;
                return col;
            }
            ENDCG
        }
    }
}
