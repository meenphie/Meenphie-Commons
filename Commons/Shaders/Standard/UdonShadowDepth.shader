    Shader "Hidden/Meenphie/UdonShadowDepth"
    {
        Properties
        {
            _MainTex("Texture", 2D) = "white" {}
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
            float3 worldPos : TEXCOORD0;
            float2 uv : TEXCOORD1;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        // Variables Udon
        float4x4 _UdonShadowViewMatrix;
        float _Udon_LightNear;
        float _Udon_LightFar;

        sampler2D _MainTex;
        float4 _MainTex_ST;
        float _Cutoff;

        // Fonction de profondeur
        float _UdonShadowDepthEncode(float3 worldPos)
        {
            float viewDepth = -mul(_UdonShadowViewMatrix, float4(worldPos, 1.0)).z;
            return saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));
        }

        // Vertex
        v2f vert(appdata v)
        {
            v2f o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_TRANSFER_INSTANCE_ID(v, o);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            o.pos = UnityObjectToClipPos(v.vertex);
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);
            return o;
        }

        // Fragment (elle sera incluse partout)
        float4 frag(v2f i) : SV_Target
        {
            UNITY_SETUP_INSTANCE_ID(i);

            // On laisse la possibilité de faire du discard pour les Cutout
            #ifdef _ALPHA_TEST
                float alpha = tex2D(_MainTex, i.uv).a;
                // On coupe en dessous du seuil (sans dithering pour éviter les trous)
                if (alpha < _Cutoff) discard;
            #endif

            float depth = _UdonShadowDepthEncode(i.worldPos);
            return depth.xxxx;
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
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                // On ne définit PAS _ALPHA_TEST ici
                ENDCG
            }
        }

        // Pour les objets TransparentCutout (cheveux, vêtements troués)
        SubShader
        {
            Tags { "RenderType"="TransparentCutout" }
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #define _ALPHA_TEST 1 // Active le test alpha
                ENDCG
            }
        }

        // Pour les objets Transparent (comme les verres, mais on veut quand même leur profondeur)
        SubShader
        {
            Tags { "RenderType"="Transparent" }
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                // On ne définit PAS _ALPHA_TEST, car on veut que le verre écrive dans la shadow map
                // (sinon le verre serait totalement transparent et ne cacherait pas les objets derrière)
                ENDCG
            }
        }

        // Pour les objets "Overlay" ou autres, on ajoute un SubShader générique
        SubShader
        {
            Tags { "RenderType"="Overlay" }
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                ENDCG
            }
        }

        Fallback Off
    }