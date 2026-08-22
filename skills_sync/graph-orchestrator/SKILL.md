---
name: graph-orchestrator
description: 4th-generation Graph Engineering & Multi-Agent Orchestrator. Solves single-agent bloat and hallucinations by splitting tasks into distinct nodes (Router, Parallel Workers, Strict Code Reviewer, Human Checkpoints) with state tracking and resilient error handling.
---

# 🕸️ Graph Engineering Multi-Agent Orchestrator

This skill enforces the 4th-generation Graph Engineering architecture & Architect-based Subagent Context Isolation across complex multi-step tasks.

## 📌 Core Architecture

```mermaid
flowchart TD
    A["입력 태스크 (Input Task)"] --> B{"1. 라우터 (Router Node)"}
    B -->|단일/경량 작업| C["단일 패스 즉시 실행 (Single Pass Diet)"]
    B -->|복합/다중 컴포넌트| D["2. 아키텍트 명세 생성 (ARCHITECT.md)"]
    D --> E["3. 병렬 서브에이전트 (Context Isolated Workers)"]
    E --> F["4. 정형 완료 보고 수신 (Structured Completion Report)"]
    F --> G["5. 검사관 검증 (Strict Reviewer Node)"]
    G -->|오류 발견 (Failure)| E
    G -->|검증 통과 (Success)| H{"6. 중요 결정? (Human Checkpoint)"}
    H -->|결제/시스템변경| I["사용자 승인 요청 (Approval)"]
    H -->|일반 산출물| J["최종 배포 및 보고 (Complete)"]
```

## 🛠️ 실전 하네스 5대 실행 규칙

### 1. Router Node (작업 분류 & 단일 패스 다이어트)
- 단순 작업, 경량 수정은 불필요한 멀티에이전트를 띄우지 않고 단일 컨텍스트에서 빠르게 완결.
- 프론트엔드 + 백엔드 + DB 스키마 등 다중 도메인이 얽힌 복합 작업 시에만 서브에이전트 하네스 가동.

### 2. Architect Spec (역할 및 산출물 사전 고정)
- 메인 에이전트가 혼자 모든 코드를 짜며 컨텍스트를 소진하지 않고, 각 서브에이전트가 맡을 파일/산출물/인터페이스를 사전에 확정.
- 명세 템플릿: `resources/ARCHITECT_TEMPLATE.md` 참조.

### 3. Context-Isolated Workers (컨텍스트 격리 병렬 일꾼)
- 서브에이전트는 각자의 독립 컨텍스트에서 코딩, 파일 탐색, 단위 테스트를 수행.
- 수많은 중간 디버깅 로그와 원시 텍스트는 서브에이전트 내부에서 소화하여 메인 컨텍스트 윈도우 오염 방지.

### 4. Structured Completion Report (정형 완료 보고 수신)
- 서브에이전트는 작업 완료 시 잡다한 대화 대신 아래 4대 요소만 압축 보고:
  1. **산출물 파일 경로**
  2. **핵심 기능 및 변경 사항 요약**
  3. **자체 빌드/테스트 검증 결과 (자가치유 초록불 확인)**
  4. **외부 노출 인터페이스 명세**

### 5. Strict Reviewer & Integration (통합 검증)
- 메인 에이전트는 서브에이전트들의 완료 보고를 취합하여 상호 연동 및 최종 빌드를 검증하고 완성.
