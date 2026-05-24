// --- GLOBALS ---
uniform float    _UdonSpecularLightCount;
uniform float4   _UdonSpecularLightPos[32];
uniform float4   _UdonSpecularLightDir[32];
uniform float4   _UdonSpecularLightCol[32];
uniform float4   _UdonSpecularLightRight[32];
uniform float4   _UdonSpecularLightUp[32];

// dirAngle.w sentinels:
//  >= 0.0  → area light (cosOuter) ou spot
//  -0.5    → area bidirectionnelle (deux faces, même rect)
//  -1.0    → point light (omnidirectionnel, pas de rect)

float3 DirectSpecular(
    float3 Color,
    float  Metallic,
    float  Smoothness,
    float3 Lightmap,
    float3 WorldPos,
    float3 WorldNormal,
    float3 ViewDir)
{
    // --- CONFIGURATION ---
    static const float specBoost  = 0.005;
    static const float fadeStart  = 0.0;
    static const float fadeEnd    = 30.0;

    // --- INIT ---
    float3 N    = normalize(WorldNormal);
    float3 vDir = normalize(ViewDir);
    float3 R    = reflect(-vDir, N);

    // --- LIGHTMAP MASK ---
    float luma = dot(Lightmap, float3(0.2126, 0.7152, 0.0722));
    if (Smoothness < 0.0001 || _UdonSpecularLightCount < 0.5 || luma <= 0.0001) return 0.0;

    // --- ROUGHNESS ---
    float roughness = 1.0 - Smoothness;
    float alpha2    = max(roughness * roughness * roughness * roughness, 0.0001);
    alpha2          = lerp(alpha2, 0.0001, Metallic);

    // --- SPECULAR LOOP ---
    float  nDotV     = max(dot(N, vDir), 1e-4);
    float3 specAccum = 0;
    int    loopCount = (int)_UdonSpecularLightCount;

    for (int i = 0; i < loopCount; i++) {
        float4 posRange = _UdonSpecularLightPos[i];

        float camDist      = distance(_WorldSpaceCameraPos, posRange.xyz);
        float distanceFade = saturate(1.0 - (camDist - fadeStart) / max(fadeEnd - fadeStart, 1e-4));
        if (distanceFade <= 0.0) continue;

        float3 L_vector = posRange.xyz - WorldPos;
        float  distSq   = dot(L_vector, L_vector);
        float4 dirAngle = _UdonSpecularLightDir[i];
        float3 L_norm   = L_vector * rsqrt(max(distSq, 1e-6));

        bool isPointLight = dirAngle.w < -0.9;
        bool isBidir      = !isPointLight && dirAngle.w < -0.1;

        float spotMask = (isPointLight || isBidir)
            ? 1.0
            : saturate((dot(-L_norm, dirAngle.xyz) - dirAngle.w) / max(0.01, 1.0 - dirAngle.w));
        if (spotMask <= 0.0) continue;

        float3 diff     = 0;
        float  rectMask = 1.0;
        float2 halfSize = float2(_UdonSpecularLightRight[i].w, _UdonSpecularLightUp[i].w);

        if (isPointLight) {
            diff = L_vector;
        }
        else {
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

            float  softness   = max(0.01, roughness);
            float2 distToEdge = abs(localP) - halfSize;
            rectMask = smoothstep(softness, 0.0, length(max(distToEdge, 0.0)));
        }

        if (rectMask <= 0.0) continue;

        float3 lDir = diff * rsqrt(max(dot(diff, diff), 1e-6));
        float3 H    = normalize(lDir + vDir);

        float nDotH = saturate(dot(N, H));
        float nDotL = saturate(dot(N, lDir));

        if (nDotL <= 0.0) continue;

        float d_denom = (nDotH * nDotH) * (alpha2 - 1.0) + 1.0;
        float D       = alpha2 / (3.14159265 * d_denom * d_denom);

        float k  = ((roughness + 1.0) * (roughness + 1.0)) / 8.0;
        float Gv = nDotV / max(nDotV * (1.0 - k) + k, 1e-4);
        float Gl = nDotL / max(nDotL * (1.0 - k) + k, 1e-4);
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
    return specAccum * specBoost * colorTint;
}
