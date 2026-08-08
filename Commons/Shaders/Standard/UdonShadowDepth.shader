Shader "Hidden/Meenphie/UdonShadowDepth"
{
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
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 pos      : SV_POSITION;
                float3 worldPos : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            // Anciennement dans UdonShadowDepthCapture.cginc — inline ici pour
            // éviter tout problème de résolution de chemin d'include côté Unity.
            float _UdonShadowDepthEncode(float3 worldPos)
            {
                float4 clipPos = mul(UNITY_MATRIX_VP, float4(worldPos, 1.0));
                return clipPos.z / clipPos.w;
            }

            float4 frag(v2f i) : SV_Target
            {
                float depth = _UdonShadowDepthEncode(i.worldPos);
                return depth.xxxx;
            }
            ENDCG
        }
    }
    Fallback Off
}