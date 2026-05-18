float3 IndirectSpecular(
    float3 Color,
    float  Metallic,
    float  Smoothness,
    float  IOR,
    float3 Fresnel,
    float3 WorldPos,
    float3 WorldNormal,
    float3 ViewDir)
{
// --- 0. PARAMETERS ---
float maxMip = 6.0;

// --- 1. VECTORS ---
float3 N     = normalize(WorldNormal);
float3 V     = normalize(ViewDir);
float3 R     = reflect(-V, N);
float  nDotV = saturate(dot(N, V));

// --- 2. BOX PROJECTION ---
float3 ray = R;
[branch]
if (unity_SpecCube0_ProbePosition.w > 0.0) {
    float3 safeRay  = max(abs(ray), 1e-5) * sign(ray);
    float3 rbMax    = (unity_SpecCube0_BoxMax.xyz - WorldPos) / safeRay;
    float3 rbMin    = (unity_SpecCube0_BoxMin.xyz - WorldPos) / safeRay;
    float3 rbMinMax = (ray > 0) ? rbMax : rbMin;
    float  fa       = min(min(rbMinMax.x, rbMinMax.y), rbMinMax.z);
    ray = ray * fa + (WorldPos - unity_SpecCube0_ProbePosition.xyz);
}

// --- 3. F0 (IOR-BASED) ---
float  iorTerm = (IOR - 1.0) / (IOR + 1.0);
float  f0_base = iorTerm * iorTerm;
float3 F0      = lerp(f0_base.xxx, Color.rgb, Metallic);

// --- 4. ROUGHNESS (PERCEPTUAL) ---
float roughnessOrig       = 1.0 - Smoothness;
float perceptualRoughness = saturate(roughnessOrig);

// --- 5. MIP MAPPING ---
float angleThreshold = smoothstep(0.0, 0.1, nDotV);
float mipLevel       = clamp(perceptualRoughness * angleThreshold * maxMip, 0.0, maxMip);

// --- 6. FRESNEL PBR ---
float3 F = F0 + (max(float3(Smoothness, Smoothness, Smoothness), F0) - F0) * pow(1.0 - nDotV, 5.0);

// --- 7. ATTENUATION ---
float logCurve  = 1.0 - sqrt(roughnessOrig);
float finalFade = lerp(logCurve, 1.0, Metallic);

// --- 8. SAMPLING ---
float4 sampleCube   = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, ray, mipLevel);
float3 indirectSpec = DecodeHDR(sampleCube, unity_SpecCube0_HDR);

return indirectSpec * F * finalFade;
}