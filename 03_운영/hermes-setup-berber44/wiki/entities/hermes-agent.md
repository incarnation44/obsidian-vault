---
title: Hermes Agent
created: 2026-09-11
updated: 2026-09-11
type: entity
tags: [hermes, agent, system, maturity]
sources: [raw/transcripts/every-level-of-hermes-agent-explained.md]
confidence: high
---

# Hermes Agent

Nous Research에서 개발한 자율형 AI 에이전트.

## 주요 특징 및 환경
- 독립 클라우드 네이티브 에이전트 환경.
- 로컬 마크다운 위키(`~/wiki`)를 외장 메모리 레이어로 활용.
- 한국어 자연어 작문 가이드(Humanizer 규칙) 준수.

## 에이전트 사용자 성숙도 7단계 (Maturity Levels)
에이전트를 고도화하여 업무에 내재화하는 단계를 7단계로 분류합니다^[raw/transcripts/every-level-of-hermes-agent-explained.md].

1. **Level 0 (Unaware)**: 단순 챗봇 취급 단계.
2. **Level 1 (Beginner)**: 로컬 설치 및 단순 단발성 작업 수행.
3. **Level 2 (Apprentice)**: 메모리 연동 및 `soul.md` 기반 개인 맥락 학습 (Context Engineering).
4. **Level 3 (Commands & Skills)**: 제어 명령어 활용 및 최적 모델 매칭.
5. **Level 4 (The Integrator)**: 다양한 MCP 서버 및 협업 툴셋 연동.
6. **Level 5 (Orchestration)**: 병렬 서브에이전트 통제.
7. **Level 6 (The Builder)**: 크론 기반 비동기 스케줄 업무 자동 수행.
8. **Level 7 (Power User)**: 에이전트 기반 통합 업무 운영체제(AI OS) 구축.

## 관련 문서
- [[llm-wiki-architecture]]
- [[hermes-agent-skills]]
