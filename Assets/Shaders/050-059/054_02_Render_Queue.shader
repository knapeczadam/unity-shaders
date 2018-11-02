Shader "Custom/050-059/054_02_Render_Queue"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }   
    
    SubShader
	{
	    ZWrite Off
	    
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