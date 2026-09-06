---
title: GitHub 주간 트렌딩 TOP 5 오픈소스 에이전트 도구 완전분석 (2026년 9월 1주)
category: 01_AI_시스템_및_도구
tags:
  - GitHub
  - AgenticTools
  - NoAISlop
  - SkillSpecter
  - PhoneHarness
  - VideoUse
  - AICRM
  - GregIsenberg
created: 2026-09-06
updated: 2026-09-06
source: https://youtu.be/9_SZFIW7tus
source_date: 2026-09-02
---

# 🚀 GitHub 트렌딩 TOP 5: AI Slop 제거, 바이럴, 수익화 에이전트 도구 완전분석

> **출처**: [Greg Isenberg - 5 GitHub Repos: Kill AI Slop, Go Viral, Make Money](https://youtu.be/9_SZFIW7tus)  
> **발행일자**: 2026-09-02  
> **보관소 등록일자**: 2026-09-06  

---

## 💡 개요 및 배경
깃허브는 6개월 뒤 SaaS 스타트업, 에이전시 비즈니스, 자동화 워크플로우로 발전할 혁신적인 에이전트 도구들이 가장 먼저 등장하는 곳이다. 이번 영상에서는 최근 30일간 주목받은 오픈소스 리포지토리 중 1인 창업가, 개발자, 크리에이터가 즉시 업무에 도입해 시간과 비용을 절감하거나 수익화할 수 있는 **핵심 오픈소스 프로젝트 5종**을 소개한다.

---

## 📌 핵심 오픈소스 도구 5선 상세 분석

### 1. No AI Slop Skill (Peter Yang) — 인간다운 글쓰기 에디터
* **해결하는 문제**: ChatGPT, Claude 등이 쓴 글은 문법은 맞으나 특유의 대칭성, 상투어구("X가 아니라 Y다", "조용히~", 가짜 컨퍼런스 키노트 톤) 등 'AI 냄새(AI Slop)'가 나 신뢰도를 떨어뜨림.
* **동작 방식**: 작성자의 거친 아이디어 초안(Human draft)을 바탕으로, 작성자의 고유한 목소리와 개성은 보존하면서 인위적인 AI 수식 패턴만 외과수술적으로 제거.
* **실전 활용**: 콜드 메일, 랜딩페이지 카피, 런칭 포스트, X/LinkedIn 스레드 작성 시 
px skills add <repo>로 에이전트에 주입해 활용.

### 2. Open-Source AI CRM (trycompai) — 스스로 관리하는 에이전트 전용 CRM
* **해결하는 문제**: 기존 CRM(Salesforce, Notion 등)은 사람이 직접 수동 업데이트를 해야 해서 몇 주 지나면 데이터가 썩는 무덤(Graveyard)으로 전락함.
* **동작 방식**: 사람이 쓰는 보관함이 아닌 **AI 에이전트의 작업 공간(Workspace)**으로 설계됨. 에이전트가 리드/고객 정보를 자동 조사(Enrichment)하고, 후속 미팅/답장 일정을 추적하며 관계망 그래프를 능동적으로 유지.
* **스택 및 실행**: Bun + Docker Compose 환경 (localhost:3000 프론트, :3001 API). "절대 잊으면 안 되는 따뜻한 리드" 파이프라인부터 작게 시작 권장.

### 3. Video Use (by Browser Use) — 코딩 에이전트 기반 영상 자동 편집
* **해결하는 문제**: 1인 창업가와 크리에이터의 최대 병목인 영상 편집(무음 구간 자르기, 자막 스타일링, 숏폼 추출 등)의 반복 노가다.
* **동작 방식**: 폴더에 원본 영상(Raw footage)을 넣으면 Claude Code, Codex 등 터미널 툴을 쓰는 코딩 에이전트가 자막 스크립트와 타임스탬프를 읽고, 편집 전략을 세운 뒤 FFmpeg로 렌더링 및 컷 편집 완결.
* **실전 활용**: 긴 팟캐스트나 튜토리얼에서 60초짜리 핵심 숏폼 3개 자동 추출, SaaS 제품 런칭 영상 생성.

### 4. Skill Specter (NVIDIA) — AI 에이전트 스킬 & MCP 보안 감사기
* **해결하는 문제**: GitHub에서 검증되지 않은 스킬(SKILL.md), MCP 서버, 플러그인을 무차별 설치할 때 발생하는 프롬프트 인젝션, 데이터 탈취(Exfiltration), 악성 공급망 위험.
* **동작 방식**: 에이전트에 새 도구를 부여하기 전, 해당 스킬 디렉터리나 GitHub URL을 사전 스캔(skill-specter scan <repo>). 민감 파일의 경우 외부 LLM 전송 없이 순수 정적 분석(--no-llm) 지원.
* **엔비디아의 시사점**: 모듈형 에이전트 OS 시대에는 보안이 엔터프라이즈뿐만 아니라 1인 빌더에게도 필수적인 게이트웨이가 됨.

### 5. Phone Harness — 실기기 모바일(iOS/Android) 조작 하네스
* **해결하는 문제**: 브라우저나 CLI와 달리, 모바일 전용 앱(SNS, 배달, 뱅킹 등)은 API가 없어 에이전트 자동화가 극히 어려웠음.
* **동작 방식**: 탈옥(Jailbreak) 없이 macOS iPhone 미러링(iOS) 및 ADB(Android)를 통해 화면을 인식하고 탭, 타이핑, 스크롤을 직접 수행하며 결과를 검증.
* **실전 활용**: 모바일 앱 온보딩/결제 QA 자동 테스트, API가 없는 모바일 플랫폼 반복 작업 대행.

---

## 🛠️ Antigravity 시스템 및 워크플로우 적용점

1. **글쓰기 프롬프트 탈(脫) AI 슬롭 헌법 준수**:
   - Peter Yang의 접근법처럼, Antigravity의 요약 및 문서 작성 시 상투적인 번역투, 억지 AI 적용점, 불필요한 서두를 배제하고 자연스러운 리듬감 유지.
2. **NVIDIA Skill Specter 보안 게이트 도입 검토**:
   - 전역 스킬(~/.gemini/config/skills/) 및 MCP 추가 시, 설치 전 정적 보안 스캔(security-gate 또는 skill-specter) 프로토콜을 거치도록 보안 가드레일 강화.
3. **Phone Harness & LDPlayer 모바일 연동**:
   - 노트북/본체에 기구축된 안드로이드 환경(LDPlayer)과 ADB를 연계해 모바일 브라우징/앱 테스트 자동화 스킬로 확장 가능성 확보.

---

## 📎 아카이빙 3대 메타데이터
* **원본 출처**: https://youtu.be/9_SZFIW7tus
* **원본 정보 발행일자**: 2026-09-02
* **내 보관소 등록일자**: 2026-09-06
