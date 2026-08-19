#ifndef UDON_REALTIME_DIFFUSE
#define UDON_REALTIME_DIFFUSE

uniform float4 _UdonLightData[257];
uniform float  _UdonDiffuseRealtimeEnabled;

// Variables globales venant du script C#
// Une seule shadow map maintenant : opaque ET translucide (dithering) y écrivent
// leur depth, plus besoin de _UdonShadowAlphaMap / 2e RenderTexture.
uniform sampler2D _UdonShadowMap;
uniform float4    _UdonShadowMap_TexelSize; // auto-rempli par Unity (x=1/width, y=1/height)
uniform float4x4  _UdonShadowMatrixVP;   // Matrice de la lumière

#ifndef UDON_SHADOW_COMMON
    #define UDON_SHADOW_COMMON
    uniform float _UdonShadowRaySteps;
    uniform float _UdonShadowNearCasterExclude;
#endif

static const float _RTShadowMaxDist    = 10.0;
static const float _RTShadowMinDist    = 0.05;
static const float _RTShadowBiasEye    = 0.05;
static const float _RTShadowNormalBias = 0.02;

static const float _MaxDynamicDiffuseRange   = 10.0;
static const float _MaxDynamicDiffuseRangeSq = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
static const float _MinLightRadius           = 1.5;
static const float _DynamicDiffuseBoost      = 1.0;

float _UdonRTSq(float x) { return x * x; }

float _UdonRTSpotMask(float3 L_norm, float3 lightFwd, float cosOuter, float cosInner) {
    float cosAngle = dot(-L_norm, lightFwd);
    return smoothstep(cosOuter, cosInner, cosAngle);
}

float _UdonRTAreaMask(float3 L_norm, float3 lightFwd) {
    return saturate(dot(-L_norm, lightFwd) * 4.0);
}

// Fonction de base : Screen Space Shadow (Ombres de contact)
float _UdonRTComputeScreenSpaceShadow(float3 WorldPos, float3 lightPos, float3 N, bool wantsShadow) {
    if (!wantsShadow) return 1.0;

    float3 toLight = lightPos - WorldPos;
    float  lightDist = length(toLight);
    if (lightDist > _RTShadowMaxDist || lightDist < _RTShadowMinDist) return 1.0;

    // Simplification : Retourner 1.0 par défaut pour laisser agir la Shadow Map
    return 1.0;
}

// Lecture de la shadow map unique (opaque + translucide/dithering confondus).
// Un seul tap donnerait un résultat 0/1 net sur les objets opaques mais du
// "bruit" binaire sur les objets translucides ditherés (pas de dégradé).
// Un petit PCF 2x2 moyenne ce bruit spatial en une atténuation continue,
// ce qui redonne une pénombre douce aux ombres de fumée/vitres sans
// avoir besoin d'une texture de transmittance séparée.
float _UdonRTComputeShadowMapAtten(float3 WorldPos, bool wantsShadow)
{
    if (!wantsShadow) return 1.0;

    float4 shadowClip = mul(_UdonShadowMatrixVP, float4(WorldPos, 1.0));
    if (shadowClip.w <= 1e-5) return 1.0;
    float3 shadowNDC = shadowClip.xyz / shadowClip.w;
    float2 shadowUV = shadowNDC.xy * 0.5 + 0.5;

    #if UNITY_UV_STARTS_AT_TOP
        shadowUV.y = 1.0 - shadowUV.y;
    #endif

    if (shadowUV.x < 0.0 || shadowUV.x > 1.0 || shadowUV.y < 0.0 || shadowUV.y > 1.0)
        return 1.0;

    float myDepth = shadowNDC.z;
    float bias = 0.005; // ajuste si tu as des artefacts (shadow acne)

    float2 texel = _UdonShadowMap_TexelSize.xy;
    float atten = 0.0;
    [unroll]
    for (int y = 0; y <= 1; y++)
    {
        [unroll]
        for (int x = 0; x <= 1; x++)
        {
            float2 uv = shadowUV + (float2(x, y) - 0.5) * texel;
            float storedDepth = tex2D(_UdonShadowMap, uv).r;
            atten += (myDepth > storedDepth + bias) ? 0.0 : 1.0;
        }
    }
    return atten * 0.25;
}

float3 UdonRealtimeDiffuse(float3 WorldPos, float3 WorldNormal)
{
    float3 diffuse = 0;
    if (_UdonDiffuseRealtimeEnabled < 0.5) return diffuse;

    float3 N = normalize(WorldNormal);
    float4 meta = _UdonLightData[0];
    int loopCount = (int)round(meta.x);

    for (int i = 0; i < loopCount; i++)
    {
        int baseIdx = i * 8 + 1;

        float4 layerSliceAndFlags = _UdonLightData[baseIdx + 6];
        bool diffuseOn = layerSliceAndFlags.y > 0.5;
        if (!diffuseOn) continue;

        float4 lightPosAndBakedIntensity = _UdonLightData[baseIdx + 0];
        float3 lightPos = lightPosAndBakedIntensity.xyz;

        float3 L_vector = lightPos - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        if (distSq > _MaxDynamicDiffuseRangeSq) continue;

        float4 liveColorAndIntensity = _UdonLightData[baseIdx + 1];
        float3 currentCol = liveColorAndIntensity.rgb * liveColorAndIntensity.w;

        float  invDist = rsqrt(max(distSq, 1e-6));
        float3 L_norm  = L_vector * invDist;

        float4 forwardAndCosOuter = _UdonLightData[baseIdx + 2];
        float4 rangesAndType      = _UdonLightData[baseIdx + 7];
        int    lightType          = (int)round(rangesAndType.z);

        float spotMask = _UdonRTSpotMask(L_norm, forwardAndCosOuter.xyz, forwardAndCosOuter.w, rangesAndType.w);
        float areaMask = _UdonRTAreaMask(L_norm, forwardAndCosOuter.xyz);
        float dirMask  = (lightType == 0) ? 1.0 : ((lightType == 1) ? spotMask : areaMask);

        float nDotL         = saturate(dot(N, L_norm));
        float falloff       = rcp(max(distSq, _MinLightRadius * _MinLightRadius));
        float windowFalloff = _UdonRTSq(saturate(1.0 - _UdonRTSq(distSq * rcp(_MaxDynamicDiffuseRangeSq))));
        falloff *= windowFalloff;

        bool wantsShadow = rangesAndType.y > 0.5;

        float ssShadow = _UdonRTComputeScreenSpaceShadow(WorldPos, lightPos, N, wantsShadow);
        float mapShadow = _UdonRTComputeShadowMapAtten(WorldPos, wantsShadow);
        float shadowAtten = min(ssShadow, mapShadow);

        diffuse += currentCol * _DynamicDiffuseBoost * nDotL * dirMask * falloff * shadowAtten;
    }

    return diffuse;
}
#endif
