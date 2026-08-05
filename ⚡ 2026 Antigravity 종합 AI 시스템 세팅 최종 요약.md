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

### 6) **Memory & Benchmark Subsystem (메모리 및 메트릭 서브시스템)**
* **대화 메모리**: `chat_history.json` (이전 대화 맥락 유지)
* **성능 트렌드**: `benchmark_log.json` (응답 속도, TPS, 모델별 사용률 및 성공/폴백 기록)
* **종합 헬스체크**: Ollama 서버, 모델 존재, Python 환경, 여유 디스크 용량(`disk_free_gb`) 자동 검증

---

## 🔒 3. 재현성 및 버전 관리 (v2.0.0 Release)

* **Git Release Tag**: `v2.0.0` (GitHub `https://github.com/incarnation44/obsidian-vault.git`)
* **패키지 관리**: `pyproject.toml` 및 `requirements.txt` 이중 적용으로 Python 환경 완벽 고정
* **1분 자동 복원**: 파워셸에서 `git clone https://github.com/incarnation44/obsidian-vault.git C:\전일도; powershell -ExecutionPolicy Bypass -File "C:\전일도\setup_academy_pc.ps1"` 단 1줄로 복원

---

*최종 업데이트: 2026-08-05 | 작성: Antigravity AI Orchestrator*
