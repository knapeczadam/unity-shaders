Shader "Custom/120-129/125_Fish"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _AnimSpeed ("Animation speed", Float) = 1.0
        _AnimFreq ("Animation frequency", Float) = 1.0
        _AnimOffsetX ("Animation offset X", Float) = 1.0
        _AnimOffsetY ("Animation offset Y", Float) = 1.0
        _AnimOffsetZ ("Animation offset Z", Float) = 1.0
        _AnimPowerX ("Animation power X", Float) = 0.0
        _AnimPowerY ("Animation power Y", Float) = 0.0
        _AnimPowerZ ("Animation power Z", Float) = 0.0
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
            
            half _AnimSpeed;
            half _AnimFreq;
            half _AnimOffsetX;
            half _AnimOffsetY;
            half _AnimOffsetZ;
            half _AnimPowerX;
            half _AnimPowerY;
            half _AnimPowerZ;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.texcoord = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                float4 newPos = v.vertex;
                half3 animOffset = half3(_AnimOffsetX, _AnimOffsetY, _AnimOffsetZ) * newPos.xyz;
                half3 animPower = half3(_AnimPowerX, _AnimPowerY, _AnimPowerZ);
                newPos.xyz += sin(_Time.y * _AnimSpeed + (animOffset.x + animOffset.y + animOffset.z) * _AnimFreq) * animPower.xyz;
                o.pos = UnityObjectToClipPos(newPos);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return tex2D(_MainTex, i.texcoord);
            }
            ENDCG
        }
    }
}