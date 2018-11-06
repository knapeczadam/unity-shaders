Shader "Custom/180-189/184_10_SGEL_Liquid_Noise"
{
    Properties
    {
        _NoiseScale ("Noise scale", Float) = 1.0
        _NoiseWeight ("Noise weight", Float) = 1.0
        _Speed ("Noise scrool speed", Float) = 1.0
        _TintA ("Tint A", Color) = (1, 1, 1, 1)
        _TintB ("Tint B", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        CGPROGRAM
        #pragma surface surf Standard alpha:blend
        
        float _NoiseScale;
        float _NoiseWeight;
        float _Speed;
        fixed4 _TintA;
        fixed4 _TintB;
        
        float unity_noise_randomValue(float2 uv)
        {
            return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
        }

        float unity_noise_interpolate(float a, float b, float t)
        {
            return (1.0 - t) * a + (t * b);
        }

        float unity_valueNoise(float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
        
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0 = unity_noise_randomValue(c0);
            float r1 = unity_noise_randomValue(c1);
            float r2 = unity_noise_randomValue(c2);
            float r3 = unity_noise_randomValue(c3);
        
            float bottomOfGrid = unity_noise_interpolate(r0, r1, f.x);
            float topOfGrid = unity_noise_interpolate(r2, r3, f.x);
            float t = unity_noise_interpolate(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        float simpleNoise(float2 uv, float scale)
        {
            float t = 0.0;
            for(int i = 0; i < 3; i++)
            {
                float freq = pow(2.0, float(i));
                float amp = pow(0.5, float(3 - i));
                t += unity_valueNoise(float2(uv.x * scale / freq, uv.y * scale / freq)) * amp;
            }
            return t;
        }
        
        struct Input
        {
            float3 worldPos;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.worldPos + _Time.y * _Speed;
            float noise = simpleNoise(uv, _NoiseScale);
            fixed4 col = lerp(_TintA, _TintB, noise);
            o.Albedo = col.rgb;
            o.Emission = col.rgb;
            o.Alpha = lerp(0.0, noise, _NoiseWeight);
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}