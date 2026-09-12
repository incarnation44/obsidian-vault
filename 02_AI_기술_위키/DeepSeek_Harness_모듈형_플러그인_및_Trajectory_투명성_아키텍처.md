---
title: "DeepSeek Harness: 모듈형 플러그인 및 Trajectory 투명성 아키텍처"
aliases: ["DeepSeek Harness", "Everything is a plugin", "Trajectory 로깅", "에이전트 모듈화"]
category: "02_AI_기술_위키"
created_date: "2026-09-12"
updated_date: "2026-09-12"
tags: ["AI", "Agent", "Architecture", "DeepSeek", "Plugin", "Trajectory"]
knowledge_type: concept
---

# DeepSeek Harness: 모듈형 플러그인 및 Trajectory 투명성 아키텍처

## 1. 개요
DeepSeek Harness는 특정 기업(Anthropic의 Claude Code 등)의 폐쇄적인 생태계를 탈피하기 위해 고안된 오픈소스 AI 에이전트 프레임워크다. 
이 프레임워크의 핵심 사상은 **"AI 모델(Brain)과 도구/환경(Harness)의 철저한 분리"**이며, 모든 기능을 탈부착 가능한 플러그인으로 구성하는 극단적인 모듈화를 추구한다.

---

## 2. 핵심 아키텍처 사상

### 1) Everything is a Plugin (완전 모듈화)
하네스 자체는 비어 있는 컨테이너이며, 에이전트의 모든 기능이 독립된 플러그인으로 동작한다.
- **예시 플러그인**: `Timer`, `Shell Agent`, `Web Search`, `LLM Retry`, `HMR(Hot Module Replacement)`
- **장점**: 불필요한 기능(예: 로컬 쉘 접근)을 꺼서 보안(Sandbox)을 강화하거나, 사용자가 자신의 워크플로우에 맞는 커스텀 플러그인을 직접 개발하여 주입할 수 있다 (Creator Mode 지원).

### 2) Brain Swapping (모델 어그노스틱)
프레임워크가 특정 언어 모델에 종속되지 않는다.
- OpenRouter API 또는 로컬 LLM 엔드포인트(Ollama, LM Studio)를 연결하여, 작업의 난이도와 예산에 맞춰 **뇌(모델)**를 실시간으로 교체할 수 있다.
- 예: 논리 설계는 고비용 프론티어 모델로, 단순 타이핑 및 스캐폴딩은 DeepSeek V4.1 Flash나 로컬 Qwen 모델로 처리.

---

## 3. Trajectory (궤적) 투명성과 블랙박스 타파
AI 에이전트가 "알아서 해줄게"라며 중간 과정을 숨기는 블랙박스 안티패턴을 배제하고, 에이전트의 모든 사고와 행동을 영구적인 감사 트레일(Audit Trail)로 남긴다.

- **기록 대상**:
  1. 주입된 전체 시스템 프롬프트 및 동적 컨텍스트
  2. LLM이 호출한 도구(Tool/Function)와 API 페이로드(Payload)
  3. 쉘(Shell) 실행 로그 및 반환된 에러 메시지
  4. 재시도(Retry) 횟수 및 서머리
- **효과**: 개발자는 에이전트가 왜 실패했는지, 프롬프트를 어떻게 오해했는지 즉각적으로 디버깅(Root Cause Analysis)할 수 있으며, 환각(Hallucination)에 의한 파괴적 명령 실행을 사전에 감지할 수 있다.

---

## 4. Antigravity 시스템(Ildo 헌법)과의 철학적 일치
본 시스템(Antigravity)의 `GEMINI.md` 헌법 29번 조항은 DeepSeek Harness의 철학을 그대로 계승한다.
> **29. DeepSeek형 모듈형 플러그인 & Trajectory 투명성**: Everything is a Plugin(어댑터·도구·스킬 조립형 아키텍처), Append-Only Trajectory 정형 리포트(블랙박스 추론 차단), Creator Mode 실존 `scripts/`와 `SKILL.md` 즉석 패키징 자산화.

따라서 Antigravity 시스템 내의 모든 확장 기능은 거대한 단일 코드베이스가 아닌 `SKILL.md`와 독립된 파이썬 스크립트(`scripts/`) 조합으로 개발되어야 하며, 실행 내역은 항상 사용자에게 명시적으로 노출(Report)되어야 한다.

---

## 🔗 관련 문서
- [[DeepSeek_Harness_오픈소스_에이전트_프레임워크_AstroKJoseph]]
- [[frouter_ai_무과금_LLM_라우터_및_Opencode_연동_AstroKJoseph]]
