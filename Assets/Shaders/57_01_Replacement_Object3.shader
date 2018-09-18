Shader "Custom/50-59/57_01_Replacement_Object3"
{
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
            o.Albedo = fixed4(0, 0, 1, 1);
        }
        ENDCG
    }
}   