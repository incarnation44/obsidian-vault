---
title: "기획 하네스 및 의사결정 기록(ADR) 템플릿"
created: <% tp.file.creation_date("YYYY-MM-DD") %>
updated: <% tp.file.creation_date("YYYY-MM-DD") %>
tags:
  - 기획하네스
  - ADR
  - 의사결정
  - 아키텍처
---

# 🎯 프로젝트 기획 하네스 & ADR (Architecture Decision Record)

> **핵심 원칙**: 실행 방법은 AI에게 위임하되, **무엇을 왜 만드는지(문제 정의 · 기준 · 결정 기록)**는 고정한다.  
> **운영 수칙**: 사소한 일상 변경에는 ADR을 작성하지 않는다. AI 모델 선택, Orchestrator 구조, Local/Cloud 역할, Git 전략, Multi-PC 동기화, RAG/Memory, Security, 핵심 자동화 등 **중대한 기술 결정에만 작성**한다.

---

## 1. 🎯 문제 정의 (Problem Definition)
* **누가 (Target)**: 
* **언제 (Context)**: 
* **무엇을 못 해서 (Friction)**: 
* **무엇을 포기하는가 (Pain Point)**: 
* **해결 시 무엇이 달라지는가 (Expected Outcome)**: 

---

## 2. ⚖️ 판단 기준 및 제약 (Trade-offs & Constraints)
* **기준 1**: **[A]** 와 **[B]** 중에서는 항상 **[A]**. 왜냐하면 `[이유]`이기 때문.
* **기준 2**: **[속도]** 와 **[완성도]** 중에서는 항상 **[   ]**. 왜냐하면 `[이유]`이기 때문.
* **절대 넘지 말아야 할 선 (Hard Constraints)**:
  - 1) 
  - 2) 

---

## 3. 📜 아키텍처 의사결정 기록 (ADR 9대 필수 항목)

### ADR 메타데이터
* **ID / 상태 (Status)**: `PROPOSED` | `ACCEPTED` | `REJECTED` | `SUPERSEDED`
* **일자 (Date)**: YYYY-MM-DD
* **결정 주체 (Deciders)**: 전일도 (최종 승인), Antigravity (분석 및 초안)

### 1) Context (맥락)
* 현재 시스템의 배경, 비즈니스/기술적 제약 사항, 직면한 시스템 상황.

### 2) Problem (직면한 문제)
* 어떤 실제 문제가 발생했는가? 해결하지 않으면 어떤 손실/마찰이 지속되는가?

### 3) Decision (채택한 결정)
* 무엇을 하기로 결정했는가? (구체적 변경 또는 `NO CHANGE` 결정)

### 4) Alternatives (버린 대안들)
* 검토했으나 채택하지 않은 대안 목록 (옵션 1, 옵션 2, 옵션 3 등).

### 5) Reasons (채택 및 기각 이유 - Negative Choice)
* 왜 이 결정을 채택했으며, 왜 다른 대안들은 기각했는가?

### 6) Trade-offs (상충관계 분석)
* 이 결정을 위해 무엇을 얻고(Gain), 무엇을 감수/포기(Sacrifice)했는가?

### 7) Consequences (결과 및 파급 효과)
* 이 결정으로 인해 향후 시스템, 운영 프로세스, 유지보수에 미치는 긍정적/부정적 영향.
