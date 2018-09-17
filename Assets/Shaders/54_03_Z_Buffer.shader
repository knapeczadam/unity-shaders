Shader "Custom/50-59/54_03_Z_Buffer"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }   
    
    SubShader
	{
	    ZWrite On
	    
	    Tags { "Queue" = "Geometry" }
	    
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