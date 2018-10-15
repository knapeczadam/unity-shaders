Shader "Custom/140-149/140_01_Magnet"
{
    Properties
    {
        _MainTex ("Main texutre", 2D) = "white" {}
        _Radius ("Radius", Range(0.0, 1.0)) = 1.0
        _Length ("Length", Range(0.01, 0.5)) = 0.01
        _MagnetPos ("Magnet position", Vector) = (0, 0, 0, 0)
    }
    
    SubShader
    {
        Pass
        {   
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            fixed _Radius;
            fixed _Length;
            float4 _MagnetPos;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                half2 uv : TEXCOORD0;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                float4 distance = _MagnetPos - worldPos;
                float r = clamp(length(distance.xz) / _Radius, 0.0, UNITY_PI);
                worldPos.y += (cos(r) + 1) * distance.y * _Length;
                o.pos = mul(UNITY_MATRIX_VP, worldPos);
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