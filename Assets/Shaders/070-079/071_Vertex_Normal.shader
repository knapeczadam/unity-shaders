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
                float4 texcoord : TEXCOORD0;
                float4 normal : NORMAL;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
                v.vertex += sin(v.normal + (_Time.y * _Speed) * _Frequency) * (_Amplitude * v.normal);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(vertexOutput i) : COLOR
            {
                fixed4 col = _SinTime;
                return col;
            }
            ENDCG
        }
    }
}   