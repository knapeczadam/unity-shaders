Shader "Custom/070-079/074_04_ZTest_GE"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    
    SubShader
    {
        Pass 
        {
            ZTest GEqual
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            fixed4 _Color;
            
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
                return _Color;
            }
            ENDCG
        }
    }
}   