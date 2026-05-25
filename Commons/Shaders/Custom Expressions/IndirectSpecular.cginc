float3 IndirectSpecular(
float3 Color,
float  Metallic,
float  Smoothness,
float3 ViewDir,
float3 WorldPos,
float3 WorldNormal,
float LightmapMask)
{
    if (Smoothness < 0.0001 || LightmapMask < 0.01) return 0.0;

    // --- 0. PARAMETERS ---
    float maxMip = 6.0;

    // --- 1. VECTORS ---
    float3 N     = normalize(WorldNormal);
    float3 V     = normalize(ViewDir);
    float3 R     = reflect(-V, N);
    float  nDotV = max(dot(N, V), 0.05);   // match DirectSpec floor (avoids dark rim blowout)

    // --- 2. BOX PROJECTION ---
    float3 ray = R;
    [branch]
    if (unity_SpecCube0_ProbePosition.w > 0.0)
    {
        float3 safeRay  = max(abs(ray), 1e-5) * sign(ray);
        float3 rbMax    = (unity_SpecCube0_BoxMax.xyz - WorldPos) / safeRay;
        float3 rbMin    = (unity_SpecCube0_BoxMin.xyz - WorldPos) / safeRay;
        float3 rbMinMax = (ray > 0.0) ? rbMax : rbMin;
        float  fa       = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
        ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
    }

    float3 F0 = lerp(float3(0.04, 0.04, 0.04), Color.rgb, Metallic);

    // --- 4. ROUGHNESS ---
    float roughness           = 1.0 - Smoothness;
    float perceptualRoughness = saturate(roughness);

    // --- 5. MIP LEVEL ---
    float angleThreshold = smoothstep(0.0, 0.1, nDotV);
    float mipLevel       = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);

    // --- 6. FRESNEL — Spherical Gaussian (matches DirectSpec exactly) ---
    // DirectSpec uses hDotV; for indirect we use nDotV as the half-vector proxy,
    // which is the standard UE4 / Filament indirect Fresnel convention.
    float  fresnelCurve = exp2((-5.55473 * nDotV - 6.98316) * nDotV);
    float3 F            = F0 + (1.0 - F0) * fresnelCurve;

    // --- 8. ATTENUATION ---
    float logCurve  = 1.0 - sqrt(roughness);
    float finalFade = lerp(logCurve, 1.0, Metallic);

    // --- 9. SAMPLE PROBE ---
    float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
    float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);

    return indirectSpec * F * finalFade * LightmapMask;
}