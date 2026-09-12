---
title: Hermes Agent Skills
created: 2026-09-11
updated: 2026-09-11
type: concept
tags: [hermes, skills, optimization, context]
sources: [raw/transcripts/hermes-agent-skills-video.md]
confidence: high
---

# Hermes Agent Skills

Hermes Agent의 운영 효율과 컨텍스트 보호, 기능 확장을 위한 최상위 스킬셋 및 플러그인 생태계.

## 1. 컨텍스트 보호 및 효율화 (Context Preservation)
- **Skill Retriever (플러그인)**: 등록된 수십~수백 개의 스킬을 상시 주입하는 비효율을 제거하고, 의미적 연관성이 높은 스킬만 주입하여 매 턴 9,000토큰가량 절약.
- **RTK (Terminal Filter)**: 터미널 명령어 출력 노이즈를 요약 정제하여 컨텍스트에 적재.

## 2. 작업 관리 및 계획 (Task Orchestration)
- **Planning with Files**: `task_plan.md`, `findings.md`, `progress.md` 3개 파일을 프로젝트 루트에 유지하고, **Hermes Hook**을 통해 에이전트 맥락에 고정 주입하여 목표 탈선을 방어.
- **Delegate Setup**: Claude Code, Codex, Cursor 등 타 에이전트와 통합 오케스트레이션 구성.

## 3. 정보 수집 및 보안 (Research & Security)
- **Agent Reach**: Reddit, Twitter 등 소셜 미디어 및 차단 빈도가 높은 커뮤니티 플랫폼 데이터 연구 목적의 무료 스크랩 우회로 제공.
- **Mantis**: Google의 다용도 보안 검토 스키마.

## 관련 문서
- [[hermes-agent]]
- [[llm-wiki-architecture]]
