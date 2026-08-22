---
name: second-brain-audit
description: Audits the Obsidian Second Brain and SQLite Agent Memory to prevent knowledge decay, eliminate stale/contradictory data, and enforce State vs Event separation.
---

# 🧠 Second Brain Anti-Decay Auditor Skill

This skill audits the Obsidian Vault (`C:\전일도`) and SQLite Agent Memory (`memory.db`) to ensure data freshness and prevent memory rotting.

## 🛠️ Execution Command

```powershell
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\second_brain_audit.py"
```

## 📋 Audit Rules
1. **State vs Event Separation**: Verifies that State documents are maintained as single sources of truth, while Event logs are timestamped append-only records.
2. **Metadata Integrity**: Checks for mandatory archiving metadata (Source, Published Date, Created Date).
3. **Decay Prevention**: Identifies stale entries and conflicting files.
