using UnityEditor;
using UnityEngine;


    public static class LightmapDebugger
    {
        private const string Keyword = "_LIGHTMAPDEBUG";
        private const string LIGHTMAPLERP = "_LIGHTMAPLERP";
        

        [MenuItem("Meenphie/Lightmaps/Lightmaps Only")]
        public static void ToggleLightmapsOnly()
        {
            // On demande DIRECTEMENT au shader son état actuel
            // Au lieu d'utiliser une variable 'isEnabled' qui peut se réinitialiser
            bool currentlyActive = Shader.IsKeywordEnabled(Keyword);

            if (currentlyActive)
            {
                Shader.DisableKeyword(Keyword);
                Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Only: <color=red>OFF</color>");
            }
            else
            {
                Shader.EnableKeyword(Keyword);
                Debug.Log($"[<color=purple>Meenphie</color>] Lightmaps Only: <color=green>ON</color>");
            }
        }

        [MenuItem("Meenphie/Lightmaps/Toggle Lightmaps Lerp")]
        public static void ToggleLightmapLerp()
        {
            // On récupère tous les MeshRenderers de la scène
            MeshRenderer[] renderers = GameObject.FindObjectsOfType<MeshRenderer>();

            int materialCount = 0;
            float newValue = 0f;
            bool valueDetermined = false;

            // 1. On détermine la nouvelle valeur (basée sur le premier trouvé)
            foreach (var renderer in renderers)
            {
                foreach (var mat in renderer.sharedMaterials)
                {
                    if (mat != null && mat.HasProperty(LIGHTMAPLERP))
                    {
                        newValue = (mat.GetFloat(LIGHTMAPLERP) > 0.5f) ? 0f : 1f;
                        valueDetermined = true;
                        break;
                    }
                }
                if (valueDetermined) break;
            }

            // 2. On applique et on compte
            foreach (var renderer in renderers)
            {
                foreach (var mat in renderer.sharedMaterials)
                {
                    if (mat != null && mat.HasProperty(LIGHTMAPLERP))
                    {
                        mat.SetFloat(LIGHTMAPLERP, newValue);
                        EditorUtility.SetDirty(mat); // Force l'enregistrement
                        materialCount++;
                    }
                }
            }

            // 3. Feedback dans la console
            string state = (newValue > 0.5f) ? "<color=green>ON</color>" : "<color=red>OFF</color>";
            Debug.Log($"[<color=purple>Meenphie</color>] {materialCount} matériaux mis à jour. Lightmaps Lerp: {state}");
        }
    }
