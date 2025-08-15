using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.Collections;

public class LightProbePlacement : EditorWindow
{
    static float progress = 0.0f;
    static string current = "Hello";
    static bool working = false;

    float heightOffset = 1.0f;
    float mergeDistance = 1.0f;
    LightProbeGroup probeObject;
    bool disableMerging;

    [MenuItem("Window/Generate Light Probes")]
    static void Init()
    {
        EditorWindow window = GetWindow(typeof(LightProbePlacement));
        window.Show();
    }

    void PlaceProbes()
    {
        LightProbeGroup p = probeObject;
        if (p != null)
        {
            working = true;

            progress = 0.0f;
            current = "Triangulating navmesh...";
            EditorUtility.DisplayProgressBar("Generating probes", current, progress);

            p.transform.position = Vector3.zero;

            UnityEngine.AI.NavMeshTriangulation navMesh = UnityEngine.AI.NavMesh.CalculateTriangulation();

            current = "Generating necessary lists...";
            EditorUtility.DisplayProgressBar("Generating probes", current, progress);

            Vector3[] newProbes = navMesh.vertices;
            List<Vector3> probeList = new List<Vector3>(newProbes);
            List<ProbeGenPoint> probeGen = new List<ProbeGenPoint>();

            foreach (Vector3 pg in probeList)
            {
                probeGen.Add(new ProbeGenPoint(pg, false));
            }

            List<Vector3> mergedProbes = new List<Vector3>();
            int probeListLength = newProbes.Length;
            int done = 0;

            foreach (ProbeGenPoint pro in probeGen)
            {
                if (!pro.used)
                {
                    current = "Checking point at " + pro.point.ToString();
                    progress = (float)done / probeListLength;
                    EditorUtility.DisplayProgressBar("Generating probes", current, progress);

                    List<Vector3> nearbyProbes = new List<Vector3> { pro.point };
                    pro.used = true;

                    if (!disableMerging)
                    {
                        foreach (ProbeGenPoint pp in probeGen)
                        {
                            if (!pp.used)
                            {
                                if (Vector3.Distance(pp.point, pro.point) <= mergeDistance)
                                {
                                    pp.used = true;
                                    nearbyProbes.Add(pp.point);
                                }
                            }
                        }
                    }

                    Vector3 newProbe = Vector3.zero;
                    foreach (Vector3 prooo in nearbyProbes)
                    {
                        newProbe += prooo;
                    }
                    newProbe /= nearbyProbes.Count;
                    newProbe += Vector3.up * heightOffset;

                    mergedProbes.Add(newProbe);
                    done += 1;
                }
            }

            current = "Final steps...";
            EditorUtility.DisplayProgressBar("Generating probes", current, progress);

            p.probePositions = mergedProbes.ToArray();

            working = false;
        }
        else
        {
            EditorUtility.DisplayDialog("Error", "Probe object not set", "OK");
        }
    }

    void OnGUI()
    {
        if (GUILayout.Button("Generate probes"))
        {
            PlaceProbes();
        }

        heightOffset = EditorGUILayout.FloatField("Height placement", heightOffset);
        mergeDistance = EditorGUILayout.FloatField("Vector merge distance", mergeDistance);
        disableMerging = EditorGUILayout.Toggle("Disable merging", disableMerging);
        probeObject = (LightProbeGroup)EditorGUILayout.ObjectField("Light Probe Group", probeObject, typeof(LightProbeGroup), true);

        EditorGUILayout.LabelField("This script will automatically generate light probe positions based on the current navmesh.");
        EditorGUILayout.LabelField("Please make sure that you have generated a navmesh before using the script.");
        EditorGUILayout.LabelField("If your navmesh is very large or complex, try using 'Disable Merging' to tremendously speed up the process.");
        EditorGUILayout.LabelField("Keep in mind this may produce more probes than necessary, which may negatively impact performance.");

        if (working)
        {
            EditorUtility.DisplayProgressBar("Generating probes", current, progress);
        }
        else
        {
            EditorUtility.ClearProgressBar();
        }
    }

    void OnInspectorUpdate()
    {
        Repaint();
    }
}

public class ProbeGenPoint
{
    public Vector3 point;
    public bool used = false;

    public ProbeGenPoint(Vector3 p, bool u)
    {
        point = p;
        used = u;
    }
}
