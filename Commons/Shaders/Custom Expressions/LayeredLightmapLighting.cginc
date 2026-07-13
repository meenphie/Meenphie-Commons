#ifndef UDON_SPECULAR_SYSTEM
    #define UDON_SPECULAR_SYSTEM

    #ifndef UDON_SPECULAR_SYSTEM_PROPERTIES
        #define UDON_SPECULAR_SYSTEM_PROPERTIES

        uniform float4 _UdonLightData[257];
        UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);

        uniform float _UdonLightLayerArrayValid;
        uniform float _UdonLightmapSliceOffset;
        uniform float _UdonLightType;

        // Distance-based LOD bias
        uniform float _UdonLODDistanceNear;
        uniform float _UdonLODDistanceFar;
        uniform float _UdonLODMaxMip;

        // Diffuse
        static const float _MaxStaticDiffuseRange   = 25.0;
        static const float _MaxStaticDiffuseRangeSq       = _MaxStaticDiffuseRange * _MaxStaticDiffuseRange;

        static const float _MaxDynamicDiffuseRange  = 25.0;
        static const float _MaxDynamicDiffuseRangeSq = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
        
        static const float _DynamicDiffuseBoost     = 1.0;
        static const float3 _FallbackAmbient        = float3(0.02, 0.02, 0.02);

        // Speculars
        static const float _MaxSpecularRange        = 10.0;
        static const float _MaxSpecularRangeSq      = _MaxSpecularRange * _MaxSpecularRange;
        static const float _StaticSpecBoost         = 5.0;
        static const float _RealtimeSpecBoost       = 0.1;
        static const float _MaxSpecIntensity        = 10.0;
        static const float _SpecularOcclusionStrength = 1.2;
        static const float _SpecularOcclusionMin    = 0.0;

        static const float _UdonSpecCameraFadeStart = 10.0;
        static const float _UdonSpecCameraFadeEnd   = 15.0;

        // Reflections
        static const float _StaticReflectionBoost   = 2.0;
        static const float _DynamicReflectionBoost  = 3.0;
        static const float _ReflectionOcclusionStrength = 0.98;
        static const float _ReflectionOcclusionMin  = 0.0;

        // Safeguard constants
        static const float _NDotVFloor              = 0.05;
        static const float _Alpha2Floor             = 0.0001;
        static const float _MathDivisorFloor        = 1e-4;
        static const float _BRDFDenominatorFloor    = 0.001;
        static const float _MaxReflectionMip        = 6.0;

        // Basis vectors
        static const float3 _BasisX = float3( 0.81649658,  0.0,        0.57735027);
        static const float3 _BasisY = float3(-0.40824829,  0.70710678, 0.57735027);
        static const float3 _BasisZ = float3(-0.40824829, -0.70710678, 0.57735027);
        static const float3 LUM     = float3(1.0, 1.0, 1.0);

        // Masked‑light threshold constants
        static const float DIFFUSE_MASK_THRESHOLD   = 5.0;
        static const float DIFFUSE_MASK_SMOOTHING   = 0.5;
    #endif

    // ---------- helpers ----------
    float _UdonDistanceLODBias(float dist)
    {
        float t = saturate((dist - _UdonLODDistanceNear) * rcp(max(_UdonLODDistanceFar - _UdonLODDistanceNear, 1e-4)));
        t = t * t;
        return t * _UdonLODMaxMip;
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

    float _UdonInvSquare(float distSq)
    {
        return rcp(max(distSq, 1e-4));
    }

    float3 SampleLayerSlice(float2 uv, float sliceIndex, float lodBias)
    {
        return UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(uv, sliceIndex), lodBias).rgb;
    }

    // ---------- mask helpers ----------
    float _UdonGetMaskLuminance(float2 LightmapUV, float LightGroupMask)
    {
        float slice = log2(max(LightGroupMask, 1.0));
        float3 sample = UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(LightmapUV, slice), 0.0).rgb;
        return dot(sample, LUM);
    }

    float _UdonDiffuseThresholdMask(float evaluationValue)
    {
        float thresholdMask;
        if (DIFFUSE_MASK_SMOOTHING > 0.0)
        thresholdMask = smoothstep(DIFFUSE_MASK_THRESHOLD - DIFFUSE_MASK_SMOOTHING,
        DIFFUSE_MASK_THRESHOLD, evaluationValue);
        else
        thresholdMask = evaluationValue < DIFFUSE_MASK_THRESHOLD ? 0.0 : 1.0;

        #if defined(_DIFFUSEMASKEDLIGHTS_ON)
            thresholdMask = 1.0 - thresholdMask;
        #endif
        return thresholdMask;
    }

    // ---------- per-light accumulation ----------
    void _UdonAccumulateLight(
    int    baseIdx,
    float3 WorldPos,
    float3 N,
    float3 R,
    float3 vDir,
    float  effectiveLod,
    float  nDotV,
    float3 F0,
    float  alpha2,
    float  k,
    float  Gv,
    float  w1, float w2, float w3,
    float2 LightmapUV,
    bool   isDynamicMesh,
    bool   arrayValid,
    bool   specularGlobalEnabled,
    int    materialMask,
    out float3 diffOut,
    out float3 specOut)
    {
        diffOut = 0;
        specOut = 0;

        // ---- light data ----
        float4 lightPosAndBakedIntensity = _UdonLightData[baseIdx + 0];
        float4 liveColorAndIntensity     = _UdonLightData[baseIdx + 1];
        float4 forwardAndCosOuter        = _UdonLightData[baseIdx + 2];
        float4 bakedColorAndRealtimeFlag = _UdonLightData[baseIdx + 5];
        float4 layerSliceAndFlags        = _UdonLightData[baseIdx + 6];
        float4 rangesAndType             = _UdonLightData[baseIdx + 7];

        int lightGroupMask = (int)round(layerSliceAndFlags.w);
        if (materialMask != 0 && (materialMask & lightGroupMask) == 0) return;

        float3 lightPos  = lightPosAndBakedIntensity.xyz;
        float  bakedInt  = max(lightPosAndBakedIntensity.w, _MathDivisorFloor);
        float3 liveCol   = liveColorAndIntensity.rgb;
        float  liveInt   = liveColorAndIntensity.w;
        float3 bakedCol  = bakedColorAndRealtimeFlag.rgb;
        bool   isBaked   = (!isDynamicMesh) && (bakedColorAndRealtimeFlag.w < 0.5);

        float3 currentCol = liveCol * liveInt;

        // ---- vector to light (no sqrt for distance) ----
        float3 L_vector = lightPos - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        float  invDist  = rsqrt(max(distSq, 1e-6));
        float3 L_norm   = L_vector * invDist;

        // ---- direction mask (branchless) ----
        float3 dirVec   = forwardAndCosOuter.xyz;
        float  cosOuter = forwardAndCosOuter.w;
        float  cosInner = rangesAndType.w;
        int    lightType = (int)round(rangesAndType.z);

        float spotMask = _UdonSpotMask(L_norm, dirVec, cosOuter, cosInner);
        float areaMask = _UdonAreaMask(L_norm, dirVec);
        float dirMask = (lightType == 0) ? 1.0 : ((lightType == 1) ? spotMask : areaMask);

        // ---- layer/flags ----
        int  sliceIndex = (int)round(layerSliceAndFlags.x);
        bool hasLayer   = sliceIndex >= 0;
        bool diffuseOn  = layerSliceAndFlags.y > 0.5;
        bool specularOn = layerSliceAndFlags.z > 0.5;

        // ---- diffuse (only when _DIFFUSE_ON) ----
        #if defined(_DIFFUSE_ON)
            if (diffuseOn)
            {
                if (isBaked)
                {
                    // Baked – static range
                    if (arrayValid && hasLayer && distSq <= _MaxStaticDiffuseRangeSq)
                    {
                        float  baseSlice = (float)sliceIndex * 3.0 + _UdonLightmapSliceOffset;
                        float3 sampleX = SampleLayerSlice(LightmapUV, baseSlice + 0.0, effectiveLod);
                        float3 sampleY = SampleLayerSlice(LightmapUV, baseSlice + 1.0, effectiveLod);
                        float3 sampleZ = SampleLayerSlice(LightmapUV, baseSlice + 2.0, effectiveLod);

                        float3 layerSample = sampleX * w1 + sampleY * w2 + sampleZ * w3;
                        diffOut += layerSample * (liveInt * rcp(bakedInt));
                    }
                }
                else
                {
                    // Realtime – dynamic range with inverse‑square + smooth edge fade
                    if (distSq <= _MaxDynamicDiffuseRangeSq)
                    {
                        float dist = sqrt(distSq);                         // linear distance for smoothstep
                        float diffFade = 1.0 - smoothstep(0.0, _MaxDynamicDiffuseRange, dist);
                        float nDotL = saturate(dot(N, L_norm));
                        float diffFalloff = _UdonInvSquare(distSq);        // physical 1/d²
                        diffOut += (currentCol * _DynamicDiffuseBoost) * nDotL * dirMask * diffFalloff * diffFade;
                    }
                }
            }
        #endif

        // ---- specular ----
        if (!specularOn || !specularGlobalEnabled) return;

        // Camera distance fade – skip completely if past fade end
        float camDistToPixel = distance(_WorldSpaceCameraPos, WorldPos);
        if (camDistToPixel >= _UdonSpecCameraFadeEnd) return;

        float camFade = 1.0;
        if (camDistToPixel > _UdonSpecCameraFadeStart)
        camFade = 1.0 - smoothstep(_UdonSpecCameraFadeStart, _UdonSpecCameraFadeEnd, camDistToPixel);

        // Early skip using squared range
        if (distSq > _MaxSpecularRangeSq) return;

        // ---- representative point calculation (branchless) ----
        float4 rightAndWidth = _UdonLightData[baseIdx + 3];
        float4 upAndHeight   = _UdonLightData[baseIdx + 4];
        float3 rightVec = rightAndWidth.xyz;
        float3 upVec    = upAndHeight.xyz;
        float2 halfSize = float2(rightAndWidth.w, upAndHeight.w);

        float3 repDiff;
        float3 pointRep = L_vector;
        float  RdotL       = dot(R, L_norm);
        float3 rayOffset   = L_vector - R * RdotL;
        float  lightRadius = max(halfSize.x, halfSize.y);
        float  lenSq       = dot(rayOffset, rayOffset);
        float  invLen      = rsqrt(max(lenSq, lightRadius * lightRadius));
        float3 repDir      = rayOffset * invLen;
        float3 spotRep     = L_vector - repDir * lightRadius;
        float3 wPos   = lightPos - L_vector;
        float  tRay   = max(dot(L_vector, R), 0.0);
        float3 pRefl  = wPos + R * tRay;
        float3 lp     = pRefl - lightPos;
        float2 localP = float2(dot(lp, rightVec), dot(lp, upVec));
        float2 clampP = clamp(localP, -halfSize, halfSize);
        float3 areaRep = lightPos + rightVec * clampP.x + upVec * clampP.y - wPos;

        repDiff = (lightType == 0) ? pointRep : ((lightType == 1) ? spotRep : areaRep);

        float  repDistSq  = max(dot(repDiff, repDiff), 1e-6);
        float3 lDir       = repDiff * rsqrt(repDistSq);
        float3 H          = normalize(lDir + vDir);
        float  nDotH      = saturate(dot(N, H));
        float  nDotL_spec = saturate(dot(N, lDir));
        if (nDotL_spec <= 0.0) return;

        // ---- smooth distance fade ----
        float dist = sqrt(distSq);
        float specFade = 1.0 - smoothstep(0.0, _MaxSpecularRange, dist);

        // ---- Cook-Torrance (Schlick Fresnel) ----
        float  d_denom = nDotH * nDotH * (alpha2 - 1.0) + 1.0;
        float  D       = alpha2 * rcp(max(3.14159265 * d_denom * d_denom, 1e-7));
        float  Gl      = nDotL_spec * rcp(max(nDotL_spec * (1.0 - k) + k, _MathDivisorFloor));
        float  G       = Gv * Gl;

        float  hDotV      = saturate(dot(H, vDir));
        float  oneMinusH  = 1.0 - hDotV;
        float  oneMinusH2 = oneMinusH * oneMinusH;
        float  fCurve     = oneMinusH2 * oneMinusH2 * oneMinusH;
        float3 F          = F0 + (1.0 - F0) * fCurve;

        float brdf = D * G * rcp(max(4.0 * nDotV * nDotL_spec, _BRDFDenominatorFloor)) * (nDotL_spec * dirMask);

        float specFalloff = _UdonInvSquare(repDistSq);
        float currentSpecBoost = isBaked ? _StaticSpecBoost : _RealtimeSpecBoost;

        specOut = max(0, currentCol * F * brdf * specFalloff * specFade * camFade * currentSpecBoost);
        specOut = min(specOut, _MaxSpecIntensity);
    }

    // ---------- cubemap reflection ----------
    float3 _UdonComputeReflection(
    float3 WorldPos, float3 N, float3 vDir, float3 R,
    float nDotV, float Metallic, float Roughness, float3 F0,
    bool isDynamicMesh, float occlusionFactor)
    {
        float3 ray = R;
        if (unity_SpecCube0_ProbePosition.w > 0.0)
        {
            float3 rbMax    = (unity_SpecCube0_BoxMax.xyz - WorldPos) * rcp(ray + 1e-6);
            float3 rbMin    = (unity_SpecCube0_BoxMin.xyz - WorldPos) * rcp(ray - 1e-6);
            float3 rbMinMax = (ray > 0.0) ? rbMax : rbMin;
            float  fa       = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
            ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
        }

        float mipLevel      = Roughness * _MaxReflectionMip;
        float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
        float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);

        float  fresnel = pow(1.0 - nDotV, 5.0);
        float3 F_refl  = F0 + (max(float3(1.0 - Roughness, 1.0 - Roughness, 1.0 - Roughness), F0) - F0) * fresnel;

        float boost = isDynamicMesh ? _DynamicReflectionBoost : _StaticReflectionBoost;
        return indirectSpec * F_refl * boost * occlusionFactor;
    }

    // ---------- main ----------
    float3 LayeredLightmapLighting(
    float3 Color, float Metallic, float Roughness,
    float3 ViewDir, float3 WorldPos, float3 Normal, float3 WorldNormal,
    float2 LightmapUV, float LightGroupMask, float IsDynamicMesh,
    out float3 DiffuseMaskedLights, out float3 Diffuse,
    out float3 Specular, out float3 Reflection)
    {
        DiffuseMaskedLights = 0;
        Diffuse = 0;
        Specular = 0;
        Reflection = 0;

        float4 meta = _UdonLightData[0];
        int loopCount = (int)round(meta.x);
        bool specularGlobalEnabled = meta.w > 0.5;
        bool isDynamicMesh = IsDynamicMesh > 0.5;

        float3 N_tangent = normalize(Normal);
        float w1 = max(0, dot(N_tangent, _BasisX));
        float w2 = max(0, dot(N_tangent, _BasisY));
        float w3 = max(0, dot(N_tangent, _BasisZ));

        bool arrayValid = _UdonLightLayerArrayValid > 0.5;

        // Mask luminance for static meshes
        float maskLum = 1.0;
        if (!isDynamicMesh && arrayValid)
        {
            maskLum = _UdonGetMaskLuminance(LightmapUV, LightGroupMask);
        }

        // Early exit when no lights
        if (loopCount < 1)
        {
            #if defined(_DIFFUSE_ON)
                float eval = isDynamicMesh ? dot(Diffuse, LUM) : maskLum;
                float mask = _UdonDiffuseThresholdMask(eval);
                DiffuseMaskedLights = Diffuse * mask;
            #endif
            #if defined(_DIFFUSEMASKEDLIGHTS_ON)
                return DiffuseMaskedLights;
            #else
                #if defined(_DIFFUSE_ON)
                    return Diffuse;
                #else
                    return Specular;
                #endif
            #endif
        }

        float3 N    = normalize(WorldNormal);
        float3 vDir = normalize(ViewDir);
        float3 R    = reflect(-vDir, N);

        float camDist = distance(_WorldSpaceCameraPos, WorldPos);
        float effectiveLod = _UdonDistanceLODBias(camDist);

        float nDotV  = max(dot(N, vDir), _NDotVFloor);
        float alpha  = Roughness * Roughness;
        float alpha2 = max(alpha * alpha, _Alpha2Floor);
        float k      = alpha * 0.5;
        float Gv     = nDotV * rcp(max(nDotV * (1.0 - k) + k, _MathDivisorFloor));

        float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color, Metallic);
        int materialMask = (int)round(LightGroupMask);

        half3 diffAcc = half3(0,0,0);
        half3 specAcc = half3(0,0,0);

        for (int i = 0; i < loopCount; i++)
        {
            int baseIdx = i * 8 + 1;
            float3 diffC, specC;
            _UdonAccumulateLight(baseIdx, WorldPos, N, R, vDir, effectiveLod,
            nDotV, F0, alpha2, k, Gv,
            w1, w2, w3, LightmapUV,
            isDynamicMesh, arrayValid, specularGlobalEnabled, materialMask,
            diffC, specC);
            diffAcc += (half3)diffC;
            specAcc += (half3)specC;
        }

        float rawDiffLum = dot((float3)diffAcc, LUM);

        #if defined(_DIFFUSE_ON)
            {
                // Occlusion factors
                float occRaw = saturate(rawDiffLum);
                float occEased = lerp(1, occRaw, saturate(_ReflectionOcclusionStrength));
                float occlusionFactor = max(occEased, _ReflectionOcclusionMin);

                float occRawSpec = saturate(rawDiffLum);
                float occEasedSpec = lerp(1, occRawSpec, _SpecularOcclusionStrength);
                float specOcclusionFactor = max(occEasedSpec, _SpecularOcclusionMin);

                // Diffuse – metallic surfaces get zero diffuse
                if (Metallic < 0.99)
                {
                    Diffuse = (float3)diffAcc * Color * (1 - Metallic);
                    Diffuse = (!arrayValid && !isDynamicMesh)
                    ? max(Diffuse, _FallbackAmbient * Color * (1 - Metallic))
                    : Diffuse;
                }
                // else Diffuse stays 0 (initialized above)

                Specular = (float3)specAcc * specOcclusionFactor;

                // Reflection
                Reflection = 0;
                if (Roughness < 0.99)
                {
                    Reflection = _UdonComputeReflection(WorldPos, N, vDir, R, nDotV,
                    Metallic, Roughness, F0, isDynamicMesh, occlusionFactor);
                }

                // Masked‑light output (blackout bright areas)
                #if defined(_DIFFUSEMASKEDLIGHTS_ON)
                    {
                        float eval = isDynamicMesh ? dot(Diffuse, LUM) : maskLum;
                        float mask = _UdonDiffuseThresholdMask(eval);
                        DiffuseMaskedLights = Diffuse * mask;
                        return DiffuseMaskedLights;
                    }
                #else
                    return Diffuse + Specular + Reflection;
                #endif
            }
        #else
            {
                Specular = (float3)specAcc;
                return Specular;
            }
        #endif
    }
#endif