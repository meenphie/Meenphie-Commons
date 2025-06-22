
using System;
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class LanguageDetection : UdonSharpBehaviour
{
    [SerializeField] private string locale;

    void Start()
    {
        locale = VRCPlayerApi.GetCurrentLanguage();

        Debug.Log(locale);
    }
}
