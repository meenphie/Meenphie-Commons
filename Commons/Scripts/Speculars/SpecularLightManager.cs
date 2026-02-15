using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class SpecularLightManager : UdonSharpBehaviour
{
    [Header("Settings")]
    public bool isEnabled = true;
    public float activationRadius = 40f;
    [Range(1, 60)] public int updateIntervalFrames = 10;

    [Header("Hierarchy Targets")]
    [Tooltip("The objects that will receive these specific lights")]
    public MeshRenderer[] targetRenderers;

    private const int MAX_LIGHTS = 32;
    private const int MAX_CANDIDATES = 64; 

    [Header("Baked Data")]
    public Vector4[] bakedPositions;
    public Vector4[] bakedColors;
    public Vector4[] bakedRight; 
    public Vector4[] bakedUp;    

    [Header("Debug Info")]
    public int currentActiveCount;
    
    // Shader Buffers
    private Vector4[] _shaderPosBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderColBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderRightBuffer = new Vector4[MAX_LIGHTS];
    private Vector4[] _shaderUpBuffer = new Vector4[MAX_LIGHTS];

    // Logic Buffers
    private float[] _distances = new float[MAX_CANDIDATES];
    private int[] _indices = new int[MAX_CANDIDATES];
    private int[] _lastIndicesSorted = new int[MAX_LIGHTS];
    private int[] _compareBuffer = new int[MAX_LIGHTS];

    // Property Block
    private MaterialPropertyBlock _props;
    private int _posID, _colID, _rightID, _upID, _countID;
    
    private VRCPlayerApi _localPlayer;
    private int _lastFinalCount = -1;
    private bool _isLooping = false;

    void Start()
    {
        _localPlayer = Networking.LocalPlayer;
        _props = new MaterialPropertyBlock();
        
        // Property IDs
        _posID = VRCShader.PropertyToID("_UdonSpecularLightPos");
        _colID = VRCShader.PropertyToID("_UdonSpecularLightCol");
        _rightID = VRCShader.PropertyToID("_UdonSpecularRight");
        _upID = VRCShader.PropertyToID("_UdonSpecularLightUp");
        _countID = VRCShader.PropertyToID("_UdonSpecularLightCount");

        for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;

        if (isEnabled) StartUpdateLoop();
    }

    public void ToggleSpecular()
    {
        isEnabled = !isEnabled;
        if (!isEnabled)
        {
            ApplyToRenderers(0);
            _lastFinalCount = 0;
            currentActiveCount = 0;
            for (int i = 0; i < MAX_LIGHTS; i++) _lastIndicesSorted[i] = -1;
        }
        else
        {
            StartUpdateLoop();
        }
    }

    private void StartUpdateLoop()
    {
        if (_isLooping) return;
        _isLooping = true;
        UpdateNearestLights();
    }

    public void UpdateNearestLights()
    {
        if (!isEnabled || _localPlayer == null) 
        {
            _isLooping = false;
            return;
        }

        Vector3 playerPos = _localPlayer.GetPosition();
        float radiusSq = activationRadius * activationRadius;
        int candidateCount = 0;

        // 1. Filter lights
        for (int i = 0; i < bakedPositions.Length; i++)
        {
            if (bakedPositions[i].w <= 0.001f) continue;
            float distSq = Vector3.SqrMagnitude(playerPos - (Vector3)bakedPositions[i]);
            if (distSq < radiusSq)
            {
                _distances[candidateCount] = distSq;
                _indices[candidateCount] = i;
                candidateCount++;
                if (candidateCount >= MAX_CANDIDATES) break;
            }
        }

        // 2. Sort
        for (int i = 0; i < candidateCount - 1; i++)
        {
            for (int j = 0; j < candidateCount - i - 1; j++)
            {
                if (_distances[j] > _distances[j + 1])
                {
                    float tempD = _distances[j]; _distances[j] = _distances[j + 1]; _distances[j + 1] = tempD;
                    int tempI = _indices[j]; _indices[j] = _indices[j + 1]; _indices[j + 1] = tempI;
                }
            }
        }

        int finalCount = Mathf.Min(candidateCount, MAX_LIGHTS);
        currentActiveCount = finalCount;

        // 3. Check for changes
        for (int i = 0; i < finalCount; i++) _compareBuffer[i] = _indices[i];
        
        // Sort indices numerically for stable comparison
        for (int i = 0; i < finalCount - 1; i++)
        {
            for (int j = 0; j < finalCount - i - 1; j++)
            {
                if (_compareBuffer[j] > _compareBuffer[j + 1])
                {
                    int temp = _compareBuffer[j]; _compareBuffer[j] = _compareBuffer[j + 1]; _compareBuffer[j + 1] = temp;
                }
            }
        }

        bool isDirty = (finalCount != _lastFinalCount);
        if (!isDirty)
        {
            for (int i = 0; i < finalCount; i++)
            {
                if (_compareBuffer[i] != _lastIndicesSorted[i]) { isDirty = true; break; }
            }
        }

        // 4. Update Renderers if dirty
        if (isDirty)
        {
            for (int i = 0; i < MAX_LIGHTS; i++)
            {
                if (i < finalCount)
                {
                    int idx = _indices[i];
                    _shaderPosBuffer[i] = bakedPositions[idx];
                    _shaderColBuffer[i] = bakedColors[idx];
                    _shaderRightBuffer[i] = bakedRight[idx];
                    _shaderUpBuffer[i] = bakedUp[idx];
                    _lastIndicesSorted[i] = _compareBuffer[i];
                }
                else
                {
                    _shaderPosBuffer[i] = Vector4.zero;
                    _shaderColBuffer[i] = Vector4.zero;
                    _shaderRightBuffer[i] = Vector4.zero;
                    _shaderUpBuffer[i] = Vector4.zero;
                    _lastIndicesSorted[i] = -1;
                }
            }
            ApplyToRenderers(finalCount);
            _lastFinalCount = finalCount;
        }

        SendCustomEventDelayedFrames(nameof(UpdateNearestLights), updateIntervalFrames);
    }

    private void ApplyToRenderers(int count)
    {
        if (targetRenderers == null) return;

        // Update the Property Block once
        _props.SetVectorArray(_posID, _shaderPosBuffer);
        _props.SetVectorArray(_colID, _shaderColBuffer);
        _props.SetVectorArray(_rightID, _shaderRightBuffer);
        _props.SetVectorArray(_upID, _shaderUpBuffer);
        _props.SetFloat(_countID, (float)count);

        // Apply to all valid renderers in the hierarchy
        for (int i = 0; i < targetRenderers.Length; i++)
        {
            if (targetRenderers[i] != null)
            {
                targetRenderers[i].SetPropertyBlock(_props);
            }
        }
    }
}