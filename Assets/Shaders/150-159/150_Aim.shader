Shader "Custom/150-159/150_Aim"
{
    Properties 
    {
		_Color ("Color", Color) = (1,1,1,1)
		_Center ("Center", Vector) = (0,0,0,0)
		_Radius ("Radius", Float) = 0.5
		_RadiusColor ("Radius Color", Color) = (1,0,0,1)
		_RadiusWidth ("Radius Width", Float) = 2
	}
	
	SubShader 
	{
	    Pass
	    {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            fixed4 _Color;
            float3 _Center; 
            float _Radius; 
            fixed4 _RadiusColor; 
            float _RadiusWidth; 
    
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET 
            {
                fixed4 col;
                float d = distance(_Center, i.worldPos);
                return (d > _Radius) && (d < (_Radius + _RadiusWidth)) ? _RadiusColor : _Color;
            }
            ENDCG
		}
	}
}