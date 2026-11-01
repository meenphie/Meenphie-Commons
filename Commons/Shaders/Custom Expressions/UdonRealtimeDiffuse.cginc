// Color map stores the nearest opaque/cutout caster's normalized depth in R.
#ifndef UDON_REALTIME_DIFFUSE
#define UDON_REALTIME_DIFFUSE

uniform float4 _UdonLightData[513];
uniform float  _UdonDiffuseRealtimeEnabled;
uniform float  _UdonRealtimeShadowsEnabled;

// Variables globales venant du script C#
// Shadow globals supplied by ShadowAtlasCaster.
uniform sampler2D _UdonShadowMap;
uniform float4x4  _UdonShadowViewMatrix;
uniform float4x4  _UdonShadowProjectionMatrix;
uniform float     _Udon_LightNear;
uniform float     _Udon_LightFar;

#ifndef UDON_SHADOW_COMMON
    #define UDON_SHADOW_COMMON
    uniform float _UdonShadowRaySteps;
    uniform float _UdonShadowNearCasterExclude;
#endif

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

// Matches ShadowAtlasCaster and the shared layered-lighting shadow projection/depth convention.
float _UdonRTComputeShadowMapAtten(float3 WorldPos, bool wantsShadow)
{
    if (!wantsShadow || _UdonRealtimeShadowsEnabled < 0.5) return 1.0;

    float3 lightView = mul(_UdonShadowViewMatrix, float4(WorldPos, 1.0)).xyz;
    float viewDepth = -lightView.z;
    if (viewDepth < _Udon_LightNear || viewDepth > _Udon_LightFar) return 1.0;

    float4 shadowClip = mul(_UdonShadowProjectionMatrix, float4(lightView, 1.0));
    if (shadowClip.w <= 1e-5) return 1.0;
    float3 shadowNDC = shadowClip.xyz / shadowClip.w;
    float2 shadowUV = shadowNDC.xy * 0.5 + 0.5;

    float2 edgeDist2 = min(shadowUV, 1.0 - shadowUV);
    float edgeDist = min(edgeDist2.x, edgeDist2.y);
    if (edgeDist <= 0.0) return 1.0;

    float receiverDepth = saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));
    float shadowDepth = tex2Dlod(_UdonShadowMap, float4(shadowUV, 0.0, 0.0)).r;
    float atten = (receiverDepth <= shadowDepth + 0.0005) ? 1.0 : 0.0;

    float edgeBlend = smoothstep(0.0, 0.05, edgeDist);
    return lerp(1.0, atten, edgeBlend);
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

        bool wantsShadow = rangesAndType.y >= 0.0;
        float shadowAtten = _UdonRTComputeShadowMapAtten(WorldPos, wantsShadow);

        diffuse += currentCol * _DynamicDiffuseBoost * nDotL * dirMask * falloff * shadowAtten;
    }

    return diffuse;
}
#endif
