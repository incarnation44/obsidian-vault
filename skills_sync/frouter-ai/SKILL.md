---
name: frouter-ai
description: Real-time Free AI Model Router & Latency Health-Checker (NVIDIA NIM & OpenRouter). Discovers live zero-cost models (GLM, Qwen, Mistral, Kimi) and automatically generates Opencode/CLI agent configs.
---

# 🆓 frouter: Real-Time Free AI Model Router & Health-Checker

This skill integrates **frouter / free-router** to discover, benchmark, and route requests to live free AI models from **NVIDIA NIM** (100+ models) and **OpenRouter Free Tier** in real-time.

---

## 🚀 When to Use
- When running high-volume batch tasks, test suites, or background subagents where API costs should be **\$0**.
- When you need to find the lowest-latency live free model without manual API benchmarking.
- When generating OpenCode / OpenClaude provider configurations.

---

## 🛠️ CLI Commands & Execution

```bash
# 1. Interactive TUI (Discover, compare latency & uptime, select model)
free-router

# 2. Automated Best-Model Discovery (Returns top live model ID to stdout in ~10s)
free-router --best
```

### Supported Free Providers
- **NVIDIA NIM** (API key prefix: `nvapi-`): 100+ enterprise-grade open weights (Llama 3.3, Qwen 2.5, DeepSeek, Mistral, GLM).
- **OpenRouter Free Tier** (API key prefix: `sk-or-`): Auto-filtered `:free` tagged models.
