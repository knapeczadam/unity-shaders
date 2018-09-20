Shader "Custom/50-59/57_01_Replacement"
{
    SubShader
    {
        Tags { "General Dodonna" = "May the Force be with you" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(1, 1, 1, 1);
        }
        ENDCG
    }
    
    SubShader
    {
        Tags { "RenderType" = "Cyan" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(0, 1, 1, 1);
        }
        ENDCG
    }
    
    SubShader
    {
        Tags { "RenderType" = "Magenta" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(1, 0, 1, 1);
        }
        ENDCG
    }
    
    SubShader
    {
        Tags { "RenderType" = "Yellow" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(1, 1, 0, 1);
        }
        ENDCG
    }
    
    SubShader
    {
        Tags { "Dark Side" = "Black" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = fixed4(0, 0, 0, 1);
        }
        ENDCG
    }
}   