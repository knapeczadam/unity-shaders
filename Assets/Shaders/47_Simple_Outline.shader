Shader "Custom/40-49/47_Simple_Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [Toggle(CALCULATE_DISTANCE)] _CalcDist("Calculate distance (vertex <-> camera)", Float) = 0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        ZWrite Off
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        #pragma shader_feature CALCULATE_DISTANCE
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void vert(inout appdata_full v)
        {
            #ifdef CALCULATE_DISTANCE
                float dist = length(ObjSpaceViewDir(v.vertex));
                v.vertex.xyz += v.normal * abs(sin(_Time.w)) * 0.02 * dist;
            #else
                v.vertex.xyz += v.normal * abs(sin(_Time.w)) * 0.05;
            #endif
        }
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = sin(_Time.w) > 0 ? fixed3(1, 0, 0) : fixed3(0, 0, 1);
        }
        
        ENDCG
        
        ZWrite ON 
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    }
    Fallback "Diffuse"
}   