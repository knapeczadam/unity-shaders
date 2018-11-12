Shader "Custom/070-079/076_03_Scale_Matrix"
{
        Properties
    {
        _X ("X-Axis scaling", Float) = 1.0
        _Y ("Y-Axis scaling", Float) = 1.0
        _Z ("Z-Axis scaling", Float) = 1.0
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
            
            float4 scale(float4 vertex)
            {
                _X = _SinTime.x;
                _Y = _SinTime.y;
                _Z = _SinTime.z;
                
                float4x4 scaleMatrix = float4x4
                (
                    _X, 0, 0, 0,
                     0,_Y, 0, 0,
                     0, 0,_Z, 0,
                     0, 0, 0, 1
                );
                
                return mul(scaleMatrix, vertex);
            }
            
            struct v2f
            {
                float4 pos : SV_POSITION;
            };
            
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(scale(v.vertex));
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