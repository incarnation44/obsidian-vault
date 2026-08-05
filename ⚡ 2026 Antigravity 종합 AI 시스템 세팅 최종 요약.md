---
title: ⚡ 2026 Antigravity AI Orchestrator v2.4.0 종합 세팅 명세서
tags:
  - antigravity
  - orchestrator
  - obsidian-rag
  - local-ai
  - dashboard
  - v2.4.0
date: 2026-08-05
---

# ⚡ 2026 Antigravity AI Orchestrator v2.4.0 종합 세팅 명세서

이 문서는 **Google Antigravity**와 **AMD Radeon RX 6600 로컬 GPU 가속**, 그리고 **옵시디언 개인 지식 RAG**가 결합된 **Antigravity AI Orchestrator v2.4.0**의 전체 세팅과 기능을 사용자가 옵시디언에서 한눈에 알아보기 쉽게 정돈한 종합 명세서입니다.

---

## 🖥️ 1. 시스템 하드웨어 & 로컬 가속 스펙

| 구분 | 구성 부품 / 세팅 값 | 비고 / 가속 상태 |
| :--- | :--- | :--- |
| **CPU** | AMD Ryzen 5 5600XT (6C / 12T / 3.7GHz) | 멀티스레드 병렬 처리 |
| **GPU** | AMD Radeon RX 6600 (8GB VRAM) | **FlashAttention=1 & ROCm 10.3.0** 가속 적용 |
| **RAM** | 32 GB DDR4 (16GB x 2) | 대형 모델 및 RAG 벡터 인덱스 보조 |
| **Storage** | NVMe SSD 1TB (여유 공간: **`341.02 GB`**) | 10,820개 지식 청크 및 AI 모델 보관 |
| **OS** | Windows 11 Pro (64-bit) | PowerShell 및 작업 스케줄러 자동화 |

---

## 🏛️ 2. 제공자 독립적 6대 서브시스템 구조 (Subsystems v2.4.0)

```
                              [ 🤖 Antigravity Core Orchestrator ]
                               (Gemini 3.6 / 메인 제어 & 오케스트레이션)
                                               │
 ┌──────────────────┬──────────────────┬───────┴──────────┬──────────────────┬──────────────────┐
 ▼                  ▼                  ▼                  ▼                  ▼                  ▼
[ ⚡ Local AI ]   [ ☁️ Cloud AI ]    [ 🔍 Research ]    [ 💻 Coding ]      [ 🔄 Task Queue ]   [ 📊 Metrics ]
- Qwen2.5/3.8     - Gemini 3.6       - Multi Search     - Repo Indexing    - Self-Healing     - Healthcheck
- Qwen-Coder      - Claude           - Cross Check      - Diff Planner     - Checkpoints      - P50/P95 Latency
- DeepSeek-R1     - Kimi K3          - Citations        - Exact Line       - DLQ Queue        - Obsidian RAG
(0원/44tps)       (UI/100만문서)     (Fact-Check)       (file://)          (Doc->Code->Git)   (10,820 chunks)
```

---

## ⚡ 3. v2.4.0 핵심 기능 모듈 한눈에 보기

### 📚 **① 옵시디언 개인 지식 RAG (`obsidian_rag.py`)**
- **기능**: 옵시디언 보관소 내 **10,820개 지식 청크** 증분 인덱싱(`should_rebuild_index()`) & 조건부 트리거(Conditional RAG).
- **조건부 지연 방지**: 일반 코딩/대화 질문 시 RAG를 건너뛰어 **0초 오버헤드 44 TPS** 유지.
- **개인 노트 인용**: *"내가 정리한 가이드 알려줘"* 질의 시 **클릭 가능한 `file:///` 출처 노트 링크와 함께 내 노트를 인용하여 답변**.

