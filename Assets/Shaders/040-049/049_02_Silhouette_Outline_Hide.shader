// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/040-049/049_02_Silhouette_Outline_Hide" 
{
    CGINCLUDE
    #include "UnityCG.cginc"
 
    struct appdata 
    {
	    float4 vertex : POSITION;
	    float3 normal : NORMAL;
    };
 
    struct v2f 
    {
	    float4 pos : POSITION;
	    float4 color : COLOR;
    };
 
    float4 _OutlineColor;
 
    v2f vert(appdata v) 
    {
	    v2f o;
	    o.pos = UnityObjectToClipPos(v.vertex);
 
	    float3 norm = mul((float3x3) UNITY_MATRIX_IT_MV, v.normal);
	    float2 offset = TransformViewToProjection(norm.xy);
        
        _OutlineColor = _SinTime;
	    o.pos.xy += offset * o.pos.z * abs(_SinTime.w);
	    o.color = _OutlineColor;
	    return o;
    }
    ENDCG
 
	SubShader 
	{
		Tags { "Queue" = "Transparent" }
 
		Pass
		{
			Name "BASE"
			
			Cull Back
			
			Blend Zero One
 
			Offset -8, -8
 
			SetTexture [_OutlineColor] 
			{
				ConstantColor (0,0,0,0)
				Combine constant
			}
		}
 
		Pass 
		{
			Name "OUTLINE"
			
			Tags { "LightMode" = "Always" }
			
			Cull Front
 
			Blend DstColor SrcColor
 
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
 
        half4 frag(v2f i) :COLOR 
        {
	        return i.color;
        }
        ENDCG
		}
	}
    Fallback "Diffuse"
}