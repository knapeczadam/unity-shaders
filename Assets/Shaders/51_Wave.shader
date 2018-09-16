Shader "Custom/50-59/51_Wave"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
        _Freq ("Frequency", Range(0, 5)) = 1
        _Speed ("Speed", Range(0, 100)) = 1
        _Amp ("Amplitude", Range(0, 1)) = 1
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        float _Freq;
        float _Speed;
        float _Amp;
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };
        
        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
            float4 texcoord1 : TEXCOORD1;
            float4 texcoord2 : TEXCOORD2;
        };
        
        void vert(inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed;
            
            //float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t * 2 + v.vertex.x * _Freq * 2) * _Amp;
            float waveHeightZ = sin(t + v.vertex.z * _Freq) * _Amp + sin(t * 2 + v.vertex.z * _Freq * 2) * _Amp;
            
            //v.vertex.y = v.vertex.y + waveHeight;
            v.vertex.y = v.vertex.y + waveHeight + waveHeightZ;
            
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            //v.normal = normalize (float3(- cos (t + v.vertex.x * _Freq) * _Amp * _Freq - cos (t*2 + v.vertex.x * _Freq * 2) * _Amp * _Freq * 2,1,0));
            
            o.vertColor = 1;
            //o.vertColor = waveHeight + 2;
        }
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c * IN.vertColor;
        }
        ENDCG
    }
}   