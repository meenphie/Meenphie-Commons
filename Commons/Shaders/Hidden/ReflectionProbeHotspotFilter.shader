Shader "Hidden/Meenphie/ReflectionProbeHotspotFilter"
{
    Properties
    {
        _MainTex ("Source", 2D) = "black" {}
        _HotspotThreshold ("Linear RGB Threshold", Range(0,1)) = 1
        _HotspotFeather ("Threshold Feather", Range(0,0.5)) = 0.1
        _HotspotEnabled ("Enable hotspot removal", Float) = 0
        _HotspotReplacement ("Replacement", Float) = 1
    }

    SubShader
    {
        Cull Off
        ZWrite Off
        ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;
            float4 _SourceHDRDecode;
            float _HotspotThreshold;
            float _HotspotFeather;
            float _HotspotEnabled;
            float _HotspotReplacement;

            float3 DecodeSource(float2 uv)
            {
                return DecodeHDR(tex2D(_MainTex, uv), _SourceHDRDecode);
            }

            float3 CompressToSdr(float3 color)
            {
                return color / max(1.0, max(color.r, max(color.g, color.b)));
            }

            float4 frag(v2f_img input) : SV_Target
            {
                float3 source = DecodeSource(input.uv);
                float brightness = max(source.r, max(source.g, source.b));
                if (_HotspotEnabled < 0.5)
                    return float4(CompressToSdr(source), 1);

                float replacementWeight;
                if (_HotspotFeather <= 1e-5)
                {
                    if (brightness <= _HotspotThreshold)
                        return float4(CompressToSdr(source), 1);
                    replacementWeight = 1.0;
                }
                else
                {
                    float featherStart = max(0.0, _HotspotThreshold - _HotspotFeather);
                    float featherEnd = _HotspotThreshold + _HotspotFeather;
                    replacementWeight = smoothstep(featherStart, featherEnd, brightness);
                    if (replacementWeight <= 0.0)
                        return float4(CompressToSdr(source), 1);
                }

                float3 replacement = 0;
                if (_HotspotReplacement >= 0.5)
                {
                    const float diagonal = 0.70710678;
                    const float2 directions[8] =
                    {
                        float2(1, 0), float2(-1, 0), float2(0, 1), float2(0, -1),
                        float2(diagonal, diagonal), float2(-diagonal, diagonal),
                        float2(diagonal, -diagonal), float2(-diagonal, -diagonal)
                    };

                    float cleanThreshold = max(0.0, _HotspotThreshold - _HotspotFeather);
                    [loop]
                    for (int radius = 1; radius <= 16; radius++)
                    {
                        float3 nearbyColor = 0;
                        float sampleCount = 0;

                        [unroll]
                        for (int direction = 0; direction < 8; direction++)
                        {
                            float2 uv = input.uv + directions[direction] *
                                _MainTex_TexelSize.xy * radius;
                            float3 sampleColor = DecodeHDR(tex2Dlod(_MainTex, float4(uv, 0, 0)), _SourceHDRDecode);
                            float sampleBrightness = max(sampleColor.r, max(sampleColor.g, sampleColor.b));
                            if (sampleBrightness <= cleanThreshold)
                            {
                                nearbyColor += sampleColor;
                                sampleCount += 1;
                            }
                        }

                        if (sampleCount > 0)
                        {
                            replacement = nearbyColor / sampleCount;
                            break;
                        }
                    }
                }

                float3 filtered = lerp(source, replacement, replacementWeight);
                return float4(CompressToSdr(filtered), 1);
            }
            ENDCG
        }
    }
}
