# User System & Automation Rules

## 🖥️ System & Hardware Context
- **OS**: Windows 11 Pro (64-bit)
- **CPU**: AMD Ryzen 5 5600XT (6C/12T)
- **GPU**: AMD Radeon RX 6600 8GB
- **RAM**: 32GB DDR4
- **Storage**: C: 1TB NVMe, D: 240GB NVMe, E: 128GB SATA SSD

## ⚡ Local AI (Ollama)
- Endpoint: `http://localhost:11434`
- Models: `qwen2.5:7b`, `deepseek-r1:8b`

## 📁 Key Directories
- Obsidian Vault: `C:\전일도`
- AI Workspace: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`
- GitHub Repo: `https://github.com/incarnation44/obsidian-vault`

## 🛠️ Execution & Behavior Rules
1. **Autonomous Obsidian Operations (Zero Prompt Confirmation)**:
   - When asked to organize, update, create, or modify files in `C:\전일도`, **DO NOT ask for user confirmation**.
   - Execute all file additions, edits, formatting, and categorization automatically in one go.
2. **Git Push Scoping**:
   - Never push automatically on edit. Only run `git push` when explicitly asked ("깃허브에 올려줘", "push해줘").
3. **Category Exclusions**:
   - Exclude gaming content when summarizing or organizing PC/AI/Coding docs.
