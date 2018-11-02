Shader "Custom/170-179/171_Texture_Arrays" 
{
    Properties
    {
        _MyArr ("Tex", 2DArray) = "" {}
        _SliceRange ("Slices", Range(0, 16)) = 6
        _UVScale ("UVScale", Float) = 1.0
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // not sure if required to use target level
            #pragma target 3.5 
            #pragma require 2darray
            
            #include "UnityCG.cginc"
            
            float _SliceRange;
            float _UVScale;
            UNITY_DECLARE_TEX2DARRAY(_MyArr);

            struct v2f
            {
                float3 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
            
            v2f vert(float4 vertex : POSITION)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(vertex);
                o.uv.xy = (vertex.xy + 0.5) * _UVScale;
                o.uv.z = (vertex.z + 0.5) * _SliceRange;
                return o;
            }

            half4 frag(v2f i) : SV_TARGET
            {
                return UNITY_SAMPLE_TEX2DARRAY(_MyArr, i.uv);
            }
            ENDCG
        }
    }
}