#ifndef UDON_SPECULAR_SYSTEM
    #define UDON_SPECULAR_SYSTEM

    #ifndef UDON_SPECULAR_SYSTEM_PROPERTIES
        #define UDON_SPECULAR_SYSTEM_PROPERTIES

        uniform float4 _UdonLightData[257];
        UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);

        static const float _SpecBoost = 0.4;
        static const float3 _BasisX = float3( 0.81649658,  0.0,        0.57735027);
        static const float3 _BasisY = float3(-0.40824829,  0.70710678, 0.57735027);
        static const float3 _BasisZ = float3(-0.40824829, -0.70710678, 0.57735027);
        static const float3 LUM = float3(0.299, 0.587, 0.114);

    #endif

    // ── Helpers ──────────────────────────────────────────────────────────────
    // Unity-style smooth windowed fade: 1 near the light, smoothly to 0 at
    // maxDist, with zero slope at both ends (no popping at the cutoff).
    float _UdonLightFade(float dist, float maxDist)
    {
        float t = saturate(dist / max(maxDist, 1e-4));
        float w = 1.0 - t * t * t * t;
        w = w * w;
        return saturate(w);
    }

    float _UdonSpotMask(float3 L_norm, float3 lightFwd, float cosOuter)
    {
        float cosAngle = dot(-L_norm, lightFwd);
        float cosInner = lerp(cosOuter, 1.0, 0.15); // small inner cone for a soft edge
        return saturate((cosAngle - cosOuter) / max(cosInner - cosOuter, 1e-4));
    }

    float _UdonAreaMask(float3 L_norm, float3 lightFwd)
    {
        // Area lights emit from the front face only.
        return saturate(dot(-L_norm, lightFwd) * 4.0);
    }


    float _UdonSpecularFalloff(float distSq, float rangeSq)
    {
        return 1.0 / max(distSq, 1e-4);
    }

    float _UdonDiffuseFalloff(float distSq)
    {
        return 1.0 / max(distSq, 1e-4);
    }

    float3 SampleLayerSlice(float2 uv, float sliceIndex, float lodBias)
    {
        return UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(uv, sliceIndex), lodBias).rgb;
    }

    // --------------------------------------------------------------------------
    // Main lighting function (Signature mise à jour)
    // --------------------------------------------------------------------------
    float3 DirectSpecular(
    float3 Color,
    float  Metallic,
    float  Smoothness,
    float3 ViewDir,
    float3 WorldPos,
    float3 Normal,
    float3 WorldNormal,
    float2 LightmapUV,
    float  LightGroupMask,
    float  IsDynamicMesh,
    out float3 Diffuse,
    out float3 Specular
    )
    {
        float4 meta = _UdonLightData[0];
        int loopCount = (int)round(meta.x);
        float rangeScale = meta.y;
        float lodBias = meta.z;

        bool specularGlobalEnabled = meta.w > 0.5;

        // On utilise la variable passée par l'input d'Amplify
        bool isDynamicMesh = IsDynamicMesh > 0.5;

        float3 N_tangent = normalize(Normal);
        float w1 = max(0.0, dot(N_tangent, _BasisX));
        float w2 = max(0.0, dot(N_tangent, _BasisY));
        float w3 = max(0.0, dot(N_tangent, _BasisZ));

        float3 diffAcc = float3(0.0, 0.0, 0.0);

        if (!isDynamicMesh)
        {
            float3 baseSample = UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonLightLayerArray, float3(LightmapUV, 0.0), lodBias).rgb;
            diffAcc += baseSample;
        }

        if (loopCount < 1)
        {
            Diffuse  = diffAcc * Color.rgb;
            Specular = float3(0.0, 0.0, 0.0);

            return float3(0.0, 0.0, 0.0);
        }

        float3 N    = normalize(WorldNormal);
        float3 vDir = normalize(ViewDir);
        float3 R    = reflect(-vDir, N);

        float roughness = 1.0 - Smoothness;
        float alpha     = roughness * roughness;
        float alpha2    = max(alpha * alpha, 0.0001);
        float nDotV     = max(dot(N, vDir), 0.05);

        float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
        float  k  = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
        float  Gv = nDotV / max(nDotV * (1.0 - k) + k, 1e-4);

        float3 specAcc = float3(0.0, 0.0, 0.0);
        int materialMask = (int)round(LightGroupMask);

        for (int i = 0; i < loopCount; i++)
        {
            int baseIdx = i * 8 + 1;

            float4 posAndBaked    = _UdonLightData[baseIdx + 0];
            float4 colAndLive     = _UdonLightData[baseIdx + 1];
            float4 dirAndCosOuter = _UdonLightData[baseIdx + 2];
            float4 rightAndWidth  = _UdonLightData[baseIdx + 3];
            float4 upAndHeight    = _UdonLightData[baseIdx + 4];
            float4 bakedColFlags  = _UdonLightData[baseIdx + 5];
            float4 packedLayer    = _UdonLightData[baseIdx + 6];
            float4 packedExtra    = _UdonLightData[baseIdx + 7];

            float3 lightPos  = posAndBaked.xyz;
            float  bakedInt  = max(posAndBaked.w, 1e-4);
            float3 liveCol   = colAndLive.rgb;
            float  liveInt   = colAndLive.w;
            float3 bakedCol  = bakedColFlags.rgb;
            
            bool   isBaked   = (!isDynamicMesh) && (bakedColFlags.w < 0.5);

            float3 currentCol = liveCol * liveInt;
            float  range      = sqrt(bakedInt) * rangeScale;
            float  rangeSq    = range * range;

            float3 L_vector = lightPos - WorldPos;
            float  distSq   = dot(L_vector, L_vector);
            float  dist     = sqrt(max(distSq, 1e-6));
            float  invDist  = rsqrt(max(distSq, 1e-6));
            float3 L_norm   = L_vector * invDist;

            float3 dirVec      = dirAndCosOuter.xyz;
            float  cosOuter    = dirAndCosOuter.w;
            bool isPointLight  = cosOuter < -0.9;
            bool isArea        = !isPointLight && cosOuter <= 0.0;
            bool isSpot        = !isPointLight && cosOuter >  0.0;

            float dirMask = 1.0;
            if      (isSpot) dirMask = _UdonSpotMask(L_norm, dirVec, cosOuter);
            else if (isArea) dirMask = _UdonAreaMask(L_norm, dirVec);

            int  sliceIndex = (int)round(packedLayer.x);
            bool hasLayer   = sliceIndex >= 0;
            bool diffuseOn  = packedLayer.y > 0.5;
            bool specularOn = packedLayer.z > 0.5;
            int  lightGroupMask = (int)round(packedLayer.w);

            if (materialMask != 0 && (materialMask & lightGroupMask) == 0)
            continue;

            float nDotL     = saturate(dot(N, L_norm));

            // ── Specular range (unchanged behaviour: smooth fade-out) ──────────
            float maxSpecDist = packedExtra.x;
            float effectiveSpecularRange = (maxSpecDist > 0.0) ? maxSpecDist : range;
            float effectiveSpecularRangeSq = effectiveSpecularRange * effectiveSpecularRange;

            // ── Diffuse range (new, independent slider: hard cutoff, no fade) ──
            float maxDiffuseDist = packedExtra.y;
            float effectiveDiffuseRange = (maxDiffuseDist > 0.0) ? maxDiffuseDist : range;
            float effectiveDiffuseRangeSq = effectiveDiffuseRange * effectiveDiffuseRange;

            float fade = 1.0;
            bool cutDiffuseByDistance = !isBaked && !isDynamicMesh;

            if (cutDiffuseByDistance)
            {
                // Realtime diffuse on a static mesh: smooth fade using the
                // diffuse-specific range, same window shape as specular.
                if (effectiveDiffuseRange <= 0.0 || distSq > effectiveDiffuseRangeSq) continue;
            }

            float3 layerSample = float3(0.0, 0.0, 0.0);
            if (diffuseOn)
            {
                if (isBaked)
                {
                    // Lightmap layer: hard distance cutoff only, never fades.
                    // Purely a sampling-cost cutoff, not a visual effect.
                    bool withinDiffuseRange = (effectiveDiffuseRange <= 0.0) || (distSq <= effectiveDiffuseRangeSq);

                    if (hasLayer && withinDiffuseRange)
                    {
                        float baseSlice = (float)sliceIndex * 3.0 + 1.0;
                        float3 sampleX = SampleLayerSlice(LightmapUV, baseSlice + 0.0, lodBias);
                        float3 sampleY = SampleLayerSlice(LightmapUV, baseSlice + 1.0, lodBias);
                        float3 sampleZ = SampleLayerSlice(LightmapUV, baseSlice + 2.0, lodBias);
                        layerSample = sampleX * w1 + sampleY * w2 + sampleZ * w3;
                        diffAcc += layerSample * (liveInt / bakedInt);
                    }
                }
                else
                {
                    // Realtime diffuse (dynamic mesh always, or static mesh
                    // lit by a non-baked light): inverse-square x window,
                    // matching the specular falloff shape but using the
                    // diffuse-specific range.
                    float diffFalloff = _UdonDiffuseFalloff(distSq) * _UdonLightFade(dist, effectiveDiffuseRange);
                    diffAcc += currentCol * nDotL * dirMask * diffFalloff * fade;
                }
            }

            if (effectiveSpecularRange <= 0.0 || distSq > effectiveSpecularRangeSq)
            continue;

            float specFade = _UdonLightFade(dist, effectiveSpecularRange);

            float3 rightVec  = rightAndWidth.xyz;
            float3 upVec     = upAndHeight.xyz;
            float2 halfSize  = float2(rightAndWidth.w, upAndHeight.w);

            float3 repDiff;
            if (isPointLight)
            {
                repDiff = L_vector;
            }
            else if (isSpot)
            {
                float  RdotL       = dot(R, L_norm);
                float3 rayOffset   = L_vector - R * RdotL;
                float  lightRadius = max(halfSize.x, halfSize.y);
                float3 repDir      = rayOffset / max(length(rayOffset), lightRadius);
                repDiff = L_vector - repDir * lightRadius;
            }
            else 
            {
                float3 wPos   = lightPos - L_vector;
                float  tRay   = max(dot(L_vector, R), 0.0);
                float3 pRefl  = wPos + R * tRay;
                float3 lp     = pRefl - lightPos;
                float2 localP = float2(dot(lp, rightVec), dot(lp, upVec));
                float2 clampP = clamp(localP, -halfSize, halfSize);
                repDiff = lightPos + rightVec * clampP.x + upVec * clampP.y - wPos;
            }

            float repDistSq = max(dot(repDiff, repDiff), 1e-6);
            float3 lDir     = repDiff * rsqrt(repDistSq);
            float3 H        = normalize(lDir + vDir);
            float  nDotH    = saturate(dot(N, H));
            float  nDotL_spec = saturate(dot(N, lDir));

            if (nDotL_spec <= 0.0) continue;

            float shadowEstimate = 1.0;
            if (isBaked && hasLayer)
            {
                float unshadowed = nDotL_spec * dirMask;
                float theoLum    = dot(bakedCol * bakedInt * unshadowed, LUM);
                float ownLum     = dot(layerSample, LUM);
                shadowEstimate   = saturate(ownLum / max(theoLum, 1e-4));
            }

            float d_denom = (nDotH * nDotH) * (alpha2 - 1.0) + 1.0;
            float D       = alpha2 / max(3.14159265 * d_denom * d_denom, 1e-7);

            float Gl  = nDotL_spec / max(nDotL_spec * (1.0 - k) + k, 1e-4);
            float G   = Gv * Gl;

            float  hDotV  = saturate(dot(H, vDir));
            float  fCurve = exp2((-5.55473 * hDotV - 6.98316) * hDotV);
            float3 F      = F0 + (1.0 - F0) * fCurve;

            float unshadowedDiffuse = nDotL_spec * dirMask;
            float brdf = (D * G / max(4.0 * nDotV * nDotL_spec, 0.001)) * unshadowedDiffuse;

            if (specularOn && specularGlobalEnabled)
            {
                specAcc += max(float3(0.0, 0.0, 0.0), currentCol * F * brdf * shadowEstimate * specFade);
            }
        }

        Diffuse  = diffAcc * Color.rgb;
        Specular = specAcc * _SpecBoost;

        return Diffuse + Specular;
    }
#endif
