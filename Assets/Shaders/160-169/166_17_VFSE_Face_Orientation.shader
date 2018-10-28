Shader "Custom/160-169/166_17_VFSE_Face_Orientation" 
{
    Properties
    {
        _ColorFront ("Front Color", Color) = (1, 0.7, 0.7, 1)
        _ColorBack ("Back Color", Color) = (0.7, 1, 0.7, 1)
    }
    
    SubShader
    {
        Pass
        {
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            fixed4 _ColorFront;
            fixed4 _ColorBack;

            float4 vert(float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }

            fixed4 frag(fixed facing : VFACE) : SV_Target
            {
                return facing > 0 ? _ColorFront : _ColorBack;
            }
            ENDCG
        }
    }
}