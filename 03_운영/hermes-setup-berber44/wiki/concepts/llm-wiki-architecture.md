---
title: LLM Wiki Architecture
created: 2026-09-11
updated: 2026-09-11
type: concept
tags: [hermes, architecture, memory, wiki]
sources: [raw/transcripts/karpathy-llm-wiki-video.md]
confidence: high
---

# LLM Wiki Architecture

Andrej Karpathy가 제안한 LLM Wiki 기반의 외장 메모리 아키텍처.
에이전트 내부 토큰 메모리의 한계를 극복하고 마크다운 파일 시스템을 공용 지식 저장소로 활용한다.

## 핵심 구조
1. **Raw Layer (`raw/`)**: 수집한 원본 데이터(웹 스크랩, 자막 등) 보존. 수정 불가.
2. **Processed Layer (`entities/`, `concepts/`, `comparisons/`)**: 정제된 지식과 교차 참조(`[[wikilinks]]`).
3. **Control Layer (`SCHEMA.md`, `index.md`, `log.md`)**: 규칙 정의, 색인 관리, 변경 이력 추적.

## 운영 규칙
- 에이전트는 작업 시작 전 `index.md`와 관련 문서를 읽고 맥락을 파악함.
- 도출한 지식이나 변경 사항은 즉시 마크다운 문서로 반영하고 `index.md`와 `log.md`를 업데이트함.
- 외부 도구(Obsidian 등)와 호환되는 표준 마크다운 및 위키링크 형식을 유지함.

## 관련 문서
- [[hermes-agent]]
