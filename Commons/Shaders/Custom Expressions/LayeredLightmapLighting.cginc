#ifndef LAYERED_LIGHTMAP_LIGHTING
    #define LAYERED_LIGHTMAP_LIGHTING

    uniform float4 _UdonLightData[257];

    static const int MAX_PROBES = 16;
    #if defined(SHADER_API_MOBILE)
        UNITY_DECLARE_TEX2DARRAY(_UdonReflectionProbeArray);
    #else
        UNITY_DECLARE_TEXCUBEARRAY(_UdonReflectionProbeArray);
    #endif
    uniform float _UdonReflectionArrayValid;
    uniform float  _UdonReflectionProbeCount;
    uniform float  _UdonReflectionProbeMaxMip;
    uniform float4 _UdonReflectionProbeData[MAX_PROBES * 3];
    uniform float4 _UdonReflectionProbeHDR[MAX_PROBES];

    UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);
    UNITY_DECLARE_TEX2DARRAY(_UdonCookieArray);
    uniform float _UdonCookieArrayValid;

    uniform float _UdonLightLayerArrayValid;
    uniform float _UdonLightmapSliceOffset;
    uniform float _UdonLightType;

    uniform float _UdonDirectionalEnabled;
    uniform float _UdonDiffuseStaticEnabled;
    uniform float _UdonDiffuseRealtimeEnabled;
    uniform float _UdonRealtimeShadowsEnabled;

    uniform float _UdonLODDistanceNear;
    uniform float _UdonLODDistanceFar;
    uniform float _UdonLODMaxMip;

    // Shadow map UNIQUE : opaque ET translucide (dithering côté caster) y
    // écrivent leur depth. Plus de texture de transmittance séparée.
    UNITY_DECLARE_TEX2D(_UdonShadowMap);
    uniform float4 _UdonShadowMap_TexelSize; // auto-rempli par Unity (x=1/width, y=1/height)
    uniform float4x4 _UdonShadowViewMatrix;
    uniform float4x4 _UdonShadowProjectionMatrix;
    uniform float _Udon_LightNear;
    uniform float _Udon_LightFar;

    // Biais réglables depuis Udon (anciennement static const)
    static const float _ShadowMapBias             = 0.0005;
    static const float _ShadowMapSlopeBias        = 0.005;

    static const float _MaxStaticDiffuseRange           = 30.0;
    static const float _MaxStaticDiffuseRangeSq         = _MaxStaticDiffuseRange * _MaxStaticDiffuseRange;
    static const float _MaxDynamicDiffuseRange          = 12.0;
    static const float _MaxDynamicDiffuseRangeSq        = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
    static const half  _DynamicDiffuseBoost             = 1.0h;
    static const float _DynamicDiffuseSmoothing         = 2.0;
    static const float _MinLightRadius                  = 2.5;
    static const float _UdonRealtimeDiffuseWrap         = 0.5;

    static const float _MaxSpecularRange                = 12.0;
    static const float _MaxSpecularRangeSq              = _MaxSpecularRange * _MaxSpecularRange;
    static const half  _StaticSpecBoost                 = 0.2h;
    static const half  _DynamicSpecBoost                = 0.1h;
    static const half  _MaxSpecIntensity                = 10.0h;
    static const float _DynamicSpecularSmoothing        = 2.0;
    static const float _SpecularOcclusionMin            = 0.0;
    static const float _SpecularOcclusionMax            = 1.0;
    static const float _SpecularOcclusionSmoothing      = 0.1;
    static const float _UdonSpecCameraFadeStart         = 0.0;
    uniform float _UdonSpecCameraFadeEnd;

    static const half  _StaticReflectionBoost           = 1.0h;
    static const half  _DynamicReflectionBoost          = 1.0h;
    static const float _DynamicReflectionSmoothing      = 2.0;
    static const float _ReflectionOcclusionMin          = 0.125;
    static const float _ReflectionOcclusionMax          = 1.0;
    static const float _ReflectionOcclusionSmoothing    = 0.1;

    static const half  _NDotVFloor                      = 0.05h;
    static const half  _Alpha2Floor                     = 0.0001h;
    static const float _MathDivisorFloor                = 1e-4;
    static const half  _BRDFDenominatorFloor            = 0.001h;
    static const float _MaxReflectionMipFallback        = 6.0;

    static const half3  LUM     = half3(1.0h, 1.0h, 1.0h);

    #if defined(SHADER_API_MOBILE)
        static const int _UdonMaxLightsMobile = 4;
    #endif

    int _UdonSelectProbe(float3 worldPos)
    {
        int bestBoxProbe = -1;
        float bestBoxVolume = 1e10;

        int bestNoBoxProbe = -1;
        float bestNoBoxDist = 1e10;

        int probeCount = (int)_UdonReflectionProbeCount;

        for (int i = 0; i < probeCount; i++)
        {
            int b = i * 3;
            float3 probePos = _UdonReflectionProbeData[b + 0].xyz;
            float3 boxMin   = _UdonReflectionProbeData[b + 1].xyz;
            float  useBox   = _UdonReflectionProbeData[b + 1].w;
            float3 boxMax   = _UdonReflectionProbeData[b + 2].xyz;

            if (useBox > 0.5)
            {
                if (all(worldPos >= boxMin) && all(worldPos <= boxMax))
                {
                    float3 size = boxMax - boxMin;
                    float volume = size.x * size.y * size.z;
                    if (volume < bestBoxVolume)
                    {
                        bestBoxVolume = volume;
                        bestBoxProbe = i;
                    }
                }
            }
            else
            {
                float dist = distance(worldPos, probePos);
                if (dist < bestNoBoxDist)
                {
                    bestNoBoxDist = dist;
                    bestNoBoxProbe = i;
                }
            }
        }

        if (bestBoxProbe >= 0) return bestBoxProbe;
        return bestNoBoxProbe;
    }

    void _UdonCubeDirToFaceUV(float3 dir, out int face, out float2 uv)
    {
        float3 a = abs(dir);
        bool isX = a.x >= a.y && a.x >= a.z;
        bool isY = a.y > a.x && a.y >= a.z;

        float ma;

        if (isX)
        {
            ma = a.x;
            if (dir.x > 0.0) { face = 0; uv = float2(-dir.z, -dir.y); }
            else             { face = 1; uv = float2( dir.z, -dir.y); }
        }
        else if (isY)
        {
            ma = a.y;
            if (dir.y > 0.0) { face = 2; uv = float2( dir.x,  dir.z); }
            else             { face = 3; uv = float2( dir.x, -dir.z); }
        }
        else
        {
            ma = a.z;
            if (dir.z > 0.0) { face = 4; uv = float2( dir.x, -dir.y); }
            else             { face = 5; uv = float2(-dir.x, -dir.y); }
        }

        ma = max(ma, 1e-5);
        uv = uv / ma * 0.5 + 0.5;
    }

    float4 _UdonSampleProbeArray(int probeIndex, float3 dir, float mip)
    {
        #if defined(SHADER_API_MOBILE)
            int face; float2 uv;
            _UdonCubeDirToFaceUV(dir, face, uv);
            float slice = (float)(probeIndex * 6 + face);
            return UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonReflectionProbeArray, float3(uv, slice), mip);
        #else
            return UNITY_SAMPLE_TEXCUBEARRAY_LOD(_UdonReflectionProbeArray, float4(dir, (float)probeIndex), mip);
        #endif
    }

    half3 _UdonComputeReflectionArray(
    float3 WorldPos, half3 N, half3 vDir, half3 R,
    half nDotV, half Metallic, half Roughness, half3 F0,
    bool isDynamicMesh, half occlusionFactor, int ProbeIndex)
    {
        int probeIdx = (ProbeIndex >= 0) ? (int)ProbeIndex : _UdonSelectProbe(WorldPos);
        if (probeIdx < 0 || (float)probeIdx >= _UdonReflectionProbeCount) return (half3)0;

        int b = probeIdx * 3;
        float3 probePos    = _UdonReflectionProbeData[b + 0].xyz;
        float3 boxMin      = _UdonReflectionProbeData[b + 1].xyz;
        bool   useBoxProj  = _UdonReflectionProbeData[b + 1].w > 0.5;
        float3 boxMax      = _UdonReflectionProbeData[b + 2].xyz;
        float4 hdrDecode   = _UdonReflectionProbeHDR[probeIdx];

        float3 ray = (float3)R;

        if (useBoxProj)
        {
            float3 dir = normalize(ray);
            float3 safeDir = dir + (dir == 0.0 ? 1e-5 : 0.0);
            float3 tMax = (boxMax - WorldPos) / safeDir;
            float3 tMin = (boxMin - WorldPos) / safeDir;
            float3 tHit = lerp(tMin, tMax, step(0.0, safeDir));
            float fa = min(min(tHit.x, tHit.y), tHit.z);
            ray = dir * fa + (WorldPos - probePos);
        }

        float maxMip = (_UdonReflectionProbeMaxMip > 0.0) ? _UdonReflectionProbeMaxMip : _MaxReflectionMipFallback;
        float mipLevel = (float)Roughness * maxMip;

        float4 sampleCube = _UdonSampleProbeArray(probeIdx, ray, mipLevel);
        half3 indirectSpec = (half3)DecodeHDR(sampleCube, hdrDecode);

        half fresnel = pow(1.0h - nDotV, 5.0h);
        half3 F_refl = F0 + (max(half3(1.0h - Roughness, 1.0h - Roughness, 1.0h - Roughness), F0) - F0) * fresnel;
        half boost = isDynamicMesh ? _DynamicReflectionBoost : _StaticReflectionBoost;

        return indirectSpec * F_refl * boost * occlusionFactor;
    }

    half _UdonComputeOcclusionFactor(half rawLum, half lumMin, half lumMax, half smoothing)
    {
        if (smoothing > 0.0h)
        {
            half lowerFadeIn  = smoothstep(lumMin - smoothing, lumMin, rawLum);
            half upperFadeOut = 1.0h - smoothstep(lumMax, lumMax + smoothing, rawLum);
            return lowerFadeIn * upperFadeOut;
        }
        return step(lumMin, rawLum) * step(rawLum, lumMax);
    }

    float _UdonDistanceLODBias(float dist)
    {
        float t = saturate((dist - _UdonLODDistanceNear) * rcp(max(_UdonLODDistanceFar - _UdonLODDistanceNear, 1e-4)));
        t = t * t;
        return t * _UdonLODMaxMip;
    }

    half _UdonSpotMask(half3 L_norm, half3 lightFwd, half cosOuter, half cosInner)
    {
        half cosAngle = dot(-L_norm, lightFwd);
        return smoothstep(cosOuter, cosInner, cosAngle);
    }

    half _UdonAreaMask(half3 L_norm, half3 lightFwd)
    {
        return saturate(dot(-L_norm, lightFwd) * 4.0h);
    }

    float _UdonInvSquare(float distSq) { return rcp(max(distSq, 1e-6)); }
    float Sq(float x) { return x * x; }
    half Sqh(half x) { return x * x; }

    half3 SampleLayerSlice(float2 uv, float sliceIndex, float lodBias)
    {
        return (half3)UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(uv, sliceIndex), lodBias).rgb;
    }

    // Adaptation de la projection à la plateforme
    float4x4 _UdonGetShadowGPUProjection()
    {
        return _UdonShadowProjectionMatrix;
    }

    // Calcul d'ombre avec PCF 2x2 et biais sur normale géométrique
    half _UdonComputeShadowMapShadow(float3 WorldPos, half3 defaultN, half3 L_norm, bool hasShadow)
    {
        if (!hasShadow || _UdonRealtimeShadowsEnabled < 0.5) return 1.0h;

        // Position dans l'espace de vue de la lumière
        float3 lightView = mul(_UdonShadowViewMatrix, float4(WorldPos, 1.0)).xyz;
        float viewDepth = -lightView.z;

        // Projection dans l'espace d'écran de la shadow map
        float4x4 gpuProjection = _UdonGetShadowGPUProjection();
        float4 lightClip = mul(gpuProjection, float4(lightView, 1.0));
        if (lightClip.w <= 1e-5) return 1.0h;
        float3 shadowNDC = lightClip.xyz / lightClip.w;
        float2 shadowUV = shadowNDC.xy * 0.5 + 0.5;

        #if UNITY_UV_STARTS_AT_TOP
            // shadowUV.y = 1.0 - shadowUV.y;
        #endif

        if (shadowUV.x <= 0.0 || shadowUV.x >= 1.0 || shadowUV.y <= 0.0 || shadowUV.y >= 1.0)
        return 1.0h;

        // Profondeur linéaire normalisée (comme dans le shadow caster)
        float myDepth = saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));

        // Biais basé sur la normale géométrique
        float bias = _ShadowMapBias + _ShadowMapSlopeBias * saturate(1.0 - dot((float3)defaultN, (float3)L_norm));

        float2 texel = _UdonShadowMap_TexelSize.xy;
        half atten = 0.0h;

        [unroll]
        for (int y = 0; y <= 1; y++)
        {
            [unroll]
            for (int x = 0; x <= 1; x++)
            {
                float2 uv = shadowUV + (float2(x, y) - 0.5) * texel;
                float storedDepth = UNITY_SAMPLE_TEX2D_LOD(_UdonShadowMap, uv, 0).r;
                atten += (myDepth - bias <= storedDepth) ? 1.0h : 0.0h;
            }
        }
        return atten * 0.25h;
    }

    void _UdonAccumulateLight(
    int    baseIdx,
    float3 WorldPos, half3 N, half3 defaultN, half3 R, half3 vDir,
    float  effectiveLod, half  nDotV,
    half3 F0, half alpha2, half k, half Gv,
    float2 MainUV, float2 LightmapUV,
    bool   isDynamicMesh,
    bool   arrayValid,
    bool   specularGlobalEnabled,
    bool   diffuseStaticEnabled,
    bool   diffuseRealtimeEnabled,
    int    materialMask,
    out half3 diffOut,
    out half3 specOut)
    {
        diffOut = (half3)0;
        specOut = (half3)0;

        float4 layerSliceAndFlags = _UdonLightData[baseIdx + 6];
        int lightGroupMask = (int)round(layerSliceAndFlags.w);
        if (materialMask != 0 && (materialMask & lightGroupMask) == 0) return;

        float4 lightPosAndBakedIntensity = _UdonLightData[baseIdx + 0];
        float4 liveColorAndIntensity     = _UdonLightData[baseIdx + 1];
        float4 forwardAndCosOuter        = _UdonLightData[baseIdx + 2];
        float4 rightAndWidth             = _UdonLightData[baseIdx + 3];
        float4 upAndHeight               = _UdonLightData[baseIdx + 4];
        float4 bakedColorAndRealtimeFlag = _UdonLightData[baseIdx + 5];
        float4 rangesAndType             = _UdonLightData[baseIdx + 7];

        bool diffuseOn  = layerSliceAndFlags.y > 0.5;
        bool specularOn = layerSliceAndFlags.z > 0.5;
        bool isBaked    = (!isDynamicMesh) && (bakedColorAndRealtimeFlag.w < 0.5);

        #if defined(SHADER_API_MOBILE)
            bool canSpecularBase = specularOn && specularGlobalEnabled && !isBaked;
        #else
            bool canSpecularBase = specularOn && specularGlobalEnabled;
        #endif

        float3 lightPos = lightPosAndBakedIntensity.xyz;
        float3 L_vector = lightPos - WorldPos;
        float  distSq   = dot(L_vector, L_vector);

        if (isBaked)
        {
            bool canStaticDiffuse = diffuseStaticEnabled && arrayValid && (layerSliceAndFlags.x >= 0) && diffuseOn;
            bool canSpecular      = canSpecularBase;
            if (!canStaticDiffuse && !canSpecular) return;
            if (canStaticDiffuse && distSq <= _MaxStaticDiffuseRangeSq) {}
            else if (canSpecular && distSq <= _MaxSpecularRangeSq) {}
            else return;
        }
        else
        {
            bool canRealtimeDiffuse = diffuseRealtimeEnabled && diffuseOn;
            bool canSpecular = canSpecularBase && diffuseRealtimeEnabled;
            if (!canRealtimeDiffuse && !canSpecular) return;
            if (canRealtimeDiffuse && distSq <= _MaxDynamicDiffuseRangeSq) {}
            else if (canSpecular && distSq <= _MaxSpecularRangeSq) {}
            else return;
        }

        float  invDist  = rsqrt(max(distSq, 1e-6));
        half3  L_norm   = (half3)(L_vector * invDist);
        half3  dirVec   = (half3)forwardAndCosOuter.xyz;
        half   cosOuter = (half)forwardAndCosOuter.w;
        half   cosInner = (half)rangesAndType.w;
        int    lightType = (int)round(rangesAndType.z);

        half spotMask = _UdonSpotMask(L_norm, dirVec, cosOuter, cosInner);
        half areaMask = _UdonAreaMask(L_norm, dirVec);
        half dirMask = (lightType == 0) ? 1.0h : ((lightType == 1) ? spotMask : areaMask);

        bool skippableByDirMask = !(isBaked && diffuseOn);
        if (dirMask <= 1e-4h && skippableByDirMask) return;

        half3 currentCol = (half3)(liveColorAndIntensity.rgb * liveColorAndIntensity.w);
        half  bakedInt   = max((half)lightPosAndBakedIntensity.w, (half)_MathDivisorFloor);
        half  liveInt    = (half)liveColorAndIntensity.w;

        half shadowAtten = 1.0h;
        half cookieAtten = 1.0h;
        int   shadowSlice = (int)round(rangesAndType.y);

        #if defined(SHADER_API_MOBILE)
            bool wantsShadow  = false;
            bool cookieNeeded = false;
        #else
            bool  wantsShadow = (shadowSlice >= 0) && !isBaked;
            bool  cookieNeeded = (!isBaked) || (specularOn && specularGlobalEnabled);
        #endif

        if (wantsShadow)
        shadowAtten = _UdonComputeShadowMapShadow(WorldPos, defaultN, L_norm, true);

        if (cookieNeeded)
        {
            int cookieSlice = (int)round(rangesAndType.x);
            if (_UdonCookieArrayValid > 0.5 && cookieSlice >= 0 && lightType != 0)
            {
                float3 lightToWorld = WorldPos - lightPos;
                float z = dot(lightToWorld, (float3)dirVec);
                float2 cookieUV = float2(-1.0, -1.0);
                if (z > 0.0)
                {
                    float x = dot(lightToWorld, rightAndWidth.xyz);
                    float y = dot(lightToWorld, upAndHeight.xyz);
                    if (lightType == 1) // Spot
                    {
                        float tanHalfAngle = sqrt(max(0.0, 1.0 - (float)cosOuter * (float)cosOuter)) * rcp(max((float)cosOuter, 1e-4));
                        float2 projUV = float2(x, y) / (z * tanHalfAngle);
                        cookieUV = projUV * 0.5 + 0.5;
                    }
                    else if (lightType == 2) // Area
                    {
                        float2 projUV = float2(x, y) / max(float2(rightAndWidth.w, upAndHeight.w) * 2.0, 1e-4);
                        cookieUV = projUV + 0.5;
                    }
                }
                float2 inBounds2 = step(0.0, cookieUV) * step(cookieUV, 1.0);
                float cookieSample = saturate(UNITY_SAMPLE_TEX2DARRAY(_UdonCookieArray, float3(cookieUV, (float)cookieSlice)).r);
                cookieAtten = (half)(cookieSample * inBounds2.x * inBounds2.y);
            }
        }

        // ====================================================================
        // DIFFUS
        // ====================================================================
        if (diffuseOn)
        {
            if (isBaked)
            {
                if (diffuseStaticEnabled && arrayValid && (layerSliceAndFlags.x >= 0) && distSq <= _MaxStaticDiffuseRangeSq)
                {
                    float baseSlice = (float)layerSliceAndFlags.x * 1.0 + _UdonLightmapSliceOffset;
                    half3 bakedTransfer = SampleLayerSlice(LightmapUV, baseSlice, effectiveLod);

                    half3 layerSample;
                    if (_UdonDirectionalEnabled > 0.5h)
                    {
                        half diff = dot(N, L_norm) - dot(defaultN, L_norm);
                        half t = saturate(diff + 0.5h);
                        t = t * t * (3.0h - 2.0h * t);
                        layerSample = bakedTransfer * (t * 2.0h);
                    }
                    else
                    {
                        layerSample = bakedTransfer;
                    }

                    half intensityRatio = saturate((half)liveColorAndIntensity.w / max((half)bakedInt, 0.001h));
                    layerSample *= intensityRatio;
                    diffOut += layerSample;
                }
            }
            else
            {
                if (diffuseRealtimeEnabled && distSq <= _MaxDynamicDiffuseRangeSq)
                {
                    half rawNoL = dot(N, L_norm);
                    half nDotL = saturate((rawNoL + _UdonRealtimeDiffuseWrap) / (1.0h + _UdonRealtimeDiffuseWrap));
                    half diffFalloff = (half)rcp(max(distSq, _MinLightRadius * _MinLightRadius));
                    half t = (half)(distSq * rcp(_MaxDynamicDiffuseRangeSq));
                    half windowFalloff = 1.0h - smoothstep(1.0h - (half)_DynamicDiffuseSmoothing, 1.0h, t);
                    diffFalloff *= windowFalloff;
                    diffOut += (currentCol * _DynamicDiffuseBoost) * nDotL * dirMask * diffFalloff * cookieAtten * shadowAtten;
                }
            }
        }

        // ====================================================================
        // SPÉCULAIRE
        // ====================================================================
        if (!canSpecularBase) return;

        float3 cameraToPixel = _WorldSpaceCameraPos - WorldPos;
        float camDistSq = dot(cameraToPixel, cameraToPixel);
        float specCameraFadeEnd = max(_UdonSpecCameraFadeEnd, 0.0);
        if (camDistSq >= specCameraFadeEnd * specCameraFadeEnd) return;
        float camDistToPixel = sqrt(camDistSq);
        half camFade = 1.0h;
        if (camDistToPixel > _UdonSpecCameraFadeStart)
        camFade = 1.0h - (half)smoothstep(_UdonSpecCameraFadeStart, specCameraFadeEnd, camDistToPixel);

        if (distSq > _MaxSpecularRangeSq) return;

        // Point représentatif
        float3 repDiff;
        {
            float3 R_f = (float3)R;
            float3 pointRep = L_vector;
            float RdotL = dot(R_f, L_vector);
            float3 rayOffset = L_vector - R_f * RdotL;
            float lightRadius = max(rightAndWidth.w, upAndHeight.w);
            float lenSq = dot(rayOffset, rayOffset);
            float invLen = rsqrt(max(lenSq, lightRadius * lightRadius));
            float3 repDir = rayOffset * invLen;
            float3 spotRep = L_vector - repDir * lightRadius;
            float3 wPos = lightPos - L_vector;
            float tRay = max(dot(L_vector, R_f), 0.0);
            float3 pRefl = wPos + R_f * tRay;
            float3 lp = pRefl - lightPos;
            float2 localP = float2(dot(lp, rightAndWidth.xyz), dot(lp, upAndHeight.xyz));
            float2 clampP = clamp(localP, -float2(rightAndWidth.w, upAndHeight.w), float2(rightAndWidth.w, upAndHeight.w));
            float3 areaRep = lightPos + rightAndWidth.xyz * clampP.x + upAndHeight.xyz * clampP.y - wPos;
            repDiff = (lightType == 0) ? pointRep : ((lightType == 1) ? spotRep : areaRep);
        }

        float repDistSq = max(dot(repDiff, repDiff), 1e-6);
        half3 lDir = (half3)(repDiff * rsqrt(repDistSq));
        half3 H = normalize(lDir + vDir);
        half nDotH = saturate(dot(N, H));
        half nDotL_spec = saturate(dot(N, lDir));
        if (nDotL_spec <= 0.0h) return;

        half specFalloff = (half)rcp(max(repDistSq, _MinLightRadius * _MinLightRadius));
        half specWindowFalloff;
        if (!isBaked)
        {
            half t = (half)(distSq * rcp(_MaxSpecularRangeSq));
            specWindowFalloff = 1.0h - smoothstep(1.0h - (half)_DynamicSpecularSmoothing, 1.0h, t);
        }
        else
        {
            specWindowFalloff = Sqh(saturate(1.0h - Sqh((half)(distSq * rcp(_MaxSpecularRangeSq)))));
        }
        specFalloff *= specWindowFalloff;

        half d_denom = nDotH * nDotH * (alpha2 - 1.0h) + 1.0h;
        half D = alpha2 * rcp(max(3.14159265h * d_denom * d_denom, 1e-7h));
        half Gl = nDotL_spec * rcp(max(nDotL_spec * (1.0h - k) + k, (half)_MathDivisorFloor));
        half G = Gv * Gl;

        half hDotV = saturate(dot(H, vDir));
        half oneMinusH = 1.0h - hDotV;
        half oneMinusH2 = oneMinusH * oneMinusH;
        half fCurve = oneMinusH2 * oneMinusH2 * oneMinusH;
        half3 fresnel = F0 + (1.0h - F0) * fCurve;

        half brdf = D * G * rcp(max(4.0h * nDotV * nDotL_spec, _BRDFDenominatorFloor)) * dirMask;
        half currentSpecBoost = isBaked ? _StaticSpecBoost : _DynamicSpecBoost;

        specOut = max((half3)0, currentCol * fresnel * brdf * specFalloff * camFade * currentSpecBoost * cookieAtten * shadowAtten);
        specOut = min(specOut, (half3)_MaxSpecIntensity);
    }



    float3 LayeredLightmapLighting(
    float3 Color,
    float Metallic,
    float Roughness,
    float3 ViewDir,
    float3 WorldPos,
    float3 DefaultNormal,
    float3 WorldNormal,
    float2 MainUV,
    float2 LightmapUV,
    float LightGroupMask,
    float IsDynamicMesh,
    float ProbeIndex,
    out float3 Diffuse,
    out float3 Specular,
    out float3 Reflection)
    {
        Diffuse = 0;
        Specular = 0;
        Reflection = 0;

        float4 meta = _UdonLightData[0];
        int loopCount = (int)round(meta.x);
        bool reflectionGlobalEnabled = meta.z > 0.5;
        bool specularGlobalEnabled = meta.w > 0.5;
        bool isDynamicMesh = IsDynamicMesh > 0.5;
        bool diffuseStaticEnabled = _UdonDiffuseStaticEnabled > 0.5;
        bool diffuseRealtimeEnabled = _UdonDiffuseRealtimeEnabled > 0.5;
        bool diffuseAnyEnabled = diffuseStaticEnabled || diffuseRealtimeEnabled;


        bool arrayValid = _UdonLightLayerArrayValid > 0.5;

        if (loopCount < 1)
        {
            return Diffuse;
        }

        half3 N = (half3)normalize(WorldNormal);
        half3 defaultN = (half3)normalize(DefaultNormal);
        half3 vDir = (half3)normalize(ViewDir);
        half3 R = reflect(-vDir, N);
        float camDist = distance(_WorldSpaceCameraPos, WorldPos);
        float effectiveLod = _UdonDistanceLODBias(camDist);
        half nDotV = max(dot(N, vDir), _NDotVFloor);

        half alpha2 = _Alpha2Floor;
        half k = 0.0h;
        half Gv = 0.0h;
        if (specularGlobalEnabled)
        {
            half alpha = (half)Roughness * (half)Roughness;
            alpha2 = max(alpha * alpha, _Alpha2Floor);
            k = alpha * 0.5h;
            Gv = nDotV * rcp(max(nDotV * (1.0h - k) + k, (half)_MathDivisorFloor));
        }

        half3 F0 = lerp(half3(0.04h, 0.04h, 0.04h), (half3)Color, (half)Metallic);
        int materialMask = (int)round(LightGroupMask);

        half3 diffAcc = half3(0,0,0);
        half3 specAccBaked = half3(0,0,0);
        half3 specAccRealtime = half3(0,0,0);

        #if defined(SHADER_API_MOBILE)
            int effectiveLoopCount = min(loopCount, _UdonMaxLightsMobile);
        #else
            int effectiveLoopCount = loopCount;
        #endif

        for (int i = 0; i < effectiveLoopCount; i++)
        {
            int baseIdx = i * 8 + 1;
            half3 diffC, specC;
            _UdonAccumulateLight(baseIdx, WorldPos, N, defaultN, R, vDir, effectiveLod,
            nDotV, F0, alpha2, k, Gv,
            MainUV, LightmapUV,
            isDynamicMesh, arrayValid, specularGlobalEnabled,
            diffuseStaticEnabled, diffuseRealtimeEnabled,
            materialMask, diffC, specC);
            diffAcc += diffC;

            float4 bakedFlag = _UdonLightData[baseIdx + 5];
            bool lightIsBaked = (!isDynamicMesh) && (bakedFlag.w < 0.5);
            if (lightIsBaked)
            specAccBaked += specC;
            else
            specAccRealtime += specC;
        }

        half rawDiffLum = dot(diffAcc, LUM);
        half occlusionFactor = 1.0h;
        #if defined(_DIFFUSE_ON)
            if (diffuseAnyEnabled)
            {
                half occRaw = saturate(rawDiffLum);
                occlusionFactor = _UdonComputeOcclusionFactor(occRaw,
                (half)_ReflectionOcclusionMin, (half)_ReflectionOcclusionMax, (half)_ReflectionOcclusionSmoothing);
            }
        #endif

        half3 refl = 0;
        if (Roughness < 0.99 && reflectionGlobalEnabled && _UdonReflectionArrayValid > 0.5)
        {
            int probeIdx = (int)round(ProbeIndex);
            refl = _UdonComputeReflectionArray(WorldPos, N, vDir, R, nDotV, (half)Metallic, (half)Roughness, F0, isDynamicMesh, occlusionFactor, probeIdx);
        }

        if (diffuseAnyEnabled)
        {
            half specOcclusionFactor = 1.0h;
            if (diffuseAnyEnabled)
            {
                half occRawSpec = saturate(rawDiffLum);
                specOcclusionFactor = _UdonComputeOcclusionFactor(occRawSpec,
                (half)_SpecularOcclusionMin, (half)_SpecularOcclusionMax, (half)_SpecularOcclusionSmoothing);
            }

            half3 dielectricDiffuse = diffAcc * (half3)Color * (1.0h - (half)Metallic);
            half metalScatterAmount = (half)Metallic * (half)Roughness * (half)Roughness * (half)Roughness;
            half3 metalScatter = diffAcc * F0 * metalScatterAmount;
            Diffuse = (float3)(dielectricDiffuse + metalScatter);

            Specular = (float3)(specAccBaked * specOcclusionFactor + specAccRealtime);
            Reflection = (float3)refl;

            return Diffuse + Specular + Reflection;
        }
        else
        {
            Specular = (float3)(specAccBaked + specAccRealtime);
            Reflection = (float3)refl;
            return Specular + Reflection;
        }
    }
#endif