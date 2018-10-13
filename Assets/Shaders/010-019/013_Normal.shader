Shader "Custom/010-019/013_Normal"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}
        _Normal ("Normal", 2D) = "bump" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _Texture;
        sampler2D _Normal;
        
        struct Input
        {
            float2 uv_Texture;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Texture, IN.uv_Texture);
            o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Texture));
            float diff = _SinTime.z * 100;
            o.Normal *= float3(diff, diff, 1); 
        }
        ENDCG
    }
    Fallback "Diffuse"
}