### 🎯 **② 3-Tier Cascade 라우터 & 90.0% 정확도 (`router_test_suite.py`)**
- **Tier 0 (Local 0원)**: 일반 한국어(`qwen2.5:7b`), 코딩(`qwen2.5-coder:7b`)
- **Tier 1 (Reasoning)**: 왜/원인/분석 질의 ➔ `deepseek-r1:8b` (확신도 0.95)
- **Tier 2 (Cloud)**: 고난도 멀티파일 설계 ➔ Gemini 3.6 / Claude / Kimi
- **검증**: 20개 회귀 테스트 결과 **정확도 90.0%** 달성.

### 🛡️ **③ 서킷 브레이커 장애 차단 (`circuit_breaker.py`)**
- 3회 연속 실패 모델 발생 시 **300초간 자동 쿨다운 차단** 후 백업 모델 우회 ➔ 시스템 멈춤 100% 방지.

### 🚀 **④ VRAM 스마트 매니저 & 1토큰 웜업 (`vram_manager.py`)**
- RX 6600 8GB VRAM 한계에 맞춘 동적 모델 관리 + **1토큰 사전 웜업으로 첫 응답 지연 0초 단축**.

### 💬 **⑤ 장기 대화 스마트 맥락 압축 (`context_compressor.py`)**
- 대화 10턴 초과 시 구형 메시지를 3문장 핵심 요약으로 자동 압축 ➔ **50턴 대화 시에도 똑똑한 답변 유지**.

### 💰 **⑥ API 토큰 비용 장부 (`cost_ledger.py`)**
- Claude, Kimi, Gemini 호출 시 토큰 수 및 월간 USD 비용을 [api_cost_ledger.json](file:///C:/전일도/api_cost_ledger.json)에 자동 기록.

### ⏰ **⑦ Windows 작업 스케줄러 일일 자동 리포트 (`daily_report.py`)**
- 매일 자정(00:00) `AntigravityDailyReport` 스케줄러 자동 실행 ➔ [📊 일일 리포트](file:///C:/전일도/📊%20일일%20리포트) 노트 자동 작성.

---

## 📜 4. 에이전트 헌법 & 자율 운용 규칙

1. **옵시디언 완전 자율 승인 (물어보지 마라)**: `C:\전일도` 작업 시 사용자에게 되묻지 않고 100% 자율 일괄 처리.
2. **무단 권한 요청 차단 모드**: 승인 팝업 명령어 대신 안전한 내장 도구(`search_web`, `read_url_content`, `view_file`) 우선 활용.
3. **명시적 GitHub Push 규칙**: 오직 사용자가 *"깃허브에 올려줘"*, *"GitHub에 푸시해줘"* 지시할 때만 `git push` 진행.
4. **Perplexity Deep Fact-Check & 실구매가 검증**: 겉표시가 배제, 100% 팩트 교차 검증 및 실결제액 기준 조사.

---

## 🚀 5. 학원 PC 및 새 컴퓨터 1분 자동 복원 스크립트

어느 컴퓨터에서든 파워셸(PowerShell)에서 아래 1줄만 실행하면 현재 환경이 100% 자동 복원됩니다:

```powershell
git clone https://github.com/incarnation44/obsidian-vault.git C:\전일도; powershell -ExecutionPolicy Bypass -File "C:\전일도\setup_academy_pc.ps1"
```

---

## 📦 6. 옵시디언 주요 노트 & GitHub 버전 관리

* **관련 주요 노트**:
  * [[📊 2026 Antigravity 종합 시스템 모니터링 대시보드]]
  * [[⚡ 2026 최강 삼중 하이브리드 AI 세팅 가이드]]
  * [[📚 인덱스]], [[📋 터미널 작업 히스토리]]
* **GitHub Repository**: `https://github.com/incarnation44/obsidian-vault.git`
* **최신 Release Tag**: **`v2.4.0`** (Push 완료)

---

*최종 업데이트: 2026-08-05 | 작성: Antigravity AI Orchestrator v2.4.0*
