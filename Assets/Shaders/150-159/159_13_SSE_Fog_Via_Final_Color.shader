Shader "Custom/150-159/159_13_SSE_Fog_Via_Final_Color"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FogColor ("Fog Color", Color) = (0.3, 0.4, 0.7, 1.0)
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:myvert finalcolor:mycolor
        
        sampler2D _MainTex;
        fixed4 _FogColor;
        
        struct Input
        {
            float2 uv_MainTex;
            half fog;
        };
        
        void myvert(inout appdata_full v, out Input data)
        {
            UNITY_INITIALIZE_OUTPUT(Input, data);
            float4 hpos = UnityObjectToClipPos(v.vertex);
            hpos.xy /= hpos.w;
            data.fog = min(1, dot(hpos.xy, hpos.xy) * 0.5);
        }
        
        void mycolor (Input IN, SurfaceOutput o, inout fixed4 color)
        {
            fixed3 fogColor = _FogColor.rgb;
            #ifdef UNITY_PASS_FORWARDADD
                fogColor = 0;
            #endif
            color.rgb = lerp(color.rgb, fogColor, IN.fog);
        }
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    Fallback "Diffuse"
}