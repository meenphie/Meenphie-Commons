// ==============================================================================
// UdonSpecularSystem.cginc
// ==============================================================================
//
// Texture Array Allocation:
//   _UdonLightLayerArray[0]       -> Global Lightmap_Base (Ambient background)
//   _UdonLightLayerArray[i + 1]   -> Isolated individual light layers (Slices 0 to 31)
//
// Per-light arrays (up to 32 entries):
//   _UdonSpecularLightPos[i]       xyz = world pos           w = bakedIntensity
//   _UdonSpecularLightCol[i]       xyz = live color          w = liveIntensity
//   _UdonSpecularLightDir[i]       xyz = forward             w = cosOuter / type flag
//   _UdonSpecularLightRight[i]     xyz = right               w = halfWidth
//   _UdonSpecularLightUp[i]        xyz = up                  w = halfHeight
//   _UdonSpecularLightBakedCol[i]  xyz = baked color         w = 0.0 baked / 1.0 realtime
//   _UdonLightLayerIndex[i]        x   = slice index (-1 = none)
//                                  y   = diffuse enabled  (1.0 = on, 0.0 = off)
//                                  z   = specular enabled (1.0 = on, 0.0 = off)
//
// Type flags (Dir.w):
//   w < -0.9  → Point (omni)
//   w < -0.1  → Bidir (two-sided)
//   w == 0.0  → Area
//   w >  0.0  → Spot  (w = cosOuter)
// ==============================================================================

