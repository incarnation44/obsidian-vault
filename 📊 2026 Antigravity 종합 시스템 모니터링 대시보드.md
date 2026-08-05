---
title: 📊 2026 Antigravity 종합 시스템 모니터링 대시보드
tags:
  - dashboard
  - observability
  - metrics
  - antigravity
  - local-ai
  - latency
  - tps
date: 2026-08-05
---

# 📊 2026 Antigravity 종합 시스템 모니터링 대시보드 (v2.1.0)

이 대시보드는 **Antigravity AI Orchestrator v2.1.0**의 로컬/클라우드 추론 상태, TPS 처리 속도, P50/P95 지연 시간(Latency), 파이프라인 자동 복구(Self-Healing)율 및 GPU 가속 상태를 실시간 기록하는 통합 대시보드입니다.

---

## ⚡ 1. 실시간 오퍼레이션 지표 (Observability Metrics)

| 측정 항목 | 지표 값 | 비고 / 상태 |
| :--- | :--- | :--- |
| **시스템 전체 상태** | **`HEALTHY`** | Ollama 데몬 & 백그라운드 태스크 정상 가동 중 |
| **태스크 성공률 (Success Rate)** | **`100.0%`** | 3-Tier Fallback 체인 및 DLQ 이관 모니터링 |
| **평균 생성 속도 (Avg TPS)** | **`36.89 ~ 44.20 tokens/sec`** | AMD Radeon RX 6600 (8GB VRAM) 가속 |
| **응답 지연 시간 P50** | **`67.79초`** (심층 추론 기준) | General/Coder 모델은 4~18초 소요 |
| **여유 디스크 용량 (SSD)** | **`341.06 GB`** | 모델 파일 (Qwen, DeepSeek 등 4.7~5.2GB씩 점유) |

---

## 🚀 2. 하드웨어 옵티마이저 & ROCm 가속 현황

* **`OLLAMA_FLASH_ATTENTION`**: **`1`** (Flash Attention 가속 활성화)
* **`HSA_OVERRIDE_GFX_VERSION`**: **`10.3.0`** (AMD Radeon RX 6600 GFX1030 드라이버 가속 적용)
* **VRAM 활용 정책**: 7B~8B 모델 100% GPU VRAM 할당 (대기 중 점유율 0%)

---

## 🎯 3. 3-Tier Cascade 라우팅 지표

```
[사용자 요청 입력]
      │
      ▼
 3-Tier Cascade Router (보안/의도 분석)
      ├─ Tier 0 (Local First): qwen2.5:7b / qwen2.5-coder:7b (단순 분류, 코딩, 요약 - 0원 / 초고속)
      ├─ Tier 1 (Mid Reasoning): deepseek-r1:8b (왜/원인/분석/추론 - 36.89 tps)
      └─ Tier 2 (Frontier Cloud): Gemini 3.6 Pro / Claude / Kimi K3 (멀티파일 리팩토링, 100만 토큰 문서)
```

---

## 🔒 4. 파이프라인 자동 복구 (Self-Healing & DLQ)

* **체크포인트 파이프라인**: 성공한 개별 단계는 [checkpoints](file:///C:/Users/ildoc/.gemini/antigravity/scratch/my_ai_workspace/checkpoints)에 자동 기록되어 재시작 시 실패한 위치부터 복원
* **Dead Letter Queue (DLQ)**: 3회 재시도 초과 실패 태스크는 [dead_letter_queue.json](file:///C:/Users/ildoc/.gemini/antigravity/scratch/my_ai_workspace/dead_letter_queue.json)으로 안전 이관 후 자동 알림

---

*최종 업데이트: 2026-08-05 | 작성: Antigravity AI Observability System*
