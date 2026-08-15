---
source_url: "https://youtu.be/Zuvn5F9HhEo"
channel: "AI Workflow Tutorial"
source_date: "2026-08-14"
registered_date: "2026-08-14"
tags:
  - Antigravity
  - 멀티에이전트
  - MultiAgent
  - 서브에이전트
  - AgentMode
  - 구글AI
---

# 🤖 Google AntiGravity 멀티 에이전트(Multi-Agent) 실전 가동 가이드 (2026 최신판)

> **"단일 챗봇의 한계를 넘어, Google AntiGravity에서 여러 전문 AI 에이전트를 동시에 소환하고 기획·조사·실행을 자동 분업시키는 최신 공식 워크플로우"**

---

## 📌 3줄 핵심 요약

1. **에이전트 모드(Agent Mode) 전환**: 단일 어시스턴트 모드에서 에이전트 모드를 켜면 여러 서브에이전트가 동시에 일하는 다중 워크스페이스로 변신한다.
2. **역할 기반 자동 분업(Role-based Coordination)**: 메인 에이전트가 기획(Planning), 리서치(Researching), 코딩/실행(Executing) 역할을 각 서브에이전트에게 자동 배정한다.
3. **액티비티 패널 실시간 관제**: 서로 다른 에이전트들이 주고받는 메시지와 작업 상태를 Activity Panel에서 한눈에 실시간 모니터링한다.

---

## 💡 내(Antigravity) 시스템에 즉시 적용할 핵심 포인트 (적용 완료 ⭐)

1. **서브에이전트 병렬 호출 (`invoke_subagent`) 극대화**:  
   대규모 리서치나 여러 파일 동시 분석 시, 메인 컨텍스트를 어지럽히지 않고 `research` 및 `self` 서브에이전트를 백그라운드에 병렬로 띄워 3초 만에 결과 취합.
2. **3대 핵심 역할 분업 체계 상시 유지**:
   * 🎯 **Planner (기획/라우터)**: 사용자 요구사항 분석 및 로드맵 수립
   * 🔍 **Researcher (조사/검색)**: 웹 검색 및 문서 정밀 분석
   * 💻 **Executor / Reviewer (실행/검증)**: 코드 작성 및 무결점 자체 검증

## 관련
- [[AI_에이전트_및_도구_통합_마스터_가이드]]
- [[그래프_엔지니어링_차세대_AI에이전트_오케스트레이션_완전정복]]
- [[오르카_기반_그래프_엔지니어링_및_에이전트_오케스트레이션_가이드]]
