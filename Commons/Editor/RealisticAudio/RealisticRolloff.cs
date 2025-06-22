using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif


public static class AudioSourceExtensions
{
#if UNITY_EDITOR
    [MenuItem("CONTEXT/AudioSource/Realistic Setup")]
    public static void RealisticRolloff(MenuCommand command)
    {
        Undo.RecordObject(command.context, "AudioSource Realistic Setup");
        ((AudioSource)command.context).RealisticRolloff();
        ((AudioSource)command.context).RealisticBlend();
        EditorUtility.SetDirty(command.context);
    }
#endif

    private static void RealisticRolloff(this AudioSource AS)
    {
        var animCurve = new AnimationCurve(
            new Keyframe(AS.minDistance, 1f),
            new Keyframe(AS.minDistance + (AS.maxDistance - AS.minDistance) / 4f, .35f),
            new Keyframe(AS.maxDistance, 0f));

        AS.rolloffMode = AudioRolloffMode.Custom;
        animCurve.SmoothTangents(1, .025f);
        AS.SetCustomCurve(AudioSourceCurveType.CustomRolloff, animCurve);

        AS.spread = 60f;
    }

    private static void RealisticBlend(this AudioSource AS)
    {
        var animCurve = new AnimationCurve(
            new Keyframe(AS.minDistance, 0.8f),
            new Keyframe(AS.maxDistance, 1.0f));

        AS.SetCustomCurve(AudioSourceCurveType.SpatialBlend, animCurve);
    }
}
