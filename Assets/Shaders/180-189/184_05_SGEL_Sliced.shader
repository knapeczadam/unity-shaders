Shader "Custom/180-189/184_05_SGEL_Sliced"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _Slice1 ("Slice value 1", Float) = 1.0
        _Slice2 ("Slice value 2", Float) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard vertex:vert
        
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _EmissionMap;
        sampler2D _MetallicGlossMap;
        
        float _Slice1;
        float _Slice2;
        
        struct Input
        {
            float2 uv_MainTex;
            float4 vertex;
        };
        
        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.vertex = v.vertex;
        }
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Alpha = 0.5;
            fixed treshold = step(frac(IN.vertex.y * 2 * _Slice1), _Slice2);
            clip(o.Alpha - treshold);
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb;
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}