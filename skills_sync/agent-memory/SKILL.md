---
name: agent-memory
description: "Hierarchical Agent Memory System. Use this skill to query past decisions, check failure logs (anti-patterns) before starting complex tasks, and record new decisions and execution results."
---

# Agent Memory System Workflow

이 스킬은 Antigravity 에이전트가 과거의 실패와 성공 경험을 기억하고 동일한 실수를 방지하기 위한 메모리 시스템 지침입니다.

Grok Bot 없이 로컬 SQLite만 사용한다. 스킬 폴더에는 SKILL.md만 있고, 실행 스크립트와 DB는 워크스페이스에 있다.

## 🎯 핵심 원칙 (Core Principles)
1. **작업 전 실패 사례 확인**: 복잡한 작업이나 에러가 발생하기 쉬운 명령 실행 전 과거 실패 기록(`failures`)을 먼저 검색한다.
2. **새로운 결정 기록**: 아키텍처 선택이나 중요한 도구 결정을 내렸을 때 `agent_memory.record_decision`으로 기록한다.
3. **허위 완료 보고 금지**: 완료 보고 전 Trust Layer 검증을 거쳐 `executions` 테이블에 승인 도장이 찍혔는지 확인한다.

## 🛠️ CLI 사용법 및 파이썬 인터페이스

실존 경로 (확인됨): `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\agent_memory.py`

### 1. 과거 기억 검색 (Querying Memory)
```powershell
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\agent_memory.py" query "<키워드>"
```

### 2. 마크다운 로그 동기화
```powershell
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\agent_memory.py" sync
```

## 📁 저장 위치
- **SQLite DB**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\.agents\memory\memory.db`
- **마크다운 로그**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\.agents\memory\`
  - `decisions.md` (결정 로그)
  - `failures.md` (실패 및 안티패턴 로그)
  - `executions.md` (검증된 작업 이력)
