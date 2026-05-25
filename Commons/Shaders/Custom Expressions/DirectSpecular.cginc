// --- GLOBALS ---
uniform float    _UdonSpecularLightCount;
uniform float4   _UdonSpecularLightPos[32];
uniform float4   _UdonSpecularLightDir[32];
uniform float3   _UdonSpecularLightCol[32];
uniform float4   _UdonSpecularLightRight[32];
uniform float4   _UdonSpecularLightUp[32];

float3 DirectSpecular(
float3 Color, 
float Metallic, 
float Smoothness, 
float3 ViewDir, 
float3 WorldPos, 
float3 WorldNormal,
float LightmapMask)
{
    if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || LightmapMask < 0.001) return 0.0;

    static const float specBoost      = 1.0;
    static const float fadeStart      = 25.0;
    static const float maxVisibleDist = 30.0;

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

    float3 specAccum = 0;
    int    loopCount = (int)_UdonSpecularLightCount;

    for (int i = 0; i < loopCount; i++)
    {
        float4 posRange = _UdonSpecularLightPos[i];

        float3 L_vector = posRange.xyz - WorldPos;
        float  distSq   = dot(L_vector, L_vector);

        float rangeSq       = max(posRange.w * posRange.w, 1e-4);
        float inverseSquare = 1.0 / max(distSq, 0.0001);
        float ratio         = distSq / rangeSq;
        float ratioSq       = ratio * ratio;
        float window        = saturate(1.0 - ratioSq);
        if (window <= 0.0) continue;
        float falloff = inverseSquare * (window * window);

        float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
        float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(maxVisibleDist - fadeStart, 1e-4));
        if (distanceFade <= 0.0) continue;

        float4 dirAngle = _UdonSpecularLightDir[i];
        float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));

        bool isPointLight = dirAngle.w < -0.9;
        bool isBidir      = !isPointLight && dirAngle.w < -0.1;

        float spotMask = (isPointLight || isBidir)
            ? 1.0
            : saturate((dot(-L_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));

        if (spotMask <= 0.0) continue;

        // Standard dans UE5/Filament pour les surfaces courbes.
        float horizonFade = saturate(dot(N, L_norm) + 0.2) / 1.2;
        if (horizonFade <= 0.0) continue;

        float3 diff    = 0;
        float  diffSq  = 0;
        float  invDiff = 0;
        float2 halfSize      = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
        float  currentAlpha2 = alpha2;

        [branch]
        if (isPointLight)
        {
            diff    = L_vector;
            diffSq  = distSq;
            invDiff = rsqrt(max(diffSq, 1e-6));
        }
        else
        {
            float denom  = dot(dirAngle.xyz, R);
            float tPlane = dot(L_vector, dirAngle.xyz) / (abs(denom) < 1e-4 ? 1e-4 : denom);
            tPlane = abs(tPlane);

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
            float  missAngularSize = sqrt(max(missDistSq, 1e-6)) * invDiff;

            float alphaPrime = saturate(alpha + (angularSize * 0.2) + (missAngularSize * 0.5));
            currentAlpha2    = max(alphaPrime * alphaPrime, 0.0001);
        }

        float3 lDir = diff * invDiff;
        float3 H    = normalize(lDir + vDir);

        float nDotH = saturate(dot(N, H));

        // nDotL avec horizon softening intégré — pas de continue brutal ici
        float nDotL_raw = dot(N, lDir);
        float nDotL     = saturate(nDotL_raw);
        if (nDotL <= 0.0) continue;

        float d_denom = (nDotH * nDotH) * (currentAlpha2 - 1.0) + 1.0;
        float D       = currentAlpha2 / (3.14159 * d_denom * d_denom);

        float Gl = nDotL / max(nDotL * (1.0 - k) + k, 1e-4);
        float G  = Gv * Gl;

        float hDotV        = saturate(dot(H, vDir));
        float fresnelCurve = exp2((-5.55473 * hDotV - 6.98316) * hDotV);
        float3 F           = F0 + (1.0 - F0) * fresnelCurve;

        float3 spec = F * (D * G) / max(4.0 * nDotV * nDotL, 0.001);

        specAccum += max(0.0, _UdonSpecularLightCol[i]
            * spec
            * nDotL
            * spotMask
            * falloff
            * distanceFade
            * horizonFade);  // <-- atténuation douce au lieu du cull brutal
    }

    return specAccum * specBoost * LightmapMask;
}