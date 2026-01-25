using UnityEngine;

[CreateAssetMenu(fileName = "_UdonSpecularData", menuName = "Meenphie/_UdonSpecularData")]
public class SpecularLightData : ScriptableObject
{
    [Header("Core Data")]
    public Vector4[] bakedPositions; // XYZ = Pos, W = Range
    public Vector4[] bakedColors;    // RGB = Color, W = Summed Intensity
    
    [Header("Area Light Data")]
    public Vector4[] bakedRight;     // XYZ = Right Vector, W = Half-Width
    public Vector4[] bakedUp;        // XYZ = Up Vector, W = Half-Height

    public int lightCount;
}