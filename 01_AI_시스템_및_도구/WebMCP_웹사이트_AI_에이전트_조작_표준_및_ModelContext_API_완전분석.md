---
title: WebMCP 웹사이트 AI 에이전트 조작 표준 및 ModelContext API 완전분석
category: 01_AI_시스템_및_도구
tags:
  - WebMCP
  - ModelContextAPI
  - AgentReady
  - 브라우저자동화
  - 코드깎는노인
created: 2026-09-05
updated: 2026-09-05
source: https://youtu.be/sOLFEc63US4
source_date: 2026-09-03
---

# WebMCP: 웹사이트 AI 에이전트 조작 표준 및 ModelContext API 완전분석

> **출처**: [코드깎는노인 - MCP만큼 큰 변화가 또 옵니다, 이번엔 WebMCP](https://youtu.be/sOLFEc63US4)  
> **발행일자**: 2026-09-03  
> **보관소 등록일자**: 2026-09-05  

---

## 1. 개요 및 배경

기존 웹은 오직 사람의 시각적 인터랙션(버튼 클릭, 폼 입력, 스크롤)을 전제로 발전했다. 하지만 웹을 사용하는 주체로 AI 에이전트가 급부상하면서 기존 방식에는 뚜렷한 한계가 드러났다.

* **기존 에이전트의 브라우징 방식**: 사람이 보는 복잡한 DOM/화면을 캡처하고 역분석하여 클릭·입력 코드를 실시간으로 직접 생성함. 사이트 구조가 조금만 바뀌거나 복잡도가 높으면 환각이나 오작동이 빈번하고 토큰 소모가 큼.
* **WebMCP의 접근법**: 웹사이트 제작자가 처음부터 **AI 에이전트 전용 조작 인터페이스(Model Context API)**를 웹페이지 내에 내장(egisterTool)하여, AI가 복잡한 화면 분석 없이 즉시 신뢰성 높은 도구(executeTool) 형태로 웹사이트 기능을 실행할 수 있게 만듦.

---

## 2. 핵심 동작 원리 (ModelContext API)

WebMCP는 웹 브라우저 표준 웹 API(웹소켓, 웹어셈블리 등과 같은 궤)로 제안되는 **ModelContext API**를 기반으로 동작한다.

`mermaid
sequenceDiagram
    autonumber
    actor User as 사용자
    participant Agent as AI 에이전트 브라우저
    participant Web as WebMCP 지원 웹사이트
    participant ModelCtx as ModelContext API

    User->>Agent: "투두리스트에 '장보기' 추가해줘"
    Agent->>Web: 웹사이트 접속 (WebMCP 플래그 활성화)
    Web->>ModelCtx: registerTool('list_todos', 'add_todo', 'delete_todo')
    Agent->>ModelCtx: getTools() 호출로 등록된 도구 스펙 인출
    ModelCtx-->>Agent: 도구 목록 및 파라미터 규격 반환
    Agent->>ModelCtx: executeTool('add_todo', { title: '장보기' })
    ModelCtx->>Web: 내부 비즈니스 로직 직결 실행
    Web-->>Agent: 성공 응답 반환
    Agent-->>User: "장보기가 추가되었습니다."
`

### 핵심 API 3요소
1. **egisterTool (사이트 개발자 관점)**
   - 웹사이트 프론트엔드 코드에서 AI에게 허용할 기능(예: 목록 조회, 등록, 삭제)을 도구 규격(이름, 설명, 파라미터 스키마)과 함께 브라우저 컨텍스트에 등록.
2. **getTools (AI 에이전트 관점)**
   - 에이전트가 웹페이지에 방문했을 때, 현재 페이지에서 바로 쓸 수 있는 AI 도구 목록과 설명서를 단 1회 호출로 확인.
3. **executeTool (실행)**
   - 화면을 클릭하거나 타이핑하는 대신, 에이전트가 JSON 인자를 전달하여 사이트 내부 함수를 직결 실행.

---

## 3. 웹 생태계에 미치는 파급력과 변화

1. **에이전트 이코노미 인터페이스 선점**:
   - 사용자를 대신해 AI가 상품 탐색, 예약, 결제를 대행하는 시대에 AI 친화적이지 않은 웹사이트는 에이전트 트래픽에서 영구 소외됨.
2. **화면 분석 토큰 90% 절감 & 실패율 제로화**:
   - 비전 모델을 통한 스크린샷 판독이나 거대 DOM 트리 탐색 없이, 정형화된 JSON-RPC 수준의 호출로 웹 인터랙션 완결.
3. **미래 웹의 형태 (프론트엔드의 진화)**:
   - 궁극적으로 최종 이용 주체가 에이전트가 될 경우 프론트엔드 UI의 필요성에 대한 질문이 제기되나, 당분간은 인간용 화면과 AI용 WebMCP 인터페이스가 공존하는 하이브리드 웹이 주류를 이룰 것.
4. **표준화 진행 상황**:
   - 현재 MDN 정식 문서화 이전 단계이며, W3C Web Machine Learning 커뮤니티 및 관련 깃허브 저장소(web-machine-learning)를 중심으로 표준 스펙 논의 활발 진행 중.

---

## 4. Antigravity 시스템 및 워크플로우 적용점

* **헌법 10조 연계**: 이미 Antigravity 헌법 제10조(32대 프로토콜 중 10번 WebMCP & 브라우저 자동화)에 정의된 **DOM 파싱 토큰 절감 및 인페이지 툴 계약** 개념과 100% 궤를 같이함.
* **향후 웹 서비스 개발 표준 반영**:
  - Next.js / Vite로 웹 서비스를 빌드할 때, 백엔드 API 외에도 프론트엔드 레벨에서 egisterTool 패턴의 에이전트 엔드포인트를 선제적으로 설계할 것.
* **Playwright 백그라운드 브라우징 개선**:
  - WebMCP가 지원되는 사이트 방문 시 복잡한 셀렉터 클릭 대신 window.modelContext 또는 브라우저 주입 스크립트를 통해 신속하고 안정적인 데이터 인출을 우선 시도하도록 적용.
