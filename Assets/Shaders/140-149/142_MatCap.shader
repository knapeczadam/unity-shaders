Shader "Custom/140-149/142_MatCap"
{
    Properties 
    {
        _BumpMap ("Bumpmap (RGB)", 2D) = "bump" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
	}
	
	Subshader 
	{
		Tags { "RenderType" = "Opaque" }
		
		Pass 
		{
			//Tags { "LightMode" = "Always" }
			
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
				
            sampler2D _BumpMap;
            sampler2D _MatCap;
				
            struct v2f 
            { 
                float4 pos : SV_POSITION;
                float2	uv : TEXCOORD0;
                float3	TtoV0 : TEXCOORD2;
                float3	TtoV1 : TEXCOORD3;
            };
				
				
            v2f vert (appdata_tan v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos (v.vertex);
                o.uv = v.texcoord;
                
                TANGENT_SPACE_ROTATION;
                o.TtoV0 = mul(rotation, UNITY_MATRIX_IT_MV[0].xyz);
                o.TtoV1 = mul(rotation, UNITY_MATRIX_IT_MV[1].xyz);
                return o;
            }
				
            float4 frag (v2f i) : SV_TARGET
            {
                float3 normal = UnpackNormal(tex2D(_BumpMap, i.uv));
                
                half2 vn;
                vn.x = dot(i.TtoV0, normal);
                vn.y = dot(i.TtoV1, normal);
                
                float4 matcapLookup = tex2D(_MatCap, vn * 0.5 + 0.5);
                
                matcapLookup.a = 1;
                
                return matcapLookup  * 2;
            }
			ENDCG
		}
	}
}