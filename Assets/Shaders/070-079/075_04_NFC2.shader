Shader "Custom/070-079/075_04_NFC2"
{
    Properties
    {
        _Normal ("Normal", 2D) = "bump" {}
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _Normal;
            float4 _Normal_ST;
            
            float3 normalFromColor(float4 col)  // UnpackNormal
            {
                #if defined(UNITY_NO_DXT5nm)
                    return col.xyz * 2 - 1;
                #else
                    col.r *= col.a;
                    float3 normVal;
                    normVal = float3(col.r * 2 - 1, col.g * 2 - 1, 0.0);
                    normVal.z = sqrt(1 - saturate(dot(normVal, normVal)));
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
                float2 normalTexcoord : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normalTexcoord = v.texcoord.xy * _Normal_ST.xy + _Normal_ST.zw; 
                return o;
            }
            
            float4 frag(vertexOuput i) : SV_TARGET
            {
                float4 col = tex2D(_Normal, i.normalTexcoord);
                float4 norm = float4(normalFromColor(col), 0);
                return norm;
            }
            ENDCG
        }
    }
}   