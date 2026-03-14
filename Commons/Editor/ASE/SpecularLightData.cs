using UnityEngine;

[CreateAssetMenu(fileName = "_UdonSpecularData", menuName = "Meenphie/_UdonSpecularData")]
public class SpecularLightData : ScriptableObject
{
    public Vector4[] bakedPositions;  // XYZ: Pos, W: Range
    public Vector4[] bakedColors;     // RGB: Color, W: Intensity
    public Vector4[] bakedRight;      // XYZ: Right, W: Half-Width
    public Vector4[] bakedUp;         // XYZ: Up, W: Half-Height
    public Vector4[] bakedDirections; // XYZ: Forward, W: cosOuter
    public int lightCount;
}