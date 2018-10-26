Shader "Custom/150-159/159_11_SSE_Custom_Vertex_Data"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
            float3 customColor;
        };
        
        void vert(inout appdata_full v, out Input o) 
        {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            o.customColor = abs(normalize(v.normal));
        }
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Albedo *= IN.customColor;
        }
        ENDCG
    }
    Fallback "Diffuse"
}