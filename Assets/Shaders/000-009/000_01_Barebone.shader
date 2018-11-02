Shader "Custom/000-009/000_01_Barebone"
{   
    SubShader
    {
        CGPROGRAM
        #pragma surface yourSurfaceFunction Lambert exclude_path:deferred exclude_path:prepass noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nofog nometa noforwardadd  nolppv  noshadowmask 
        
        struct Input
        {
            int structInputHasNoMembers;
            float3 worldNormal;
        };
        
        void yourSurfaceFunction(Input IN, inout SurfaceOutput o)
        {
            
        }
        ENDCG
    }
}