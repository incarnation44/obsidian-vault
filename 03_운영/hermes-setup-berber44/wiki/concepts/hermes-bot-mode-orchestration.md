---
title: Hermes Bot Mode Orchestration & Specialist Upgrade
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [hermes-agent, bot-mode, multi-agent, zotero, consensus-mcp, llm-wiki, memory-poisoning]
sources: [raw/transcripts/hermes-bot-mode-team-level-up.md]
confidence: high
---

# Hermes Bot Mode Orchestration

Hermes의 프로필 기반 봇 모드(Bot Mode)를 활용한 멀티 에이전트 협업 및 지식 연동 아키텍처^[raw/transcripts/hermes-bot-mode-team-level-up.md].

## 1. 봇 모드 팀 구조 (Team Topology)

```
[User / Human-in-the-loop]
          │ (최종 승인)
          ▼
   [Orchestrator] ──(QA Check)──► [Librarian] ──► [LLM Wiki]
          │                            ▲
          └──(업무 위임/리서치 요청)───┘
                     │
                     ▼
               [Researcher]
           (Zotero + Consensus MCP)
```

- **Orchestrator (지휘자)**: 사용자 요구사항을 분해하고, 전문 에이전트에게 위임하며, 제출된 결과물의 품질을 산출물 전달 전 검증.
- **Researcher (전문 연구원)**: 
  - 외부 학술 DB (Consensus MCP)
  - 개인 축적 논문 DB (Zotero)
  - 방법론 스킬 (LLM Wiki Research)을 활용해 교차 검증된 고품질 보고서 작성.
- **Librarian (사서)**: 승인된 지식을 정제하여 외장 공용 두뇌인 **LLM Wiki (`~/wiki`)**에 교차 인용문으로 등록 및 색인 관리.

## 2. 에이전트 기억 오염 (Agentic Memory Poisoning) 방어
- **문제**: 에이전트가 자동 수집한 정보나 왜곡된 컨텍스트를 자체 메모리에 무단 저장 시 기억이 오염되어 향후 환각 유발.
- **해결 방안**: 
  1. 에이전트 내부 메모리 대신 **외부 마크다운 지식 베이스(LLM Wiki)** 사용.
  2. Orchestrator 및 인간의 QA 승인 레이어(Control Layer)를 통과한 검증된 팩트만 위키에 인제스트.

## 3. 핵심 확장 도구 (Tooling)
- **Zotero Integration**: 사용자의 로컬/클라우드 레퍼런스 라이브러리 서치 및 인용문 추출.
- **Consensus MCP**: 학술 논문 및 실증 연구 결과 탐색 MCP 서버.
- **Kanban & Cron Scheduler**: 비동기 타스크 관리 및 주기적 트렌드 추적 스케줄링.

## 관련 문서
- [[hermes-agent]]
- [[llm-wiki-architecture]]
- [[ai-coding-skills-landscape]]
