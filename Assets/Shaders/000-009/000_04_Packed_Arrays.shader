Shader "Custom/000-009/000_04_Packed_Arrays"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        // float1 _fl1 = float1(1.0);
        float2 _fl2 = float2(1.0, 1.0);
        float3 _fl3 = float3(1.0, 1.0, 1.0);
        float4 _fl4 = float4(1.0, 1.0, 1.0, 1.0);
        
        // half1 _ha1 = half1(1.0);
        half2 _ha2 = half2(-60000.0, 60000.0);
        half3 _ha3 = half3(1.0, 1.0, 1.0);
        half4 _ha4 = half4(1.0, 1.0, 1.0, 1.0);
        
        fixed2 _fi2 = fixed2(-2.0, 2.0);
        fixed3 _fi3 = fixed3(1.0, 1.0, 1.0);
        fixed4 _fi4 = fixed4(1.0, 1.0, 1.0, 1.0);
        
        // int1 _in1 = int1(1);
        int2 _in2 = int2(1, 1);
        int3 _in3 = int3(1, 1, 1);
        int4 _in4 = int4(1, 1, 1, 1);
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 color1 = _fi4.rgba;
            fixed4 color2 = _fi4.xyzw;
            
            fixed4 color3;
            color3.r = 1;
            color3.y = 0.5;
            color3.b = 0.5;
            color3.w = 1;
            
            fixed4 copy;
            copy.r = color3.x;
            copy.g = color3.y;
            copy.b = color3.z;
            copy.a = color3.w;
        }
        ENDCG
    }
    Fallback Off
}