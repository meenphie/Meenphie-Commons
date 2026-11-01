#ifndef LAYERED_LIGHTMAP_LIGHTING
    #define LAYERED_LIGHTMAP_LIGHTING

    // Textures & buffers globaux
    uniform float4 _UdonLightData[513];
    static const int MAX_PROBES = 16;

    #if defined(SHADER_API_MOBILE)
        UNITY_DECLARE_TEX2DARRAY(_UdonReflectionProbeArray);
    #else
        UNITY_DECLARE_TEXCUBEARRAY(_UdonReflectionProbeArray);
    #endif

    UNITY_DECLARE_TEX2DARRAY(_UdonLightLayerArray);
    UNITY_DECLARE_TEX2DARRAY(_UdonCookieArray);
    UNITY_DECLARE_TEX2D(_UdonShadowMap);
    UNITY_DECLARE_TEX2D(_UdonMaterialTable);

    // Uniforms globaux
    uniform float _UdonReflectionArrayValid;
    uniform float _UdonLightmapSliceOffset;
    uniform float _UdonReflectionProbeCount;
    uniform float _UdonReflectionProbeMaxMip;
    uniform float4 _UdonReflectionProbeData[MAX_PROBES * 3];
    uniform float4 _UdonReflectionProbeHDR[MAX_PROBES];
    uniform float _UdonReflectionProbePreviewEnabled;
    uniform float _UdonReflectionProbePreviewAssignment;
    uniform float _UdonCookieArrayValid;
    uniform float _UdonLightLayerArrayValid;

    uniform float _UdonDirectionalEnabled;
    uniform float _UdonDiffuseStaticEnabled;
    uniform float _UdonDiffuseRealtimeEnabled;
    uniform float _UdonRealtimeShadowsEnabled;
    uniform float _UdonSSSEnabled;

    uniform float _UdonLODDistanceNear;
    uniform float _UdonLODDistanceFar;
    uniform float _UdonLODMaxMip;

    uniform float4 _UdonMaterialTable_TexelSize;
    uniform float4x4 _UdonShadowViewMatrix;
    uniform float4x4 _UdonShadowProjectionMatrix;
    uniform float _Udon_LightNear;
    uniform float _Udon_LightFar;

    uniform float _UdonSpecCameraFadeEnd;

    // Diffuse
    static const float _MaxStaticDiffuseRange      = 15.0;
    static const float _MaxStaticDiffuseRangeSq    = _MaxStaticDiffuseRange * _MaxStaticDiffuseRange;
    static const float _StaticDiffuseSmoothing     = 0.5;

    // Dynamic
    static const float _MaxDynamicDiffuseRange     = 15.0;
    static const float _MaxDynamicDiffuseRangeSq   = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
    static const half  _DynamicDiffuseBoost        = 0.25h;
    static const float _DynamicDiffuseSmoothing    = 0.1;
    static const float _MinLightRadius             = 1.0;
    static const float _UdonRealtimeDiffuseWrap    = 3.0;

    static const half  _AreaIndirectBoost          = 0.02h;
    static const half  _AreaMaskTransitionWidth    = 0.1h;

    // Translucence 
    static const half  _SSSDistortion              = 0.05h;  // courbe la direction lumière vers/à travers la normale (simule l'épaisseur traversée)
    static const half  _SSSPower                   = 8.0h;  // resserre (grand) / élargit (petit) le halo de transmission
    static const half  _SSSAmbient                 = 0.0h;  // plancher constant additionnel, 0 = désactivé

    // Specular
    static const float _MaxSpecularRange     = 20.0;
    static const float _MaxSpecularRangeSq   = _MaxSpecularRange * _MaxSpecularRange;
    static const half  _SpecBoost            = 0.05h;
    static const half  _MaxSpecIntensity     = 10.0h;
    static const float _AreaSpecThin         = 0.5;

    // GeometricAA (dérivées d'écran)
    static const float _SpecAAVariance                  = 0.15915494; // force : 0 = off, monte (0.3 à 0.5) si ça scintille encore
    static const float _SpecAAThreshold                 = 0.18;       // plafond de l'élargissement

    // Reflection
    static const half  _StaticReflectionBoost           = 1.0h;
    static const half  _DynamicReflectionBoost          = 1.0h;
    static const float _DynamicReflectionSmoothing      = 1.0;
    static const float _UdonSpecCubeLodSteps            = 6.0;   
    static const float _ReflectionOcclusionMin          = 0.3;
    static const float _ReflectionOcclusionMax          = 1.0;
    static const float _ReflectionOcclusionSmoothing    = 0.3;

    // Shadow
    static const float _UdonShadowBackfaceFadeStart  = -0.333; // début du fondu (N·L)
    static const float _UdonShadowBackfaceFadeEnd    = 0.2; // fin du fondu

    // BRDF & utilitaires
    static const half  _NDotVFloor                 = 0.05h;
    static const half  _Alpha2Floor                = 0.002h;
    static const float _MathDivisorFloor           = 1e-4;
    static const half  _BRDFDenominatorFloor       = 0.001h;
    static const float _MaxReflectionMipFallback   = 6.0;

    static const half3 LUM = half3(1.0h, 1.0h, 1.0h);

    // Material table : constantes par-matériau source, une colonne par matériau.
    // Layout (cf. MeshArrayBaker.ReadParams) :
    //   row 0 = _Color RGBA
    //   row 1 = subsurface.rgb + thickness (.a)
    //   row 2 = emission.rgb + intensity (.a)
    //   row 3 = metallic (.r), roughness (.g), metallic-map flag (.b), roughness-map flag (.a)
    // column = UV2.y (écrit dans le mesh baké)
    half4 _UdonMaterialRow(float column, float row)
    {
        float2 uv = float2((column + 0.5) * _UdonMaterialTable_TexelSize.x,
        (row + 0.5) * 0.25);
        return UNITY_SAMPLE_TEX2D(_UdonMaterialTable, uv);
    }

    // Plus la normale varie d'un pixel à l'autre (normal map minifiée, courbure, distance),
    // plus on élargit la rugosité pour éviter le scintillement. Retourne une rugosité perceptuelle.
    half GeometricSpecularAA(half3 N, half perceptualRoughness)
    {
        float3 Nf   = (float3)N;
        float3 dndx = ddx(Nf);
        float3 dndy = ddy(Nf);
        float variance = _SpecAAVariance * (dot(dndx, dndx) + dot(dndy, dndy));
        float kernel   = min(2.0 * variance, _SpecAAThreshold);

        float alpha  = (float)perceptualRoughness * (float)perceptualRoughness;
        float alpha2 = saturate(alpha * alpha + kernel);
        return (half)sqrt(sqrt(alpha2));
    }

    half3 _UdonSampleLightProbes(float3 normalWS)
    {
        half4 normal4 = half4(normalWS, 1.0h);
        half3 x1, x2, x3;

        // Terme linéaire + constant
        x1.r = dot(unity_SHAr, normal4);
        x1.g = dot(unity_SHAg, normal4);
        x1.b = dot(unity_SHAb, normal4);

        // 4 des polynômes quadratiques
        half4 vB = normal4.xyzz * normal4.yzzx;
        x2.r = dot(unity_SHBr, vB);
        x2.g = dot(unity_SHBg, vB);
        x2.b = dot(unity_SHBb, vB);

        // Dernier polynôme quadratique
        half vC = normal4.x * normal4.x - normal4.y * normal4.y;
        x3 = unity_SHC.rgb * vC;

        return x1 + x2 + x3;
    }

    // Direction d'échantillonnage dans la probe : ré-ancrage par intersection rayon/boîte
    // si c'est une box projection (corrige le parallaxe à l'intérieur du volume), sinon R direct.
    float3 _UdonProbeSampleRay(float3 worldPos, float3 reflDir, int probeIdx)
    {
        float3 ray = reflDir;
        int b = probeIdx * 3;

        if (_UdonReflectionProbeData[b + 1].w > 0.5)
        {
            float3 probePos = _UdonReflectionProbeData[b + 0].xyz;
            float3 boxMin   = _UdonReflectionProbeData[b + 1].xyz;
            float3 boxMax   = _UdonReflectionProbeData[b + 2].xyz;

            // Origine ramenée dans la boîte : identique à worldPos à l'intérieur, et continue dans la zone
            // de fondu juste à l'extérieur (où l'intersection rayon/boîte n'a plus de sens).
            float3 origin  = clamp(worldPos, boxMin, boxMax);

            float3 dir     = normalize(ray);
            float3 safeDir = dir + (dir == 0.0 ? 1e-5 : 0.0);
            float3 tMax    = (boxMax - origin) / safeDir;
            float3 tMin    = (boxMin - origin) / safeDir;
            float3 tHit    = lerp(tMin, tMax, step(0.0, safeDir));
            float  fa      = max(min(min(tHit.x, tHit.y), tHit.z), 0.0);

            ray = dir * fa + (origin - probePos);
        }
        return ray;
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

    // Rugosité perceptuelle -> niveau de mip, même courbe que Unity (Unity_GlossyEnvironment) :
    // les probes bakées par Unity sont convoluées avec cette répartition, pas linéairement.
    // maxMip doit valoir ~6 (UNITY_SPECCUBE_LOD_STEPS) pour des probes bakées par Unity.
    float _UdonRoughnessToMip(float perceptualRoughness, float maxMip)
    {
        return perceptualRoughness * (1.7 - 0.7 * perceptualRoughness) * maxMip;
    }

    // Couleur de la probe `idx` dans la direction de réflexion (box projection gérée dans _UdonProbeSampleRay).
    half3 _UdonSampleProbeColor(int idx, float3 worldPos, float3 reflDir, float mip)
    {
        float3 ray = _UdonProbeSampleRay(worldPos, reflDir, idx);
        float4 smp = _UdonSampleProbeArray(idx, ray, mip);
        return (half3)DecodeHDR(smp, _UdonReflectionProbeHDR[idx]);
    }

    // L'index de probe attribué au mesh reste fixe sur toute sa surface.
    half3 _UdonComputeReflectionArray(
    float3 WorldPos, half3 N, half3 vDir, half3 R,
    half nDotV, half Metallic, half Roughness, half3 F0,
    bool isDynamicMesh, half occlusionFactor, float assignedProbe)
    {
        float effectiveAssignedProbe = _UdonReflectionProbePreviewEnabled > 0.5
            ? _UdonReflectionProbePreviewAssignment
            : assignedProbe;
        if (effectiveAssignedProbe < 0.5)
            return (half3)0;

        int idxA = (int)round(effectiveAssignedProbe) - 1;
        if (idxA < 0 || idxA >= (int)_UdonReflectionProbeCount || idxA >= MAX_PROBES)
            return (half3)0;

        // Unity convolue ses probes sur UNITY_SPECCUBE_LOD_STEPS (6) niveaux, pas sur toute la chaîne de mips.
        float maxMip   = (_UdonReflectionProbeMaxMip > 0.0) ? min(_UdonReflectionProbeMaxMip, _UdonSpecCubeLodSteps) : _MaxReflectionMipFallback;
        float mipLevel = _UdonRoughnessToMip((float)Roughness, maxMip);

        half3 colA = _UdonSampleProbeColor(idxA, WorldPos, (float3)R, mipLevel);

        // Fresnel Schlick (formulation Unity Standard : F0 de face -> grazingTerm à l'angle rasant)
        half  oneMinusNV  = 1.0h - saturate(nDotV);
        half  fresnelTerm = oneMinusNV * oneMinusNV;
        fresnelTerm       = fresnelTerm * fresnelTerm * oneMinusNV;      // (1 - nDotV)^5
        half3 grazingTerm = max((half3)(1.0h - Roughness), F0);
        half3 F_refl      = lerp(F0, grazingTerm, fresnelTerm);

        // Surface reduction (Unity Standard) : atténue le reflet des surfaces rugueuses.
        half  alphaR           = Roughness * Roughness;
        half  surfaceReduction = 1.0h / (alphaR * alphaR + 1.0h);

        half boost   = isDynamicMesh ? _DynamicReflectionBoost : _StaticReflectionBoost;

        return colA * F_refl * surfaceReduction * boost * occlusionFactor;
    }

    half _UdonComputeOcclusionFactor(
    half rawLum,
    half lumMin,        half lumMax,
    half smoothingLow,  half smoothingHigh,   // largeur de transition indépendante bas/haut
    half strengthLow,   half strengthHigh)    // intensité indépendante bas/haut
    {
        half lowerFadeIn  = 1.0h;
        half upperFadeOut = 1.0h;

        if (smoothingLow > 0.0h)
        {
            lowerFadeIn = smoothstep(lumMin - smoothingLow, lumMin, rawLum);
            lowerFadeIn = pow(max(lowerFadeIn, 1e-4h), strengthLow); // contrôle la "morsure" côté sombre
        }
        else
        {
            lowerFadeIn = step(lumMin, rawLum);
        }

        if (smoothingHigh > 0.0h)
        {
            upperFadeOut = 1.0h - smoothstep(lumMax, lumMax + smoothingHigh, rawLum);
            upperFadeOut = pow(max(upperFadeOut, 1e-4h), strengthHigh); // contrôle la "morsure" côté clair
        }
        else
        {
            upperFadeOut = step(rawLum, lumMax);
        }

        return lowerFadeIn * upperFadeOut;
    }

    float _UdonDistanceLODBias(float dist)
    {
        float t = saturate((dist - _UdonLODDistanceNear) * rcp(max(_UdonLODDistanceFar - _UdonLODDistanceNear, 1e-4)));
        t = t * t;
        return t * _UdonLODMaxMip;
    }

    // NB : ces trois helpers ne sont plus appelés par _UdonAccumulateLight (masques inlinés
    // avec un dot partagé). Conservés au cas où un autre include les utiliserait.
    half _UdonSpotMask(half3 L_norm, half3 lightFwd, half cosOuter, half cosInner)
    {
        half cosAngle = dot(-L_norm, lightFwd);
        return smoothstep(cosOuter, cosInner, cosAngle);
    }

    half _UdonAreaMask(half3 L_norm, half3 lightFwd)
    {
        half frontDot = dot(-L_norm, lightFwd);
        return smoothstep(-_AreaMaskTransitionWidth, _AreaMaskTransitionWidth, frontDot);
    }

    half _UdonAreaMaskSpecular(half3 L_norm, half3 lightFwd)
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

    half _UdonComputeShadowMapShadow(float3 WorldPos, bool hasShadow)
    {
        if (!hasShadow || _UdonRealtimeShadowsEnabled < 0.5) return 1.0h;

        float3 lightView = mul(_UdonShadowViewMatrix, float4(WorldPos, 1.0)).xyz;
        float viewDepth = -lightView.z;
        if (viewDepth < _Udon_LightNear || viewDepth > _Udon_LightFar) return 1.0h;

        float4x4 gpuProjection = _UdonGetShadowGPUProjection();
        float4 lightClip = mul(gpuProjection, float4(lightView, 1.0));
        if (lightClip.w <= 1e-5) return 1.0h; // hors frustum, on laisse passer (à ajuster)
        float3 shadowNDC = lightClip.xyz / lightClip.w;
        float2 shadowUV = shadowNDC.xy * 0.5 + 0.5;

        float2 edgeDist2 = min(shadowUV, 1.0 - shadowUV);
        float edgeDist = min(edgeDist2.x, edgeDist2.y);
        if (edgeDist <= 0.0) return 1.0h;

        half receiverDepth = (half)saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));
        half depthBias = 0.0005h;
        half shadowDepth = (half)UNITY_SAMPLE_TEX2D_LOD(_UdonShadowMap, shadowUV, 0).r;
        half atten = (receiverDepth <= shadowDepth + depthBias) ? 1.0h : 0.0h;

        const float edgeFadeMargin = 0.05;
        half edgeBlend = (half)smoothstep(0.0, edgeFadeMargin, edgeDist);
        return lerp(1.0h, atten, edgeBlend);
    }

    // Les valeurs par pixel (a2, lambdaV, alignThreshold, camFade) sont calculées une seule fois
    // dans LayeredLightmapLighting et passées ici, au lieu d'être recalculées à chaque lumière.
    // specPixelOn = specularGlobalEnabled && pixel dans la portée caméra du spéculaire.
    void _UdonAccumulateLight(
    int    baseIdx,
    float3 WorldPos, half3 N, half3 defaultN, half3 R, half3 vDir,
    float  effectiveLod,
    half3 F0,
    half  a2, half lambdaV, half camFade,
    half Thickness, half3 SubsurfaceColor,
    float2 MainUV, float2 LightmapUV,
    bool   isDynamicMesh,
    bool   arrayValid,
    bool   specPixelOn,
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
            const bool canSpecularBase = false;      // Quest : jamais de spéculaire
        #else
            bool canSpecularBase = specularOn && specPixelOn;
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

        // Masques directionnels : un seul dot partagé, seul le masque du type concerné est calculé.
        // 0 = point/directionnelle, 1 = spot, 2 = area.
        half dirMask     = 1.0h;
        half specDirMask = 1.0h;
        if (lightType != 0)
        {
            half frontDot = dot(-L_norm, dirVec);
            if (lightType == 1)
            {
                dirMask     = smoothstep(cosOuter, cosInner, frontDot);
                specDirMask = dirMask;
            }
            else
            {
                // large, sert au diffus (direct + backfill)
                dirMask     = smoothstep(-_AreaMaskTransitionWidth, _AreaMaskTransitionWidth, frontDot);
                specDirMask = (lightType == 2) ? saturate(frontDot * 4.0h) : dirMask;
            }
        }

        bool skippableByDirMask = !(isBaked && diffuseOn);

        bool wantsAreaBackfill = (lightType == 2) && !isBaked && diffuseOn && diffuseRealtimeEnabled;

        if (dirMask <= 1e-4h && skippableByDirMask && !wantsAreaBackfill) return;

        half3 currentCol = (half3)(liveColorAndIntensity.rgb * liveColorAndIntensity.w);
        half  bakedInt   = max((half)lightPosAndBakedIntensity.w, (half)_MathDivisorFloor);
        half  liveInt    = (half)liveColorAndIntensity.w;

        half shadowAtten = 1.0h;
        half cookieAtten = 1.0h;
        int   shadowSlice = (int)round(rangesAndType.y);

        bool  wantsShadow = (shadowSlice >= 0) && !isBaked;
        bool  cookieNeeded = (!isBaked) || canSpecularBase;

        if (wantsShadow)
                shadowAtten = _UdonComputeShadowMapShadow(WorldPos, true);

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
                // _LOD 0 : pas de dérivées dans une branche dynamique, et pas de flou de mip
                // sur les bords du cône (cookieUV = -1 hors cône fausserait les dérivées).
                float cookieSample = saturate(UNITY_SAMPLE_TEX2DARRAY_LOD(_UdonCookieArray, float3(cookieUV, (float)cookieSlice), 0).r);
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
                    float baseSlice = (float)layerSliceAndFlags.x + _UdonLightmapSliceOffset;
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

                    // --- Fondu progressif en fin de portée ---
                    float t = distSq * rcp(_MaxStaticDiffuseRangeSq);
                    half windowFalloff = 1.0h - smoothstep(1.0h - (half)_StaticDiffuseSmoothing, 1.0h, t);

                    half intensityRatio = saturate((half)liveColorAndIntensity.w / max((half)bakedInt, 0.001h));
                    layerSample *= intensityRatio * windowFalloff;
                    diffOut += layerSample;
                }
            }
            else
            {
                if (diffuseRealtimeEnabled && distSq <= _MaxDynamicDiffuseRangeSq)
                {
                    half rawNoL = dot(N, L_norm);
                    half nDotL = saturate((rawNoL + _UdonRealtimeDiffuseWrap) / (1.0h + _UdonRealtimeDiffuseWrap));
                    half diffFalloff = (half)rcp(distSq + _MinLightRadius * _MinLightRadius);
                    half t = (half)(distSq * rcp(_MaxDynamicDiffuseRangeSq));
                    half windowFalloff = 1.0h - smoothstep(1.0h - (half)_DynamicDiffuseSmoothing, 1.0h, t);
                    diffFalloff *= windowFalloff;

                    // --- Diffus direct ---
                    diffOut += (currentCol * _DynamicDiffuseBoost) * nDotL * dirMask * diffFalloff * cookieAtten * shadowAtten;

                    // --- Backfill indirect pour les area lights : complément exact du dirMask, transition partagée ---
                    if (lightType == 2)
                    {
                        half backEnvelope = 1.0h - dirMask; // partition garantie : dirMask + backEnvelope == 1 partout

                        if (backEnvelope > 0.0h)
                        {
                            float areaRadius = max(rightAndWidth.w, upAndHeight.w);
                            half indirectFalloff = (half)rcp(distSq + areaRadius * areaRadius);
                            half nDotL_omni = dot(N, L_norm) * 0.5h + 0.5h;

                            diffOut += (currentCol * _AreaIndirectBoost) * backEnvelope * nDotL_omni
                            * indirectFalloff * windowFalloff * cookieAtten * shadowAtten;
                        }
                    }

                    // --- Translucence simple (fake SSS) ---
                    if (_UdonSSSEnabled > 0.5h && Thickness > 0.001h)
                    {
                        half3 transDir = normalize(L_norm + N * _SSSDistortion);
                        half  transDot = pow(saturate(dot(vDir, -transDir)), _SSSPower);
                        half  transTerm = (transDot + _SSSAmbient) * Thickness;
                        diffOut += (currentCol * SubsurfaceColor) * transTerm * dirMask * diffFalloff * cookieAtten * shadowAtten;
                    }
                }
            }
        }

        // ====================================================================
        // SPÉCULAIRE
        // ====================================================================
        // canSpecularBase inclut déjà specPixelOn (donc le test de portée caméra) ;
        // le fondu caméra (camFade) arrive précalculé en paramètre.
        if (!canSpecularBase) return;
        if (lightType == 2 && specDirMask <= 1e-4h) return; // derrière le plan émissif : pas de spéculaire, diffus déjà géré via le backfill

        // --- Portée spéculaire ---
        if (distSq > _MaxSpecularRangeSq) return;

        // ====================================================================
        // POINT REPRÉSENTATIF avec LOD angulaire
        // ====================================================================
        float lightRadius = max(rightAndWidth.w, upAndHeight.w);
        float angularSize = lightRadius * rsqrt(max(distSq, 1e-6)); // approximation taille angulaire

        float3 repDiff;
        if (lightType == 0 || angularSize < 0.02)
        {
            // Source ponctuelle ou très petite : le vecteur direct suffit
            repDiff = L_vector;
        }
        else if (lightType == 1) // Spot
        {
            float3 R_f = (float3)R;
            float RdotL = dot(R_f, L_vector);
            float3 rayOffset = L_vector - R_f * RdotL;
            float lenSq = dot(rayOffset, rayOffset);
            float invLen = rsqrt(max(lenSq, lightRadius * lightRadius));
            float3 repDir = rayOffset * invLen;
            repDiff = L_vector - repDir * lightRadius;
        }
        else // Area
        {
            // Intersection du rayon réfléchi avec le plan de la dalle, puis clamp au rectangle.
            float3 fwd = forwardAndCosOuter.xyz;
            float3 Rf  = (float3)R;
            float  dL  = min(dot(L_vector, fwd), 0.0);   // <= 0 : le pixel est devant la dalle
            float  dR  = min(dot(Rf, fwd), -1e-3);       // toujours < 0 : continu quand le rayon devient parallèle ou s'éloigne
            float3 hit = Rf * (dL / dR) - L_vector;      // point d'impact, relatif au centre de la dalle
            float2 ext = float2(rightAndWidth.w, upAndHeight.w);
            ext = (ext.x <= ext.y) ? float2(ext.x * _AreaSpecThin, ext.y): float2(ext.x, ext.y * _AreaSpecThin);
            float2 clampP = clamp(float2(dot(hit, rightAndWidth.xyz), dot(hit, upAndHeight.xyz)), -ext, ext);
            repDiff = L_vector + rightAndWidth.xyz * clampP.x + upAndHeight.xyz * clampP.y;
        }

        // --- Atténuation (distance au point représentatif + fondu de portée) ---
        float repDistSq = max(dot(repDiff, repDiff), 1e-6);
        half  specFalloff = (half)rcp(max(repDistSq, _MinLightRadius * _MinLightRadius));
        half  tS = (half)(distSq * rcp(_MaxSpecularRangeSq));
        specFalloff *= 1.0h - smoothstep(0.7h, 1.0h, tS);

        half3 lDir = (half3)(repDiff * rsqrt(repDistSq));

        // --- Early-out : borne haute de l'intensité, pic GGX compris ---
        half specEstimate = _SpecBoost * max(currentCol.r, max(currentCol.g, currentCol.b))
        * specFalloff * specDirMask * camFade * cookieAtten * shadowAtten;
        half Dpeak = min(rcp(3.14159265h * a2 + 1e-7h), 256.0h);
        if (specEstimate * Dpeak <= 0.001h) return;

        // --- Test de lobe : angle R/lumière vs 2·θh, avec coupure à tan(θh) = 6·alpha ---
        half k2 = 36.0h * a2;
        if (dot(R, lDir) < (1.0h - k2) * rcp(1.0h + k2)) return;

        // --- BRDF GGX ---
        half3 H = lDir + vDir;
        H *= rsqrt(max(dot(H, H), 1e-6h));
        half nDotH = saturate(dot(N, H));
        half nDotL_spec = saturate(dot(N, lDir));
        if (nDotL_spec <= 0.0h) return;

        half ggxDenom = max(nDotH * nDotH * (a2 - 1.0h) + 1.0h, 1e-7h);
        half D = a2 / (3.14159265h * ggxDenom * ggxDenom);
        half lambdaL = nDotL_spec * sqrt(a2 + (1.0h - a2) * nDotL_spec * nDotL_spec);
        half Vis = 0.5h * rcp(max(lambdaV + lambdaL, 1e-5h));

        // --- Fresnel (inchangé) ---
        half hDotV = saturate(dot(H, vDir));
        half oneMinusH = 1.0h - hDotV;
        half oneMinusH2 = oneMinusH * oneMinusH;
        half fCurve = oneMinusH2 * oneMinusH2 * oneMinusH;
        half3 fresnel = F0 + (1.0h - F0) * fCurve;

        half horizonFade = saturate(nDotL_spec * 4.0h);

        half3 spec = currentCol * fresnel
        * (D * Vis * specDirMask * specFalloff * camFade * _SpecBoost
        * cookieAtten * shadowAtten * horizonFade);
        specOut = min(spec, (half3)_MaxSpecIntensity);
    }

    float3 LayeredLightmapLighting(
    float4 AlbedoColor,
    float4 Albedo,
    float Metallic,
    float Roughness,
    float3 EmissionColor,
    float3 Emission,
    float3 EmissionIntensity,
    float3 ViewDir,
    float3 WorldPos,
    float3 DefaultNormal,
    float3 WorldNormal,
    float3 SubsurfaceColor,
    float Thickness,
    float2 MainUV,
    float2 LightmapUV,
    float LightGroupMask,
    float IsDynamicMesh,
    float MaterialColumn,
    float ReflectionProbeAssignment,
    out float3 Diffuse,
    out float3 Specular,
    out float3 Reflection,
    out float3 EmissionOut,
    out float AlphaOut)
    {
        Diffuse = 0;
        Specular = 0;
        Reflection = 0;
        EmissionOut = 0;
        AlphaOut = 1;

        // Teinte / alpha / PBR par matériau
        float3 tint = AlbedoColor.rgb;
        float alpha = Albedo.a * AlbedoColor.a;

        #if defined(_UDON_MESH_ARRAYS_ON)
            {
                half4 row0 = _UdonMaterialRow(MaterialColumn, 0.0);
                half4 row1 = _UdonMaterialRow(MaterialColumn, 1.0);
                half4 row2 = _UdonMaterialRow(MaterialColumn, 2.0);
                half4 row3 = _UdonMaterialRow(MaterialColumn, 3.0);

                tint              = (float3)row0.rgb;
                alpha            *= (float)row0.a;
                EmissionColor     = (float3)row2.rgb;
                EmissionIntensity = (float3)row2.a;
                Metallic          = saturate(row3.b > 0.5h ? Metallic : (float)row3.r);
                Roughness         = saturate(row3.a > 0.5h ? Roughness : (float)row3.g);
                SubsurfaceColor   = (float3)row1.rgb;
                Thickness         = (float)row1.a;
            }
        #endif

        float3 surfaceAlbedo = Albedo.rgb * tint;

        alpha = saturate(alpha);
        AlphaOut = alpha;

        #if defined(_ALPHATEST_ON) || defined(ASE_SURFACE_TRANSPARENT)
            if (alpha <= 0.004) return 0;
        #endif

        EmissionOut = Emission * EmissionColor * EmissionIntensity;

        float4 meta = _UdonLightData[0];
        int loopCount = (int)round(meta.x);
        bool reflectionGlobalEnabled = meta.z > 0.5;

        #if defined(SHADER_API_MOBILE)
            const bool specularGlobalEnabled = false;
        #else
            bool specularGlobalEnabled = meta.w > 0.5;
        #endif

        bool isDynamicMesh = IsDynamicMesh > 0.5;
        bool diffuseStaticEnabled = _UdonDiffuseStaticEnabled > 0.5;
        bool diffuseRealtimeEnabled = _UdonDiffuseRealtimeEnabled > 0.5;
        bool diffuseAnyEnabled = diffuseStaticEnabled || diffuseRealtimeEnabled;
        bool arrayValid = _UdonLightLayerArrayValid > 0.5;

        if (loopCount < 1) return 0;

        half3 N = (half3)normalize(WorldNormal);
        half3 defaultN = (half3)normalize(DefaultNormal);
        half3 vDir = (half3)normalize(ViewDir);
        half3 R = reflect(-vDir, N);

        float camDist = distance(_WorldSpaceCameraPos, WorldPos);
        half nDotV = max(dot(N, vDir), _NDotVFloor);

        half specularAARoughness = GeometricSpecularAA(N, (half)Roughness);

        float effectiveLod = _UdonDistanceLODBias(camDist);

        float specFadeEnd = max(_UdonSpecCameraFadeEnd, 0.0);
        bool specInRange = (camDist * camDist) < (specFadeEnd * specFadeEnd);

        bool specPixelOn = specularGlobalEnabled && specInRange;

        half3 F0 = lerp(
        half3(0.04h, 0.04h, 0.04h),
        (half3)surfaceAlbedo,
        (half)Metallic
        );

        int materialMask = (int)round(LightGroupMask);

        half a2 = 0.0h;
        half lambdaV = 0.0h;
        half camFade = 0.0h;

        if (specPixelOn)
        {
            half specAlpha = max(specularAARoughness * specularAARoughness, _Alpha2Floor);
            a2 = specAlpha * specAlpha;
            lambdaV = nDotV * sqrt(a2 + (1.0h - a2) * nDotV * nDotV);
            camFade = 1.0h - (half)smoothstep(specFadeEnd * 0.5, specFadeEnd, camDist);
        }

        half3 diffAcc = half3(0, 0, 0);
        half3 specAcc = half3(0, 0, 0);

        [loop]
        for (int i = 0; i < loopCount; i++)
        {
            int baseIdx = i * 8 + 1;
            half3 diffC, specC;

            _UdonAccumulateLight(
            baseIdx, WorldPos, N, defaultN, R, vDir, effectiveLod,
            F0,
            a2, lambdaV, camFade,
            (half)Thickness, (half3)SubsurfaceColor,
            MainUV, LightmapUV,
            isDynamicMesh, arrayValid, specPixelOn,
            diffuseStaticEnabled, diffuseRealtimeEnabled,
            materialMask, diffC, specC
            );

            diffAcc += diffC;
            specAcc += specC;
        }

        half rawDiffLum = dot(diffAcc, LUM);
        half occlusionFactor = 1.0h;

        #if defined(_DIFFUSE_ON)
            if (diffuseAnyEnabled && !isDynamicMesh)
            {
                half occRaw = saturate(rawDiffLum);

                occlusionFactor = _UdonComputeOcclusionFactor(
                occRaw,
                (half)_ReflectionOcclusionMin,
                (half)_ReflectionOcclusionMax,
                (half)_ReflectionOcclusionSmoothing,
                (half)_ReflectionOcclusionSmoothing,
                1.0h,
                1.0h
                );
            }
        #endif

        half3 refl = 0;

        if (Metallic >= 0.999h && reflectionGlobalEnabled && _UdonReflectionArrayValid > 0.5)
        {
            refl = _UdonComputeReflectionArray(
            WorldPos, N, vDir, R,
            nDotV, (half)Metallic, specularAARoughness,
            F0, isDynamicMesh, occlusionFactor, ReflectionProbeAssignment
            );

            half roughnessFade = 1.0h - smoothstep(0.9h, 0.99h, (half)Roughness);
            refl *= roughnessFade;
        }

        if (diffuseAnyEnabled)
        {
            half3 dielectricDiffuse =
            diffAcc * (half3)surfaceAlbedo * (1.0h - (half)Metallic);

            half metalScatterAmount =
            (half)Metallic * (half)Roughness * (half)Roughness * (half)Roughness;

            half3 metalScatter = diffAcc * F0 * metalScatterAmount;

            Diffuse.rgb = dielectricDiffuse + metalScatter;

            if (isDynamicMesh)
            {
                half3 lightProbeIrradiance = _UdonSampleLightProbes((float3)N);

                Diffuse.rgb += (float3)(
                lightProbeIrradiance *
                (half3)surfaceAlbedo *
                (1.0h - (half)Metallic)
                );
            }

            Specular = (float3)specAcc;
            Reflection = (float3)refl;

            return Diffuse.rgb + Specular + Reflection;
        }
        else
        {
            Diffuse.rgb = 0;

            if (isDynamicMesh)
            {
                half3 lightProbeIrradiance = _UdonSampleLightProbes((float3)N);

                Diffuse.rgb = (float3)(
                lightProbeIrradiance *
                (half3)surfaceAlbedo *
                (1.0h - (half)Metallic)
                );
            }

            Specular = (float3)specAcc;
            Reflection = (float3)refl;

            return Diffuse.rgb + Specular + Reflection;
        }
    }
#endif