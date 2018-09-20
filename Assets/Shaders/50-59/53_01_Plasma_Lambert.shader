Shader "Custom/50-59/53_01_Plasma_Lambert"
{
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        #include "UnityCG.cginc"
        
        struct Input 
        {
            float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o) 
        {
            const float PI = UNITY_PI;
            float _Speed = 10 ;
            _CosTime *= 10;
            
            float _Scale1 = abs(_CosTime.x);
            float _Scale2 = abs(_CosTime.y);
            float _Scale3 = abs(_CosTime.z);
            float _Scale4 = abs(_CosTime.w);
            
            float t = _Time.x * _Speed;
            
            //vertical
            float c = sin(IN.worldPos.x * _Scale1 + t);
            
            //horizontal
            c += sin(IN.worldPos.z * _Scale2 + t);
            
            //diagonal
            c += sin(_Scale3 * (IN.worldPos.x * sin(t / 2.0) + IN.worldPos.z * cos(t / 3)) + t);
            
            //circular
            float c1 = pow(IN.worldPos.x + 0.5 * sin(t / 5), 2);
            float c2 = pow(IN.worldPos.z + 0.5 * cos(t / 3), 2);
            c += sin(sqrt(_Scale4 * (c1 + c2) + 1 + t));
            
            o.Albedo.r = sin(c / 4.0 * PI);
            o.Albedo.g = sin(c / 4.0 * PI + 2 * PI / 4);
            o.Albedo.b = sin(c / 4.0 * PI + 4 * PI / 4);
            o.Albedo *= _SinTime;
        }
        ENDCG
    } 
    Fallback "Diffuse"
}   