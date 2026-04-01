using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    [Header("Settings")]
    public bool isEnabled = true;
    public float updateInterval = 0.5f;

    private const int MAX_LIGHTS = 32;
    [Range(1, MAX_LIGHTS)] public int activeLightCount = MAX_LIGHTS;

    [Header("Baked Data")]
    public Vector4[] bakedPositions;
    public Vector4[] bakedColors;
    public Vector4[] bakedRight;
    public Vector4[] bakedUp;
    public Vector4[] bakedDirections;

    [Header("Debug Info")]
    public int currentActiveCount;
    public bool shaderWasUpdated;

    private Vector4[] _shaderPosBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderColBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRightBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUpBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderDirBuffer = new Vector4[MAX_LIGHTS];

    private int[] _indices = new int[MAX_LIGHTS];
    private float[] _distances = new float[MAX_LIGHTS];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];

    private int _posID, _colID, _rightID, _upID, _dirID, _countID;
    private VRCPlayerApi _localPlayer;
    private int _lastFinalCount = -1;

#if UNITY_ANDROID
    private const float MAX_RADIUS = 10f;
#else
    private const float MAX_RADIUS = 20f;
#endif

    private float _maxRadiusSq;

    void Start()
    {
        _localPlayer = Networking.LocalPlayer;

        _posID = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID = VRCShader.PropertyToID("_UdonSpecularLightRight");
        _upID = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _dirID = VRCShader.PropertyToID("_UdonSpecularLightDir");
        _countID = VRCShader.PropertyToID("_UdonSpecularLightCount");

        _maxRadiusSq = MAX_RADIUS * MAX_RADIUS;

        for (int i = 0; i < MAX_LIGHTS; i++)
            _lastIndicesSorted[i] = -1;

        UpdateNearestLights();
    }

    public void ToggleSpecular()
    {
        isEnabled = !isEnabled;

        if (!isEnabled)
        {
            ApplyToShader(0);
            _lastFinalCount = 0;
            currentActiveCount = 0;

            for (int i = 0; i < MAX_LIGHTS; i++)
                _lastIndicesSorted[i] = -1;
        }
    }


    public void UpdateNearestLights()
    {
        if (!isEnabled || _localPlayer == null)
        {
            SendCustomEventDelayedSeconds(nameof(UpdateNearestLights), updateInterval);
            return;
        }

        Vector3 playerPos = _localPlayer.GetPosition();
        int totalBaked = bakedPositions.Length;
        int count = 0;

        // 🔥 Top-N nearest selection
        for (int i = 0; i < totalBaked; i++)
        {
            float distSq = Vector3.SqrMagnitude(playerPos - (Vector3)bakedPositions[i]);

            if (distSq > _maxRadiusSq)
                continue;

            // insertion triée (plus proche → index 0)
            int insertIndex = count;

            while (insertIndex > 0 && _distances[insertIndex - 1] > distSq)
                insertIndex--;

            // si pas utile → skip
            if (insertIndex >= activeLightCount)
                continue;

            // shift droite
            int maxShift = Mathf.Min(count, activeLightCount - 1);
            for (int j = maxShift; j > insertIndex; j--)
            {
                _indices[j] = _indices[j - 1];
                _distances[j] = _distances[j - 1];
            }

            // insert
            _indices[insertIndex] = i;
            _distances[insertIndex] = distSq;

            if (count < activeLightCount)
                count++;
        }

        int finalCount = count;
        currentActiveCount = finalCount;

        // 🔹 Dirty check
        bool isDirty = finalCount != _lastFinalCount;

        if (!isDirty)
        {
            for (int i = 0; i < finalCount; i++)
            {
                if (_indices[i] != _lastIndicesSorted[i])
                {
                    isDirty = true;
                    break;
                }
            }
        }

        // 🔹 Update buffers
        if (isDirty)
        {
            shaderWasUpdated = true;

            for (int i = 0; i < MAX_LIGHTS; i++)
            {
                if (i < finalCount)
                {
                    int idx = _indices[i];

                    _shaderPosBuffer[i] = bakedPositions[idx];
                    _shaderColBuffer[i] = bakedColors[idx];
                    _shaderRightBuffer[i] = bakedRight[idx];
                    _shaderUpBuffer[i] = bakedUp[idx];
                    _shaderDirBuffer[i] = bakedDirections[idx];

                    _lastIndicesSorted[i] = idx;
                }
                else if (_lastIndicesSorted[i] != -1)
                {
                    _shaderPosBuffer[i] = Vector4.zero;
                    _shaderColBuffer[i] = Vector4.zero;
                    _shaderRightBuffer[i] = Vector4.zero;
                    _shaderUpBuffer[i] = Vector4.zero;
                    _shaderDirBuffer[i] = Vector4.zero;

                    _lastIndicesSorted[i] = -1;
                }
            }

            ApplyToShader(finalCount);
            _lastFinalCount = finalCount;
        }
        else
        {
            shaderWasUpdated = false;
        }

        SendCustomEventDelayedSeconds(nameof(UpdateNearestLights), updateInterval);
    }

    private void ApplyToShader(int count)
    {
        VRCShader.SetGlobalVectorArray(_posID, _shaderPosBuffer);
        VRCShader.SetGlobalVectorArray(_colID, _shaderColBuffer);
        VRCShader.SetGlobalVectorArray(_rightID, _shaderRightBuffer);
        VRCShader.SetGlobalVectorArray(_upID, _shaderUpBuffer);
        VRCShader.SetGlobalVectorArray(_dirID, _shaderDirBuffer);
        VRCShader.SetGlobalFloat(_countID, (float)count);
    }
}