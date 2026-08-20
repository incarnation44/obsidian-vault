---
type: knowledge
title: Gemini Enterprise 및 Workspace 기반 AI 에이전트 구축 실전 가이드
description: Google Cloud Tech 공식 라이브 요약 - Agent Studio 노코드, ADK 프로코드 프레임워크, Workspace MCP 연동, Model Armor 보안 가드레일
tags:
  - ai-agent
  - gemini-enterprise
  - google-workspace
  - mcp
  - google-cloud
created_at: 2026-08-20
source: https://www.youtube.com/live/BFtkDiJYYHk
source_date: 2026-08-20
registered_at: 2026-08-20
---

# How to build AI agents with Gemini Enterprise & Workspace (구글 클라우드 공식 라이브 요약)

> **1) 원본 출처**: [YouTube Live (Google Cloud Tech)](https://www.youtube.com/live/BFtkDiJYYHk)  
> **2) 원본 정보 발행일자**: 2026-08-20  
> **3) 내 보관소 등록일자**: 2026-08-20  
> **발표자**: Tilde Thurium (Google Cloud), Pierrick Voulet (Google Workspace AI Agent Lead)

---

## 💡 1. 핵심 3줄 요약

1. **Workspace + Gemini Enterprise의 결합**: 구글 워크스페이스(Gmail, Drive, Docs, Sheets, Chat)와 제미나이 기업용 플랫폼을 연결해 실무 생산성을 극대화하는 엔드투엔드(End-to-End) AI 에이전트 구축 방법론 공개.
2. **노코드부터 프로코드까지 2-Track 개발**: 비개발자는 **Agent Studio**의 비주얼 플로우로 즉시 기획하고, 개발자는 **ADK(Agent Development Kit)**와 Colab Enterprise로 복잡한 추론·도구 연동·메모리 관리 구현.
3. **MCP(Model Context Protocol) & Add-ons 연동**: 구글 공식 관리형 MCP 서버와 Workspace 커넥터를 통해 사내 데이터베이스 및 외부 SaaS(Salesforce, Jira 등)와 결합된 지능형 자동화 지원.

---

## 📌 2. 주요 핵심 내용 & 아키텍처

### 🏗️ 1) AI 에이전트 구축 레벨 (2-Track)
- **No-Code / Low-Code (Agent Studio & Agent Designer)**:
  - 자연어로 에이전트의 목표와 역할을 서술하고 드래그 앤 드롭 플로우 빌더로 다단계 승인 및 워크플로우를 빠르게 프로토타이핑.
- **Code-Based (Agent Development Kit - ADK)**:
  - 복잡한 비즈니스 로직, 세밀한 Tool Calling, 장기 메모리(Memory Management), 상태 머신(State Machine)을 파이썬 코드로 모듈화하여 패키징.

### 🔌 2) Google Workspace 연동 파이프라인
- **Workspace Connectors & APIs**: Gmail 수신함 자동 분류 및 답장 초안 작성, 구글 드라이브 문서 RAG 검색, 구글 시트 데이터 파싱 및 통계 시각화.
- **MCP (Model Context Protocol) 지원**: 표준화된 MCP 규격을 통해 AI 에이전트가 워크스페이스 문서와 사내 데이터 저장소에 안전하고 정밀하게 접근.
- **Agent Gateway & Model Armor**: 기업 보안을 위해 최소 권한(Least Privilege) 원칙에 따른 접근 제어와 악의적 프롬프트 인젝션을 사전 차단하는 보안 가드레일 탑재.

---

## 🛠️ 3. AI(나/Antigravity)에게 즉시 적용할 점 (핵심!)

1. **계층형 툴 디스패칭 & MCP 하네스 고도화**:
   - 영상에서 제시된 ADK(Agent Development Kit)의 모듈형 도구 호출 철학을 반영하여, 로컬 파일 탐색과 옵시디언 관리 시 불필요한 전체 컨텍스트 적재를 막고 필요한 툴만 핀셋 호출하는 계층형 하네스를 완벽 유지.
2. **사내/개인 워크플로우 자동화 패턴 내재화**:
   - 사용자가 구글 드라이브, 문서, 스프레드시트 연동 작업을 요구할 때 노코드 에이전트 스튜디오 패턴과 파이썬 ADK API 호출을 결합한 2-Track 자동화 코드를 즉시 작성하여 제공.
3. **Model Armor 가드레일 준수**:
   - 시스템 헌법 3대 절대 원칙(이메일 발송 금지, 결제 금지, 파일 삭제 금지)과 연계하여 에이전트 자율 작업 시 데이터 무결성을 검증하는 확인 루프를 시스템 전반에 상시 작동.
