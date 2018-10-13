Shader "Custom/070-079/078_03_UI"
{
    Properties
    {
        [Enum(ColorGamut)] _Gamut ("Gamut", Int) = 0
        [Enum(UnityEditor.Rendering.ShaderType)] _ShaderType ("Shader type", Int) = 1
        [Enum(UnityEngine.Rendering.RenderQueue)] _RenderQueue ("Render queue", Int) = 1000
        [Enum(UnityEngine.Rendering.PassType)] _PassType ("Pass type", Int) = 0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1;
        }
        ENDCG
    }
    Fallback "Diffuse"
}   