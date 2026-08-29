---
name: kubernetes-troubleshooter
description: Diagnoses issues with Kubernetes manifests and cluster state. Analyzes logs, events, and resources to identify problems in configuration errors or failed pods. Tailored for lightweight execution (Laptop-friendly).
---

# 🚀 Kubernetes Troubleshooter (Laptop Optimized)

This skill empowers the Antigravity agent to troubleshoot Kubernetes environments (GKE or local) quickly, efficiently, and accurately using local tools and scripts, specifically optimized to avoid heavy local processing to preserve laptop battery and performance.

## 🛠️ When to Use
- When the user asks to troubleshoot a failing pod, deployment, or service.
- When there are `ImagePullBackOff`, `CrashLoopBackOff`, `CreateContainerConfigError`, or other Kubernetes errors.
- When diagnosing network policies or cluster health.

## ⚙️ How it Works (Hardware-Aware Execution)
- **Do NOT run heavy local LLM processing (e.g., Ollama) for this skill.** Always use the default Antigravity Cloud (Gemini) engine to process logs and events to save laptop battery and prevent overheating.
- **Strictly use standard `kubectl` and lightweight Python scripts.**

## 📋 Execution Steps
1. **Understand Context:** Check if the user specified a namespace or pod. If not, ask or check the current context using `kubectl config current-context`.
2. **Run Triage Script:** Run the bundled python script to gather a fast snapshot of cluster health without bombarding the context with endless logs.
   ```powershell
   python "C:\Users\ildoc\.gemini\config\skills\kubernetes-troubleshooter\scripts\kubernetes_triage_script.py" <namespace>
   ```
3. **Analyze & Fix:** Based on the output, identify the root cause using the references in `references/`.
4. **Propose Fix:** Offer to fix the manifest (`replace_file_content` or `write_to_file`) and run `kubectl apply -f` on the user's behalf.

## 📚 References
- Cheat Sheet: `C:\Users\ildoc\.gemini\config\skills\kubernetes-troubleshooter\references\kubectl_cheat_sheet.md`
- Common Errors: `C:\Users\ildoc\.gemini\config\skills\kubernetes-troubleshooter\references\common_errors.md`
