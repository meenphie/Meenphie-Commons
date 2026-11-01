        // Opaque/cutout casters write zero transmittance; transparent casters write the
        // Only opaque and alpha-cutout render types have replacement passes below.
    Shader "Hidden/Meenphie/UdonShadowDepth"
    {
        Properties
        {
            _MainTex("Texture", 2D) = "white" {}
            _Color("Tint", Color) = (1,1,1,1)
            _Cutoff("Alpha Cutoff", Range(0,1)) = 0.5
        }

        // ------------------------------------------------------------
        // 1. On écrit une seule fois les fonctions vertex/fragment
        // ------------------------------------------------------------
        CGINCLUDE
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
            float2 uv : TEXCOORD0;
            float3 worldPos : TEXCOORD1;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        sampler2D _MainTex;
        float4 _MainTex_ST;
        float4 _Color;
        float _Cutoff;
        float4x4 _UdonShadowViewMatrix;
        float _Udon_LightNear;
        float _Udon_LightFar;

        float _EncodeShadowDepth(float3 worldPos)
        {
            float viewDepth = -mul(_UdonShadowViewMatrix, float4(worldPos, 1.0)).z;
            return saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));
        }

        v2f vert(appdata v)
        {
            v2f o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_TRANSFER_INSTANCE_ID(v, o);
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            return o;
        }

        float4 fragOpaque(v2f i) : SV_Target
        {
            UNITY_SETUP_INSTANCE_ID(i);
            return _EncodeShadowDepth(i.worldPos).xxxx;
        }

        float4 fragCutout(v2f i) : SV_Target
        {
            UNITY_SETUP_INSTANCE_ID(i);
            float alpha = tex2D(_MainTex, i.uv).a * _Color.a;
            clip(alpha - _Cutoff);
            return _EncodeShadowDepth(i.worldPos).xxxx;
        }

        ENDCG

        // ------------------------------------------------------------
        // 2. On déclare maintenant les SubShaders pour chaque RenderType
        // ------------------------------------------------------------

        // Pour les objets Opaque (pas de test alpha)
        SubShader
        {
            Tags { "RenderType"="Opaque" }
            Pass
            {
                ZTest LEqual
                ZWrite On
                Blend Off
                ColorMask R
                CGPROGRAM
                #pragma only_renderers d3d11 gles3 metal vulkan
                #pragma vertex vert
                #pragma fragment fragOpaque
                ENDCG
            }
        }

        // Pour les objets TransparentCutout (cheveux, vêtements troués)
        SubShader
        {
            Tags { "RenderType"="TransparentCutout" }
            Pass
            {
                ZTest LEqual
                ZWrite On
                Blend Off
                ColorMask R
                CGPROGRAM
                #pragma only_renderers d3d11 gles3 metal vulkan
                #pragma vertex vert
                #pragma fragment fragCutout
                ENDCG
            }
        }

        Fallback Off
    }