#ifndef UDON_SPECULAR_SYSTEM
    #define UDON_SPECULAR_SYSTEM

    // ------------------------------------------------------------------------------
    // Properties
    // ------------------------------------------------------------------------------

    #ifndef UDON_SPECULAR_SYSTEM_PROPERTIES
        #define UDON_SPECULAR_SYSTEM_PROPERTIES

        uniform float4 _UdonSpecularLightData;          // x = light count, y = rangeScale
        uniform float4 _UdonSpecularLightPos[32];
        uniform float4 _UdonSpecularLightDir[32];
        uniform float4 _UdonSpecularLightCol[32];
        uniform float4 _UdonSpecularLightBakedCol[32];
        uniform float4 _UdonSpecularLightRight[32];
        uniform float4 _UdonSpecularLightUp[32];
        uniform float4 _UdonLightLayerIndex[32];

        UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);

        static const float _SpecBoost     = 0.4;
        static const float _FadeStartDist = 25.0;
        static const float _FadeEndDist   = 30.0;

    #endif // UDON_SPECULAR_SYSTEM_PROPERTIES

    // ------------------------------------------------------------------------------
    // Helpers
    // ------------------------------------------------------------------------------

    float _UdonCameraFade(float3 lightPos)
    {
        float rcpRange = 1.0 / max(_FadeEndDist - _FadeStartDist, 1e-4);
        return saturate(1.0 - (length(_WorldSpaceCameraPos - lightPos) - _FadeStartDist) * rcpRange);
    }

    float _UdonSpotMask(float3 L_norm, float3 lightFwd, float cosOuter)
    {
        float cosInner = lerp(cosOuter, 1.0, 0.15);
        float cosA     = dot(-L_norm, lightFwd);
        float t        = saturate((cosA - cosOuter) / max(cosInner - cosOuter, 1e-4));
        return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
    }

    float _UdonAreaMask(float3 L_norm, float3 lightFwd)
    {
        return smoothstep(0.0, 0.2, dot(-L_norm, lightFwd));
    }

    float _UdonHorizonFade(float3 N, float3 L_norm)
    {
        return saturate(dot(N, L_norm) + 0.2) / 1.2;
    }

    float _UdonDistFalloff(float distSq, float rangeSq)
    {
        float w = saturate(1.0 - distSq / rangeSq);
        return (w * w) / max(distSq, 0.0001);
    }

    float _UdonDiffuseFalloff(float distSq)
    {
        return 1.0 / max(distSq, 0.0001);
    }

    float3 _UdonRepPoint(int i, bool isPointLight, bool isSpot,
                         float3 L_vector, float3 L_norm,
                         float distSq, float invDist, float3 R)
    {
        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);

        if (isPointLight) return L_vector;

        if (isSpot)
        {
            float  RdotL       = dot(R, L_norm);
            float3 rayOffset   = L_vector - R * RdotL;
            float  lightRadius = max(halfSize.x, halfSize.y);
            float3 repDir      = rayOffset / max(length(rayOffset), lightRadius);
            return L_vector - repDir * lightRadius;
        }

        // === FIX 1: Closest-point-on-ray method to permanently eliminate infinite tunnels ===
        float3 lightPos = _UdonSpecularLightPos[i].xyz;
        float3 wPos     = lightPos - L_vector; // Recovers World Position
        
        // Project light center onto reflection ray R safely without division
        float  tRay     = max(dot(L_vector, R), 0.0);
        float3 pRefl    = wPos + R * tRay;
        
        // Map back to quad local space
        float3 lp     = pRefl - lightPos;
        float2 localP = float2(dot(lp, _UdonSpecularLightRight[i].xyz),
                               dot(lp, _UdonSpecularLightUp[i].xyz));
        float2 clampP = clamp(localP, -halfSize, halfSize);

        return lightPos
            + _UdonSpecularLightRight[i].xyz * clampP.x
            + _UdonSpecularLightUp[i].xyz    * clampP.y
            - wPos;
    }

    // ------------------------------------------------------------------------------
    // DirectSpecular
    // ------------------------------------------------------------------------------
    float3 DirectSpecular(
        float3 Color,
        float  Metallic,
        float  Smoothness,
        float3 ViewDir,
        float3 WorldPos,
        float3 WorldNormal,
        float3 VertexNormal,
        float2 LightmapUV,
        out float3 Diffuse,
        out float3 Specular
    )
    {
        int loopCount = (int)_UdonSpecularLightData.x;

        // Establish background lighting base from array index 0
        float3 diffAcc = float3(0.0, 0.0, 0.0);
        float3 baseSample = UNITY_SAMPLE_TEX2DARRAY(_UdonLightLayerArray, float3(LightmapUV, 0.0)).rgb;
        diffAcc += baseSample;

        if (loopCount < 1)
        {
            Diffuse  = diffAcc * Color.rgb;
            Specular = float3(0.0, 0.0, 0.0);
            return 0;
        }

        float rangeScale = _UdonSpecularLightData.y;

        float3 N     = normalize(WorldNormal);
        float3 N_geo = normalize(VertexNormal);
        float3 vDir  = normalize(ViewDir);
        float3 R     = reflect(-vDir, N);

        float roughness = 1.0 - Smoothness;
        float alpha     = roughness * roughness;
        float alpha2    = max(alpha * alpha, 0.0001);
        float nDotV     = max(dot(N, vDir), 0.05);

        float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
        float  k  = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
        float  Gv = nDotV / max(nDotV * (1.0 - k) + k, 1e-4);

        float3 specAcc = float3(0.0, 0.0, 0.0);

        for (int i = 0; i < loopCount; i++)
        {
            // ------------------------------------------------------------------
            // Light data
            // ------------------------------------------------------------------
            float3 lightPos  = _UdonSpecularLightPos[i].xyz;
            float  bakedInt  = max(_UdonSpecularLightPos[i].w,    1e-4);
            float3 liveCol   = _UdonSpecularLightCol[i].rgb;
            float  liveInt   = _UdonSpecularLightCol[i].w;
            float3 bakedCol  = _UdonSpecularLightBakedCol[i].rgb;
            bool   isLightBaked = _UdonSpecularLightBakedCol[i].w < 0.5;

            float3 currentCol = liveCol * liveInt;
            float  range   = sqrt(bakedInt) * rangeScale;
            float rangeSq = range * range;

            float3 L_vector = lightPos - WorldPos;
            float  distSq   = dot(L_vector, L_vector);
            float  invDist  = rsqrt(max(distSq, 1e-6));
            float3 L_norm   = L_vector * invDist;

            // ------------------------------------------------------------------
            // Light type configuration
            // ------------------------------------------------------------------
            float4 dirAngle   = _UdonSpecularLightDir[i];
            bool isPointLight = dirAngle.w < -0.9;
            bool isBidir      = !isPointLight && dirAngle.w < -0.1;
            bool isArea       = !isPointLight && !isBidir && dirAngle.w <= 0.0;
            bool isSpot       = !isPointLight && !isBidir && dirAngle.w >  0.0;

            float dirMask = 1.0;
            if      (isSpot) dirMask = _UdonSpotMask(L_norm, dirAngle.xyz, dirAngle.w);
            else if (isArea) dirMask = _UdonAreaMask(L_norm, dirAngle.xyz);

            int  sliceIndex = (int)_UdonLightLayerIndex[i].x;
            bool hasLayer   = sliceIndex >= 0;
            bool diffuseOn  = _UdonLightLayerIndex[i].y > 0.5;
            bool specularOn = _UdonLightLayerIndex[i].z > 0.5;

            float horizFade = _UdonHorizonFade(N, L_norm);
            float nDotL     = saturate(dot(N, L_norm));

            // ------------------------------------------------------------------
            // DIFFUSE CHANNEL
            // ------------------------------------------------------------------
            float3 layerSample = float3(0.0, 0.0, 0.0);

            if (diffuseOn)
            {
                if (isLightBaked)
                {
                    if (hasLayer)
                    {
                        float targetSlice = (float)sliceIndex + 1.0;
                        layerSample = UNITY_SAMPLE_TEX2DARRAY(_UdonLightLayerArray, float3(LightmapUV, targetSlice)).rgb;
                        diffAcc += layerSample * (liveInt / bakedInt);
                    }
                }
                else
                {
                    float diffFalloff = _UdonDiffuseFalloff(distSq);
                    diffAcc += currentCol * nDotL * dirMask * diffFalloff * horizFade;
                }
            }

            // ------------------------------------------------------------------
            // SPECULAR CHANNEL (Realtime GGX Execution)
            // ------------------------------------------------------------------
            float3 repDiff   = _UdonRepPoint(i, isPointLight, isSpot, L_vector, L_norm, distSq, invDist, R);
            float  repDistSq = max(dot(repDiff, repDiff), 1e-6);
            float3 lDir      = repDiff * rsqrt(repDistSq);

            float3 H          = normalize(lDir + vDir);
            float  nDotH      = saturate(dot(N, H));
            float  nDotL_spec = saturate(dot(N, lDir));

            // === FIX 2: Removed hard 'dot(N_geo, L_norm) <= 0.0' branch cutoff ===
            if (nDotL_spec <= 0.0) continue;

            float fade = _UdonCameraFade(lightPos);
            if (fade <= 0.0 || distSq > rangeSq) continue;

            float specFall = _UdonDistFalloff(distSq, rangeSq) * fade;

            // === FIX 3: Evaluate a custom smooth horizon fade based on the shifted highlight direction ===
            float specHorizFade = _UdonHorizonFade(N, lDir);

            // Specular Shadow Estimation using the offset slice reference
            float shadowEstimate = 1.0;
            if (isLightBaked && hasLayer)
            {
                float unshadowed = nDotL_spec * dirMask * specFall * specHorizFade;
                float theoLum    = dot(bakedCol * bakedInt * unshadowed, float3(0.299, 0.587, 0.114));
                float ownLum     = dot(layerSample,                      float3(0.299, 0.587, 0.114));
                shadowEstimate   = saturate(ownLum / max(theoLum, 1e-4));
            }

            float d_denom = (nDotH * nDotH) * (alpha2 - 1.0) + 1.0;
            float D       = alpha2 / max(3.14159265 * d_denom * d_denom, 1e-7);

            float Gl  = nDotL_spec / max(nDotL_spec * (1.0 - k) + k, 1e-4);
            float G   = Gv * Gl;

            float  hDotV  = saturate(dot(H, vDir));
            float  fCurve = exp2((-5.55473 * hDotV - 6.98316) * hDotV);
            float3 F      = F0 + (1.0 - F0) * fCurve;

            float unshadowedDiffuse = nDotL_spec * dirMask * specFall * specHorizFade;
            float brdf = (D * G / max(4.0 * nDotV * nDotL_spec, 0.001)) * unshadowedDiffuse;

            if (specularOn)
            {
                specAcc += max(float3(0.0, 0.0, 0.0), currentCol * F * brdf * shadowEstimate);
            }
        }

        Diffuse  = diffAcc * Color.rgb;
        Specular = specAcc * _SpecBoost;

        return 0;
    }

#endif // UDON_SPECULAR_SYSTEM