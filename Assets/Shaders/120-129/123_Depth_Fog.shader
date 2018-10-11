Shader "Custom/120-129/123_Depth_Fog"
{
    Properties 
    {
        _Color ("Color", Color) = (0, 0, 0, 0)
        _FogColor ("Fog color", Color) = (0, 0, 0, 0)
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
            
            fixed4 _Color;
            fixed4 _FogColor;
            half _FogStart;
            half _FogEnd;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                fixed depth : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                half4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.depth = saturate((distance(worldPos.xyz, _WorldSpaceCameraPos.xyz) - _FogStart) / _FogEnd);
                
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return fixed4(i.depth * _FogColor  + _Color.xyz, 1.0);
            }
            ENDCG
        }
    }
}