Shader "Custom/050-059/055_02_IgnoreProjector_False"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }   
    
    SubShader
	{
	    Tags { "IgnoreProjector" = "False" }
	    
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