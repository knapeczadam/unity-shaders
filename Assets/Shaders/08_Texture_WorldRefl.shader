Shader "Custom/08_Texture_WorldRefl"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Cube ("Cube map", CUBE) = "black" {}
        _Range ("Range", Range(0, 1)) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        samplerCUBE _Cube;
        float _Range;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex) * _Range;
            o.Emission= texCUBE(_Cube, IN.worldRefl);
        }
        ENDCG
    }
    Fallback "Diffuse"
}
