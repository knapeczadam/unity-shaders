Shader "Custom/21_Rim_Cutoff"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
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
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            half dotp = dot(normalize(IN.viewDir), o.Normal);
            half rim = 1 - saturate(dotp);
            o.Emission = _Color * rim > abs(_SinTime.x) ? rim : 0;   
        }
        ENDCG
    }
    Fallback "Diffuse"
}