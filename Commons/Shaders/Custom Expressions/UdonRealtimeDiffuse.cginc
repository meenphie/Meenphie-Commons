#ifndef UDON_REALTIME_DIFFUSE
#define UDON_REALTIME_DIFFUSE

uniform float4 _UdonLightData[257];
uniform float  _UdonDiffuseRealtimeEnabled;

// ----- Shared shadow uniforms/texture — guarded so this cginc can be included
// alongside UdonSpecularSystem.cginc in the same shader without redeclaring. -----
#ifndef UDON_SHADOW_COMMON
    #define UDON_SHADOW_COMMON
    uniform float _UdonShadowRaySteps;
    uniform float _UdonShadowNearCasterExclude;
    UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
#endif

static const float _RTShadowMaxDist    = 10.0;
static const float _RTShadowMinDist    = 0.05;
static const float _RTShadowBiasEye    = 0.05;
static const float _RTShadowNormalBias = 0.02;

static const float _MaxDynamicDiffuseRange   = 10.0;
static const float _MaxDynamicDiffuseRangeSq = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
static const float _MinLightRadius           = 1.5;
static const float _DynamicDiffuseBoost      = 1.0;

float _UdonRTSq(float x)
    {
return x * x;
    }

float _UdonRTSpotMask(float3 L_norm, float3 lightFwd, float cosOuter, float cosInner)
    {
float cosAngle = dot(-L_norm, lightFwd);
return smoothstep(cosOuter, cosInner, cosAngle);
    }

float _UdonRTAreaMask(float3 L_norm, float3 lightFwd)
    {
return saturate(dot(-L_norm, lightFwd) * 4.0);
    }

// Hard, single-bit screen-space shadow — same rule as the main lighting system.
// This receiving surface is typically ZWrite Off (transparent), so it never appears
// in _CameraDepthTexture itself — no self-shadow risk, no near-caster exclusion needed
// for this object's own geometry. Real occluders (opaque walls/props) still work normally.
float _UdonRTComputeScreenSpaceShadow(float3 WorldPos, float3 lightPos, float3 N, bool wantsShadow)
    {
if (!wantsShadow) return 1.0;

float3 toLight = lightPos - WorldPos;
float  lightDist = length(toLight);
if (lightDist > _RTShadowMaxDist || lightDist < _RTShadowMinDist) return 1.0;

float3 lightDir = toLight / max(lightDist, 1e-6);
float3 offsetLightPos = lightPos + lightDir * 0.15;

float3 biasedPos = WorldPos + N * _RTShadowNormalBias;

float3 offsetToLight = offsetLightPos - biasedPos;
float  offsetLightDist = length(offsetToLight);
float3 rayDir = offsetToLight / max(offsetLightDist, 1e-6);

int steps = clamp((int)_UdonShadowRaySteps, 2, 64);
float stepLen = offsetLightDist / (float)steps;

float NdotL = saturate(dot(N, lightDir));
float bias = _RTShadowBiasEye * (1.0 + offsetLightDist * 0.02) / max(NdotL, 0.1);

for (int i = 1; i <= steps; i++)
        {
float3 worldStep = biasedPos + rayDir * (stepLen * (float)i);

float4 clipStep = mul(UNITY_MATRIX_VP, float4(worldStep, 1.0));
float4 screenStep = ComputeScreenPos(clipStep);

if (clipStep.w <= 0.0) continue;
float2 uv = screenStep.xy / max(clipStep.w, 1e-5);
if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) continue;

float expectedEyeDepth = abs(mul(UNITY_MATRIX_V, float4(worldStep, 1.0)).z);
if (expectedEyeDepth < _UdonShadowNearCasterExclude) continue;

float rawDepth = SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv, 0, 0));
float sampledEyeDepth = LinearEyeDepth(rawDepth);

if (sampledEyeDepth < expectedEyeDepth - bias)
return 0.0;
        }

return 1.0;
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

            // Realtime lights shadow everything, including this transparent receiver —
            // same rule as the main lighting system.
            bool wantsShadow = rangesAndType.y > 0.5;
            float shadowAtten = _UdonRTComputeScreenSpaceShadow(WorldPos, lightPos, N, wantsShadow);

            diffuse += currentCol * _DynamicDiffuseBoost * nDotL * dirMask * falloff * shadowAtten;
        }

return diffuse;
    }

#endif
