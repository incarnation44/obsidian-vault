# 📐 [설계 제안 / RFC] Agent-Ready Tool 인터페이스 및 Action ➔ Observation ➔ Verification 설계안

> **상태**: 🟡 **설계 제안 (CANDIDATE / RFC) — 구현 전면 보류 (FREEZE 유지)**  
> **기준 일시**: 2026-09-05 22:42  
> **적용 시점**: Phase 1~5 3-PC 실측 검증 및 실제 기능 1개 개발/The Loupe 실증 완료 후 검토  
> **핵심 사상**: "도구 호출 성공 ≠ 작업 성공 ≠ SPEC 준수 ≠ 안전한 결과"

---

## 1. 배경 및 핵심 아이디어 (Unity CLI / MCP 교훈)

Unity CLI 및 MCP(Model Context Protocol) 분석에서 도출된 핵심은 특정 엔진에 국한된 것이 아니라, 모든 에이전트 도구 상호작용에 적용되는 일반 원칙이다:

> **"GUI를 AI가 눈(Vision)으로 조작하는 방식보다, CLI / API / MCP처럼 기계가 직접 호출하고 결과를 관찰·검증할 수 있는 인터페이스를 우선한다."**

### 🎯 인터페이스 계층 우선순위 (Headless-First)
```text
CLI First (가장 가볍고 결정론적)
   ↓
API Second (정형화된 통신)
   ↓
MCP When Available (양방향 상태/도구 프로토콜)
   ↓
GUI Last (Fallback: 관찰 가능성/안전성 보조 수단)
```
*단, 무조건적인 기계적 배제가 아니라 도구의 안정성·권한·검증 가능성을 함께 평가하여 채택한다.*

---

## 2. Agent-Ready Tool 표준 평가 규격

새로운 프로그램이나 서비스를 Antigravity에 연결할 때 필수적으로 사전 정의해야 하는 공통 평가 기준:

```text
Tool Contract
├── Input Schema          # 입력 매개변수 및 타입
├── Permissions           # 실행 권한 및 격리 수준
├── Side Effects          # 파일/프로세스/네트워크 변경 범위
├── Expected Output       # 예상 반환 형식 및 상태 코드
├── Verification Method   # 실제 결과 상태를 확인(Query/Read)하는 방법
└── Rollback Method       # 실패 시 원래 상태로 복구/격리하는 방법
```

> **단순히 "이 도구를 호출할 수 있다"가 아니라, "호출 가능 → 결과 관찰 가능 → 실제 상태 검증 가능"해야 비로소 Agent-Ready Tool로 인정한다.**

---

## 3. The Loupe와의 결합: 도구 실행과 검증의 분리

도구 실행 계층(Tool Execution Layer)과 신뢰 검증 계층(Trust Verification Layer)을 엄격히 분리한다.

```text
USER REQUEST
    ↓
SPEC
    ↓
TOOL SELECTION
    ↓
ACTION
    ↓
OBSERVATION
    ↓
L0 (문법 / 정적 파일 검사)
    ↓
L1 (회귀 / 단위 테스트)
    ↓
L2 (SPEC Compliance — 명세 일치 검증)
    ↓
L3 (Edge Case Matrix)
    ↓
L4 (독립 감사 / 휴리스틱)
    ↓
FINAL GATE
```

### 🚨 불가침 판정 공리
```text
Tool Call Success
      ≠
Task Success
      ≠
SPEC Compliance
      ≠
Safe Result
```
- **예시 (Unity)**: "큐브 생성" 명령이 exit code 0을 반환했다고 PASS가 아님.
  - 실제 Cube가 씬 하이어라키에 존재하는가?
  - 위치(Transform)가 요구사항과 일치하는가?
  - 머티리얼이 적용되었는가?
  - Scene 파일이 디스크에 안전하게 저장되었는가?

---

## 4. Action ➔ Observation ➔ Verification 실행 패턴

명령어의 반환 코드(exit code)나 "실행 완료" 문자열만으로 성공을 판단하지 않고, **실제 시스템 상태를 다시 조회(Query)**하여 확인한다.

```text
PLAN ➔ ACTION ➔ OBSERVE ➔ VERIFY ➔ PASS / FAIL / UNCERTAIN
```

### 실례 1: Ollama 모델 다운로드
```text
ollama pull <model>       [ACTION]
       ↓
ollama list               [OBSERVE]
       ↓
모델 존재 및 크기 확인   [VERIFY]
       ↓
간단한 0-Shot 추론 테스트  [VERIFY]
       ↓
PASS
```

### 실례 2: Git 동기화
```text
git pull origin <branch>  [ACTION]
       ↓
git rev-parse HEAD        [OBSERVE]
git status --short        [OBSERVE]
       ↓
원격 SHA와 일치 & Clean   [VERIFY]
       ↓
PASS
```

---

## 5. MCP(Model Context Protocol)에 대한 가드레일

- MCP 자체를 신뢰 계층으로 과대평가하지 않는다.
- MCP는 단순한 **Tool Execution Layer의 프로토콜 중 하나**일 뿐이다.
- MCP 도구가 "Success"를 반환하더라도, 그것이 사용자의 SPEC을 만족했는지와 안전성을 보장하지 않으므로 반드시 Observation 및 The Loupe 검증 파이프라인의 감사를 거친다.

---

## 6. 보류 및 향후 적용 로드맵

현재 시스템은 **코드 동결(FREEZE)** 상태를 엄격히 유지하며, 아래 순서가 완결된 후 본 설계안을 최소 변경으로 구현 검토한다:

1. **Phase 1 데스크톱 실측** (주말 본체 부팅 시)
2. **Phase 2~3 Laptop ↔ Desktop 실제 Git 왕복** (SHA 연속성 검증)
3. **Phase 4 Academy 실측** (격리 검증)
4. **Phase 5 3-PC 전체 왕복 검증**
5. **실제 기능 1개 개발** (The Loupe 실제 검증 반응 관찰)
6. **실제 재현된 결손 수정 시 본 Agent-Ready 원칙 반영 검토**