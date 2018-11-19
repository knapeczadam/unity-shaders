Shader "Custom/040-049/048_Advanced_Outline"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
        
        struct Input 
        {
            float2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutput o) 
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
        
        Pass 
        {
            Cull Front

            CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
				
			struct appdata 
			{
			    float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f 
			{
				float4 pos : SV_POSITION;
				fixed4 color : COLOR0;
			};
			
			v2f vert(appdata v) 
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);

				float3 norm = normalize(mul((float3x3) UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);

				o.pos.xy += offset * o.pos.z * abs(sin(_Time.w)) * 0.4;
				o.color = sin(_Time.w) > 0 ? fixed4(1, 0, 0, 1) : fixed4(0, 0, 1, 1);
				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				return i.color;
			}
			ENDCG
		}
    } 
}

