// Fonction auxiliaire pour la projection
float3 ProjectBox(float3 dir, float3 rbMax, float3 rbMin, float3 offset)
{
    float3 inv = 1.0 / (dir + 1e-6);
    float3 tmax = max(rbMax * inv, rbMin * inv);
    float d = min(min(tmax.x, tmax.y), tmax.z);
    return (dir * d) + offset;
}

// Fonction principale Blackhole
float4 Blackhole(
    float3 WorldPos,
    float3 WorldNormal,
    float  SingularityRadius,
    float  LensStrength,
    float  HorizonSoftness,
    float  Roughness
)
{
    const float BASE_OFFSET = 500000.0;
    const float SPEED       = 20.0;
    const float FLOW_SPEED  = 100.0;

    // 1. Vecteurs
    float3 N = normalize(WorldNormal);
    float3 V = normalize(_WorldSpaceCameraPos.xyz - WorldPos);
    float edgeDist = 1.0 - saturate(dot(N, V));

    // 2. Event Horizon (Antialiasé)
    float horizonEdge = smoothstep(max(0.0, SingularityRadius - 0.01), SingularityRadius + 0.01, edgeDist);
    float r = edgeDist;

    // 3. Lens Bending
    float gravity = 1.0 - smoothstep(SingularityRadius, SingularityRadius + 0.5, r);
    float stretch = pow(gravity, LensStrength * 100.0);
    float3 bentDir = normalize(lerp(-V, -N, saturate(stretch)));

    // 4. Rotation Infinie
    float swirlMask = pow(gravity, 15.0);
    float spatialFactor = swirlMask * (1.0 + log(1.0 + 2.0 / (r + 0.1)));
    
    float swirl = fmod((BASE_OFFSET + _Time.y * SPEED) * spatialFactor, 6.2831853);
    float cosA = cos(swirl);
    float sinA = sin(swirl);
    
    float3 finalDir = bentDir * cosA + cross(N, bentDir) * sinA + N * dot(N, bentDir) * (1.0 - cosA);
    finalDir = normalize(finalDir);

    // 5. Aspiration Infinie (Flowmap)
    float flowStrength = pow(gravity, 15.0) * 0.8;
    float phase0 = frac(_Time.y * FLOW_SPEED);
    float phase1 = frac(_Time.y * FLOW_SPEED + 0.5);
    float blend = abs(phase0 * 2.0 - 1.0);
    
    float3 dir0 = normalize(lerp(finalDir, -N, phase0 * flowStrength));
    float3 dir1 = normalize(lerp(finalDir, -N, phase1 * flowStrength));

    // 6. Box Projection
    if (unity_SpecCube0_ProbePosition.w > 0.0)
    {
        float3 rbMax  = unity_SpecCube0_BoxMax.xyz - WorldPos;
        float3 rbMin  = unity_SpecCube0_BoxMin.xyz - WorldPos;
        float3 offset = WorldPos - unity_SpecCube0_ProbePosition.xyz;
        dir0 = ProjectBox(dir0, rbMax, rbMin, offset);
        dir1 = ProjectBox(dir1, rbMax, rbMin, offset);
    }

    // 7. Anti-Aliasing (ddx/ddy)
    float3 dx = ddx(finalDir);
    float3 dy = ddy(finalDir);
    float delta = max(dot(dx, dx), dot(dy, dy));
    float aaMipOffset = 0.5 * log2(delta * 256.0 + 2.0);

    float edgeBlur = (1.0 - smoothstep(SingularityRadius, SingularityRadius + 0.08, r)) * 3.0;
    float mip = clamp((Roughness * 7.0) + stretch + edgeBlur + aaMipOffset, 0.0, 7.0);

    // 8. Lecture et Interpolation
    float4 env0 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, dir0, mip);
    float4 env1 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, dir1, mip);
    float3 env = DecodeHDR(lerp(env0, env1, blend), unity_SpecCube0_HDR);

    // 9. Sortie finale (RGBA)
    float absorption = smoothstep(SingularityRadius, SingularityRadius + HorizonSoftness, r);
    float redshift = (1.0 - smoothstep(SingularityRadius, SingularityRadius + 0.15, r)) * 0.3;
    float3 tint = lerp(float3(1.0, 1.0, 1.0), float3(1.0, 0.2, 0.02), redshift);
    
    // --- NOUVEAU : Logique Alpha ---
    // Le centre (r < SingularityRadius) est opaque (1.0).
    // Dès qu'on dépasse la singularité, l'alpha chute rapidement pour laisser voir la scène.
    float finalAlpha = 1.0 - smoothstep(SingularityRadius, SingularityRadius + 0.25, r);

    return float4(env * absorption * horizonEdge * tint, finalAlpha);
}