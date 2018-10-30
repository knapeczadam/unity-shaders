Shader "Custom/160-169/169_Property_Attributes_Drawers" 
{
    Properties
    {
        [HideInInspector] _HiddenTex ("Please hide me", 2D) = "white" {}
        [NoScaleOffset] _MainTex ("No scale, no offset", 2D) = "white" {}
        [Normal] _BumpTex ("R U Normal?", 2D) = "bump" {}
        [HDR] _HDRTex ("High dynamic range", CUBE) = "white" {}
        [Gamma] _sRGB ("sRGB value", Float) = 1.0
        [PerRendererData] _SpriteTex ("Sprite texture", 2D) = "white" {}
    }
    
    SubShader 
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(float4 vertex : POSITION, float2 texcoord : TEXCOORD0)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.uv = texcoord;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_TARGET
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}