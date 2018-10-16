Shader "Custom/140-149/141_01_Toon_Vert"
{
    Properties
    {
        _ToonAngle1 ("Toon angle 1 - Low", Range(0.0, 1.0)) = 0
        _ToonAngle2 ("Toon angle 2 - Mid", Range(0.0, 1.0)) = 0
        _ToonAngle3 ("Toon angle 3 - High", Range(0.0, 1.0)) = 0
        _ToonColor1 ("Toon color 1 - Low", Color) = (1, 1, 1, 1)
        _ToonColor2 ("Toon color 2 - Mid", Color) = (1, 1, 1, 1)
        _ToonColor3 ("Toon color 3 - High", Color) = (1, 1, 1, 1)
        _Color ("Default color - Highest", Color) = (1, 1, 1, 1)
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
            
            fixed4 _Color;
            fixed4 _ToonColor1;
            fixed4 _ToonColor2;
            fixed4 _ToonColor3;
            
            fixed _ToonAngle1;
            fixed _ToonAngle2;
            fixed _ToonAngle3;
            
            fixed4 toonShading(float3 N)
            {
                float3 L = normalize(_WorldSpaceLightPos0.xyz);
                float angle = saturate(dot(N, L));
                
                if (angle < _ToonAngle1) return _ToonColor1;
                if (angle < _ToonAngle2) return _ToonColor2;
                if (angle < _ToonAngle3) return _ToonColor3;
                return _Color;
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
                fixed4 col : COLOR0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                o.col = toonShading(worldNormal);
                return o;
            }
                
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return i.col;
            }
            ENDCG
        }
    }
}