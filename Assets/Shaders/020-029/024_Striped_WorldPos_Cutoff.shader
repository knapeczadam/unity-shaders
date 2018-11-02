Shader "Custom/020-029/024_Striped_WorldPos_Cutoff"
{
    Properties
    {
        _Stretch ("Stretch", Float) = 1.0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float _Stretch;
        
        struct Input
        {
            float3 worldPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            fixed4 x = frac(IN.worldPos.x * _Stretch * _SinTime.x * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            fixed4 y = frac(IN.worldPos.y * _Stretch * _SinTime.y * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            fixed4 z = frac(IN.worldPos.z * _Stretch * _SinTime.z * 0.5) > 0.4 ? abs(_SinTime) : abs(_CosTime);
            o.Emission = (x * y * z).rgb;
        }
        ENDCG
    }
}   