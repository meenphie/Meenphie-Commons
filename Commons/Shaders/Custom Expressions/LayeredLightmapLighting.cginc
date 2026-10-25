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

    // Uniforms globaux
    uniform float _UdonReflectionArrayValid;
    uniform float _UdonLightmapSliceOffset;
    uniform float _UdonReflectionProbeCount;
    uniform float _UdonReflectionProbeMaxMip;
    uniform float4 _UdonReflectionProbeData[MAX_PROBES * 3];
    uniform float4 _UdonReflectionProbeHDR[MAX_PROBES];

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

    uniform float4 _UdonShadowMap_TexelSize;
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
    static const float _MaxDynamicDiffuseRange     = 50.0;
    static const float _MaxDynamicDiffuseRangeSq   = _MaxDynamicDiffuseRange * _MaxDynamicDiffuseRange;
    static const half  _DynamicDiffuseBoost        = 0.25h;
    static const float _DynamicDiffuseSmoothing    = 0.1;
    static const float _MinLightRadius             = 1.0;
    static const float _UdonRealtimeDiffuseWrap    = 1.0;

    static const half  _AreaIndirectBoost          = 0.02h;
    static const half  _AreaMaskTransitionWidth    = 0.1h;

    // Translucence 
    static const half  _SSSDistortion              = 0.05h;  // courbe la direction lumière vers/à travers la normale (simule l'épaisseur traversée)
    static const half  _SSSPower                   = 8.0h;  // resserre (grand) / élargit (petit) le halo de transmission
    static const half  _SSSAmbient                 = 0.0h;  // plancher constant additionnel, 0 = désactivé

    // Specular
    static const float _MaxSpecularRange           = 50.0;
    static const float _MaxSpecularRangeSq         = _MaxSpecularRange * _MaxSpecularRange;
    static const float _SpecularSmoothing          = 2.0;
    static const half  _StaticSpecBoost            = 0.05h;
    static const half  _DynamicSpecBoost           = 0.01h;
    static const half  _MaxSpecIntensity           = 10.0h;

    //GeometricAA
    static const half _SpecularAAScreenSpaceVariance = 0.12h;
    static const half _SpecularAAThreshold           = 0.0001h;
    static const half _SpecularAAMinRoughness        = 0.1h;

    static const float _SpecularOcclusionMin           = 0.0;
    static const float _SpecularOcclusionMax           = 1.0;
    static const float _SpecularOcclusionSmoothingLow   = 0.1;
    static const float _SpecularOcclusionSmoothingHigh  = 0.1; 
    static const half  _SpecularOcclusionStrengthLow    = 1.0h;
    static const half  _SpecularOcclusionStrengthHigh   = 1.0h;

    static const float _UdonSpecCameraFadeStart    = 0.0;
    static const half _SpecIntensityFadeMin        = 0.001h;
    static const half _SpecIntensityFadeSmoothing  = 0.002h;

    // Reflection
    static const float _UdonReflectionProbeBlendRadius = 1.0;   // utilisé seulement si le builder n'a pas exporté de blendDistance (défaut Unity = 1)
    static const half  _StaticReflectionBoost      = 1.0h;
    static const half  _DynamicReflectionBoost     = 1.0h;
    static const float _DynamicReflectionSmoothing = 2.0;
    static const float _UdonSpecCubeLodSteps       = 6.0;   // UNITY_SPECCUBE_LOD_STEPS : nombre de niveaux de rugosité des probes Unity
    // Debug des réflexions (la valeur est lue à la compilation) :
    //   0 = off | 1 = probe retenue par pixel (une couleur par index, noir = aucune)
    //   2 = poids de la probe principale (blanc = seule/entière, gris = en fondu avec la 2e) | 3 = facteur d'occlusion
    static const int   _UdonDebugReflection        = 0;

    static const float _ReflectionOcclusionMin            = 0.15;
    static const float _ReflectionOcclusionMax            = 1.0;
    static const float _ReflectionOcclusionSmoothing      = 0.1;
    static const float _ReflectionOcclusionSmoothingLow   = 0.15;  // largeur côté sombre (0.15 = fondu de 0 jusqu'à Min : plus de contour franc, jamais moins de reflet qu'avant)
    static const float _ReflectionOcclusionSmoothingHigh  = 0.1;   // largeur côté clair
    static const half  _ReflectionOcclusionStrengthLow    = 1.0h;  // >1 = transition plus dure côté sombre, <1 = plus douce
    static const half  _ReflectionOcclusionStrengthHigh   = 1.0h;  // idem côté clair

    // Shadow
    static const float _ShadowMapBias             = 0.0005;
    static const float _ShadowMapSlopeBias        = 0.0005;
    static const float _UdonShadowBackfaceFadeStart  = -0.333; // début du fondu (N·L)
    static const float _UdonShadowBackfaceFadeEnd    = 0.2; // fin du fondu
    static const float _UdonShadowBackfaceMaxThickness = 0.00025;

    // BRDF & utilitaires
    static const half  _NDotVFloor                 = 0.05h;
    static const half  _Alpha2Floor                = 0.0001h;
    static const float _MathDivisorFloor           = 1e-4;
    static const half  _BRDFDenominatorFloor       = 0.001h;
    static const float _MaxReflectionMipFallback   = 6.0;

    static const half3 LUM = half3(1.0h, 1.0h, 1.0h);


    half GeometricSpecularAA(
    half3 geomNormalWS,
    half3 viewDirWS,
    float camDist,
    half  perceptualRoughness,
    half  metallic)
    {
        // Même gate que la version "GeometricAA" d'origine
        if (metallic < 0.99h || perceptualRoughness < _SpecularAAMinRoughness)
        return perceptualRoughness;

        float pixelWorldSize = camDist * 0.002; // ~2mm à 1m (1080p, FOV ~90°) — à ajuster
        half  distVar    = (half)(pixelWorldSize * pixelWorldSize * _SpecularAAScreenSpaceVariance);

        half nDotV       = saturate(dot(geomNormalWS, viewDirWS));
        half grazing     = 1.0h - nDotV;
        half grazingVar  = grazing * grazing * _SpecularAAScreenSpaceVariance * 0.25h;

        half variance = max(distVar + grazingVar - _SpecularAAThreshold, 0.0h);

        half alpha = perceptualRoughness * perceptualRoughness + variance;
        return sqrt(min(alpha, 1.0h));
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

    // Poids d'influence d'une probe en ce point : 0 à `blend` en dehors de la boîte, 0.5 sur la face,
    // 1 à `blend` à l'intérieur. Deux boîtes qui se touchent fondent donc l'une dans l'autre de part et d'autre
    // de leur frontière, au lieu de basculer d'un coup.
    // Une surface qui regarde vers l'intérieur depuis une face (sol sur la face basse, mur sur une face latérale,
    // plafond sur la face haute) ne doit pas s'estomper contre cette face : sa distance à la face est repoussée de
    // `blend` en fonction de l'orientation de la normale. Le facteur est continu (smoothstep) : sur une voûte, le poids
    // évolue progressivement avec la normale, sans seuil qui créerait une coupure franche dans le fondu.
    float _UdonProbeInfluence(int probeIdx, float3 worldPos, float3 nrm)
    {
        int b = probeIdx * 3;
        float3 boxMin = _UdonReflectionProbeData[b + 1].xyz;
        float3 boxMax = _UdonReflectionProbeData[b + 2].xyz;

        float blend = _UdonReflectionProbeData[b + 0].w;   // blendDistance de la probe (0 = ancien export -> valeur par défaut)
        if (blend <= 0.0) blend = _UdonReflectionProbeBlendRadius;

        float3 dMin = worldPos - boxMin;   // > 0 à l'intérieur
        float3 dMax = boxMax - worldPos;

        dMin += smoothstep(0.2, 0.7,  nrm) * blend;   // normale vers +axe : la surface repose sur la face min
        dMax += smoothstep(0.2, 0.7, -nrm) * blend;   // normale vers -axe : la surface repose sur la face max

        float3 m3   = min(dMin, dMax);
        float  edge = min(min(m3.x, m3.y), m3.z);          // distance signée à la face pertinente la plus proche

        return saturate(edge / (2.0 * blend) + 0.5);
    }

    // Sélectionne les deux probes les plus prioritaires (importance d'abord, puis boîte la plus petite)
    // parmi toutes celles qui influencent le pixel — box projection ou non.
    void _UdonSelectProbes(float3 worldPos, float3 nrm,
                           out int idxA, out int idxB, out half wA, out half wB)
    {
        idxA = -1; idxB = -1; wA = 1.0h; wB = 0.0h;

        int probeCount = min((int)_UdonReflectionProbeCount, MAX_PROBES);
        float impA = -1e30, volA = 1e30, wAf = 0.0;
        float impB = -1e30, volB = 1e30, wBf = 0.0;

        for (int i = 0; i < probeCount; i++)
        {
            float w = _UdonProbeInfluence(i, worldPos, nrm);
            if (w <= 0.0) continue;

            int    b    = i * 3;
            float3 size = _UdonReflectionProbeData[b + 2].xyz - _UdonReflectionProbeData[b + 1].xyz;
            float  vol  = max(size.x * size.y * size.z, 1e-6);
            float  imp  = _UdonReflectionProbeData[b + 2].w;   // importance Unity (0 = ancien export)

            if (imp > impA || (imp == impA && vol < volA))
            {
                idxB = idxA; impB = impA; volB = volA; wBf = wAf;
                idxA = i;    impA = imp;  volA = vol;  wAf = w;
            }
            else if (imp > impB || (imp == impB && vol < volB))
            {
                idxB = i; impB = imp; volB = vol; wBf = w;
            }
        }

        wA = (half)wAf;
        wB = (half)wBf;
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

    // Une couleur par index de probe (debug). Jamais noir : le noir est réservé à "aucune probe".
    half3 _UdonDebugProbeColor(int i)
    {
        float3 c = 0.5 + 0.5 * cos(6.2831853 * ((float)i * 0.381966 + float3(0.0, 0.33, 0.67)));
        return (half3)(0.15 + 0.85 * c);
    }

    // geomN = normale géométrique (sans normal map) : sert à choisir/fondre les probes, pour que le détail de
    // normal map ne fasse pas scintiller le poids de fondu.
    half3 _UdonComputeReflectionArray(
    float3 WorldPos, half3 N, half3 geomN, half3 vDir, half3 R,
    half nDotV, half Metallic, half Roughness, half3 F0,
    bool isDynamicMesh, half occlusionFactor)
    {
        int idxA, idxB;
        half wA, wB;
        _UdonSelectProbes(WorldPos, (float3)geomN, idxA, idxB, wA, wB);

        // Debug (voir _UdonDebugReflection) : 1 = probe retenue (noir = aucune), 2 = poids de A, 3 = occlusion
        if (_UdonDebugReflection == 1) return (idxA >= 0) ? _UdonDebugProbeColor(idxA) : (half3)0;
        if (_UdonDebugReflection == 2) return (half3)((idxB >= 0) ? wA : 1.0h);
        if (_UdonDebugReflection == 3) return (half3)occlusionFactor;

        if (idxA < 0) return (half3)0;

        // Unity convolue ses probes sur UNITY_SPECCUBE_LOD_STEPS (6) niveaux, pas sur toute la chaîne de mips.
        float maxMip   = (_UdonReflectionProbeMaxMip > 0.0) ? min(_UdonReflectionProbeMaxMip, _UdonSpecCubeLodSteps) : _MaxReflectionMipFallback;
        float mipLevel = _UdonRoughnessToMip((float)Roughness, maxMip);

        half3 colA = _UdonSampleProbeColor(idxA, WorldPos, (float3)R, mipLevel);

        // Fondu avec la deuxième probe : A garde son poids, le reste va à B pondéré par sa propre influence
        // (B arrive donc à 0 à la limite de sa zone, sans apparition brutale). Une probe seule n'est jamais atténuée.
        if (idxB >= 0 && wA < 0.999h)
        {
            half3 colB = _UdonSampleProbeColor(idxB, WorldPos, (float3)R, mipLevel);
            half  bw   = (1.0h - wA) * wB;
            colA = (colA * wA + colB * bw) / max(wA + bw, 1e-4h);
        }

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

    half _UdonComputeShadowMapShadow(float3 WorldPos, half3 defaultN, half3 L_norm, half3 vDir, bool hasShadow)
    {
        if (!hasShadow || _UdonRealtimeShadowsEnabled < 0.5) return 1.0h;

        // Produit scalaire N·L (réutilisé pour le test backface ET le slope bias)
        half nDotL = dot(defaultN, L_norm);

        float3 lightView = mul(_UdonShadowViewMatrix, float4(WorldPos, 1.0)).xyz;
        float viewDepth = -lightView.z;

        float4x4 gpuProjection = _UdonGetShadowGPUProjection();
        float4 lightClip = mul(gpuProjection, float4(lightView, 1.0));
        if (lightClip.w <= 1e-5) return 1.0h; // hors frustum, on laisse passer (à ajuster)
        float3 shadowNDC = lightClip.xyz / lightClip.w;
        float2 shadowUV = shadowNDC.xy * 0.5 + 0.5;

        float2 edgeDist2 = min(shadowUV, 1.0 - shadowUV);
        float edgeDist = min(edgeDist2.x, edgeDist2.y);
        if (edgeDist <= 0.0) return 1.0h;

        float myDepth = saturate((viewDepth - _Udon_LightNear) / max(_Udon_LightFar - _Udon_LightNear, 1e-5));

        half atten;

        if (nDotL < 0.0h)
        {
            // Backface par rapport à la lumière : deuxième couche d'un objet double-face.
            // On autorise la lumière à traverser si l'épaisseur est faible (objet fin),
            // sinon on force l'ombre (blocage par plusieurs couches).
            // Un seul tap suffit : le PCF serait de toute façon écrasé.
            float storedDepth = UNITY_SAMPLE_TEX2D_LOD(_UdonShadowMap, shadowUV, 0).r;
            // Épaisseur en unités monde (positive si le pixel est derrière la surface la plus proche)
            float thickness = (myDepth - storedDepth) * (_Udon_LightFar - _Udon_LightNear);
            atten = (thickness < _UdonShadowBackfaceMaxThickness) ? 1.0h : 0.0h;
        }
        else
        {
            // Face avant : PCF 2x2 (l'épaisseur n'est pas utilisée dans ce cas)
            float bias = _ShadowMapBias + _ShadowMapSlopeBias * saturate(1.0 - (float)nDotL);
            float2 texel = _UdonShadowMap_TexelSize.xy;
            atten = 0.0h;
            [unroll]
            for (int y = 0; y <= 1; y++)
            {
                [unroll]
                for (int x = 0; x <= 1; x++)
                {
                    float2 uv = shadowUV + (float2(x, y) - 0.5) * texel;
                    float sampleDepth = UNITY_SAMPLE_TEX2D_LOD(_UdonShadowMap, uv, 0).r;
                    atten += (myDepth - bias <= sampleDepth) ? 0.25h : 0.0h;
                }
            }
        }

        // Fondu sur les bords de la shadow map pour éviter les artefacts
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
    half  a2, half lambdaV, half alignThreshold, half camFade,
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
            bool canSpecularBase = specularOn && specPixelOn && !isBaked;
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
        bool  cookieNeeded = (!isBaked) || (specularOn && specPixelOn);

        if (wantsShadow)
        shadowAtten = _UdonComputeShadowMapShadow(WorldPos, defaultN, L_norm, vDir, true);

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
            float3 wPos = lightPos - L_vector;
            float tRay = max(dot(L_vector, (float3)R), 0.0);
            float3 pRefl = wPos + (float3)R * tRay;
            float3 lp = pRefl - lightPos;
            float2 localP = float2(dot(lp, rightAndWidth.xyz), dot(lp, upAndHeight.xyz));
            float2 clampP = clamp(localP, -float2(rightAndWidth.w, upAndHeight.w), float2(rightAndWidth.w, upAndHeight.w));
            repDiff = lightPos + rightAndWidth.xyz * clampP.x + upAndHeight.xyz * clampP.y - wPos;
        }

        // --- Atténuation spéculaire (calculée tôt) ---
        float repDistSq = max(dot(repDiff, repDiff), 1e-6);
        half specFalloff = (half)rcp(max(repDistSq, _MinLightRadius * _MinLightRadius));

        half t = (half)(distSq * rcp(_MaxSpecularRangeSq));
        half specWindowFalloff = 1.0h - smoothstep(1.0h - (half)_SpecularSmoothing, 1.0h, t);
        specFalloff *= specWindowFalloff;

        half estimLum = max(currentCol.r, max(currentCol.g, currentCol.b)); // déjà en mémoire

        half specIntensityEstimate = (isBaked ? _StaticSpecBoost : _DynamicSpecBoost)
        * estimLum * specFalloff * specDirMask * camFade * cookieAtten * shadowAtten;

        if (specIntensityEstimate <= _SpecIntensityFadeMin) return; // Early-out réel
        half specVisibility = smoothstep(_SpecIntensityFadeMin, _SpecIntensityFadeMin + _SpecIntensityFadeSmoothing, specIntensityEstimate);

        // --- Test d'alignement du lobe (généralisé) ---
        // alignThreshold est précalculé par pixel (dépend uniquement de la rugosité)
        half rDotL = dot(R, L_norm);
        half alignmentFade = smoothstep(alignThreshold - 0.05h, alignThreshold + 0.05h, rDotL);
        if (alignmentFade <= 0.0h) return;

        // --- Maintenant seulement, on fait les calculs vectoriels coûteux ---
        half3 lDir = (half3)(repDiff * rsqrt(repDistSq));
        half3 H = normalize(lDir + vDir);
        half nDotH = saturate(dot(N, H));
        half nDotL_spec = saturate(dot(N, lDir));
        if (nDotL_spec <= 0.0h) return;

        // --- BRDF GGX isotrope ---
        // a2 (= alpha²) et lambdaV sont précalculés par pixel
        half ggxDenom = max(nDotH * nDotH * (a2 - 1.0h) + 1.0h, 1e-7h);
        half D = a2 / (3.14159265h * ggxDenom * ggxDenom);
        half lambdaL = nDotL_spec * sqrt(a2 + (1.0h - a2) * nDotL_spec * nDotL_spec);
        half Vis = 0.5h * rcp(max(lambdaV + lambdaL, 1e-5h));

        half hDotV = saturate(dot(H, vDir));
        half oneMinusH = 1.0h - hDotV;
        half oneMinusH2 = oneMinusH * oneMinusH;
        half fCurve = oneMinusH2 * oneMinusH2 * oneMinusH;
        half3 fresnel = F0 + (1.0h - F0) * fCurve;

        half brdf = D * Vis * specDirMask;
        half currentSpecBoost = isBaked ? _StaticSpecBoost : _DynamicSpecBoost;

        // alignmentFade n'était utilisé que comme early-out : le spéculaire apparaissait d'un coup au seuil
        // d'alignement. On l'applique, ainsi qu'un fondu près de l'horizon (nDotL_spec -> 0), où le BRDF
        // (sans terme cosinus) gardait une valeur non nulle et se coupait net.
        half horizonFade = smoothstep(0.0h, 0.25h, nDotL_spec);

        specOut = max((half3)0, currentCol * fresnel * brdf * specFalloff * camFade * currentSpecBoost * cookieAtten * shadowAtten);
        specOut *= specVisibility * alignmentFade * horizonFade;
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
    float3 SubsurfaceColor,
    float  Thickness,
    float2 MainUV,
    float2 LightmapUV,
    float LightGroupMask,
    float IsDynamicMesh,
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
        half nDotV    = max(dot(N, vDir), _NDotVFloor);

        half specularAARoughness = GeometricSpecularAA(
        N, vDir, camDist, (half)Roughness, (half)Metallic);

        float effectiveLod = _UdonDistanceLODBias(camDist);

        float specFadeEnd = max(_UdonSpecCameraFadeEnd, 0.0);
        bool  specInRange = (camDist * camDist) < (specFadeEnd * specFadeEnd);

        // Le spéculaire n'est actif pour ce pixel que si le global est activé ET si le pixel est
        // dans la portée caméra. Passé à _UdonAccumulateLight à la place de specularGlobalEnabled.
        bool specPixelOn = specularGlobalEnabled && specInRange;

        half3 F0 = lerp(half3(0.04h, 0.04h, 0.04h), (half3)Color, (half)Metallic);
        int materialMask = (int)round(LightGroupMask);

        // --- Constantes spéculaires par pixel (calculées une seule fois, hors de la boucle) ---
        half a2 = 0.0h;
        half lambdaV = 0.0h;
        half alignThreshold = 0.0h;
        half camFade = 0.0h;
        if (specPixelOn)
        {
            half alpha = max(specularAARoughness * specularAARoughness, _Alpha2Floor);
            a2 = alpha * alpha;
            lambdaV = nDotV * sqrt(a2 + (1.0h - a2) * nDotV * nDotV);
            alignThreshold = lerp(0.6h, 0.1h, specularAARoughness);
            camFade = 1.0h - smoothstep(0.0, specFadeEnd, camDist);
        }

        half3 diffAcc = half3(0,0,0);
        half3 specAccBaked = half3(0,0,0);
        half3 specAccRealtime = half3(0,0,0);

        int effectiveLoopCount = loopCount;

        [loop]
        for (int i = 0; i < effectiveLoopCount; i++)
        {
            int baseIdx = i * 8 + 1;
            half3 diffC, specC;
            
            _UdonAccumulateLight(baseIdx, WorldPos, N, defaultN, R, vDir, effectiveLod,
            F0,
            a2, lambdaV, alignThreshold, camFade,
            (half)Thickness, (half3)SubsurfaceColor,
            MainUV, LightmapUV,
            isDynamicMesh, arrayValid, specPixelOn,
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
            if (diffuseAnyEnabled && !isDynamicMesh)
            {
                half occRaw = saturate(rawDiffLum);
                occlusionFactor = _UdonComputeOcclusionFactor(occRaw,
                (half)_ReflectionOcclusionMin, (half)_ReflectionOcclusionMax,
                (half)_ReflectionOcclusionSmoothingLow, (half)_ReflectionOcclusionSmoothingHigh,
                _ReflectionOcclusionStrengthLow, _ReflectionOcclusionStrengthHigh);
            }
        #endif

        half3 refl = 0;
        if (Roughness < 0.99 && reflectionGlobalEnabled && _UdonReflectionArrayValid > 0.5)
        {
            // Direction de réflexion standard (pas d'anisotropie)
            refl = _UdonComputeReflectionArray(WorldPos, N, defaultN, vDir, R, nDotV, (half)Metallic, specularAARoughness, F0, isDynamicMesh, occlusionFactor);

            // Le seuil Roughness < 0.99 coupait le reflet d'un coup : on l'éteint progressivement avant ce seuil.
            refl *= 1.0h - smoothstep(0.9h, 0.99h, (half)Roughness);
        }

        if (diffuseAnyEnabled)
        {
            half specOcclusionFactor = 1.0h;
            if (diffuseAnyEnabled)
            {
                half occRawSpec = saturate(rawDiffLum);
                specOcclusionFactor = _UdonComputeOcclusionFactor(occRawSpec,
                (half)_SpecularOcclusionMin, (half)_SpecularOcclusionMax,
                (half)_SpecularOcclusionSmoothingLow, (half)_SpecularOcclusionSmoothingHigh,
                _SpecularOcclusionStrengthLow, _SpecularOcclusionStrengthHigh);
            }

            half3 dielectricDiffuse = diffAcc * (half3)Color * (1.0h - (half)Metallic);
            half metalScatterAmount = (half)Metallic * (half)Roughness * (half)Roughness * (half)Roughness;
            half3 metalScatter = diffAcc * F0 * metalScatterAmount;

            Diffuse = (float3)(dielectricDiffuse + metalScatter);

            if (isDynamicMesh)
            {
                half3 lightProbeIrradiance = _UdonSampleLightProbes((float3)N);
                half3 probeDiffuse = lightProbeIrradiance * (half3)Color * (1.0h - (half)Metallic);
                Diffuse += (float3)probeDiffuse;
            }

            Specular = (float3)(specAccBaked * specOcclusionFactor + specAccRealtime);
            Reflection = (float3)refl;

            return Diffuse + Specular + Reflection;
        }
        else
        {
            Diffuse = 0;
            if (isDynamicMesh)
            {
                half3 lightProbeIrradiance = _UdonSampleLightProbes((float3)N);
                Diffuse = (float3)(lightProbeIrradiance * (half3)Color * (1.0h - (half)Metallic));
            }

            Specular = (float3)(specAccBaked + specAccRealtime);
            Reflection = (float3)refl;
            return Diffuse + Specular + Reflection;
        }
    }
#endif
