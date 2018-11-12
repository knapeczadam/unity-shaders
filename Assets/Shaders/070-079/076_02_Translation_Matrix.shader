Shader "Custom/070-079/076_02_Translation_Matrix"
{
    Properties
    {
        _X ("X-Axis translation", Float) = 0.0
        _Y ("Y-Axis translation", Float) = 0.0
        _Z ("Z-Axis translation", Float) = 0.0
    }
    
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _X, _Y, _Z;
            
            float4 translate(float4 vertex)
            {
                _X = _SinTime.x;
                _Y = _SinTime.y;
                _Z = _SinTime.z;
                
                float4x4 translationMatrix = float4x4
                (
                    1, 0, 0, _X,
                    0, 1, 0, _Y,
                    0, 0, 1, _Z,
                    0, 0, 0,  1
                );
                
                return mul(translationMatrix, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(translate(v.vertex));
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}   