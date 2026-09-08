---
type: knowledge
title: "오마이 오픈코드 (Oh My OpenCode, OMO)"
tags: [opencode, ai-agent, orchestration, cli, sisyphus]
knowledge_type: knowledge
---

# 🧠 오마이 오픈코드 (Oh My OpenCode)

**Oh My OpenCode (OMO)**는 오픈소스 AI 코딩 에이전트인 **OpenCode**의 확장 플러그인으로, 복잡한 멀티 에이전트 오케스트레이션을 자동화하고 일관된 작업 환경을 구축하는 도구이다.

## 1. 핵심 개념
- **멀티 에이전트 협업**: 프론트엔드(Gemini), 백엔드(Claude), 설계(OpenAI) 등 각 역할에 최적화된 LLM을 적재적소에 배치하여 병렬 작업을 수행한다.
- **Sisyphus (시지프스)**: OMO의 핵심 마스터 에이전트. 전체 작업 계획을 수립하고, 비동기적으로 서브 에이전트들을 관리하여 목표를 완수한다.
- **AGENTS.md**: `/init` 명령어로 생성되는 단일 진실 공급원(SSOT). 팀 전체가 공유하는 에이전트 룰과 컨텍스트가 정의된다.

## 2. 설치 및 세팅 방법

### Step 1: 사전 요구사항
- Node.js (npm/npx) 또는 Bun 환경
- 사용할 LLM의 API Key (Claude, OpenAI, Gemini 등)

### Step 2: OpenCode 기본 설치
```bash
# 공식 스크립트 설치 (권장)
curl -fsSL https://opencode.ai/install | bash
# 또는 npm 설치
npm install -g opencode-ai
```

### Step 3: Oh My OpenCode 설치
```bash
# Bun 사용 시 (빠름)
bunx oh-my-opencode install
# npm 사용 시
npx oh-my-opencode install
```

### Step 4: 초기화 및 최적화 설정
1. 프로젝트 폴더로 이동 후 OpenCode 실행 (`opencode`)
2. `/connect` 명령어로 각 LLM API 키 등록 및 인증
3. `/init` 명령어로 프로젝트 구조 분석 및 `AGENTS.md` 자동 생성
4. `~/.config/opencode/` 경로의 설정 파일을 수정하여 모델 라우팅 최적화 (예: 코드 작성은 Claude 3.5 Sonnet, 단순 문서화는 Gemini 1.5 Flash 등)
