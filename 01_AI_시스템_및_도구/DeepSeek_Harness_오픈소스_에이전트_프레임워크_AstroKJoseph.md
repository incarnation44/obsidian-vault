---
title: "Claude Code를 대체하는 무료 오픈소스 에이전트: DeepSeek Harness 완벽 가이드 — Astro K Joseph"
aliases: ["DeepSeek Harness", "오픈소스 Claude Code", "Astro K Joseph DeepSeek"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/b3rlTdd_EZ0"
published_date: "2026-09-11"
created_date: "2026-09-12"
tags: ["AI", "Agent", "DeepSeek", "Harness", "Plugin", "OpenSource", "VPS", "ClaudeCode"]
knowledge_type: source
---

# Claude Code를 대체하는 무료 오픈소스 에이전트: DeepSeek Harness 완벽 가이드 — Astro K Joseph

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/b3rlTdd_EZ0
- **원본 정보 발행일자**: 2026-09-11
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: Astro K Joseph

---

## 💡 핵심 요약 (Level 0)
1. **종속성 없는 오픈소스 에이전트 프레임워크**: DeepSeek Harness는 Anthropic의 폐쇄적인 Claude Code를 완전히 대체할 수 있는 개발자 프리뷰 단계의 오픈소스 도구이며, "모든 것이 플러그인(Everything is a plug-in)"이라는 철학 아래 고도의 모듈성을 제공함.
2. **자유로운 두뇌(Model) 교체와 궤적(Trajectory) 투명성**: 특정 기업 모델에 종속되지 않고 OpenRouter, 로컬 모델, OpenAI 등을 자유롭게 '두뇌'로 장착할 수 있으며, Trajectory 탭을 통해 시스템 프롬프트부터 페이로드(Payload), 도구 호출 내역까지 에이전트의 모든 사고와 행동을 투명하게 추적할 수 있음.
3. **VPS 24/7 백그라운드 운용**: 로컬 PC뿐만 아니라 저사양 클라우드 VPS에 배포하여, 노트북이 꺼진 상태에서도 스마트폰으로 코딩 에이전트의 작업을 지시하고 모니터링하는 상시 구동(Always-on) 워크플로우를 구현함.

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. DeepSeek Harness의 철학과 Claude Code의 한계 [00:00~01:41]
- **Claude Code의 폐쇄성**: 훌륭한 도구이지만 Anthropic이 설계한 방식대로만 사용해야 하며, 기능 추가나 삭제 등 커스텀 확장이 불가능한 닫힌 생태계임.
- **모듈형 플러그인(Everything is a plug-in)**: DeepSeek Harness는 코어 뼈대만 제공하고, 나머지 모든 기능(Context, Tool, Memory 등)은 플러그인 형태로 조립됨. 사용자가 직접 플러그인을 개발하거나 불필요한 기능을 끌 수 있음.

### 2. 브레인 교체와 모델 어그노스틱(Model-Agnostic) 구조 [01:42~02:25]
- **뇌(Brain)와 하네스(Harness)의 분리**: AI 모델은 단지 판단을 내리는 '뇌'일 뿐이며, 하네스는 그 뇌를 감싸고 도구와 컨텍스트를 공급하는 '외골격'임.
- **OpenRouter 연동**: DeepSeek 모델뿐만 아니라 OpenRouter API를 등록하여 GLM, Mistral, OpenAI, Anthropic, Minimax 등 지구상의 거의 모든 모델을 제약 없이 브레인으로 스왑(Swap)할 수 있음. (예: 초저가 DeepSeek V4.1 Flash 장착)

### 3. 클라우드 VPS 배포 및 24/7 워크플로우 [02:26~04:47]
- **VPS 배포의 이점**: 터미널 명령어로 로컬 구동도 가능하나, Hostinger 등의 VPS에 올려두면 컴퓨터 전원을 끄더라도 백그라운드에서 에이전트가 코딩 및 서버 실행(Localhost Forwarding)을 지속함. 여러 기기(노트북, 데스크톱, 스마트폰)에서 단일 에이전트 상태를 모니터링 가능.

### 4. 사용자 인터페이스: Trajectory 탭과 크리에이터 모드 [04:48~11:59]
- **모드 전환**: Standard(일반 코딩), Creator Mode(플러그인 및 하네스 자체를 개발할 때 사용), Minimal Mode 등 다중 샌드박스 제공.
- **Trajectory 탭 (블랙박스 해소)**: LLM이 백그라운드에서 무슨 짓을 하는지 숨기지 않음. 시스템 프롬프트, 컨텍스트 조립 과정, API 요청 페이로드, 반환값, 서머리 등 모든 왕복(Round-trip) 이력이 정형화되어 기록됨.
- **플러그인 리스트**: Timer, Shell, Web Search, HMR, LLM Retry 등 수십 개의 내장 플러그인을 체크박스로 켜고 끌 수 있음.

### 5. 실전 코딩 테스트 [12:00~13:56]
- DeepSeek V4.1 Flash (입력 $0.15 / 출력 $0.60) 모델을 장착하여 '네오 브루탈리즘(Neo-brutalist) 포트폴리오 웹사이트' 구축을 지시.
- 초당 250 토큰 이상의 미친 속도로 코드를 작성하고, 자체적으로 로컬 웹서버를 띄워 외부 접속 가능한 URL을 반환하여 사용자가 즉시 결과물을 확인할 수 있게 함.

---

## 🛠️ AI(나) 및 3-PC 사용자 환경 적용점 (Level 2 System Actions)

1. **헌법(GEMINI.md) 29번 조항 강화 및 사상 일치 확인**:
   - DeepSeek Harness의 "Everything is a Plugin" 사상과 "Trajectory 투명성(블랙박스 추론 차단)"은 현재 Ildo 사용자의 Antigravity 에이전트 헌법(29번 원칙)의 핵심 기반임. 이를 재확인하고, 향후 신규 스킬이나 MCP 추가 시 반드시 단일 목적의 모듈형 플러그인(`SKILL.md`) 형태로만 격리 개발함.
2. **원격/오프라인 에이전트 지속성 (Always-On Agent)**:
   - 본체(PC B)를 홈 서버/VPS처럼 취급하여, 외부에서 서브 노트북(PC A)이나 학원 PC(PC C)로 접속하더라도 본체의 에이전트 세션이 끊기지 않고 장시간 작업(웹 크롤링, 대규모 리팩토링 등)을 수행할 수 있도록 SSH/터널링 기반 백그라운드 실행 환경을 우선 배정함.
3. **다중 모델 라우팅 (Brain Swapping)**:
   - 복잡한 아키텍처 설계는 Gemini 1.5 Pro나 3.1 Pro로 수행하되, 단순 반복 코딩이나 웹서버 스캐폴딩 등은 로컬에 띄운 오픈 모델(RX 6600의 Ollama)이나 Frouter 기반 무과금 API로 '브레인'을 동적 교체하여 토큰 비용을 최소화함.

---

## 🔗 관련 문서 및 위키 링크
- [[DeepSeek_Harness_모듈형_플러그인_및_Trajectory_투명성_아키텍처]]
- [[frouter_ai_무과금_LLM_라우터_및_Opencode_연동_AstroKJoseph]]
