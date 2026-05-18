// --- GLOBALS ---
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
    float  IOR,
    float3 Fresnel,
    float3 Lightmap,
    float3 WorldPos,
    float3 WorldNormal,
    float3 ViewDir)
{
    // --- CONFIGURATION ---
    static const float specBoost      = 0.01;
    static const float lumaStart      = 0.02;
    static const float lumaEnd        = 1.0;
    static const float maxVisibleDist = 30.0;
    static const float fadeStart      = 0.0;

    // --- INIT ---
    float3 N    = normalize(WorldNormal);
    float3 vDir = normalize(ViewDir);
    float3 R    = reflect(-vDir, N);

    // --- LIGHTMAP MASK ---
    float  luma   = dot(Lightmap, float3(0.2126, 0.7152, 0.0722));
    float  lmMask = smoothstep(lumaStart, lumaEnd, luma);
    float3 lmTint = lmMask * lerp(1.0, Lightmap / max(luma, 1e-4), Metallic);

    if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || lmMask <= 0.0001) return 0.0;

    // --- ROUGHNESS ---
    float roughness = 1.0 - Smoothness;
    float alpha     = roughness * roughness;
    float alpha2    = max(alpha * alpha, 0.0001);

    // --- SPECULAR LOOP ---
    float  nDotV     = max(dot(N, vDir), 1e-4);
    float3 specAccum = 0;
    int    loopCount = (int)_UdonSpecularLightCount;

    for (int i = 0; i < loopCount; i++) {
        float4 posRange = _UdonSpecularLightPos[i];

        float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
        float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(maxVisibleDist - fadeStart, 1e-4));
        if (distanceFade <= 0.0) continue;

        float3 L_vector = posRange.xyz - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        float4 dirAngle = _UdonSpecularLightDir[i];
        float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));

        float spotMask = saturate((dot(-L_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
        if (spotMask <= 0.0) continue;

        float3 diff     = 0;
        float  rectMask = 1.0;
        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);

        [branch]
        if (dirAngle.w < -0.9) {
            diff = L_vector;
        }
        else {
            float denom  = dot(dirAngle.xyz, R);
            float tPlane = dot(L_vector, dirAngle.xyz) / (abs(denom) < 1e-4 ? 1e-4 : denom);
            if (tPlane <= 0.0) continue;

            float3 pReflection = WorldPos + R * tPlane;
            float3 lp          = pReflection - posRange.xyz;
            float2 localP      = float2(dot(lp, _UdonSpecularLightRight[i].xyz),
                                        dot(lp, _UdonSpecularLightUp[i].xyz));
            float2 clampedPos  = clamp(localP, -halfSize, halfSize);

            diff = posRange.xyz
                 + _UdonSpecularLightRight[i].xyz * clampedPos.x
                 + _UdonSpecularLightUp[i].xyz    * clampedPos.y
                 - WorldPos;

            float  softness   = max(0.1, roughness * 2.0);
            float2 distToEdge = abs(localP) - halfSize;
            rectMask = smoothstep(softness, 0.0, length(max(distToEdge, 0.0)));
        }

        if (rectMask <= 0.0) continue;

        float  dSqDiff = dot(diff, diff);
        float3 lDir    = diff * rsqrt(max(dSqDiff, 1e-6));
        float3 H       = normalize(lDir + vDir);

        float nDotH = saturate(dot(N, H));
        float nDotL = saturate(dot(N, lDir));

        float d_denom = (nDotH * nDotH) * (alpha2 - 1.0) + 1.0;
        float D       = alpha2 / (3.14159 * d_denom * d_denom);

        float k  = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
        float Gv = nDotV / (nDotV * (1.0 - k) + k);
        float Gl = nDotL / (nDotL * (1.0 - k) + k);
        float G  = Gv * Gl;

        float3 spec = (D * G) / max(4.0 * nDotV * nDotL, 0.001);

        specAccum += max(0.0, _UdonSpecularLightCol[i].rgb
            * _UdonSpecularLightCol[i].w
            * spec
            * nDotL
            * spotMask
            * distanceFade
            * rectMask);
    }

    // --- FINAL ---
    float3 colorTint = lerp(1.0, Color.rgb, Metallic);
    float3 result    = specAccum * colorTint * lmTint * specBoost;
    return result;
}
