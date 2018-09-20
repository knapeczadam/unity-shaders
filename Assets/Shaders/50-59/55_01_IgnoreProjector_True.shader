Shader "Custom/50-59/55_01_IgnoreProjector_True"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }   
    
    SubShader
	{
	    Tags { "IgnoreProjector" = "True" }
	    
	    CGPROGRAM
	    #pragma surface surf Lambert
	    
	    fixed4 _Color;
	    
	    struct Input
	    {
	        float2 uv_MainTex;
	    };
	    
	    void surf(Input IN, inout SurfaceOutput o)
	    {
	        o.Albedo = _Color;
	    }
	    ENDCG
	}
	Fallback "Diffuse"
}   