using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    [Header("Settings")]
    public bool isEnabled = true;
    public float activationRadius = 16f;
    [Tooltip("Intervalle de frames entre les calculs (1 = chaque frame)")]
    public int updateIntervalFrames = 10;

    private const int MAX_LIGHTS = 32;
    [Range(1, MAX_LIGHTS)] public int activeLightCount = MAX_LIGHTS;

    [Header("Baked Data")]
    public Vector4[] bakedPositions;
    public Vector4[] bakedColors;
    public Vector4[] bakedRight;
    public Vector4[] bakedUp;

    [Header("Debug Info")]
    public int currentActiveCount;
    public bool shaderWasUpdated;

    private Vector4[] _shaderPosBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderColBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRightBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUpBuffer = new Vector4[MAX_LIGHTS];

    private int[] _indices = new int[MAX_LIGHTS];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];

    private int _posID, _colID, _rightID, _upID, _countID;
    private VRCPlayerApi _localPlayer;
    private int _lastFinalCount = -1;

    void Start()
    {
        _localPlayer = Networking.LocalPlayer;
        _posID = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID = VRCShader.PropertyToID("_UdonSpecularLightRight");
        _upID = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _countID = VRCShader.PropertyToID("_UdonSpecularLightCount");

        // Initialisation du cache des index
        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;

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
            for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        }
    }

    public void UpdateNearestLights()
    {
        if (!isEnabled || _localPlayer == null) 
        {
            SendCustomEventDelayedFrames(nameof(UpdateNearestLights), updateIntervalFrames);
            return;
        }

        Vector3 playerPos = _localPlayer.GetPosition();
        float radiusSq = activationRadius * activationRadius;
        int candidateCount = 0;
        int totalBaked = bakedPositions.Length;

        // 1. Culling rapide (Sans tri car total sources <= 32)
        for (int i = 0; i < totalBaked; i++)
        {
            // Rayon d'activation
            float distSq = Vector3.SqrMagnitude(playerPos - (Vector3)bakedPositions[i]);
            if (distSq < radiusSq)
            {
                _indices[candidateCount] = i;
                candidateCount++;
                if (candidateCount >= activeLightCount) break;
            }
        }

        int finalCount = candidateCount;
        currentActiveCount = finalCount;

        // 2. Dirty Check simplifié
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

        // 3. Mise à jour des Buffers si changement détecté
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
                    _lastIndicesSorted[i] = idx;
                }
                else
                {
                    // Nettoyage des slots vides
                    if (_lastIndicesSorted[i] != -1)
                    {
                        _shaderPosBuffer[i] = Vector4.zero;
                        _shaderColBuffer[i] = Vector4.zero;
                        _shaderRightBuffer[i] = Vector4.zero;
                        _shaderUpBuffer[i] = Vector4.zero;
                        _lastIndicesSorted[i] = -1;
                    }
                }
            }
            ApplyToShader(finalCount);
            _lastFinalCount = finalCount;
        }
        else
        {
            shaderWasUpdated = false;
        }

        SendCustomEventDelayedFrames(nameof(UpdateNearestLights), updateIntervalFrames);
    }

    private void ApplyToShader(int count)
    {
        VRCShader.SetGlobalVectorArray(_posID, _shaderPosBuffer);
        VRCShader.SetGlobalVectorArray(_colID, _shaderColBuffer);
        VRCShader.SetGlobalVectorArray(_rightID, _shaderRightBuffer);
        VRCShader.SetGlobalVectorArray(_upID, _shaderUpBuffer);
        VRCShader.SetGlobalFloat(_countID, (float)count);
    }
}