Shader "Custom/040-049/047_Simple_Outline"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Color1 ("Color 1", Color) = (1, 1, 1, 1)
        _Color2 ("Color 2", Color) = (1, 1, 1, 1)
        _Extrusion ("Extrusion amount", Range(0.01, 0.1)) = 0.0
        [Toggle(CALCULATE_DISTANCE)] _CalcDist("Calculate distance (vertex <-> camera)", Float) = 0.0
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        
        ZWrite Off
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        #pragma shader_feature CALCULATE_DISTANCE
        
        fixed4 _Color1;
        fixed4 _Color2;
        float _Extrusion;
        
        struct Input
        {
            fixed _;
        };
        
        void vert(inout appdata_full v)
        {
            #ifdef CALCULATE_DISTANCE
                float dist = length(ObjSpaceViewDir(v.vertex));
                v.vertex.xyz += v.normal * abs(sin(_Time.w)) * _Extrusion * dist;
            #else
                v.vertex.xyz += v.normal * abs(sin(_Time.w)) * _Extrusion;
            #endif
        }
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = sin(_Time.w) > 0 ? _Color1.rgb : _Color2.rgb;
        }
        
        ENDCG
        
        ZWrite On
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
}   