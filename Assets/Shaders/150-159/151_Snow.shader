Shader "Custom/150-159/151_Snow"
{
    Properties 
    {
        _Color ("Main color", Color) = (0, 0, 0, 0)
		_SnowColor ("Color of snow", Color) = (1, 1, 1, 1)
		_SnowDir ("Direction of snow", Vector) = (0, 1, 0, 0)
		_Snow ("Level of snow", Range(1, -1)) = 1
	}
	
	SubShader 
	{
	    Pass
	    {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
    
            float _Snow;
            float4 _SnowColor;
            float4 _Color;
            float4 _SnowDir;
            float _SnowDepth;
    
            struct appdata 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };
    
            v2f vert(appdata v) 
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }
    
            fixed4 frag(v2f i) : SV_TARGET 
            {
                return dot(i.worldNormal, normalize(_SnowDir.xyz)) > _Snow ? _SnowColor : _Color;          
            }
            ENDCG
		}
	}
}