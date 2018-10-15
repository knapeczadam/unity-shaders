Shader "Custom/140-149/140_03_Magnet"
{
    Properties
    {
        _Radius ("Radius", Range(0.0, 1.0)) = 1.0
        _Length ("Length", Range(0.01, 0.2)) = 0.01
        _MagnetDir ("Magnet", Vector) = (0, 0, 0, 0)
    }
    
    SubShader
    {
        Pass
        {   
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            fixed _Radius;
            fixed _Length;
            float4 _MagnetDir;
            
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
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float4 dp = saturate(dot(_MagnetDir, worldNormal));
                fixed res = dp > 1 - _Radius ? dp : 0;
                v.vertex.xyz += v.normal * _Length * res;
                o.col = res;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
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