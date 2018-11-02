Shader "Custom/150-159/155_01_VF_Tex"
{
    Properties
    {
        _MainTex ("Main texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
                
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
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}