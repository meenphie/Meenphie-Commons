#ifndef UDON_SPECULAR_SYSTEM
    #define UDON_SPECULAR_SYSTEM

    #ifndef UDON_SPECULAR_SYSTEM_PROPERTIES
        #define UDON_SPECULAR_SYSTEM_PROPERTIES

        uniform float4 _UdonLightData[257];
        UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);

        uniform float _UdonLightLayerArrayValid;
        uniform float _UdonLightmapSliceOffset;
        uniform float _UdonLightType;

        // Distance-based LOD bias (bandwidth optimization)
        uniform float _UdonLODDistanceNear;   
        uniform float _UdonLODDistanceFar;
        uniform float _UdonLODMaxMip;

        // Lighting Tweaks
        static const float _StaticSpecBoost = 0.5;
        static const float _RealtimeSpecBoost = 0.01;
        static const float _DiffBoost = 0.25;
        static const float _StaticReflectionBoost = 2.0;
        static const float _DynamicReflectionBoost = 3.0;
        static const float _MaxDiffuse = 1.0;
        static const float3 _FallbackAmbient = float3(0.02, 0.02, 0.02);
        


        // Clamping & Safeguard Constants
        static const float _NDotVFloor = 0.05;
        static const float _Alpha2Floor = 0.0001;
        static const float _MathDivisorFloor = 1e-4;
        static const float _BRDFDenominatorFloor = 0.001;
        static const float _MaxReflectionMip = 6.0;

        // Math Constants
        static const float3 _BasisX = float3( 0.81649658,  0.0,        0.57735027);
        static const float3 _BasisY = float3(-0.40824829,  0.70710678, 0.57735027);
        static const float3 _BasisZ = float3(-0.40824829, -0.70710678, 0.57735027);
        static const float3 LUM = float3(1.0, 1.0, 1.0);

        // Masking Setup
        static const float3 _LightmapMaskVec = float3(1.0, 1.0, 1.0);
        static const float  _LightmapMaskMin = 0.0;
        static const float  _LightmapMaskMax = 0.05;

        //Diffuse
        static const float DIFFUSE_MASK_THRESHOLD = 6.0;
        static const float DIFFUSE_MASK_SMOOTHING = 2.0;
        //Speculars
        static const float SPEC_MASK_THRESHOLD = 0.3;
        static const float SPEC_MASK_SMOOTHING = 0.3;
        //Reflections
        static const float _ReflectionOcclusionStrength = 0.98;
        static const float _ReflectionOcclusionMin = 0.0;
    #endif

    float _UdonDistanceLODBias(float dist)
    {
        float t = saturate((dist - _UdonLODDistanceNear) / max(_UdonLODDistanceFar - _UdonLODDistanceNear, 1e-4));
        t = t * t; // ease-in : reste net proche, monte vite loin
        return t * _UdonLODMaxMip;
    }

    float _UdonLightFade(float dist, float maxDist)
    {
        float t = saturate(dist / max(maxDist, 1e-4));
        float w = 1.0 - t * t * t * t;
        w = w * w;
        return saturate(w);
    }

    float _UdonSpotMask(float3 L_norm, float3 lightFwd, float cosOuter, float cosInner)
    {
        float cosAngle = dot(-L_norm, lightFwd);
        return smoothstep(cosOuter, cosInner, cosAngle);
    }

    float _UdonAreaMask(float3 L_norm, float3 lightFwd)
    {
        return saturate(dot(-L_norm, lightFwd) * 4.0);
    }

    float _UdonDiffuseFalloff(float distSq)
    {
        return 1.0 / max(distSq, 1e-4);
    }

    float3 SampleLayerSlice(float2 uv, float sliceIndex, float lodBias)
    {
        return UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(uv, sliceIndex), lodBias).rgb;
    }

    // ─────────────────────────────────────────────
    // Shared diffuse-threshold mask (was duplicated verbatim in two places)
    // ─────────────────────────────────────────────
    float _UdonDiffuseThresholdMask(float evaluationValue)
    {
        float thresholdMask;
        if (DIFFUSE_MASK_SMOOTHING > 0.0)
        thresholdMask = smoothstep(DIFFUSE_MASK_THRESHOLD - DIFFUSE_MASK_SMOOTHING, DIFFUSE_MASK_THRESHOLD, evaluationValue);
        else
        thresholdMask = evaluationValue < DIFFUSE_MASK_THRESHOLD ? 0.0 : 1.0;

        #if defined(_DIFFUSEMASKEDLIGHTS_ON)
            thresholdMask = 1.0 - thresholdMask;
        #endif

        return thresholdMask;
    }

    // ─────────────────────────────────────────────
    // Lightmap layer mask setup (specMask / skipSpecularReflection)
    // ─────────────────────────────────────────────
    void _UdonComputeSpecMask(
    bool   isDynamicMesh,
    bool   arrayValid,
    float  LightGroupMask,
    float2 LightmapUV,
    float  Roughness,
    out float specMask,
    out float maskLum,
    out bool  skipSpecularReflection)
    {
        specMask = 1.0;
        maskLum = 0.0;
        skipSpecularReflection = false;

        if (isDynamicMesh) return;

        if (!arrayValid)
        {
            specMask = 0.0;
            return;
        }

        float  maskSlice  = log2(max(LightGroupMask, 1.0));
        float3 maskSample = UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(LightmapUV, maskSlice), 0.0).rgb;
        maskLum = dot(maskSample, _LightmapMaskVec);

        if (SPEC_MASK_SMOOTHING > 0.0)
        skipSpecularReflection = maskLum <= (SPEC_MASK_THRESHOLD - SPEC_MASK_SMOOTHING);
        else
        skipSpecularReflection = maskLum < SPEC_MASK_THRESHOLD;

        specMask = (!skipSpecularReflection && Roughness < 0.99) ? smoothstep(_LightmapMaskMin, _LightmapMaskMax, maskLum) : 0.0;
    }

    // ─────────────────────────────────────────────
    // Diffuse + specular contribution from a single light.
    // Light type is now passed as an integer: 0=point, 1=spot, 2=area.
    // The heavy specular data (rightVec, upVec, halfSize) is read only when
    // specular is actually needed.
    // ─────────────────────────────────────────────
    void _UdonAccumulateLight(
    int    baseIdx,
    float3 WorldPos,
    float3 N,
    float3 R,
    float3 vDir,
    float  camDist,
    float  nDotV,
    float3 F0,
    float  alpha2,
    float  k,
    float  Gv,
    float  w1, float w2, float w3,
    float2 LightmapUV,
    float  rangeScale,
    bool   isDynamicMesh,
    bool   arrayValid,
    bool   specularGlobalEnabled,
    float  specMask,
    int    materialMask,
    out float3 diffOut,
    out float3 specOut)
    {
        diffOut = float3(0, 0, 0);
        specOut = float3(0, 0, 0);

        // ── Light common data (needed for diffuse) ──
        float4 lightPosAndBakedIntensity    = _UdonLightData[baseIdx + 0];
        float4 liveColorAndIntensity     = _UdonLightData[baseIdx + 1];
        float4 forwardAndCosOuter = _UdonLightData[baseIdx + 2];
        float4 bakedColorAndRealtimeFlag  = _UdonLightData[baseIdx + 5];
        float4 layerSliceAndFlags    = _UdonLightData[baseIdx + 6];
        float4 rangesAndType    = _UdonLightData[baseIdx + 7];

        int lightGroupMask = (int)round(layerSliceAndFlags.w);
        if (materialMask != 0 && (materialMask & lightGroupMask) == 0) return;

        float3 lightPos  = lightPosAndBakedIntensity.xyz;
        float  bakedInt  = max(lightPosAndBakedIntensity.w, _MathDivisorFloor);
        float3 liveCol   = liveColorAndIntensity.rgb;
        float  liveInt   = liveColorAndIntensity.w;
        float3 bakedCol  = bakedColorAndRealtimeFlag.rgb;
        bool   isBaked   = (!isDynamicMesh) && (bakedColorAndRealtimeFlag.w < 0.5);

        float3 currentCol = liveCol * liveInt;
        float  range      = sqrt(bakedInt) * rangeScale;

        float3 L_vector = lightPos - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        float  dist     = sqrt(max(distSq, 1e-6));
        float  invDist  = rsqrt(max(distSq, 1e-6));
        float3 L_norm   = L_vector * invDist;

        // Distance-adaptive LOD
        float distLodBias  = _UdonDistanceLODBias(camDist);
        float effectiveLod = distLodBias;

        float3 dirVec   = forwardAndCosOuter.xyz;
        float  cosOuter = forwardAndCosOuter.w;
        float cosInner = rangesAndType.w;

        bool isPointLight = cosOuter < -0.9;
        int lightType = isPointLight ? 0 : (cosOuter <= 0.0 ? 2 : 1);

        float dirMask = 1.0;
        if (lightType == 1)      // spot
        dirMask = _UdonSpotMask(L_norm, dirVec, cosOuter, cosInner);
        else if (lightType == 2) // area
        dirMask = _UdonAreaMask(L_norm, dirVec);

        int  sliceIndex = (int)round(layerSliceAndFlags.x);
        bool hasLayer   = sliceIndex >= 0;
        bool diffuseOn  = layerSliceAndFlags.y > 0.5;
        bool specularOn = layerSliceAndFlags.z > 0.5;   // still specular enable flag

        float nDotL = saturate(dot(N, L_norm));

        // ── Diffuse ranges ──
        float maxDiffuseDist          = rangesAndType.y;
        float maxSpecDist             = rangesAndType.x;

        float effectiveDiffuseRange   = (maxDiffuseDist > 0.0) ? maxDiffuseDist : range;
        float effectiveDiffuseRangeSq = effectiveDiffuseRange * effectiveDiffuseRange;

        float3 layerSample = float3(0, 0, 0);
        if (diffuseOn)
        {
            if (isBaked)
            {
                bool withinDiffuseRange = (effectiveDiffuseRange <= 0.0) || (distSq <= effectiveDiffuseRangeSq);
                if (arrayValid && hasLayer && withinDiffuseRange)
                {
                    float  baseSlice = (float)sliceIndex * 3.0 + _UdonLightmapSliceOffset;
                    float3 sampleX = SampleLayerSlice(LightmapUV, baseSlice + 0.0, effectiveLod);
                    float3 sampleY = SampleLayerSlice(LightmapUV, baseSlice + 1.0, effectiveLod);
                    float3 sampleZ = SampleLayerSlice(LightmapUV, baseSlice + 2.0, effectiveLod);
                    layerSample = sampleX * w1 + sampleY * w2 + sampleZ * w3;
                    diffOut += layerSample * (liveInt / bakedInt);
                }
            }
            else
            {
                float diffFalloff = _UdonDiffuseFalloff(distSq) * _UdonLightFade(dist, effectiveDiffuseRange);
                diffOut += (currentCol * _DiffBoost) * nDotL * dirMask * diffFalloff;
            }
        }

        // ── Specular (only if needed) ──
        if (!specularOn || !specularGlobalEnabled || specMask <= 0.0) return;

        float effectiveSpecularRange   = (maxSpecDist > 0.0) ? maxSpecDist : range;
        float effectiveSpecularRangeSq = effectiveSpecularRange * effectiveSpecularRange;
        if (effectiveSpecularRange <= 0.0 || distSq > effectiveSpecularRangeSq) return;

        // ── Load additional specular geometry (right/up vectors, half extents) ──
        float4 rightAndWidth  = _UdonLightData[baseIdx + 3];
        float4 upAndHeight    = _UdonLightData[baseIdx + 4];
        float3 rightVec  = rightAndWidth.xyz;
        float3 upVec     = upAndHeight.xyz;
        float2 halfSize  = float2(rightAndWidth.w, upAndHeight.w);

        float specFade = _UdonLightFade(dist, effectiveSpecularRange);

        // ── Representative point for specular ──
        float3 repDiff;
        if (lightType == 0) // point
        {
            repDiff = L_vector;
        }
        else if (lightType == 1) // spot
        {
            float  RdotL       = dot(R, L_norm);
            float3 rayOffset   = L_vector - R * RdotL;
            float  lightRadius = max(halfSize.x, halfSize.y);
            float3 repDir      = rayOffset / max(length(rayOffset), lightRadius);
            repDiff = L_vector - repDir * lightRadius;
        }
        else // area (2)
        {
            float3 wPos   = lightPos - L_vector;
            float  tRay   = max(dot(L_vector, R), 0.0);
            float3 pRefl  = wPos + R * tRay;
            float3 lp     = pRefl - lightPos;
            float2 localP = float2(dot(lp, rightVec), dot(lp, upVec));
            float2 clampP = clamp(localP, -halfSize, halfSize);
            repDiff = lightPos + rightVec * clampP.x + upVec * clampP.y - wPos;
        }

        float  repDistSq  = max(dot(repDiff, repDiff), 1e-6);
        float3 lDir       = repDiff * rsqrt(repDistSq);
        float3 H          = normalize(lDir + vDir);
        float  nDotH      = saturate(dot(N, H));
        float  nDotL_spec = saturate(dot(N, lDir));

        if (nDotL_spec <= 0.0) return;

        // ── Specular shadow estimation ──
        float shadowEstimate = 1.0;
        if (arrayValid && isBaked && hasLayer)
        {
            float ownLum = dot(layerSample, LUM);
            if (ownLum < 0.0001)
            {
                shadowEstimate = 0.0;
            }
            else
            {
                float unshadowed = nDotL_spec * dirMask;
                float theoLum    = dot(bakedCol * bakedInt * unshadowed, LUM);
                shadowEstimate   = saturate(ownLum / max(theoLum, _MathDivisorFloor));
            }
        }

        // ── Cook-Torrance BRDF ──
        float  d_denom = (nDotH * nDotH) * (alpha2 - 1.0) + 1.0;
        float  D       = alpha2 / max(3.14159265 * d_denom * d_denom, 1e-7);
        float  Gl      = nDotL_spec / max(nDotL_spec * (1.0 - k) + k, _MathDivisorFloor);
        float  G       = Gv * Gl;
        float  hDotV   = saturate(dot(H, vDir));
        float  fCurve  = exp2((-5.55473 * hDotV - 6.98316) * hDotV);
        float3 F       = F0 + (1.0 - F0) * fCurve;

        float unshadowedDiffuse = nDotL_spec * dirMask;
        float brdf = (D * G / max(4.0 * nDotV * nDotL_spec, _BRDFDenominatorFloor)) * unshadowedDiffuse;

        float currentSpecBoost = isBaked ? _StaticSpecBoost : _RealtimeSpecBoost;

        specOut = max(float3(0, 0, 0), currentCol * F * brdf * shadowEstimate * specFade * specMask * currentSpecBoost);
    }

    // ─────────────────────────────────────────────
    // Indirect cubemap reflection.
    // ─────────────────────────────────────────────
    float3 _UdonComputeReflection(
    float3 WorldPos,
    float3 N,
    float3 vDir,
    float3 R,
    float  nDotV,
    float  Metallic,
    float  Roughness,
    float3 F0,
    bool   isDynamicMesh,
    float  occlusionFactor)
    {
        float3 ray = R;
        if (unity_SpecCube0_ProbePosition.w > 0.0)
        {
            float3 rbMax    = (unity_SpecCube0_BoxMax.xyz - WorldPos) / (ray + 1e-6);
            float3 rbMin    = (unity_SpecCube0_BoxMin.xyz - WorldPos) / (ray - 1e-6);
            float3 rbMinMax = (ray > 0.0) ? rbMax : rbMin;
            float  fa       = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
            ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
        }

        float mipLevel      = Roughness * _MaxReflectionMip;
        float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
        float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);

        float  fresnel = pow(1.0 - nDotV, 5.0);
        float3 F_refl  = F0 + (max(float3(1.0 - Roughness, 1.0 - Roughness, 1.0 - Roughness), F0) - F0) * fresnel;

        float currentReflectionBoost = isDynamicMesh ? _DynamicReflectionBoost : _StaticReflectionBoost;

        return indirectSpec * F_refl * currentReflectionBoost * occlusionFactor;
    }

    // ─────────────────────────────────────────────
    // Main entry point
    // ─────────────────────────────────────────────
    float3 LayeredLightmapLighting(
    float3 Color,
    float  Metallic,
    float  Roughness,
    float3 ViewDir,
    float3 WorldPos,
    float3 Normal,
    float3 WorldNormal,
    float2 LightmapUV,
    float  LightGroupMask,
    float  IsDynamicMesh,
    out float3 DiffuseMaskedLights,
    out float3 Diffuse,
    out float3 Specular,
    out float3 Reflection
    )
    {
        DiffuseMaskedLights = float3(0, 0, 0);
        Diffuse             = float3(0, 0, 0);
        Specular            = float3(0, 0, 0);
        Reflection          = float3(0, 0, 0);

        float4 meta                  = _UdonLightData[0];
        int    loopCount             = (int)round(meta.x);
        float  rangeScale            = meta.y;
        bool   specularGlobalEnabled = meta.w > 0.5;
        bool   isDynamicMesh         = IsDynamicMesh > 0.5;

        float3 N_tangent = normalize(Normal);
        float  w1 = max(0.0, dot(N_tangent, _BasisX));
        float  w2 = max(0.0, dot(N_tangent, _BasisY));
        float  w3 = max(0.0, dot(N_tangent, _BasisZ));

        bool arrayValid = _UdonLightLayerArrayValid > 0.5;

        float specMask;
        float maskLum;
        bool  skipSpecularReflection;
        _UdonComputeSpecMask(isDynamicMesh, arrayValid, LightGroupMask, LightmapUV, Roughness,
        specMask, maskLum, skipSpecularReflection);

        if (loopCount < 1)
        {
            Diffuse    = float3(0, 0, 0);
            Specular   = float3(0, 0, 0);
            Reflection = float3(0, 0, 0);

            float evaluationValue = isDynamicMesh ? dot(Diffuse, LUM) : maskLum;
            DiffuseMaskedLights = Diffuse * _UdonDiffuseThresholdMask(evaluationValue);

            #if defined(_DIFFUSEMASKEDLIGHTS_ON)
                return DiffuseMaskedLights;
            #else
                return Diffuse;
            #endif
        }

        float3 N    = normalize(WorldNormal);
        float3 vDir = normalize(ViewDir);
        float3 R    = reflect(-vDir, N);

        // ── Distance caméra → surface (pour LOD bandwidth, live joueur/scene-cam) ──
        float camDist = distance(_WorldSpaceCameraPos, WorldPos);

        float alpha  = Roughness * Roughness;
        float alpha2 = max(alpha * alpha, _Alpha2Floor);
        float nDotV  = max(dot(N, vDir), _NDotVFloor);

        float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color, Metallic);
        float  k  = ((Roughness + 1.0) * (Roughness + 1.0)) / 8.0;
        float  Gv = nDotV / max(nDotV * (1.0 - k) + k, _MathDivisorFloor);

        int materialMask = (int)round(LightGroupMask);

        float3 diffAcc = float3(0, 0, 0);
        float3 specAcc = float3(0, 0, 0);

        for (int i = 0; i < loopCount; i++)
        {
            int baseIdx = i * 8 + 1;

            float3 diffContribution;
            float3 specContribution;
            _UdonAccumulateLight(
            baseIdx, WorldPos, N, R, vDir, camDist, nDotV, F0, alpha2, k, Gv,
            w1, w2, w3, LightmapUV, rangeScale,
            isDynamicMesh, arrayValid, specularGlobalEnabled, specMask, materialMask,
            diffContribution, specContribution);

            diffAcc += diffContribution;
            specAcc += specContribution;
        }

        float rawDiffLum = dot(diffAcc, LUM);

        float occlusionRaw    = saturate(rawDiffLum);
        float occlusionEased  = lerp(1.0, occlusionRaw, saturate(_ReflectionOcclusionStrength));
        float occlusionFactor = max(occlusionEased, _ReflectionOcclusionMin);

        if (Metallic < 0.99)
        {
            Diffuse = diffAcc * Color * (1.0 - Metallic);
            Diffuse = (!arrayValid && !isDynamicMesh) ? max(Diffuse, _FallbackAmbient * Color * (1.0 - Metallic)) : Diffuse;
            Diffuse = min(Diffuse, _MaxDiffuse);
        }
        else
        {
            Diffuse = float3(0, 0, 0);
        }

        float specEvaluation = isDynamicMesh ? rawDiffLum : maskLum;
        float specThresholdMask;
        if (SPEC_MASK_SMOOTHING > 0.0)
        specThresholdMask = smoothstep(SPEC_MASK_THRESHOLD - SPEC_MASK_SMOOTHING, SPEC_MASK_THRESHOLD, specEvaluation);
        else
        specThresholdMask = specEvaluation < SPEC_MASK_THRESHOLD ? 0.0 : 1.0;

        Specular   = specAcc * specThresholdMask;
        Reflection = float3(0, 0, 0);

        if (specThresholdMask > 0.0 && Roughness < 0.99 && specMask > 0.0 && !skipSpecularReflection)
        {
            Reflection = _UdonComputeReflection(WorldPos, N, vDir, R, nDotV, Metallic, Roughness, F0, isDynamicMesh, occlusionFactor);
        }

        float evaluationValue = isDynamicMesh ? dot(Diffuse, LUM) : maskLum;
        DiffuseMaskedLights = Diffuse * _UdonDiffuseThresholdMask(evaluationValue);

        #if defined(_DIFFUSEMASKEDLIGHTS_ON)
            return DiffuseMaskedLights;
        #else
            return Diffuse + Specular + Reflection;
        #endif
    }
#endif