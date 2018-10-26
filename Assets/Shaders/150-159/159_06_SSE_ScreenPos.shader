Shader "Custom/150-159/159_06_SSE_ScreenPos"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Detail ("Detail", 2D) = "gray" {}
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        sampler2D _Detail;
        
        struct Input
        {
            float2 uv_MainTex;
            float4 screenPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            float2 screenUV = IN.screenPos.xy / max(IN.screenPos.w, 1);
            screenUV *= float2(8, 6);
            o.Albedo *= tex2D(_Detail, screenUV).rgb * 2;
        }
        ENDCG
    }
    Fallback "Diffuse"
}