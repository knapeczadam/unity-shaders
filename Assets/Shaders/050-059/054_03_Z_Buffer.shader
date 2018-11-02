Shader "Custom/050-059/054_03_Z_Buffer"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
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
	        fixed _;
	    };
	    
	    void surf(Input IN, inout SurfaceOutput o)
	    {
	        o.Albedo = _Color.rgb;
	    }
	    ENDCG
	}
}   