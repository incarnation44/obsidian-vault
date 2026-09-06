---
title: Wayfinder 대규모 프로젝트 안개 제거형 AI 에이전트 기획 하네스 완전분석
category: 01_AI_시스템_및_도구
tags:
  - Wayfinder
  - 기획하네스
  - AgentPlanning
  - FogOfWar
  - MattPocock
  - 컨텍스트엔지니어링
created: 2026-09-06
updated: 2026-09-06
source: https://youtu.be/F3lL98Pj90o
source_date: 2026-07-30
---

# 🗺️ /wayfinder: 단일 컨텍스트 한계를 넘는 대규모 프로젝트 다중 세션 기획 아키텍처 완전분석

> **출처**: [Matt Pocock - /wayfinder: Nothing is too big to plan anymore](https://youtu.be/F3lL98Pj90o)  
> **발행일자**: 2026-07-30  
> **보관소 등록일자**: 2026-09-06  

---

## 💡 핵심 문제의식: "단일 세션/프롬프트 기획의 한계와 AI 맞춤형 축소 증후군"

* **기존 AI 기획의 병목**: 기존의 기획 도구(/grill-me, 단일 프롬프트 인터뷰 등)는 **단일 대화 세션의 컨텍스트 윈도우(특히 모델의 지능이 극대화되는 스마트 존)**에 종속됨.
* **증상**: 사람이 만들고자 하는 거대한 목표를 AI의 토큰 한계에 억지로 끼워 맞추려고 프로젝트 범위를 사전에 임의로 축소하거나, 초반 질문 단계에서 막히면 전체 기획이 미궁(안개)에 빠짐.
* **Matt Pocock의 해결책 (Wayfinder)**:
  * 전통적인 소프트웨어 엔지니어링의 기획 원칙을 에이전트 스킬로 구현.
  * 목표 지점까지의 **'전장의 안개(Fog of War)'**를 인정하고, 단일 세션이 아닌 **의사결정 지도(Map)와 다중 세션 티켓(Sub-issues)**을 통해 점진적으로 안개를 걷어내는 아키텍처.

---

## 📌 핵심 동작 원리 및 4대 티켓 유형

`mermaid
graph TD
    Start["시작: 모호한 목표 / 거대한 비전"] --> WayfinderMap["🗺️ Wayfinder 상위 맵 생성\n(현재 안개 범위 & 프론티어 식별)"]
    WayfinderMap --> Frontier["결정 가능한 프론티어 티켓 발급"]
    
    Frontier --> T1["1. Grilling (심층 인터뷰/의사결정)"]
    Frontier --> T2["2. Research (서브에이전트 배경 조사)"]
    Frontier --> T3["3. Prototype (핵심 기능 PoC 코드 검증)"]
    Frontier --> T4["4. Task (외부 설정/실제 행동 작업)"]
    
    T1 & T2 & T3 & T4 --> Resolve["개별 독립 세션에서 티켓 완결 & 결과 기록"]
    Resolve --> UpdateMap["상위 맵 업데이트 (안개 축소 & 차단 해제)"]
    UpdateMap --> Complete{"모든 안개 제거 완료?"}
    Complete -- 아니오 --> Frontier
    Complete -- 예 --> SpecOut["최종 Buildable Spec(구현 명세서) 도출 ➔ AFK 에이전트 구현"]
`

### 1. 결정 티켓(Decision Tickets)의 4가지 유형
1. **Grilling (grill)**: 특정 설계나 구현 세부사항에 대해 사람과 AI 간의 1:1 심층 인터뷰 세션.
2. **Research (esearch)**: 서브에이전트가 격리된 세션에서 문서, API, 외부 레퍼런스를 조사해 결과를 반환.
3. **Prototype (prototype)**: 계획이 워터폴(탁상공론)로 흐르는 것을 막기 위해, 실제 코드로 빠르게 PoC를 구현해 피드백을 받는 고충실도 검증 세션.
4. **Task (	ask)**: 사람의 실제 작업, 설정 변경, 외부 미팅 등 에이전트가 단독으로 처리할 수 없는 오프라인 액션.

### 2. 의존성 차단(Blocking)과 프론티어(Frontier) 전진
* 어떤 결정(B)은 선행 결정(A)이나 프로토타입 결과가 나오기 전까지는 내릴 수 없음.
* Wayfinder는 '지금 당장 결정할 수 있는 작업(Frontier)'만 활성화하고, 나머지는 안개(Fog) 속에 둠으로써 토큰 낭비와 환각을 원천 방지함.

### 3. 일회성 명세서(Non-persistent Spec) 철학
* 맵의 모든 안개가 걷히면 	o-spec 명령으로 거대한 구현 명세서(Buildable Spec)를 1회성으로 생성하고, 이를 단위 구현 티켓(Implementation Tickets)으로 쪼개어 자동 구현(AFK Agent)으로 넘김.
* 코드가 구현되면 기획 문서는 보존에 집착하지 않고 과감히 닫거나 삭제함 (코드가 곧 단일 진실 공급원).

---

## 🧭 도구 도입 8단계 게이트 관점의 분석 (체크리스트)

1. **Problem**: 초대형 프로젝트 기획 시 컨텍스트 윈도우 소진 및 단일 패스 설계의 한계.
2. **Current Solution Check**:
   * 우리 Antigravity는 이미 헌법 제10조(프로토콜 6번: 기획 하네스, 7번: 아키텍트 명세 격리, 16번: 기획-실행 2단계 분리)와 implementation_plan.md 프로세스를 갖추고 있음.
3. **Gap 확인**:
   * 현재 우리 일상 작업(KH_AI 실습, 스크립트 작성, 지식 아카이빙)은 단일 세션 하네스로 충분히 완결되며, 수십 개 서브태스크가 얽힌 초대형 프로젝트 요구사항이 발생하지 않음.
4. **Candidate Tool**: Matt Pocock의 /wayfinder 스킬.
5. **판정**: **도입 보류 및 Freeze 유지 (순수 지식으로만 축적)**.
   * 복잡한 외부 티커/이슈 트래커 의존성을 시스템에 추가할 이유가 없음.

---

## 🛠️ Antigravity 시스템 및 워크플로우 적용점 (흡수할 철학)

1. **"안개(Fog of War)"의 현실적 인정**:
   * 거대한 작업을 마주했을 때 한 번에 모든 완벽한 계획을 세우려 하지 말고, Research ➔ Prototype ➔ Decision의 순서로 앞단의 안개부터 하나씩 걷어내는 점진적 분할 접근 유지.
2. **프로토타입 기반 워터폴 방어**:
   * 문서만 길게 쓰는 기획(탁상공론)을 배제하고, 불확실한 부분은 스크래치 스크립트(scratch/)나 작은 PoC 코드를 먼저 돌려보고 계획을 확정하는 원칙 준수.
3. **가역적 명세서 관리**:
   * 기획 문서는 영구 보관용 우상이 아니라, 구현을 위한 '임시 목적지'로 취급하며 코드가 완성되면 상태판(PROJECT_STATUS.md)에 완료 내역만 남기는 깔끔한 수명주기 유지.

---

## 📎 아카이빙 3대 메타데이터
* **원본 출처**: https://youtu.be/F3lL98Pj90o
* **원본 정보 발행일자**: 2026-07-30
* **내 보관소 등록일자**: 2026-09-06
