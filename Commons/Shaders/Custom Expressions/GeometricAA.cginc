// Geometric AA
static const float _GeomAA_ScreenSpaceVariance = 0.12;
static const float _GeomAA_Threshold           = 0.0001;
static const float _GeomAA_MinRoughness        = 0.1;

float GeometricAA(
float Roughness,
float Metallic,
float3 WorldPos,
float3 WorldNormal,
float3 ViewDir)
{
    if (Metallic < 0.99 || Roughness < _GeomAA_MinRoughness)
    return Roughness;

    float dist = distance(_WorldSpaceCameraPos, WorldPos);
    float pixelWorldSize = dist * 0.001;
    float distVariance   = pixelWorldSize * pixelWorldSize * _GeomAA_ScreenSpaceVariance;

    float nDotV   = saturate(dot(normalize(WorldNormal), normalize(ViewDir)));
    float grazing = 1.0 - nDotV;
    float grazingVariance = grazing * grazing * _GeomAA_ScreenSpaceVariance * 0.25;

    float variance = max(distVariance + grazingVariance - _GeomAA_Threshold, 0.0);
    float alpha    = Roughness * Roughness + variance;

    return sqrt(min(alpha, 1.0));
}