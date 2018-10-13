Shader "Custom/000-009/000_05_Matrices"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        // float1x1 _m_fl1x1 = float(1.0);
        float2x2 _m_fl2x2 = float2x2(1.0, 1.0,
                                     1.0, 1.0);
        float3x3 _m_fl3x3 = float3x3(1.0, 1.0, 1.0,
                                     1.0, 1.0, 1.0,
                                     1.0, 1.0, 1.0);
        float4x4 _m_fl4x4 = float4x4(1.0, 1.0, 1.0, 1.0,
                                     1.0, 2.0, 1.0, 1.0,
                                     1.0, 1.0, 3.0, 1.0,
                                     1.0, 1.0, 1.0, 4.0);
        
        // half1x1 _m_ha1x1 = half(1.0);
        half2x2 _m_ha2x2 = half2x2(1.0, 1.0,
                                   1.0, 1.0);
        half3x3 _m_ha3x3 = half3x3(1.0, 1.0, 1.0,
                                   1.0, 1.0, 1.0,
                                   1.0, 1.0, 1.0);
        half4x4 _m_ha4x4 = half4x4(1.0, 1.0, 1.0, 1.0,
                                   1.0, 1.0, 1.0, 1.0,
                                   1.0, 1.0, 1.0, 1.0,
                                   1.0, 1.0, 1.0, 1.0);
        
        fixed2x2 _m_fi2x2 = fixed2x2(1.0, 1.0,
                                     1.0, 1.0);
        fixed3x3 _m_fi3x3 = fixed3x3(1.0, 1.0, 1.0,
                                     3.1, 4.1, 5.9,
                                     1.0, 1.0, 1.0);
        fixed4x4 _m_fi4x4 = fixed4x4(1.0, 1.0, 1.0, 1.0,
                                     1.0, 1.0, 1.0, 1.0,
                                     1.0, 1.0, 1.0, 1.0,
                                     1.0, 1.0, 1.0, 1.0);
        
        // int1x1 _m_in1x1 = int(1);
        int2x2 _m_in2x2 = int2x2(1, 1,
                                 1, 1);
        int3x3 _m_in3x3 = int3x3(1, 1, 1,
                                 1, 1, 1,
                                 1, 1, 1);
        int4x4 _m_in4x4 = int4x4(1, 1, 1, 1,
                                 1, 1, 1, 1,
                                 1, 1, 0, 1,
                                 1, 1, 1, 1);
                                 
        int2x2 a = int2x2(int2(1, 1), int2(1, 1));                                 
        int2x2 b = int3x3(int3(1, 1, 1), int3(1, 1, 1), int3(1, 1, 1));                                 
        int4x4 c = int4x4(int4(1, 1, 1, 1), int4(1, 1, 1, 1), int4(1, 1, 1, 1), int4(1, 1, 1, 1));
        
        // 2X3, 2X4
        // 3X2, 3X4
        // 4X2, 4X3
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            int _catch = _m_in4x4._m22;
            
            // chaining
            float4 numbers1 = _m_fl4x4._m00_m11_m22_m33;
            float3 pi = _m_fi3x3[1];
        }
        ENDCG
    }
    Fallback Off
}