using UnityEngine;

// ScriptableObject for static bake data (optional, if you want to load static data into the manager)
[CreateAssetMenu(fileName = "FakeLightData", menuName = "Meenphie/FakeLightData")]
public class FakeLightData : ScriptableObject
{
    public Vector4[] bakedPositions;
    public Vector4[] bakedColors;
    public int lightCount;
}