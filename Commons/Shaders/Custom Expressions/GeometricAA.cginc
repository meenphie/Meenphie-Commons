// Geometric AA
static const float _GeomAA_ScreenSpaceVariance = 0.12;
static const float _GeomAA_Threshold           = 0.0001;
static const float _GeomAA_MinRoughness        = 0.1;

float GeometricAA(
float Roughness,
float Metallic,
float3 WorldNormal   // must be normalized
)
{
    // Only apply AA to fully metallic surfaces that are rough enough
    if (Metallic < 0.99 || Roughness < _GeomAA_MinRoughness)
    return Roughness;

    float3 dNx = ddx(WorldNormal);
    float3 dNy = ddy(WorldNormal);
    float normalVariance = dot(dNx, dNx) + dot(dNy, dNy);
    normalVariance = max(normalVariance - _GeomAA_Threshold, 0.0);

    float alpha = Roughness * Roughness;
    alpha += normalVariance * _GeomAA_ScreenSpaceVariance;

    return sqrt(min(alpha, 1.0));
}