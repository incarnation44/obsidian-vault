---
title: "Graph Engineering 101 - 에이전트 워크플로우 제어와 State Schema 아키텍처"
created: 2026-09-04
tags:
  - youtube
  - google-cloud
  - graph-engineering
  - agent
  - multi-agent
  - workflow
  - state-schema
source: "https://youtu.be/IrW0_f-w4kA"
published: "2026-09-04"
archived: 2026-09-04
channel: "Google Cloud Tech"
---

# Graph Engineering 101 - 에이전트 워크플로우 제어와 State Schema 아키텍처

- 원본 출처: https://youtu.be/IrW0_f-w4kA
- 원본 정보 발행일자: 2026-09-04
- 내 보관소 등록일자: 2026-09-04
- 채널: Google Cloud Tech (진행: Annie, Tilda)

---

## 💡 핵심 3줄
1. 그래프 엔지니어링은 새로운 기능을 설치하는 것이 아니라, AI 에이전트와 함수의 흐름을 제어하는 **'멀티에이전트 설계 방법론'**이다.
2. 팬 아웃(병렬 실행) ➔ 조인(결과 취합) ➔ 라우터(조건 분기) 구조에서 가장 중요한 핵심은 **노드 간에 정형화된 `State Schema`를 공유**하는 것이다.
3. 구글 클라우드의 두 영상(ADK/Cloud Run, Graph Engineering)은 우리 Antigravity 구조를 바꿀 신기술이 아니라, **이미 구축된 구조가 최신 표준 아키텍처와 일치함을 검증한 결과**다.

---

## 📌 1. 그래프 엔지니어링의 본질과 구조

### ① 3대 기본 개념
- **하니스 (Harness)**: 모델을 둘러싼 도구, 메모리, 가드레일 등 실행 환경 전체.
- **루프 (Loop)**: 에이전트가 단일 목표 달성을 위해 하니스 안에서 순환 추론하는 과정 (단순 1회성 작업).
- **그래프 (Graph)**: 조직도처럼 에이전트와 함수 노드가 상태(State)를 주고받으며 협업하는 다단계 제어 흐름.

### ② 워크플로우 제어 3패턴 (PR 코드 리뷰 사례)
- **팬 아웃 (Fan-out)**: 작업을 N개로 쪼개어 독립 Worker에게 병렬 분배.
- **조인 (Join)**: 모든 Worker의 작업이 끝날 때까지 대기 후 결과 종합.
- **라우터 (Router)**: 종합 결과의 성공/실패 조건에 따라 Fixer 에이전트 또는 사람 승인 단계로 분기.

---

## 🛡️ 2. 우리 시스템이 흡수할 핵심 설계 자산: `State Schema`

단순히 에이전트 간에 비정형 자연어 텍스트만 주고받으면 중간 상태 왜곡과 환각이 발생한다.  
앞서 정립한 **Tool Contract**와 직결되는 **정형 상태 규격(State Schema)**을 유지하는 것이 그래프 엔지니어링의 핵심이다.

```text
작업 시작
   ↓
 Router
   ↓
┌──────────┬──────────┬──────────┐
│ Worker A │ Worker B │ Worker C │  ➔ 각 노드가 표준 State Schema 생성
└──────────┴──────────┴──────────┘
             ↓
            Join
             ↓
        Reviewer
             ↓
      ┌──────┴──────┐
    FAIL           PASS
      ↓             ↓
    Fixer      Human Check
```

### 📋 공통 State Schema 규격 (추후 도입 검토)
```json
{
  "task_id": "TASK-20260904-01",
  "status": "PASS | FAIL | IN_PROGRESS",
  "worker": "security-reviewer",
  "result": "요약된 핵심 산출물",
  "evidence": "근거가 되는 파일 경로 및 줄 번호",
  "errors": ["발견된 에러 또는 결함 목록"],
  "next_action": "다음 단계 라우팅 대상 (fixer | human_checkpoint)"
}
```

---

## 📊 3. Antigravity 시스템 아키텍처 최종 비교 및 판단

| 기술 / 개념 | 구글 최신 제안 | 현재 Antigravity 상태 | 최종 판단 |
| :--- | :--- | :--- | :--- |
| **Graph Engineering** | 노드 기반 워크플로우 제어 | `graph-orchestrator` 스킬 내장 | **이미 선제 구현 완료 (개념 일치)** |
| **Fan-out** | 병렬 에이전트 처리 | Worker 병렬 분기 구조 존재 | **기존 구조 활용 (신규 프레임워크 불필요)** |
| **Join** | 결과 수렴 및 종합 | Reviewer 단계에서 취합 | **기존 구조 활용** |
| **Router** | 상태 조건별 분기 | Router 분기 로직 존재 | **기존 구조 활용** |
| **Human Checkpoint** | 사람 최종 승인 단계 | Safe No-Op 및 자율 권한 가드레일 | **기존 규칙 유지** |
| **ADK / Graph 프레임워크** | 외부 SDK 패키지 설치 | 설치되지 않음 | ❌ **설치 불필요 (인프라 비대화 방지)** |
| **State Schema 표준화** | 정형 상태 객체 공유 | 텍스트/마크다운 교환 | ⭕ **추후 고도화 검토 가치 있음** |
| **RAG Grounding 검증** | 데이터 기반 답변 강제 | 미완료 (프롬프트 수준) | 🌟 **향후 1순위 개선 과제** |

---

## 🧭 결론: 일관된 아키텍처 원칙
1. **기술 유행에 휩쓸려 무분별하게 패키지를 설치하지 않는다.**
2. 기존 시스템과 중복되는 외부 프레임워크(ADK, Graph Framework 등)는 원천 배제한다.
3. 가치 있는 **설계 원칙(Tool Contract, State Schema, Grounding 검증)**만 옵시디언에 기록하여 자산화한다.
4. 현재 완성된 안전 동기화 환경을 건드리지 않고, 향후 개선은 **`RAG Grounding 검증 계층`** 단독 과제로 진행한다.
