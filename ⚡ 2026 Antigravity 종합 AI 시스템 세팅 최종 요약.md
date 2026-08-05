---
title: ⚡ 2026 Antigravity 종합 AI 시스템 세팅 최종 요약
tags:
  - antigravity
  - summary
  - local-ai
  - ollama
  - setup
  - github
  - obsidian
date: 2026-08-05
---

# ⚡ 2026 Antigravity 종합 AI 시스템 세팅 최종 요약

이 문서는 사용자의 컴퓨터에 세팅된 **Google Antigravity 에이전트, 로컬 AI 엔진(Ollama), 53종 스킬, MCP 서버, 삼중 하이브리드 아키텍처 및 무단 권한 요청 차단 환경**의 전체 세팅 내역을 종합 정리한 최종 명세서입니다.

---

## 🖥️ 1. 사용자 시스템 & 하드웨어 사양
- **CPU**: AMD Ryzen 5 5600XT (6 Cores / 12 Threads / 3.7GHz)
- **GPU**: AMD 라데온 RX 6600 (VRAM 8GB) ➔ ROCm/DirectML 기반 GPU 가속 활성화
- **RAM**: 32 GB (16GB x 2 DDR4 3200 MHz)
- **저장장치**: 메인 Crucial P3 Plus 1TB NVMe M.2 SSD (`CT1000P3PSSD8`)
- **OS**: Microsoft Windows 11 Pro (64-bit)

---

## ⚡ 2. 구축된 삼중 하이브리드 AI 아키텍처 (Triple Hybrid Engine)

| 계층 (Layer) | 모델 & 엔진 | 주요 역할 및 특징 | 비용 & 효율 |
| :--- | :--- | :--- | :--- |
| **Layer 1 (메인 관제)** | **Google Antigravity (Gemini 3.6 Flash / Pro)** | 실시간 다각도 웹 팩트검색, 이미지 생성(`generate_image`), MCP 도구 관제, 파일/옵시디언 자동 정리 | **무료 / 무제한 (Google AI Pro)** |
| **Layer 2 (로컬 GPU)** | **Ollama (`qwen2.5:7b` / `qwen3.8`, `deepseek-r1:8b`, `qwen2.5-coder:7b`)** | 오프라인 초고속 코딩(**44.2 tps**), 민감 파일 데이터 처리, 심층 논리 추론(`<think>`) | **100% 무료 (0원) / RX 6600 가속** |
| **Layer 3 (외부 프런티어)** | **Claude Code & Kimi K3 Bridge** | 극상의 프론트엔드 UI 디자인(Claude), 100만 토큰 문서 요약 및 PPT 슬라이드 자동 생성(Kimi K3) | **브릿지 파이썬 모듈(`hybrid_ai_bridge.py`)로 핀포인트 연동** |

---

## 🛠️ 3. 시스템 규칙 및 자율 수행 프로토콜 (Agent Rules & Governance)

1. **옵시디언 완전 자율 승인 (No-Prompt Rule)**:
   - 옵시디언(`C:\전일도`) 파일 생성, 수정, 정리 시 **사용자에게 재확인을 물어보지 않고 자율적 일괄 처리**.
2. **무단 권한 요청 차단 모드**:
   - 사용자 승인 팝업이 뜨는 터미널 명령어를 최소화하고, 권한 요청이 전혀 안 뜨는 안전한 내장 도구(`search_web`, `read_url_content`, `view_file`) 우선 활용.
3. **명시적 GitHub Push 규칙**:
   - 오직 사용자가 *"깃허브에 올려줘"*, *"GitHub에 푸시해줘"* 라고 지시했을 때만 `git push` 진행.
4. **Perplexity Deep Fact-Check & 실구매가 검증 헌법**:
   - 1차 검색 단정 금지, 역추적 다각도 교차 검증 및 겉표시가 배제 후 실결제액 기준 산출.

---

## 🚀 4. 학원 PC 및 새 컴퓨터 1분 자동 복원 스크립트

어느 컴퓨터에서든 파워셸(PowerShell)을 열고 아래 1줄을 실행하면 동일한 환경이 1분 만에 구성됩니다:

```powershell
git clone https://github.com/incarnation44/obsidian-vault.git C:\전일도; powershell -ExecutionPolicy Bypass -File "C:\전일도\setup_academy_pc.ps1"
```

---

*최종 업데이트: 2026-08-05 | 작성: Antigravity AI Agent*
