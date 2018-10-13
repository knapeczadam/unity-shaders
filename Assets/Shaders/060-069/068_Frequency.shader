Shader "Custom/060-069/068_Frequency"
{
    Properties
    {
        _Speed ("Speed", Float) = 1.0
        _Frequency ("Frequency", Float) = 1.0
        _Thickness ("Thickness", Range(0.01, 0.1)) = 0.01
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _Speed;
            float _Frequency;
            float _Thickness;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = v.texcoord.xy;
                return o;
            }
            
            int drawSin(float2 uv)
            {   
                const float PI = UNITY_PI;
                float y = sin((uv.x + (_Time.y * _Speed)) * _Frequency * PI - (PI * 0.5)) * 0.5 + 0.5;
                float x = cos((uv.y + (_Time.y * _Speed)) * _Frequency * PI - (PI * 0.5)) * 0.5 + 0.5;
                if ((y - _Thickness < uv.y && uv.y < y + _Thickness)) 
                {
                    return 1;
                }
                return 0;
            }
            
            fixed4 frag(vertexOutput i) : COLOR
            {
                fixed4 col = 1;
                col.a = drawSin(i.texcoord);
                return col;
            }
            ENDCG
        }
    }
}   