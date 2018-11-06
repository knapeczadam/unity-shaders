Shader "Custom/180-189/184_11_SGEL_Phase_In_And_Out"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _BumpMap ("Normal map", 2D) = "bump" {}
        _EmissionMap ("Emission", 2D) = "white" {}
        _MetallicGlossMap ("Metallic", 2D) = "white" {}
        
        _SplitVal ("Split value", Float) = 1.0
        _EdgeColor ("Edge color", Color) = (1, 1, 1, 1)
        _EdgeSpread ("Edge spread", Range(0.0, 0.5)) = 0.0
    }
    
    SubShader
    {
        Cull Off
        
        CGPROGRAM
        #pragma surface surf Standard vertex:vert
        
        #include "UnityCG.cginc"
        
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _EmissionMap;
        sampler2D _MetallicGlossMap;
        
        float _SplitVal;
        fixed4 _EdgeColor;
        float _EdgeSpread;
        
        float remap(float inVal, float2 inMinMax, float2 outMinMax)
		{
		    return outMinMax.x + (inVal - inMinMax.x) * (outMinMax.y - outMinMax.x) / (inMinMax.y - inMinMax.x);
		}
        
        struct Input
        {
            float2 uv_MainTex;
            float4 vertex;
        };
        
        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.vertex = v.vertex;
        }
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float edge = remap(_EdgeSpread, float2(0.0, 1.0), float2(0.0, -0.5)) + _SplitVal;
            _EdgeColor *= 1.0 - smoothstep(IN.vertex.y, _SplitVal, edge);
            float treshold = 1.0 - step(IN.vertex.y, _SplitVal);
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            o.Alpha = 0.5;
            clip(o.Alpha - treshold);
            o.Emission = tex2D(_EmissionMap, IN.uv_MainTex).rgb + _EdgeColor.rgb;
            o.Metallic = tex2D(_MetallicGlossMap, IN.uv_MainTex).a;
            o.Smoothness = 0.5;
            o.Occlusion = 1.0;
        }
        ENDCG
    }
}