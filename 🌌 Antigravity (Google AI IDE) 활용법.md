---
title: 🌌 Antigravity (Google AI IDE) 활용법
tags:
  - antigravity
  - gemini
  - ide
  - local-ai
  - mcp
date: 2026-08-03
---

# 🌌 Antigravity (Google AI IDE) 활용법

## 무엇인가?
- Google이 만든 **VS Code 기반 AI 코딩 IDE & 에이전트 시스템**
- 내장 AI: **Gemini 3.6 Flash / Pro** (Google의 최첨단 AI 모델)
- 복잡한 코드 작성, 스크립트 실행, 파일 수정, 이미지 생성(`generate_image`), 웹 자동화(`playwright`) 지원

## 설치 위치 및 전용 워크스페이스
- **실행 파일**: `C:\Users\ildoc\AppData\Local\Programs\Antigravity\Antigravity.exe`
- **데이터**: `C:\Users\ildoc\.gemini\antigravity\`
- **전용 작업 디렉토리**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`

## 주요 연동 기능 및 가이드
- **로컬 AI 엔진 연동**: [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]] (Ollama + Qwen 2.5 + DeepSeek-R1 연동)
- **MCP 도구 연동**: [[🔌 MCP 서버 목록 및 활용법]] (Playwright 브라우저 제어 등)
- **설치 도구 모음**: [[🛠️ 설치된 도구 목록]]

## 주요 기능
| 기능 | 설명 |
|------|------|
| AI 에이전트 자동화 | 코드 작성, 명령어 실행, 파일 조작 일괄 처리 |
| 이미지 자동 생성 | 내장 AI를 이용해 원하시는 이미지 즉시 생성 |
| 로컬 AI 연동 | 내 컴퓨터의 무료 로컬 AI(Ollama)와 직접 대화 및 제어 |
| 브라우저 자동화 | Playwright MCP를 통해 웹사이트 스크래핑 및 자동 조작 |

## Claude Code vs Antigravity 비교

| 구분 | Claude Code | Antigravity |
|---|---|---|
| AI | Claude (Anthropic) | Gemini (Google) + 로컬 AI(Ollama) |
| 형태 | 터미널 CLI | GUI IDE (VS Code 기반) & Agent |
| 강점 | 자동화, 스킬, 터미널 작업 | 에이전트 자동 실행, 파일 조작, 이미지 생성 |
| 함께 활용 | 터미널 작업 시 활용 | IDE 및 복잡한 작업 시 활용 |
