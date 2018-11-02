Shader "Custom/020-029/021_Rim_Cutoff"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _Color;
        
        struct Input
        {
            float3 viewDir;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            float rim = 1.0 - saturate(dot(IN.viewDir, o.Normal));
            o.Emission = _Color * (rim > sin(_Time.w) * 0.5 + 0.5 ? rim : 0);   
        }
        ENDCG
    }
}