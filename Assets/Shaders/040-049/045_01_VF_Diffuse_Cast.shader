Shader "Custom/040-049/045_01_VF_Diffuse_Cast"
{
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ShadowCaster" }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 vert(appdata_base v) : SV_POSITION
            {
                return UnityObjectToClipPos(v.vertex);
            }
            
            fixed4 frag() : SV_TARGET
            {
                return 0;
            }
            ENDCG
        }
    }
}   