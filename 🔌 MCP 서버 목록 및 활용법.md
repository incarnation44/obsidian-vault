---
title: 🔌 MCP 서버 목록 및 활용법
tags:
  - mcp
  - playwright
  - context7
  - github
  - serena
  - ollama
date: 2026-08-03
---

# 🔌 MCP 서버 목록 및 활용법

> 마지막 업데이트: 2026-08-03  
> MCP = Model Context Protocol — AI에게 외부 도구/서비스를 연결하는 표준 가교 역할

---

## 현재 연결된 MCP 서버

### ✅ playwright
- **상태**: 연결됨 (자동 연결)
- **실행**: `npx @playwright/mcp@latest`
- **용도**: 브라우저 자동화 (웹 스크래핑, 폼 입력, 스크린샷)

**활용 예시**
```
"네이버 들어가서 '파이썬 강좌' 검색 결과 가져와"
"이 사이트 로그인 폼에 입력하고 제출해줘"
"웹페이지 스크린샷 찍어줘"
```

---

### ✅ ollama (로컬 AI MCP 연동)
- **상태**: 연결됨 (`http://localhost:11434`)
- **연동 문서**: [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]]
- **용도**: 무료 로컬 AI 모델(Qwen 2.5 7B, DeepSeek-R1 8B) 연동 및 연산 수행

---

### ✅ context7
- **상태**: 설치됨 (Upstash 제공)
- **용도**: 최신 라이브러리 공식 문서를 AI 컨텍스트에 즉시 주입

---

### ✅ github
- **상태**: 설치됨 (GitHub 공식)
- **용도**: GitHub 레포지토리 직접 제어 (PR, 커밋, 이슈 관리)

---

### ✅ serena
- **상태**: 설치됨 (Oraios 제공)
- **용도**: 코드 의미 분석, 리팩터링, 심층 코드베이스 탐색

---

## 관련 문서
- [[🛠️ 설치된 도구 목록]]
- [[🌌 Antigravity (Google AI IDE) 활용법]]
- [[🤖 Claude Code 활용법]]
