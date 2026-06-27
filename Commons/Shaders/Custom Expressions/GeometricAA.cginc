#ifndef GEOMETRIC_AA_INCLUDED
#define GEOMETRIC_AA_INCLUDED

float GeometricAA(
    float Roughness,
    float3 WorldNormal,
    float aaScreenSpaceVariance = 0.12,
    float aaThreshold = 0.0001)
{
    WorldNormal = normalize(WorldNormal);

    float3 dNx = ddx(WorldNormal);
    float3 dNy = ddy(WorldNormal);

    float normalVariance = dot(dNx, dNx) + dot(dNy, dNy);
    normalVariance = max(normalVariance - aaThreshold, 0.0);

    float alpha = Roughness * Roughness;
    alpha += normalVariance * aaScreenSpaceVariance;

    return sqrt(min(alpha, 1.0));
}

#endif // GEOMETRIC_AA_INCLUDED