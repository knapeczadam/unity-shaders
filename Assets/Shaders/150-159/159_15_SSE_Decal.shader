Shader "Custom/150-159/159_15_SSE_Decal"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags 
        {
            "RenderType" = "Opaque" 
            "Queue" = "Geometry+1" 
            "ForceNoShadowCasting" = "True" 
        }
        
        LOD 200
        
        Offset -1, -1
        
        CGPROGRAM
        #pragma surface surf Lambert decal:blend
        #pragma multi_compile_fog
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    Fallback "Diffuse"
}