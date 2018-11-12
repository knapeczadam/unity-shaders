Shader "Custom/070-079/071_Vertex_Normal"
{
    Properties
    {
        _Speed ("Speed", Float) = 1.0
        _Frequency ("Frequency", Float) = 1.0
        _Amplitude ("Amplitude", Float) = 1.0
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _Speed;
            float _Frequency;
            float _Amplitude;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                v.vertex += sin(v.normal + (_Time.y * _Speed) * _Frequency) * (_Amplitude * v.normal);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                return _SinTime;
            }
            ENDCG
        }
    }
}   