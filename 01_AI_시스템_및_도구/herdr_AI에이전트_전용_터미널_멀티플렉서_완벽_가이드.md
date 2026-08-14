---
title: 🚀 herdr (허더) 완벽 가이드 - AI 에이전트 전용 차세대 터미널 멀티플렉서
tags:
  - ai-agents
  - terminal
  - multiplexer
  - herdr
  - tmux
  - claude-code
  - rust
source_url: "https://youtu.be/rSHizW6dI3c"
source_creator: "YouTube"
source_date: 2026-08-13
registered_date: 2026-08-14
---

# 🚀 herdr (허더) 완벽 가이드 - AI 에이전트 전용 터미널 멀티플렉서

> **📌 아카이빙 메타데이터**
> - **원본 출처**: [YouTube (https://youtu.be/rSHizW6dI3c)](https://youtu.be/rSHizW6dI3c)
> - **출처 정보 발행일자**: `2026-08-13`
> - **내 보관소 등록일자**: `2026-08-14`
> - **개요**: tmux, cmux, orca의 한계를 넘어 **Claude Code, Codex, Kimi, Hermes 등 여러 AI 코딩 에이전트를 동시에 병렬 구동하고 모니터링하기 위해 태생부터 AI 전용으로 설계된 Rust 기반 초고속 터미널 멀티플렉서 `herdr`** 완벽 가이드입니다.

---

## 📊 기존 도구(tmux, cmux) vs herdr 핵심 비교

```mermaid
graph TD
    subgraph 기존 도구 (tmux / cmux)
        A1["복잡한 키바인딩 단축키 암기 필수"]
        A2["어떤 에이전트가 일하고 멈췄는지 모름"]
        A3["터미널 탭이 어지럽게 분산"]
    end

    subgraph herdr (AI 전용 멀티플렉서)
        B1["100% 마우스 클릭 조작 지원"]
        B2["에이전트 상태 실시간 감지 (작업중/승인대기/완료)"]
        B3["창을 닫아도 백그라운드 서버 무중단 지속"]
    end

    기존 도구 -->|AI 에이전트 시대의 전환| herdr
```

---

## 🔥 herdr의 4대 킬러 기능

### 1. AI 코딩 에이전트 자동 감지 & 실시간 상태 대시보드 ⭐
* Claude Code, Codex, Open Code, Kimi, Hermes 등을 터미널에서 실행하면 **왼쪽 사이드바에 에이전트가 자동 등록**됩니다.
* 터미널 창을 일일이 열어보지 않아도 사이드바 아이콘 하나로 현재 상태를 즉시 파악:
  * 🟡 **노란색 애니메이션**: 현재 코드 작성/실행 중
  * ⏸️ **일시정지/알림**: 사용자 승인(Y/N) 대기 중
  * 🟢 **초록색**: 작업 완료 (사운드 알림 지원)

### 2. 세션 지속성 (창을 닫아도 멈추지 않는 백그라운드 데몬) ⭐⭐
* **클라이언트-서버 구조**: 실수로 터미널 창이나 herdr을 통째로 닫아도 에이전트의 코딩 작업이 중단되지 않고 백그라운드에서 계속 실행됩니다.
* 다시 herdr을 열면 작업 중이던 상태 그대로 즉시 복귀합니다.

### 3. CLI 도구인데 완벽한 마우스 100% 친화적 UI
* 복잡한 `Ctrl + B` 같은 tmux 단축키를 외울 필요 없이 **화면 분할, 탭 이동, 스페이스 전환을 마우스 클릭**으로 쉽게 제어합니다.

### 4. 직관적인 3단계 작업 계층 구조
* **`Space (프로젝트 단위)`**: 예: 쇼핑몰 프로젝트 / AI 봇 프로젝트
* **`Tab (작업 단위)`**: 예: Research 탭 / Backend 탭 / Dev Server 탭
* **`Pane (화면 분할)`**: 한 화면에 Claude Code, Codex, 실행 터미널을 나란히 분할 배치

---

## 🛠️ 설치 및 기본 실행법

* **공식 사이트**: [herdr.dev](https://herdr.dev) (무료 오픈소스 / Rust 기반)
* **지원 OS**: Windows (PowerShell / Windows Terminal), macOS, Linux

### 1. 윈도우 설치 명령어
```powershell
# herdr 공식 원클릭 설치 (PowerShell)
irm https://herdr.dev/install.ps1 | iex
```

### 2. 실행
```powershell
herdr
```

---

## 🔗 관련 문서 링크
- [[01_AI_시스템_및_도구/ORCA_v0.1_실험_가이드_및_평가표|ORCA 병렬 에이전트 가이드]]
- [[01_AI_시스템_및_도구/AI_에이전트_및_도구_통합_마스터_가이드|AI 에이전트 통합 마스터 가이드]]
- [[인덱스]]
