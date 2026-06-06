uniform float    _UdonSpecularLightCount;
uniform float4   _UdonSpecularLightPos[32];
uniform float4   _UdonSpecularLightDir[32];
uniform float4   _UdonSpecularLightCol[32];
uniform float4   _UdonSpecularLightRight[32];
uniform float4   _UdonSpecularLightUp[32];

float3 DirectSpecular(
    float3 Color,
    float  Metallic,
    float  Smoothness,
    float3 ViewDir,
    float3 WorldPos,
    float3 WorldNormal,
    float3 VertexNormal,
    float  LightmapMode,
    float  LightmapMask
)
{
    if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5) return 0.0;

    static const float specBoost      = 0.4;
    static const float diffBoost      = 0.1;
    static const float fadeStart      = 25.0;
    static const float maxVisibleDist = 30.0;
    static const float rcpFadeRange   = 1.0 / max(maxVisibleDist - fadeStart, 1e-4);

    float3 N         = normalize(WorldNormal);      // normale finale (normal map)
    float3 N_geo     = normalize(VertexNormal);        // normale géométrique pour backface
    float3 vDir      = normalize(ViewDir);
    float3 R         = reflect(-vDir, N);

    float roughness  = 1.0 - Smoothness;
    float alpha      = roughness * roughness;
    float alpha2     = max(alpha * alpha, 0.0001);
    float nDotV      = max(dot(N, vDir), 0.05);

    float3 F0        = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
    float  k         = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
    float  Gv        = nDotV / max(nDotV * (1.0 - k) + k, 1e-4);

    float3 camPos    = _WorldSpaceCameraPos;

    float3 specTotal = 0;
    float3 diffTotal = 0;

    int loopCount    = (int)_UdonSpecularLightCount;
    bool isDynamicMesh = LightmapMode < 0.5;

    for (int i = 0; i < loopCount; i++)
    {
        float4 posRange = _UdonSpecularLightPos[i];
        float3 L_vector = posRange.xyz - WorldPos;
        float  distSq   = dot(L_vector, L_vector);

        float rangeSq = max(posRange.w * posRange.w, 1e-4);
        float ratio   = distSq / rangeSq;
        if (ratio >= 1.0) continue;

        float3 camToLight   = camPos - posRange.xyz;
        float  camDistSq    = dot(camToLight, camToLight);
        float  camDist      = sqrt(camDistSq);
        float  distanceFade = saturate(1.0 - (camDist - fadeStart) * rcpFadeRange);
        if (distanceFade <= 0.0) continue;

        float ratioSq = ratio * ratio;
        float window  = 1.0 - ratioSq;
        float falloff = window * window / max(distSq, 0.0001);

        float4 dirAngle = _UdonSpecularLightDir[i];
        float  invDist  = rsqrt(max(distSq, 1e-6));
        float3 L_norm   = L_vector * invDist;

        // ----- Backface culling géométrique (indépendant de la normal map) -----
        if (dot(N_geo, L_norm) <= 0.0) continue;

        // ----- Type detection -----
        bool isPointLight = dirAngle.w < -0.9;
        bool isBidir      = !isPointLight && dirAngle.w < -0.1;
        bool isArea       = !isPointLight && !isBidir && dirAngle.w <= 0.0;
        bool isSpot       = !isPointLight && !isBidir && dirAngle.w >  0.0;

        // ----- Direction mask -----
        float dirMask = 1.0;

        if (isSpot)
        {
            float cosOuter = dirAngle.w;
            float cosInner = lerp(cosOuter, 1.0, 0.15);
            float cosAngle = dot(-L_norm, dirAngle.xyz);
            float t        = saturate((cosAngle - cosOuter) / max(1e-4, cosInner - cosOuter));
            dirMask        = t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
        }
        else if (isArea)
        {
            float areaDot = dot(-L_norm, dirAngle.xyz);
            dirMask       = smoothstep(0.0, 0.2, areaDot);
        }

        if (dirMask <= 0.0) continue;

        float horizonFade = saturate(dot(N, L_norm) + 0.2) / 1.2;

        float3 diff    = 0;
        float  diffSq  = 0;
        float  invDiff = 0;
        float2 halfSize      = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
        float  currentAlpha2 = alpha2;

        // ----- Light sampling (Point, Spot, Area) -----
        if (isPointLight)
        {
            diff    = L_vector;
            diffSq  = distSq;
            invDiff = invDist;
        }
        else if (isSpot)
        {
            float RdotL              = dot(R, L_norm);
            float3 closestPointOnRay = L_vector - R * RdotL;
            float  lightRadius       = max(halfSize.x, halfSize.y);
            float  clampedLen        = length(closestPointOnRay);
            float3 repDir            = closestPointOnRay / max(clampedLen, lightRadius);

            diff    = L_vector - repDir * lightRadius;
            diffSq  = max(dot(diff, diff), 1e-6);
            invDiff = rsqrt(diffSq);

            float dist3D     = sqrt(diffSq);
            float angSize    = lightRadius / (2.0 * max(dist3D, 1e-4));
            float alphaPrime = saturate(alpha + angSize * 0.2);
            currentAlpha2    = max(alphaPrime * alphaPrime, 0.0001);
        }
        else   // Area or Bidir
        {
            float denom  = dot(dirAngle.xyz, R);
            float tPlane = dot(L_vector, dirAngle.xyz) / (abs(denom) < 1e-4 ? 1e-4 : denom);
            tPlane = max(tPlane, 0.0);

            float3 pReflection = WorldPos + R * tPlane;
            float3 lp          = pReflection - posRange.xyz;
            float2 localP      = float2(dot(lp, _UdonSpecularLightRight[i].xyz),
                                       dot(lp, _UdonSpecularLightUp[i].xyz));
            float2 clampedPos  = clamp(localP, -halfSize, halfSize);

            diff = posRange.xyz
                 + _UdonSpecularLightRight[i].xyz * clampedPos.x
                 + _UdonSpecularLightUp[i].xyz    * clampedPos.y
                 - WorldPos;

            diffSq  = max(dot(diff, diff), 1e-6);
            invDiff = rsqrt(diffSq);

            float distToClamp  = diffSq * invDiff;
            float lightRadius  = max(halfSize.x, halfSize.y);
            float angularSize  = lightRadius / (2.0 * distToClamp);

            float2 missVec         = localP - clampedPos;
            float  missDistSq      = dot(missVec, missVec);
            float  missAngularSize = sqrt(missDistSq) * invDiff;

            float alphaPrime = saturate(alpha + (angularSize * 0.2) + (missAngularSize * 0.5));
            currentAlpha2    = max(alphaPrime * alphaPrime, 0.0001);
        }

        float3 lDir = diff * invDiff;
        float3 H    = normalize(lDir + vDir);

        float nDotH = saturate(dot(N, H));
        float nDotL = saturate(dot(N, lDir));
        if (nDotL <= 0.0) continue;   // optionnel, déjà filtré mais sécurité

        float d_denom = (nDotH * nDotH) * (currentAlpha2 - 1.0) + 1.0;
        float D       = currentAlpha2 / (3.14159 * d_denom * d_denom);

        float Gl = nDotL / max(nDotL * (1.0 - k) + k, 1e-4);
        float G  = Gv * Gl;

        float hDotV        = saturate(dot(H, vDir));
        float fresnelCurve = exp2((-5.55473 * hDotV - 6.98316) * hDotV);
        float3 F           = F0 + (1.0 - F0) * fresnelCurve;

        float brdfScalar = D * G / max(4.0 * nDotV * nDotL, 0.001)
                         * nDotL * dirMask * falloff * distanceFade * horizonFade;

        float3 lightColor = _UdonSpecularLightCol[i].rgb;

        float3 specContrib = max(0.0, lightColor * F * brdfScalar);
        float3 diffContrib = max(0.0, lightColor * Color.rgb * (1.0 - Metallic)
                           * nDotL * dirMask * falloff * distanceFade * horizonFade);

        specTotal += specContrib;

        float diffMultiplier = isDynamicMesh ? 1.0 : _UdonSpecularLightCol[i].a;
        diffTotal += diffContrib * diffMultiplier;
    }

    if (LightmapMode < 0.5)
    {
        return specTotal * specBoost + diffTotal * diffBoost;
    }
    else
    {
        return specTotal * (specBoost * LightmapMask) + diffTotal;
    }
}