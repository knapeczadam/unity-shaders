Shader "Custom/010-019/013_Normal"
{
    Properties
    {
        _BumpMap ("Normal Map", 2D) = "bump" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _BumpMap;
        
        struct Input
        {
            float2 uv_BumpMap;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 0.5;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
        }
        ENDCG
    }
}