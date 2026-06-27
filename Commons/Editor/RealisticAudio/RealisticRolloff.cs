using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

public static class AudioSourceExtensions
{
#if UNITY_EDITOR
    [MenuItem("CONTEXT/AudioSource/Realistic Rolloff")]
    public static void ApplyRealisticRolloff(MenuCommand command)
    {
        var source = (AudioSource)command.context;
        Undo.RecordObject(source, "Realistic Rolloff");
        source.RealisticRolloff();
        EditorUtility.SetDirty(source);
    }

    [MenuItem("CONTEXT/AudioSource/Realistic Spatial Blend")]
    public static void ApplyRealisticBlend(MenuCommand command)
    {
        var source = (AudioSource)command.context;
        Undo.RecordObject(source, "Realistic Spatial Blend");
        source.RealisticBlend();
        EditorUtility.SetDirty(source);
    }

    [MenuItem("CONTEXT/AudioSource/Realistic Audio")]
    public static void ApplyRealisticAudio(MenuCommand command)
    {
        var source = (AudioSource)command.context;
        Undo.RecordObject(source, "Realistic Audio");
        source.RealisticBlend();
        source.RealisticRolloff();
        EditorUtility.SetDirty(source);
    }
#endif

    // Logarithmic (inverse-distance) rolloff, rescaled to reach exactly 0 at maxDistance
    // instead of asymptoting toward it like Unity's built-in Logarithmic mode.
    private static void RealisticRolloff(this AudioSource AS)
    {
        float minD = Mathf.Max(AS.minDistance, 0.01f);
        float maxD = Mathf.Max(AS.maxDistance, minD + 0.01f);

        float rawMin = minD / minD;   // = 1
        float rawMax = minD / maxD;
        float range = rawMin - rawMax;

        const int samples = 20;
        var keys = new Keyframe[samples];

        for (int i = 0; i < samples; i++)
        {
            float t = i / (float)(samples - 1);
            float dist = minD * Mathf.Pow(maxD / minD, t);

            float raw = minD / dist;
            float volume = (raw - rawMax) / range;

            float rawTangent = -minD / (dist * dist);
            float tangent = rawTangent / range;

            keys[i] = new Keyframe(dist, Mathf.Clamp01(volume), tangent, tangent);
        }

        AS.rolloffMode = AudioRolloffMode.Custom;
        AS.SetCustomCurve(AudioSourceCurveType.CustomRolloff, new AnimationCurve(keys));
    }

    // Spatial blend: same logarithmic rolloff-derived curve, but with a sharpness
    // exponent applied before inverting. Uses a fixed close-range reference distance
    // (independent of AS.minDistance) so the 2D zone stays tightly bound to ~20cm
    // from the source regardless of the AudioSource's actual minDistance setting.
    private static void RealisticBlend(this AudioSource AS)
    {
        const float blendMinDistance = 0.2f; // fixed reference distance for the 2D zone

        float minD = Mathf.Max(blendMinDistance, 0.01f);
        float maxD = Mathf.Max(AS.maxDistance, minD + 0.01f);

        float rawMin = minD / minD;   // = 1
        float rawMax = minD / maxD;
        float range = rawMin - rawMax;

        const float sharpness = 4f; // higher = 2D zone shrinks tighter around minD
        const int samples = 20;
        var keys = new Keyframe[samples];

        for (int i = 0; i < samples; i++)
        {
            float t = i / (float)(samples - 1);
            float dist = minD * Mathf.Pow(maxD / minD, t);

            float raw = minD / dist;
            float volume = Mathf.Clamp01((raw - rawMax) / range);

            float volumeSharp = Mathf.Pow(volume, sharpness);
            float blend = 1f - volumeSharp;

            float rawTangent = -minD / (dist * dist);
            float volumeTangent = rawTangent / range;
            float blendTangent = -sharpness * Mathf.Pow(volume, sharpness - 1f) * volumeTangent;

            keys[i] = new Keyframe(dist, Mathf.Clamp01(blend), blendTangent, blendTangent);
        }

        AS.SetCustomCurve(AudioSourceCurveType.SpatialBlend, new AnimationCurve(keys));
    }
}