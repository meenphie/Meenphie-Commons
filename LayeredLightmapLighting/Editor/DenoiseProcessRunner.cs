using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEditor;
using Debug = UnityEngine.Debug;

namespace Meenphie.Lighting
{
    /// <summary>
    /// Runs denoise_batch_headless.sh as a child process and translates its
    /// tab-separated stdout protocol into Unity's own EditorUtility progress
    /// bar (cancelable). Blocks the calling thread until the script exits —
    /// this mirrors how the rest of ArrayBuilder already works (synchronous,
    /// progress-bar-driven), so it's safe to call directly from a menu item
    /// or an AssetPostprocessor without any extra threading.
    /// </summary>
    public static class DenoiseProcessRunner
    {
        public struct Result
        {
            public bool Success;
            public bool Cancelled;
            public List<string> OkFiles;
            public List<string> FailedFiles;
        }

        /// <param name="scriptPath">Absolute path to denoise_batch_headless.sh</param>
        /// <param name="directory">Absolute path to the folder containing the EXRs</param>
        /// <param name="specificFiles">
        /// Filenames (relative to <paramref name="directory"/>) to denoise.
        /// Pass null/empty to fall back to a full directory scan (mtime-filtered).
        /// </param>
        /// <param name="compressOriginals">Also DWAA-compress the source EXRs after denoising.</param>
        public static Result Run(string scriptPath, string directory,
            IEnumerable<string> specificFiles = null, bool compressOriginals = false)
        {
            var result = new Result { OkFiles = new List<string>(), FailedFiles = new List<string>() };

            using (var process = new Process())
            {
                process.StartInfo.FileName = "/bin/bash";
                process.StartInfo.ArgumentList.Add(scriptPath);
                process.StartInfo.ArgumentList.Add(directory);
                if (specificFiles != null)
                {
                    foreach (string f in specificFiles)
                    {
                        process.StartInfo.ArgumentList.Add("--file");
                        process.StartInfo.ArgumentList.Add(f);
                    }
                }
                if (compressOriginals)
                    process.StartInfo.ArgumentList.Add("--compress");

                process.StartInfo.UseShellExecute = false;
                process.StartInfo.RedirectStandardOutput = true;
                process.StartInfo.RedirectStandardError = true;
                process.StartInfo.CreateNoWindow = true;

                var stderrLines = new List<string>();
                process.ErrorDataReceived += (s, e) =>
                {
                    if (!string.IsNullOrEmpty(e.Data)) stderrLines.Add(e.Data);
                };

                try
                {
                    process.Start();
                }
                catch (Exception ex)
                {
                    Debug.LogError("[Layered Lighting] Failed to launch denoise script: " + ex.Message);
                    result.Success = false;
                    return result;
                }

                process.BeginErrorReadLine();

                int total = 0;
                int compressTotal = 0;
                string line;
                bool cancelled = false;

                while ((line = process.StandardOutput.ReadLine()) != null)
                {
                    string[] parts = line.Split('\t');
                    switch (parts[0])
                    {
                        case "TOTAL":
                            total = int.Parse(parts[1]);
                            break;

                        case "PROGRESS":
                            {
                                int i = int.Parse(parts[1]);
                                int n = int.Parse(parts[2]);
                                string device = parts[3];
                                string file = parts[4];
                                bool cancel = EditorUtility.DisplayCancelableProgressBar(
                                    "Layered Lighting — Denoising",
                                    $"[{device}] {file}  ({i}/{n})",
                                    n > 0 ? (float)i / n : 0f);
                                if (cancel)
                                {
                                    cancelled = true;
                                    try { process.Kill(); } catch { /* already exiting */ }
                                }
                                break;
                            }

                        case "OK":
                            result.OkFiles.Add(parts[1]);
                            break;

                        case "FAIL":
                            result.FailedFiles.Add(parts[1]);
                            break;

                        case "DONE":
                            break;

                        case "COMPRESS_TOTAL":
                            compressTotal = int.Parse(parts[1]);
                            break;

                        case "COMPRESS_PROGRESS":
                            {
                                int i = int.Parse(parts[1]);
                                int n = int.Parse(parts[2]);
                                string file = parts[3];
                                bool cancel = EditorUtility.DisplayCancelableProgressBar(
                                    "Layered Lighting — Compressing originals",
                                    $"{file}  ({i}/{n})",
                                    n > 0 ? (float)i / n : 0f);
                                if (cancel)
                                {
                                    cancelled = true;
                                    try { process.Kill(); } catch { /* already exiting */ }
                                }
                                break;
                            }

                        case "COMPRESS_DONE":
                            break;

                        case "NOTHING_TO_DO":
                            break;

                        default:
                            // Unrecognized line — surface it but don't fail on it.
                            Debug.Log("[Layered Lighting] denoise script: " + line);
                            break;
                    }

                    if (cancelled) break;
                }

                process.WaitForExit();
                EditorUtility.ClearProgressBar();

                if (stderrLines.Count > 0)
                    Debug.LogWarning("[Layered Lighting] denoise script stderr:\n" + string.Join("\n", stderrLines));

                result.Cancelled = cancelled;
                result.Success = !cancelled && process.ExitCode == 0;

                if (result.FailedFiles.Count > 0)
                    Debug.LogWarning("[Layered Lighting] Denoise failed for " + result.FailedFiles.Count +
                                      " file(s): " + string.Join(", ", result.FailedFiles));

                return result;
            }
        }
    }
}