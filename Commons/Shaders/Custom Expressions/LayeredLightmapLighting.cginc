#ifndef UDON_SPECULAR_SYSTEM
    #define UDON_SPECULAR_SYSTEM

    #ifndef UDON_SPECULAR_SYSTEM_PROPERTIES
        #define UDON_SPECULAR_SYSTEM_PROPERTIES

        uniform float4 _UdonLightData[257];
        UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);
        UNITY_DECLARE_TEX2DARRAY(_UdonCookieArray);
        uniform float _UdonCookieArrayValid;

        uniform float _UdonLightLayerArrayValid;
        uniform float _UdonLightmapSliceOffset;
        uniform float _UdonLightType;
        uniform float _UdonRNMEnabled;
        uniform float _UdonDiffuseStaticEnabled;
        uniform float _UdonDiffuseRealtimeEnabled;

        // Distance-based LOD bias
        uniform float _UdonLODDistanceNear;
        uniform float _UdonLODDistanceFar;
        uniform float _UdonLODMaxMip;

        // Diffuse
        static const float _MaxStaticDiffuseRange           = 30.0;
        static const float _MaxStaticDiffuseRangeSq         = _MaxStaticDiffuseRange * _MaxStaticDiffuseRange;
        
        static const float _MaxDynamicDiffuseRange          = 10.0;
        static const float _MaxDynamicDiffuseRangeSq        = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
        
        static const float _DynamicDiffuseBoost             = 1.0;
        static const float _DynamicDiffuseSmoothing         = 2.0;
        static const float3 _FallbackAmbient                = float3(0.015, 0.02, 0.035);
        static const float _MinLightRadius                  = 1.5;

        // Speculars    
        static const float _MaxSpecularRange                = 20.0;
        static const float _MaxSpecularRangeSq              = _MaxSpecularRange * _MaxSpecularRange;


        static const float _StaticSpecBoost                 = 0.2;
        static const float _DynamicSpecBoost                = 0.1;
        static const float _MaxSpecIntensity                = 10.0;
        
        static const float _DynamicSpecularSmoothing        = 2.0;
        static const float _SpecularOcclusionMin            = 0.0;
        static const float _SpecularOcclusionMax            = 1.0;
        static const float _SpecularOcclusionSmoothing      = 0.1;
        
        static const float _UdonSpecCameraFadeStart         = 0.0;
        static const float _UdonSpecCameraFadeEnd           = 20.0;
        
        // Reflections  
        static const float _StaticReflectionBoost           = 1.0;
        static const float _DynamicReflectionBoost          = 1.0;
        static const float _DynamicReflectionSmoothing      = 2.0;
        static const float _ReflectionOcclusionMin          = 0.125;
        static const float _ReflectionOcclusionMax          = 1.0;
        static const float _ReflectionOcclusionSmoothing    = 0.1;
        
        // Safeguard constants  
        static const float _NDotVFloor                      = 0.05;
        static const float _Alpha2Floor                     = 0.0001;
        static const float _MathDivisorFloor                = 1e-4;
        static const float _BRDFDenominatorFloor            = 0.001;
        static const float _MaxReflectionMip                = 6.0;

        // Basis vectors
        static const float3 _BasisX = float3( 0.81649658,  0.0,        0.57735027);
        static const float3 _BasisY = float3(-0.40824829,  0.70710678, 0.57735027);
        static const float3 _BasisZ = float3(-0.40824829, -0.70710678, 0.57735027);
        static const float3 LUM     = float3(1.0, 1.0, 1.0);

        // Masked-light threshold constants
        static const float DIFFUSE_MASK_THRESHOLD   = 5.0;
        static const float DIFFUSE_MASK_SMOOTHING   = 0.5;

        // --- Smart-Ass Screen-Space Shadows Setup ---
        #ifndef _UdonDepthTex
            #define _UdonDepthTex
            sampler2D _CameraDepthTexture;
        #endif
    #endif

    // ---------- helpers ----------
    float _UdonComputeOcclusionFactor(float rawLum, float lumMin, float lumMax, float smoothing)
    {
        if (smoothing > 0.0)
        {
            float lowerFadeIn  = smoothstep(lumMin - smoothing, lumMin, rawLum);
            float upperFadeOut = 1.0 - smoothstep(lumMax, lumMax + smoothing, rawLum);
            return lowerFadeIn * upperFadeOut;
        }
        else
        {
            return step(lumMin, rawLum) * step(rawLum, lumMax);
        }
    }

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

    float Sq(float x)
    {
        return x * x;
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

    // ---------- smart-ass hl2 style screen-space shadows ----------
    // Raymarches from the pixel towards the light against the depth buffer.
    // Only processes realtime lights within a short radius to keep it extremely cheap.
    float _UdonComputeScreenSpaceShadow(float3 WorldPos, float3 lightPos)
    {
        float3 rayVec = lightPos - WorldPos;
        float rayDist = length(rayVec);

        if (rayDist > 5.0 || rayDist < 0.1) return 1.0;

        float3 rayDir = rayVec / rayDist;
        float shadow = 1.0;

        [unroll]
        for (int i = 1; i <= 6; i++)
        {
            float3 p = WorldPos + rayDir * (rayDist * (float)i / 6.0);
            float4 clipPos = mul(UNITY_MATRIX_VP, float4(p, 1.0));
            float2 uv = clipPos.xy / max(clipPos.w, 1e-5);

            if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) break;

            float rawDepth = tex2D(_CameraDepthTexture, uv).r;
            float sampledEyeDepth = 1.0 / (_ZBufferParams.z * rawDepth + _ZBufferParams.w);
            float rayEyeDepth = abs(mul(UNITY_MATRIX_V, float4(p, 1.0)).z);

            if (sampledEyeDepth < rayEyeDepth)
            {
                shadow = 0.0;
                break;
            }
        }
        return shadow;
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
    float2 MainUV,
    float2 LightmapUV,
    bool   isDynamicMesh,
    bool   arrayValid,
    bool   specularGlobalEnabled,
    bool   diffuseStaticEnabled,
    bool   diffuseRealtimeEnabled,
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
        float4 rightAndWidth             = _UdonLightData[baseIdx + 3];
        float4 upAndHeight               = _UdonLightData[baseIdx + 4];
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

        // ---- vector to light ----
        float3 L_vector = lightPos - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        float  invDist  = rsqrt(max(distSq, 1e-6));
        float3 L_norm   = L_vector * invDist;

        // ---- direction mask ----
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

        // ---- light axes (needed for cookie + specular) ----
        float3 rightVec = rightAndWidth.xyz;
        float3 upVec    = upAndHeight.xyz;
        float2 halfSize = float2(rightAndWidth.w, upAndHeight.w);

        // ---- cookie ----
        bool cookieNeeded = !isBaked || (specularOn && specularGlobalEnabled);

        float cookieAtten = 1.0;
        if (cookieNeeded)
        {
            int cookieSlice = (int)round(rangesAndType.x);

            if (_UdonCookieArrayValid > 0.5 && cookieSlice >= 0 && lightType != 0)
            {
                float3 lightToWorld = WorldPos - lightPos;
                float z = dot(lightToWorld, dirVec);
                float2 cookieUV = float2(-1.0, -1.0); 

                if (z > 0.0)
                {
                    float x = dot(lightToWorld, rightVec);
                    float y = dot(lightToWorld, upVec);

                    if (lightType == 1) // Spot Light
                    {
                        float tanHalfAngle = sqrt(max(0.0, 1.0 - cosOuter * cosOuter)) * rcp(max(cosOuter, 1e-4));
                        float2 projUV = float2(x, y) / (z * tanHalfAngle);
                        cookieUV = projUV * 0.5 + 0.5;
                    }
                    else if (lightType == 2) // Area Light
                    {
                        float2 projUV = float2(x, y) / max(halfSize * 2.0, 1e-4);
                        cookieUV = projUV + 0.5;
                    }
                }

                float2 inBounds2 = step(0.0, cookieUV) * step(cookieUV, 1.0);
                float cookieSample = saturate(UNITY_SAMPLE_TEX2DARRAY(_UdonCookieArray, float3(cookieUV, (float)cookieSlice)).r);

                cookieAtten = cookieSample * inBounds2.x * inBounds2.y;
            }
        }

        // ---- diffuse ----
        #if defined(_DIFFUSE_ON)
            if (diffuseOn)
            {
                if (isBaked)
                {
                    if (diffuseStaticEnabled && arrayValid && hasLayer && distSq <= _MaxStaticDiffuseRangeSq)
                    {
                        float  windowFalloff = Sq(saturate(1.0 - Sq(distSq * rcp(_MaxStaticDiffuseRangeSq))));
                        float  baseSlice = (float)sliceIndex * 3.0 + _UdonLightmapSliceOffset;
                        float3 sampleX = SampleLayerSlice(LightmapUV, baseSlice + 0.0, effectiveLod);
                        float3 sampleY = SampleLayerSlice(LightmapUV, baseSlice + 1.0, effectiveLod);
                        float3 sampleZ = SampleLayerSlice(LightmapUV, baseSlice + 2.0, effectiveLod);

                        float3 layerSample = sampleX * w1 + sampleY * w2 + sampleZ * w3;
                        diffOut += layerSample * (liveInt * rcp(bakedInt)) * windowFalloff;
                    }
                }
                else
                {
                    if (diffuseRealtimeEnabled && distSq <= _MaxDynamicDiffuseRangeSq)
                    {
                        float nDotL = saturate(dot(N, L_norm));
                        float diffFalloff = rcp(max(distSq, _MinLightRadius * _MinLightRadius));

                        float t = distSq * rcp(_MaxDynamicDiffuseRangeSq);
                        float windowFalloff = 1.0 - smoothstep(1.0 - _DynamicDiffuseSmoothing, 1.0, t);

                        diffFalloff *= windowFalloff;
                        
                        // Smart-Ass Shadow Multiplication
                        float shadowAtten = _UdonComputeScreenSpaceShadow(WorldPos, lightPos);
                        
                        diffOut += (currentCol * _DynamicDiffuseBoost) * nDotL * dirMask * diffFalloff * cookieAtten * shadowAtten;
                    }
                }
            }
        #endif

        // ---- specular ----
        if (!specularOn || !specularGlobalEnabled) return;

        float camDistToPixel = distance(_WorldSpaceCameraPos, WorldPos);
        if (camDistToPixel >= _UdonSpecCameraFadeEnd) return;

        float camFade = 1.0;
        if (camDistToPixel > _UdonSpecCameraFadeStart)
        camFade = 1.0 - smoothstep(_UdonSpecCameraFadeStart, _UdonSpecCameraFadeEnd, camDistToPixel);

        if (distSq > _MaxSpecularRangeSq) return;

        // ---- representative point ----
        float3 repDiff;
        float3 pointRep = L_vector;
        float  RdotL       = dot(R, L_vector);
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

        float specFalloff = rcp(max(repDistSq, _MinLightRadius * _MinLightRadius));
        float specWindowFalloff;

        if (!isBaked)
        {
            float t = distSq * rcp(_MaxSpecularRangeSq);
            specWindowFalloff = 1.0 - smoothstep(1.0 - _DynamicSpecularSmoothing, 1.0, t);
        }
        else
        {
            specWindowFalloff = Sq(saturate(1.0 - Sq(distSq * rcp(_MaxSpecularRangeSq))));
        }

        specFalloff *= specWindowFalloff;

        float  d_denom = nDotH * nDotH * (alpha2 - 1.0) + 1.0;
        float  D       = alpha2 * rcp(max(3.14159265 * d_denom * d_denom, 1e-7));
        float  Gl      = nDotL_spec * rcp(max(nDotL_spec * (1.0 - k) + k, _MathDivisorFloor));
        float  G       = Gv * Gl;

        float  hDotV      = saturate(dot(H, vDir));
        float  oneMinusH  = 1.0 - hDotV;
        float  oneMinusH2 = oneMinusH * oneMinusH;
        float  fCurve     = oneMinusH2 * oneMinusH2 * oneMinusH;
        float3 fresnel    = F0 + (1.0 - F0) * fCurve;

        float brdf = D * G * rcp(max(4.0 * nDotV * nDotL_spec, _BRDFDenominatorFloor)) * dirMask;

        float currentSpecBoost = isBaked ? _StaticSpecBoost : _DynamicSpecBoost;

        specOut = max(0, currentCol * fresnel * brdf * specFalloff * camFade * currentSpecBoost * cookieAtten);
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
    float3 Color, 
    float Metallic, 
    float Roughness,
    float3 ViewDir, 
    float3 WorldPos, 
    float3 Normal, 
    float3 WorldNormal, 
    float2 MainUV,
    float2 LightmapUV, 
    float LightGroupMask, 
    float IsDynamicMesh,
    out float3 DiffuseMaskedLights, 
    out float3 Diffuse,
    out float3 Specular, 
    out float3 Reflection)
    {
        DiffuseMaskedLights = 0;
        Diffuse = 0;
        Specular = 0;
        Reflection = 0;

        float4  meta                    = _UdonLightData[0];
        int     loopCount               = (int)round(meta.x);
        bool    reflectionGlobalEnabled = meta.z > 0.5;
        bool    specularGlobalEnabled   = meta.w > 0.5;
        bool    isDynamicMesh           = IsDynamicMesh > 0.5;
        bool    diffuseStaticEnabled    = _UdonDiffuseStaticEnabled > 0.5;
        bool    diffuseRealtimeEnabled  = _UdonDiffuseRealtimeEnabled > 0.5;
        bool    diffuseFullyEnabled     = diffuseStaticEnabled && diffuseRealtimeEnabled;

        float3 N_tangent = normalize(Normal);
        float w1 = max(0, dot(N_tangent, _BasisX));
        float w2 = max(0, dot(N_tangent, _BasisY));
        float w3 = max(0, dot(N_tangent, _BasisZ));

        if (_UdonRNMEnabled < 0.5)
        {
            w1 = w2 = w3 = 0.333333333;
        }

        bool arrayValid = _UdonLightLayerArrayValid > 0.5;

        float maskLum = 1.0;
        if (!isDynamicMesh && arrayValid)
        {
            maskLum = _UdonGetMaskLuminance(LightmapUV, LightGroupMask);
        }

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

        float alpha2 = _Alpha2Floor;
        float k      = 0.0;
        float Gv     = 0.0;
        if (specularGlobalEnabled)
        {
            float alpha = Roughness * Roughness;
            alpha2 = max(alpha * alpha, _Alpha2Floor);
            k      = alpha * 0.5;
            Gv     = nDotV * rcp(max(nDotV * (1.0 - k) + k, _MathDivisorFloor));
        }

        float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color, Metallic);
        int materialMask = (int)round(LightGroupMask);

        half3 diffAcc = half3(0,0,0);
        half3 specAccBaked = half3(0,0,0);
        half3 specAccRealtime = half3(0,0,0);

        for (int i = 0; i < loopCount; i++)
        {
            int baseIdx = i * 8 + 1;
            float3 diffC, specC;
            _UdonAccumulateLight(baseIdx, WorldPos, N, R, vDir, effectiveLod,
            nDotV, F0, alpha2, k, Gv,
            w1, w2, w3, MainUV, LightmapUV,
            isDynamicMesh, arrayValid, specularGlobalEnabled,
            diffuseStaticEnabled, diffuseRealtimeEnabled,
            materialMask, diffC, specC);
            diffAcc += (half3)diffC;

            float4 bakedFlag = _UdonLightData[baseIdx + 5];
            bool lightIsBaked = (!isDynamicMesh) && (bakedFlag.w < 0.5);

            if (lightIsBaked)
            specAccBaked += (half3)specC;
            else
            specAccRealtime += (half3)specC;
        }

        float rawDiffLum = dot((float3)diffAcc, LUM);

        float occlusionFactor = 1.0;
        #if defined(_DIFFUSE_ON)
            if (diffuseFullyEnabled)
            {
                float occRaw = saturate(rawDiffLum);
                occlusionFactor = _UdonComputeOcclusionFactor(occRaw,
                _ReflectionOcclusionMin,
                _ReflectionOcclusionMax,
                _ReflectionOcclusionSmoothing);
            }
        #endif

        float3 refl = 0;
        if (Roughness < 0.99 && reflectionGlobalEnabled)
        {
            refl = _UdonComputeReflection(WorldPos, N, vDir, R, nDotV,
            Metallic, Roughness, F0, isDynamicMesh, occlusionFactor);
        }

        #if defined(_DIFFUSE_ON)
            {
                float specOcclusionFactor = 1.0;
                if (diffuseFullyEnabled)
                {
                    float occRawSpec = saturate(rawDiffLum);
                    specOcclusionFactor = _UdonComputeOcclusionFactor(occRawSpec,
                    _SpecularOcclusionMin,
                    _SpecularOcclusionMax,
                    _SpecularOcclusionSmoothing);
                }

                float3 dielectricDiffuse = (float3)diffAcc * Color * (1.0 - Metallic);
                float metalScatterAmount = Metallic * Roughness * Roughness * Roughness;
                float3 metalScatter = (float3)diffAcc * F0 * metalScatterAmount;

                Diffuse = dielectricDiffuse + metalScatter;

                if (isDynamicMesh)
                {
                    float fallbackWeight = 1.0 - saturate(rawDiffLum * rcp(_DynamicDiffuseSmoothing + 0.001));
                    float3 ambientTerm = _FallbackAmbient * Color * (1.0 - Metallic);
                    Diffuse += ambientTerm * fallbackWeight;
                }
                else if (!arrayValid)
                {
                    Diffuse = max(Diffuse, _FallbackAmbient * Color * (1.0 - Metallic));
                }

                Specular = (float3)specAccBaked * specOcclusionFactor + (float3)specAccRealtime;
                Reflection = refl;

                #if defined(_DIFFUSEMASKEDLIGHTS_ON)
                    float eval = isDynamicMesh ? dot(Diffuse, LUM) : maskLum;
                    float mask = _UdonDiffuseThresholdMask(eval);
                    DiffuseMaskedLights = Diffuse * mask;
                    return DiffuseMaskedLights;
                #else
                    return Diffuse + Specular + Reflection;
                #endif
            }
        #else
            {
                Specular = (float3)specAccBaked + (float3)specAccRealtime;
                Reflection = refl;
                return Specular + Reflection;
            }
        #endif

        // --- GARANTIE POUR LE COMPILATEUR ---
        return Diffuse + Specular + Reflection;
    }
#endif