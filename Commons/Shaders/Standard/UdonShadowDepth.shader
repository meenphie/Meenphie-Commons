Shader "Hidden/Meenphie/UdonShadowDepth"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Cutoff("Alpha Cutoff", Range(0,1)) = 0.5
        _DitherScale("Dither Scale", Range(0.1, 4.0)) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Back
        ZWrite On
        ZTest LEqual

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float2 uv : TEXCOORD1;
                float4 screenPos : TEXCOORD2;
                UNITY_VERTEX_INPUT_INSTANCE_ID // nécessaire pour le transfert
            };

            // Matrices et distances fournies par le script Udon
            float4x4 _UdonShadowViewMatrix;
            float _Udon_LightNear;
            float _Udon_LightFar;

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Cutoff;
            float _DitherScale;

            // Matrice de Bayer pour le dithering (conservée si besoin de cutout)
            static const float _Bayer4[16] = {
                0.0/16.0,  8.0/16.0,  2.0/16.0, 10.0/16.0,
                12.0/16.0, 4.0/16.0, 14.0/16.0, 6.0/16.0,
                3.0/16.0, 11.0/16.0, 1.0/16.0,  9.0/16.0,
                15.0/16.0, 7.0/16.0, 13.0/16.0, 5.0/16.0
            };

            v2f vert(appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o); // transfère l'ID d'instance

                // Transformation standard, sans billboarding
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.pos = UnityObjectToClipPos(v.vertex);

                o.uv = TRANSFORM_TEX(v.uv, _MainTex); // plus de flipbook
                o.screenPos = ComputeScreenPos(o.pos);
                return o;
            }

            float _UdonShadowDepthEncode(float3 worldPos)
            {
                float viewDepth = -mul(_UdonShadowViewMatrix, float4(worldPos, 1.0)).z;
                return saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));
            }

            float4 frag(v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);

                // Dithering alpha si vous avez des objets avec transparence cutout
                float alpha = tex2D(_MainTex, i.uv).a;
                float2 screenUV = i.screenPos.xy / max(i.screenPos.w, 0.0001);
                float2 pixelPos = screenUV * _ScreenParams.xy * _DitherScale;
                int x = abs((int)floor(fmod(pixelPos.x, 4.0)));
                int y = abs((int)floor(fmod(pixelPos.y, 4.0)));
                float threshold = _Bayer4[y * 4 + x];
                if (alpha < threshold) discard;

                float depth = _UdonShadowDepthEncode(i.worldPos);
                return depth.xxxx;
            }
            ENDCG
        }
    }

    Fallback Off
}