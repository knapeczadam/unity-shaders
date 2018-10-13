Shader "Custom/040-049/041_Fragment_Barebone"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput // appdata
            {
                float4 vertex : POSITION;
            };
            
            struct vertexOuput // v2f
            {
                float4 pos : SV_POSITION;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR // SV_Target
            {
                return _SinTime;
            }
            ENDCG
        }
    }
}