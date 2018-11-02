Shader "Custom/020-029/022_Double_Rim_Cutoff"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _FirstRim ("First rim range", Range(0.0, 1.0)) = 0.0
        _SecondRim ("Second rim range", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        fixed _FirstRim;
        fixed _SecondRim;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            float rim = 1.0 - saturate(dot(IN.viewDir, o.Normal));
            o.Emission = rim > _FirstRim ? _SinTime.rgb : rim > _SecondRim ? _CosTime.rgb : _Color.rgb;   
        }
        ENDCG
    }
}