    Shader "Custom/170-179/173_Custom_Material_Property_Drawer" 
{
    Properties 
    {
        [CustomMaterialPropertyDrawer] _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert

        fixed4 _Color;

        struct Input 
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    } 
}