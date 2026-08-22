---
name: code-graph-context
description: AST-based Code Dependency Graph & Context Compactor. Solves token bloating by generating focused dependency graphs (imports, callers, classes, affected files) before feeding code into LLM context, achieving up to 90% token savings and superior reasoning precision.
---

# 🕸️ Code Dependency Graph & Context Compactor

Inspired by modern AST call-graph pruning (`code-review-graph` and `Context-Mode`), this skill analyzes file dependencies, function signatures, and call hierarchies before modifying or reviewing code.

Grok Bot 없이 Antigravity가 직접 실행한다.

## 🚀 Key Benefits
1. **90% Token Reduction**: Eliminates irrelevant source files from context.
2. **Impact Boundary Awareness**: Instantly reveals all upstream/downstream files affected by a single function change.
3. **No Hallucination**: LLM focuses strictly on verified imports and type definitions.

## 🛠️ Usage

실존 경로 (확인됨): `C:\Users\ildoc\.gemini\config\skills\code-graph-context\scripts\build_graph.py`

### 1. Analyze Impact & Focused Context for a Target File
```powershell
python "C:\Users\ildoc\.gemini\config\skills\code-graph-context\scripts\build_graph.py" --root "<PROJECT_ROOT>" --target "<TARGET_FILE>"
```

### 2. Export Entire Project Dependency Graph
```powershell
python "C:\Users\ildoc\.gemini\config\skills\code-graph-context\scripts\build_graph.py" --root "<PROJECT_ROOT>" --export-json "<OUTPUT_PATH.json>"
```
