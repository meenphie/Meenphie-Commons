using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class MaterialLocationAssetPostprocessor : AssetPostprocessor
{
    void OnPreprocessModel()
    {
        var importSettingsMissing = assetImporter.importSettingsMissing;

        if (!importSettingsMissing)
        {
            Debug.Log("Asset imported already, do not process.");
            return;
        }

        var modelImporter = assetImporter as ModelImporter;
        modelImporter.SearchAndRemapMaterials(ModelImporterMaterialName.BasedOnMaterialName, ModelImporterMaterialSearch.Everywhere);
    }
}