Shader "Custom/040-049/046_Extrude"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _Extrusion ("Extrusion amount", Range(0.0, 1.0)) = 0.0
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        fixed4 _Color;
        fixed _Extrusion;
        
        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * _Extrusion * abs(_SinTime.w);
        }
        
        struct Input
        {
            fixed _;
        };
        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
}   