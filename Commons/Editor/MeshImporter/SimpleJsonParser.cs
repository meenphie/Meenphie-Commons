using System.Collections.Generic;

public static class SimpleJsonParser
{
    public static Dictionary<string, Dictionary<string, string>> Parse(string json)
    {
        var result = new Dictionary<string, Dictionary<string, string>>();
        json = json.Replace("\r", "").Replace("\n", "");
        string[] materials = json.Split(new string[] { "}," }, System.StringSplitOptions.RemoveEmptyEntries);
        string[] keys = { "Base Color", "Normal", "Roughness", "Metallic", "Emission", "ColorHex", "EmissionHex", "MetallicValue", "RoughnessValue", "EmissionIntensity", "AlphaValue" };

        foreach (var m in materials)
        {
            int s = m.IndexOf('"') + 1;
            int e = m.IndexOf('"', s);
            if (s <= 0 || e <= 0) continue;

            string matName = m.Substring(s, e - s);
            var dict = new Dictionary<string, string>();

            foreach (var k in keys)
            {
                string search = $"\"{k}\":";
                int keyIdx = m.IndexOf(search);
                if (keyIdx != -1)
                {
                    int vStart = keyIdx + search.Length;
                    while (vStart < m.Length && (m[vStart] == ' ' || m[vStart] == ':')) vStart++;
                    if (vStart < m.Length && m[vStart] == '"')
                    {
                        vStart++;
                        int vEnd = m.IndexOf('"', vStart);
                        dict[k] = m.Substring(vStart, vEnd - vStart);
                    }
                    else
                    {
                        int vEnd = m.IndexOfAny(new char[] { ',', '}', ' ' }, vStart);
                        if (vEnd == -1) vEnd = m.Length;
                        dict[k] = m.Substring(vStart, vEnd - vStart).Trim();
                    }
                }
            }
            result[matName] = dict;
        }
        return result;
    }
}