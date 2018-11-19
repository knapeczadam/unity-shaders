Shader "Custom/070-079/070_Flag_Ver"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Offset ("Offset", Float) = 0.0
        _Speed ("Speed", Float) = 1.0
        _Frequency ("Frequency", Float) = 1.0
        _Amplitude ("Amplitude", Float) = 1.0
        [Toggle(RANDOM_COLOR)] _RandomColor("Random color", Float) = 0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Cull Off
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature RANDOM_COLOR
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float _Offset;
            float _Speed;
            float _Frequency;
            float _Amplitude;
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                UNITY_INITIALIZE_OUTPUT(vertexOutput, o);
                v.vertex.z += sin(v.texcoord.x + (_Offset + _Time.y * _Speed) * _Frequency) * (_Amplitude * v.texcoord.x);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                #ifdef RANDOM_COLOR
                    fixed4 col = 1;
                    col.rgb = _SinTime.xyz / _Offset;
                #else
                    fixed4 col = tex2D(_MainTex, i.uv);
                #endif
                return col;
            }
            ENDCG
        }
    }
}   