Shader "Custom/020-029/023_WorldPos_Cutoff"
{
    Properties
    {
        _YAxis ("Y-Axis", Float) = 1.0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        float _YAxis;
        
        struct Input
        {
            float3 worldPos;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Emission = IN.worldPos.y > _YAxis ? abs(_SinTime).rgb : abs(_CosTime).rgb;
        }
        ENDCG
    }
}