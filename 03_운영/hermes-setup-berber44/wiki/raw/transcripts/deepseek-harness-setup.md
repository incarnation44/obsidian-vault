---
source_url: https://youtu.be/b3rlTdd_EZ0?si=n3vu3RfPtEljutVz
ingested: 2026-09-12
---

# Video: DeepSeek Harness = Claude Code for $0 (Full Setup)

Astro K Joseph가 소개하는 오픈소스 AI 코딩 하네스(Harness) 'DeepSeek Harness'의 특징, 10분 설치 가이드, 그리고 실전 활용법.

## 1. DeepSeek Harness 개요
- **공식 리포**: https://github.com/deepseek-ai/deepseek-harness
- **특징**: 폐쇄형인 Claude Code와 달리 완전 오픈소스이며 모듈형(Modular) 아키텍처 채택.
- **핵심 철학**: "Everything is a plugin" (모든 기능이 플러그인화되어 커스텀 확장 용이).
- **에이전트 오케스트레이션**: Claude Code나 Codex를 하위 서브에이전트(Sub-agent)로 등록해 협업 가능.
- **프로바이더 자유도**: DeepSeek 모델뿐 아니라 OpenRouter, OpenAI, Anthropic, Google, Cerebras, Groq, Ollama(로컬) 등 자유롭게 연동.

## 2. 배포 및 실행 환경
- **로컬 설치**: Node.js / pnpm 빌드 후 로컬 실행.
- **VPS 클라우드 설치 (추천)**: Hostinger 등 KVM2 VPS 원클릭 템플릿 배포.
  - PC를 꺼도 24시간 백그라운드 구동.
  - 모바일 기기나 여러 대의 Mac/PC에서 동일 세션 원격 모니터링 및 제어.
  - 초저가 초고속 모델(예: DeepSeek V4.1 Flash, ~251 tokens/sec, $0.60/M)과 결합해 장시간 코딩 작업 비용 극소화.

## 3. 주요 모드 및 인터페이스
- **Standard Mode**: 표준적인 코딩 에이전트 작업 수행.
- **Creator Mode**: 플러그인, 확장 기능, 맞춤 에이전트 프리셋을 자연어로 개발·생성하는 모드.
- **Minimal / PTC Mode**: 간소화된 런타임 및 특수 목적 워크플로.
- **플러그인 관리**: Sandbox, Tool Bash, Session, Timer, LLM Retry 등 세부 모듈 개별 On/Off 지원.
