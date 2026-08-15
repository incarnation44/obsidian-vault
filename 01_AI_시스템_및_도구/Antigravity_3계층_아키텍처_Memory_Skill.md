# Antigravity 3계층 아키텍처 (RAG + Memory + Skill)

## 📌 1. 아키텍처 개요
기존 RAG(정적 지식 검색) 중심 구조에 **경량 계층형 Memory(경험/실패/결정)**와 **Book-to-Skill(문서의 스킬화)**, 그리고 **Trust Layer(허위 완료 보고 차단 검증)**를 결합하여 에이전트의 자율성과 신뢰성을 극대화한 아키텍처입니다.

```text
                    USER (사용자 요청)
                            │
                            ▼
                  ANTIGRAVITY ORCHESTRATOR
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
      Router             Planner           Trust Layer
        │                                       │
        │                                  실제 결과 검증
        │                                       │
        ├───────────────────┬───────────────────┘
        ▼                   ▼
       RAG               MEMORY (경험 및 기억)
 (Obsidian 지식)            │
                            ├── Short-Term / Long-Term
                            ├── Failures (실패/안티패턴)
                            └── Decisions (설계 결정)
        │
        └───────────────────┐
                            ▼
                          SKILL (작업 방법론)
                            │
                  ┌─────────┴─────────┐
                  ▼                   ▼
            Book-to-Skill        Google Skills
                  │
                  ▼
            필요한 Skill만 온디맨드 로드
                  │
                  ▼
           MODEL ROUTER (Gemini / Ollama)
                  │
                  ▼
              실행 & 사후 검증
                  │
                  ▼
             Memory 피드백 기록
```

---

## 📂 2. 역할 분리 원칙

| 구분 | 대상 | 보관 위치 | 핵심 역할 |
| :--- | :--- | :--- | :--- |
| **RAG** | 외부 / 정적 지식 | `C:\전일도` (Obsidian) | "무엇을 알고 있는가" (지식 베이스) |
| **Memory** | 실제 작업 경험 / 실패 / 결정 | `my_ai_workspace/.agents/memory/` | "과거에 무엇을 했고 무엇이 실패했는가" |
| **Skill** | 검증된 작업 절차 및 지침 | `.agents/skills/` 또는 `config/skills/` | "어떻게 작업하는가" (온디맨드 로딩) |
| **Trust Layer** | 실행 검증 및 가드 | `core/trust_layer.py` | "실제 파일/문법/동작이 완벽한가" (허위 보고 차단) |

---

## 🛠️ 3. 핵심 모듈 및 CLI 사용법

### 1. 계층형 메모리 시스템 (`agent_memory.py`)
- **DB 위치**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\.agents\memory\memory.db`
- **동기화 마크다운**:
  - `decisions.md`: 아키텍처 및 라이브러리 선택 이유
  - `failures.md`: 실패 원인 및 동일 실수 방지 지침
  - `executions.md`: Trust Layer 인증 완료 작업 로그
- **명령어**:
  ```bash
  # 과거 기억 및 실패 이력 검색
  python C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\agent_memory.py query "<키워드>"
  
  # 마크다운 파일 동기화
  python C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\agent_memory.py sync
  ```

### 2. 북투스킬 변환기 (`book_to_skill.py`)
옵시디언 노트나 기술 문서를 에이전트 전용 `SKILL.md`로 자동 변환:
```bash
# 프로젝트 전용 스킬 생성
python C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\book_to_skill.py "C:\전일도\노트.md" [스킬명]

# 전역(Global) 스킬 생성
python C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\book_to_skill.py "C:\전일도\노트.md" [스킬명] --global
```

### 3. 트러스트 레이어 (`trust_layer.py`)
작업 완료 전 물리적 파일 존재, 파이썬/JSON 문법 검사 및 메모리 기록:
```bash
python C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\trust_layer.py "작업설명" <파일1> [파일2...]
```

---

## 🚀 4. 등록된 전역 에이전트 스킬 (Global Skills)
- `book-to-skill`: `C:\Users\ildoc\.gemini\config\skills\book-to-skill\SKILL.md`
- `agent-memory`: `C:\Users\ildoc\.gemini\config\skills\agent-memory\SKILL.md`

## 관련
- [[Hermes_Agent_분석_및_Antigravity_v3_통합_아키텍처]]
- [[AI_에이전트_및_도구_통합_마스터_가이드]]
