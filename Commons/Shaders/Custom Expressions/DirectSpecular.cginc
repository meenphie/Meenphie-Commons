// --- GLOBALS ---
uniform float    _UdonSpecularLightCount;
uniform float4   _UdonSpecularLightPos[32];
uniform float4   _UdonSpecularLightDir[32];
uniform float4   _UdonSpecularLightCol[32];
uniform float4   _UdonSpecularLightRight[32];
uniform float4   _UdonSpecularLightUp[32];

// dirAngle.w sentinels:
//  >= 0.0  → area light (cosOuter) or spot
//  -0.5    → bidirectional area (two faces, same rect)
//  -1.0    → point light (omnidirectional, no rect)

float3 DirectSpecular(float3 Color, float Metallic, float Smoothness, float3 Lightmap, float3 ViewDir, float3 WorldPos, float3 WorldNormal)
{
    static const float specBoost      = 2.0;
    static const float fadeStart      = 25.0;
    static const float maxVisibleDist = 30.0;
    
    float3 N    = normalize(WorldNormal);
    float3 vDir = normalize(ViewDir);
    float3 R    = reflect(-vDir, N);

    float luma   = dot(Lightmap, float3(0.2126, 0.7152, 0.0722));
    float lmMask = saturate(luma * 2.0);

    if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || lmMask <= 0.0001) return 0.0;

    float roughness = 1.0 - Smoothness;
    float alpha     = roughness * roughness;
    float alpha2    = max(alpha * alpha, 0.0001);

    float  nDotV = max(dot(N, vDir), 0.05);

    // --- HOISTED: constant across all lights ---
    float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);
    float  k  = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
    float  Gv = nDotV / max(nDotV * (1.0 - k) + k, 1e-4);

    float3 specAccum = 0;
    int    loopCount = (int)_UdonSpecularLightCount;

    for (int i = 0; i < loopCount; i++)
    {
        float4 posRange = _UdonSpecularLightPos[i];

        float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
        float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(maxVisibleDist - fadeStart, 1e-4));
        if (distanceFade <= 0.0) continue;

        float3 L_vector = posRange.xyz - WorldPos;
        float  distSq   = dot(L_vector, L_vector);

        float range   = posRange.w;
        float rangeSq = max(range * range, 1e-4);
        float inverseSquare = 1.0 / max(distSq, 0.0001);
        float ratio   = distSq / rangeSq;
        float ratioSq = ratio * ratio;
        float window  = saturate(1.0 - ratioSq);
        float falloff = inverseSquare * (window * window);
        // NOTE: falloff early-out removed — was causing hard cuts

        float4 dirAngle = _UdonSpecularLightDir[i];
        float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));

        bool isPointLight = dirAngle.w < -0.9;
        bool isBidir      = !isPointLight && dirAngle.w < -0.1;

        float spotMask = (isPointLight || isBidir)
        ? 1.0
        : saturate((dot(-L_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
        if (spotMask <= 0.0) continue;

        // --- EARLY NDOTL CULL: L_norm already computed, zero extra cost ---
        // Skips all area-light math for back-facing lights
        float earlyNdotL = dot(N, L_norm);
        if (earlyNdotL <= 0.0) continue;

        float3 diff         = 0;
        float2 halfSize     = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);
        float  currentAlpha2 = alpha2;

        [branch]
        if (isPointLight)
        {
            diff = L_vector;
        }
        else
        {
            float denom  = dot(dirAngle.xyz, R);
            float tPlane = dot(L_vector, dirAngle.xyz) / (abs(denom) < 1e-4 ? 1e-4 : denom);

            if (isBidir)
            tPlane = abs(tPlane);
            else if (tPlane <= 0.0)
            continue;

            float3 pReflection = WorldPos + R * tPlane;
            float3 lp          = pReflection - posRange.xyz;
            float2 localP      = float2(dot(lp, _UdonSpecularLightRight[i].xyz),
            dot(lp, _UdonSpecularLightUp[i].xyz));
            float2 clampedPos  = clamp(localP, -halfSize, halfSize);

            diff = posRange.xyz
            + _UdonSpecularLightRight[i].xyz * clampedPos.x
            + _UdonSpecularLightUp[i].xyz    * clampedPos.y
            - WorldPos;

            float distToClamp    = max(length(diff), 0.001);
            float lightRadius    = max(halfSize.x, halfSize.y);
            float angularSize    = lightRadius / (2.0 * distToClamp);
            float missDist       = length(localP - clampedPos);
            float missAngularSize = missDist / distToClamp;

            float alphaPrime = saturate(alpha + (angularSize * 0.2) + (missAngularSize * 0.5));
            currentAlpha2    = max(alphaPrime * alphaPrime, 0.0001);
        }

        float3 lDir = diff * rsqrt(max(dot(diff, diff), 1e-6));
        float3 H    = normalize(lDir + vDir);

        float nDotH = saturate(dot(N, H));
        float nDotL = saturate(dot(N, lDir));

        if (nDotL <= 0.0) continue;

        float d_denom = (nDotH * nDotH) * (currentAlpha2 - 1.0) + 1.0;
        float D       = currentAlpha2 / (3.14159 * d_denom * d_denom);

        // Gv already computed above — only Gl changes per light
        float Gl = nDotL / max(nDotL * (1.0 - k) + k, 1e-4);
        float G  = Gv * Gl;

        float  hDotV        = saturate(dot(H, vDir));
        float  h_inv        = 1.0 - hDotV;
        float  h_inv2       = h_inv * h_inv;
        float  fresnelCurve = h_inv2 * h_inv2 * h_inv;
        float3 F            = F0 + (1.0 - F0) * fresnelCurve;

        float3 spec = F * (D * G) / max(4.0 * nDotV * nDotL, 0.001);

        specAccum += max(0.0, _UdonSpecularLightCol[i].rgb
        * _UdonSpecularLightCol[i].w
        * spec
        * nDotL
        * spotMask
        * falloff
        * distanceFade
        );
    }

    return specAccum * lmMask * specBoost;
}