Shader "Custom/150-159/159_14_SSE_Linear_Fog"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        LOD 200
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:myvert finalcolor:mycolor
        #pragma multi_compile_fog
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
            half fog;
        };
        
        void myvert(inout appdata_full v, out Input data)
        {
            UNITY_INITIALIZE_OUTPUT(Input,data);
            float pos = length(UnityObjectToViewPos(v.vertex).xyz);
            float invDiff = unity_FogParams.z * -1;
            float4 fogEnd = unity_FogParams.w * (-1 / unity_FogParams.z);
            data.fog = clamp((fogEnd - pos) * invDiff, 0.0, 1.0);
        }
        
        void mycolor (Input IN, SurfaceOutput o, inout fixed4 color)
        {
            #ifdef UNITY_PASS_FORWARDADD
                UNITY_APPLY_FOG_COLOR(IN.fog, color, float4(0, 0, 0, 0));
            #else
                UNITY_APPLY_FOG_COLOR(IN.fog, color, unity_FogColor);
            #endif
        }
        
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