---
title: "Skills vs MCP vs RAG vs Memory: AI 에이전트 4대 지식 체계 및 아키텍처 완전분석"
channel: "IBM Technology"
author: "Martin Keen"
source_url: "https://youtu.be/X4FVEEegCbk"
published_date: "2026-09-03"
created_date: "2026-09-04"
category: "AI_시스템_및_도구"
tags:
  - AI에이전트
  - Skills
  - MCP
  - RAG
  - AgentMemory
  - IBMTechnology
  - 아키텍처
  - 컨텍스트엔지니어링
---

# Skills vs MCP vs RAG vs Memory: AI 에이전트의 4대 지식 구축 체계 (IBM Technology 완전분석)

> **아카이빙 3대 필수 메타데이터**
> - **원본 출처**: https://youtu.be/X4FVEEegCbk
> - **원본 정보 발행일자**: 2026-09-03
> - **내 보관소 등록일자**: 2026-09-04
> - **발표자**: 마틴 킨 (Martin Keen, IBM Technology)

---

## 💡 핵심 3줄 요약

1. AI 에이전트에게 사전 학습 데이터 외의 지식을 주입할 때 무작정 컨텍스트 윈도우에 모든 런북과 문서를 때려붓는 방식(Context Stuffing)은 환각과 길 잃음(Dead End)을 초래하는 최악의 접근법임.
2. 실전 에이전트는 **Skills(절차와 판단)**, **MCP(외부 시스템 연동/실행)**, **RAG(사람이 쓴 정적 지식)**, **Memory(에이전트의 경험적 기억)**라는 명확히 분리된 4대 축으로 동작해야 함.
3. "사람이 쓴 글이면 RAG, 에이전트의 경험이면 Memory, 실행 절차면 Skill, 외부 시스템 조작이면 MCP"라는 직관적 룰 오브 썸(Rule of Thumb)을 통해 컨텍스트 낭비 없는 초고효율 에이전트 파이프라인 구축 가능.

---

## 📌 4대 지식 체계 비교 및 500 에러 해결 시나리오

```
                   [ AI Agent Context Window ]
                               │
       ┌───────────────┬───────┴───────┬───────────────┐
       ▼               ▼               ▼               ▼
   [ Skills ]       [ MCP ]         [ RAG ]        [ Memory ]
  절차 및 판단     외부 도구 실행    인간 작성 문서    에이전트 경험
(Runbook & SOP) (Logging, APIs) (Manuals, Docs) (Past Fail/Fix)
```

### 1. 잘못된 접근법: 컨텍스트 윈도우 때려붓기 (Context Stuffing)
* **문제 상황**: 웹 애플리케이션에서 `500 Internal Server Error` 발생.
* **비효율적 본능**: 수많은 런북, 모니터링 대시보드 덤프, 고객 히스토리를 몽땅 프롬프트/컨텍스트에 밀어 넣고 해결하라고 지시.
* **결과**: 에이전트가 엉뚱한 길로 빠지거나(dead ends), 특정 웹페이지 구조와 맞지 않는 두루뭉술한 일반론만 제시하며 실패함.

---

### 2. 4대 요소의 역할 분담과 상호 결합

| 구분 | 역할 및 정의 | 500 에러 시나리오 적용 | 기술적 특징 |
| :--- | :--- | :--- | :--- |
| **Skills<br>(스킬)** | **절차와 판단 기준<br>(Procedure & Judgment)** | "1단계: 에러율 확인 ➔ 2단계: 최근 배포 이력 조회 ➔ 해결 안 되면 인간 엔지니어에게 에스컬레이션" 런북 실행. | **점진적 공개 (Progressive Disclosure)** 적용. 평소엔 비활성화되다 해당 태스크 발동 시에만 컨텍스트에 주입. |
| **MCP<br>(모델 컨텍스트 프로토콜)** | **외부 세계 실행 및 연결<br>(Tooling & Action)** | 스킬의 지시에 따라 실제 로깅 시스템, 메트릭 서버에 쿼리를 날려 실시간 에러율 수치와 로그를 가져옴. | **표준화된 프로토콜**. 독자적인 사설 API 코드 없이 MCP Host(에이전트) ↔ MCP Server(외부 도구) 연결. |
| **RAG<br>(검색 증강 생성)** | **사람이 기록해 둔 문서 지식<br>(Human-Written Knowledge)** | 시스템 매뉴얼, 아키텍처 의존성 맵에서 "이 웹페이지가 정상일 때 어떻게 동작하는지" 정적 스펙 검색. | 벡터 DB 기반 시맨틱 검색. 사람이 사전에 작성/적재해 둔 정형·비정형 도메인 문서에서 매칭 청크 반환. |
| **Memory<br>(에이전트 메모리)** | **에이전트의 경험적 자산<br>(Agent-Learned Experience)** | "지난번에 똑같은 500 에러가 났을 때 매뉴얼에 없던 DB 타임아웃이 원인이었음"을 기억해내고, 이번 해결책도 재기록. | 에이전트 스스로의 실행 결과와 시행착오(Anti-pattern)를 저장하여 시간이 지날수록 지능과 성공률 누적. |

---

### 3. RAG vs Memory의 결정적 차이
* 겉보기엔 둘 다 "필요할 때 관련 지식을 검색해 컨텍스트로 불러오는 것"처럼 보이지만, **지식의 원천(Source)**이 완전히 다름:
  * **RAG**: **사람(인간 엔지니어)**이 벡터 DB에 의도적으로 저장해 둔 지식.
  * **Memory**: **에이전트 자신**이 과거 작업을 수행하면서 스스로 겪고 학습한 경험(Experience).

---

### 4. 마틴 킨의 황금 규칙 (Rule of Thumb)
> 1. 사람이 적어둔 지식인가? ➔ **RAG**
> 2. 에이전트가 경험으로 배운 지식인가? ➔ **Memory**
> 3. 따라야 할 반복적 절차와 판단인가? ➔ **Skills**
> 4. 외부 세계와 표준 규격으로 통신해야 하는가? ➔ **MCP**

---

## 🛠️ AI(나)에게 적용할 점

1. **Antigravity 4계층 아키텍처의 정당성 확인**:
   - 현재 Antigravity 시스템이 `1) 44개 전역 Skills(.gemini\config\skills)`, `2) mcp_config.json`, `3) chunkless-rag`, `4) SQLite memory.db`로 완벽히 4분할되어 운영되는 이유가 IBM의 에이전트 표준 설계와 100% 일치함을 입증.
2. **점진적 공개(Progressive Disclosure) 철저 준수**:
   - 44개의 스킬과 방대한 옵시디언 지식을 한 번에 시스템 프롬프트에 적재하지 않고, 사용자 질문이나 작업 유형에 맞춰 해당 스킬의 `SKILL.md`와 타깃 문서만 핀셋 주입함으로써 컨텍스트 청결 유지.
3. **경험 기억(Memory) 피드백 루프 일상화**:
   - 오늘 진행한 "LDPlayer 인텔 Iris Xe 백화 해결(1600x900/4GB)", "WSL2 보존을 위한 코어 격리 선택적 해제", "Everything CLI 연동"과 같은 실전 문제 해결 결과를 경험적 자산으로 보존하여, 차후 유사 질문 발생 시 탐색 과정 없이 0초 만에 해답 도출.
