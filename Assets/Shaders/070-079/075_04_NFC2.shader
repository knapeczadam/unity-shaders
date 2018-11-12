Shader "Custom/070-079/075_04_NFC2"
{
    Properties
    {
        _BumpMap ("Normal Map", 2D) = "bump" {}
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            
            fixed3 normalFromColor(fixed4 col)  // UnpackNormal
            {
                #if defined(UNITY_NO_DXT5nm)
                    return col.xyz * 2 - 1;
                #else
                    col.r *= col.a;
                    fixed3 normVal;
                    normVal.x = col.r * 2 - 1;
                    normVal.y = col.g * 2 - 1;
                    normVal.z = sqrt(1 - saturate(dot(normVal.xy, normVal.xy)));
                    return normVal;
                #endif
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw; 
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                fixed4 col = tex2D(_BumpMap, i.uv);
                return fixed4(normalFromColor(col), 1);
            }
            ENDCG
        }
    }
}   