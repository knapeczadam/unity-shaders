Shader "Custom/120-129/127_UV_Checker_Rotation"
{
    Properties 
    {
        _MainTex ("Main texture", 2D) = "white" {}
        _Degree ("Degree", Range(0.0, 360.0)) = 0.0
        _OffsetX ("Offset X", Range(0.0, 1.0)) = 0.0
        _OffsetY ("Offset Y", Range(0.0, 1.0)) = 0.0
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
            
            float _Degree;
            float _OffsetX;
            float _OffsetY;
            
            float2 rotate(float degree, float2 coord)
            {
                float theta = radians(degree);
                float2 offset = float2(_OffsetX, _OffsetY);
                
                float2x2 rotationMatrix = float2x2(cos(theta), -sin(theta),
                                                   sin(theta),  cos(theta));
                return mul(rotationMatrix, coord - offset) + offset;
            }
            
            float2 rotateWithOffset(float degree, float2 coord)
            {
                coord.x -= _OffsetX;
                coord.y -= _OffsetY;
                
                float t = radians(degree);
                float c = cos(t);
                float s = sin(t);
                float2 n;
                n.x = c * coord.x + -s * coord.y + _OffsetX;
                n.y = s * coord.x + c * coord.y + _OffsetY;
                return n;
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(vertexOuput i) : SV_TARGET
            {
                return tex2D(_MainTex, rotate(_Degree, i.uv));
            }
            ENDCG
        }
    }
}