Shader "Custom/070-079/077_Outline"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Outline ("Outline", Range(0.01, 1.0)) = 0.01
    }
    
    SubShader
    {
        Pass 
        {
            Tags { "Queue" = "Geometry-1" }
            
            // ZWrite Off
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _Outline;
            
            float4 outline(float4 vertex)
            {
                float4x4 scaleMatrix;
                scaleMatrix[0][0] = 1.0 + _Outline;
                scaleMatrix[0][1] = 0.0;
                scaleMatrix[0][2] = 0.0;
                scaleMatrix[0][3] = 0.0;
                scaleMatrix[1][0] = 0.0;
                scaleMatrix[1][1] = 1.0 + _Outline;
                scaleMatrix[1][2] = 0.0;
                scaleMatrix[1][3] = 0.0;
                scaleMatrix[2][0] = 0.0;
                scaleMatrix[2][1] = 0.0;
                scaleMatrix[2][2] = 1.0 + _Outline;
                scaleMatrix[2][3] = 0.0;
                scaleMatrix[3][0] = 0.0;
                scaleMatrix[3][1] = 0.0;
                scaleMatrix[3][2] = 0.0;
                scaleMatrix[3][3] = 1.0;
                
                return mul(scaleMatrix, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(outline(v.vertex));
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return _SinTime;
            }
            ENDCG
        }
        
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;   
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}   