Shader "Custom/180-189/184_04_SGEL_Color_Gradient"
{
    Properties
    {
        _TopColor ("Top color", Color) = (1, 1, 1, 1)
        _BottomColor ("Bottom color", Color) = (1, 1, 1, 1)
        _Spread ("Spread", Float) = 1.0
        _Position ("Position", Float) = 1.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard vertex:vert
        
        #include "UnityCG.cginc"
            
        fixed4 _TopColor;
        fixed4 _BottomColor;
        float _Spread;
        float _Position;
        
        struct Input
        {
            float4 vertex;
        };
        
        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.vertex = v.vertex;
        }
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = 0.5;
            o.Emission = lerp(_BottomColor.rgb, _TopColor.rgb, IN.vertex.y * _Spread + _Position);
            o.Alpha = 1.0;
        }
        ENDCG
    }
}