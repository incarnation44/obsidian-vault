---
title: DeepSeek Harness — Open Source Modular Coding Agent Harness
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [ai-coding, harness, deepseek, open-source, plugins, orchestration, vps]
sources: [raw/transcripts/deepseek-harness-setup.md]
confidence: high
---

# DeepSeek Harness

DeepSeek에서 공개한 오픈소스·모듈형 AI 코딩 에이전트 하네스(Harness)^[raw/transcripts/deepseek-harness-setup.md].

## 1. 배경 및 차별점
- **Claude Code의 한계 극복**: 폐쇄형 단일 도구 구조에서 벗어나 코어와 플러그인을 완전히 분리.
- **Everything is a Plugin**: 도구, 샌드박스, 세션 관리, LLM 연결이 독립 플러그인으로 동작하여 자유로운 커스텀 가능.
- **서브에이전트 수용**: 타 에이전트(Claude Code, Codex 등)를 DeepSeek Harness 내부의 서브에이전트로 품는 오케스트레이터 역할 수행.

## 2. 모델 및 인프라 운용
- **모델 애그노스틱 (Model-Agnostic)**:
  - DeepSeek 자체 모델 외에 OpenRouter, Anthropic, OpenAI, Groq, Ollama 로컬 모델 모두 지원.
  - 초고속·초저비용 모델(DeepSeek V4.1 Flash 등)과 연동 시 사실상 $0에 가까운 비용으로 코딩 자동화 가능.
- **Cloud VPS 중심 운용**:
  - 로컬 리소스 점유 없이 24/7 비동기 백그라운드 코딩 지원.
  - 모바일 및 다중 기기 제어.

## 3. 모드 체계
| 모드 | 목적 |
|------|------|
| **Standard** | 일반적인 프로젝트 빌드 및 풀스택 코딩 |
| **Creator** | 에이전트 자체 플러그인 및 커스텀 프리셋 제작 |
| **PTC / Minimal** | 경량화 및 최소 토큰 기반 타스크 실행 |

## 4. Hermes 에이전트와의 비교 및 시사점
- **Hermes Agent**: 자기 학습 루프(Curator)와 영구 외장 지식(LLM Wiki) 중심의 자율 에이전트 OS.
- **DeepSeek Harness**: 모듈식 플러그인 샌드박스 기반의 풀스택 코딩 전용 워크벤치.
- **통합 방안**: Hermes가 상위 기획 및 오케스트레이션을 담당하고, DeepSeek Harness를 로컬/VPS 코딩 워커로 연계 가능.

## 관련 문서
- [[ai-coding-skills-landscape]]
- [[hermes-agent]]
- [[openclaw-vs-hermes]]
