---
title: ⚡ 2026 Antigravity 제공자 독립적 AI 오케스트레이터 아키텍처 v2.0.0
tags:
  - antigravity
  - orchestrator
  - modular-architecture
  - local-ai
  - cloud-ai
  - task-queue
  - v2.0.0
date: 2026-08-05
---

# ⚡ Antigravity AI Orchestrator v2.0.0 (Provider-Agnostic Architecture)

이 문서는 특정 AI 서비스나 브랜드 이름에 종속되지 않고, **기능 모듈(Feature-Centric Modules) 중심**으로 설계된 **Antigravity AI 오케스트레이션 플랫폼 v2.0.0**의 구조 명세서입니다.

---

## 🏛️ 1. 제공자 독립적 기능 모듈 아키텍처 (Feature-Centric Architecture)

```
                              [ 🤖 Antigravity Core Orchestrator ]
                               (Gemini 3.6 / 메인 제어 & 오케스트레이션)
                                               │
 ┌──────────────────┬──────────────────┬───────┴──────────┬──────────────────┬──────────────────┐
 ▼                  ▼                  ▼                  ▼                  ▼                  ▼
[ ⚡ Local AI ]   [ ☁️ Cloud AI ]    [ 🔍 Research ]    [ 💻 Coding ]      [ 🔄 Task Queue ]   [ 📊 Metrics ]
- Qwen2.5/3.8     - Gemini 3.6       - Multi Search     - Repo Indexing    - Auto Pipeline    - Healthcheck
- Qwen-Coder      - Claude           - Cross Check      - Diff Planner     (Doc->Code->Git)   - Latency/TPS
- DeepSeek-R1     - Kimi K3          - Citations        - Multi-file Edit                     - Memory Log
(0원/44tps)       (Front/Doc)        (Fact-Check)       (Precise Scheme)                      (chat_history)
```

---

## 🛠️ 2. 핵심 기능 서브시스템 명세 (Subsystem Specifications)

### 1) **Local AI Subsystem (로컬 추론 서브시스템)**
* **엔진**: Ollama (`http://localhost:11434`) + AMD RX 6600 (8GB VRAM) GPU 가속
* **서브 모델**: `qwen2.5:7b` (일반 대화 / 44tps), `qwen2.5-coder:7b` (전문 코딩), `deepseek-r1:8b` (심층 논리 추론)
* **특징**: 100% 오프라인 동작, 프라이버시 보호, 토큰 비용 0원

### 2) **Cloud AI Subsystem (클라우드 모델 서브시스템)**
* **엔진**: Gemini 3.6 Pro/Flash (Antigravity Main), Claude (UI/디자인), Kimi K3 (대용량 문서)
* **특징**: 고난도 멀티모달, 초대형 컨텍스트(100만 토큰), 고품질 프론트엔드 UI 제공

### 3) **Research Subsystem (리서치 및 팩트검색 서브시스템)**
* **기능**: 다단계 프로 탐색(Multi-step Search), 다각도 교차 검증(Cross-check), 공식 출처 각주 링킹(Citations)
* **원칙**: 1차 검색 단정 금지, 실결제액 기준 조사, 역추적 교차 검증

### 4) **Coding Subsystem (코딩 서브시스템)**
* **기능**: 코드베이스 인덱싱, Multi-file Diff 플래너, exact `file://` scheme 및 라인 범위(`file:///path#L10-L20`) 링킹
* **원칙**: 억측 금지, 원문 구문 정밀 파싱 후 안전한 리팩토링 수행

### 5) **Task Pipeline Queue Subsystem (작업 큐 서브시스템)**
* **모듈**: [task_pipeline_queue.py](file:///C:/Users/ildoc/.gemini/antigravity/scratch/my_ai_workspace/task_pipeline_queue.py)
* **작업 체이닝**: `"요구사항 분석 ➔ 지능형 모델 라우팅 ➔ 코드 수정 & 헬스체크 ➔ Obsidian 문서화 & Git Commit/Push"` 순차적 파이프라인 자율 수행

### 6) **Memory & Metrics Subsystem (메모리 및 메트릭 서브시스템 v2.3.0)**
* **라우터 회귀 테스트 스위트 (`router_test_suite.py`)**: 20개 테스트 케이스 실측 결과 **정확도 90.0%** (모호한 "분석+고쳐줘" 질의의 DeepSeek-R1 라우팅 완벽 검증)
* **서킷 브레이커 (`circuit_breaker.py`)**: 3회 연속 실패 모델 300초 자동 쿨다운 차단 및 백업 라우팅으로 시스템 락업 방지
* **VRAM Pressure Manager (`vram_manager.py`)**: RX 6600 8GB VRAM 동적 언로드 및 1-토큰 웜업으로 첫 응답 0-지연 보장
* **API 비용 장부 (`cost_ledger.py` / `api_cost_ledger.json`)**: Claude, Kimi, Gemini 토큰 사용량 및 월간 누적 USD 비용 자동 집계
* **Windows 작업 스케줄러 자동 리포트**: 매일 자정(00:00) `AntigravityDailyReport` 스케줄러 자동 가동 ➔ [📊 일일 리포트](file:///C:/전일도/📊%20일일%20리포트) 노트 자동 생성
* **종합 대시보드 노트**: [📊 2026 Antigravity 종합 시스템 모니터링 대시보드](file:///C:/전일도/📊%202026%20Antigravity%20종합%20시스템%20모니터링%20대시보드.md) 상시 모니터링

---

## 🔒 3. 재현성 및 버전 관리 (v2.0.0 Release)

* **Git Release Tag**: `v2.0.0` (GitHub `https://github.com/incarnation44/obsidian-vault.git`)
* **패키지 관리**: `pyproject.toml` 및 `requirements.txt` 이중 적용으로 Python 환경 완벽 고정
* **1분 자동 복원**: 파워셸에서 `git clone https://github.com/incarnation44/obsidian-vault.git C:\전일도; powershell -ExecutionPolicy Bypass -File "C:\전일도\setup_academy_pc.ps1"` 단 1줄로 복원

---

*최종 업데이트: 2026-08-05 | 작성: Antigravity AI Orchestrator*
