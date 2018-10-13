Shader "Custom/070-079/072_04_ColorMask_A"
{
    SubShader
    {
        Pass 
        {
            ColorMask A
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            fixed4 frag(v2f i) : COLOR
            {
                return abs(_SinTime);
            }
            ENDCG
        }
    }
}   