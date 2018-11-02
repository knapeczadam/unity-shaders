Shader "Custom/050-059/056_02_VF_Tiling_On"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.texcoord.xy  * _MainTex_ST.xy;
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}   