---
title: "Multi-Token Prediction (MTP) 아키텍처 및 VRAM 최적화 트레이드오프"
aliases: ["MTP", "다중토큰예측", "Speculative Decoding", "MTP KV Cache"]
category: "02_AI_기술_위키"
created_date: "2026-09-12"
updated_date: "2026-09-12"
tags: ["AI", "Architecture", "MTP", "llama.cpp", "VRAM", "Optimization"]
knowledge_type: concept
---

# Multi-Token Prediction (MTP) 아키텍처 및 VRAM 최적화 트레이드오프

## 1. 개요
MTP(Multi-Token Prediction)는 LLM이 한 번의 연산 주기(Cycle)에 하나의 토큰만 생성하는 병목을 해소하기 위해 도입된 가속 기술이다. llama.cpp 등에 통합되어 있으며, 하드웨어 교체 없이 20~65%의 추론 속도(tok/s) 향상을 제공하지만 VRAM 및 PCIe 대역폭 측면에서 고유한 트레이드오프를 요구한다.

---

## 2. 작동 원리 (vs Speculative Decoding)
기존의 추측 해독(Speculative Decoding)은 빠르고 멍청한 '외부 초안 모델(Draft Model)'을 따로 메모리에 올려 토큰을 던지면, 메인 모델이 이를 검증하는 방식이었다.

- **MTP의 혁신**: 외부 모델을 쓰지 않고, 메인 모델 내부의 숨겨진 가중치인 **'MTP 헤드(Head)'** 가 다음 $N$개(통상 3개)의 토큰을 예측한다.
- **배치 검증(Batch Verify)**: 거대한 메인 모델은 이 3개의 토큰을 한 번의 Forward Pass로 검증한다. 적중률(Acceptance Rate)이 통상 85~93%에 달하여 연산량의 대부분을 건너뛴다.

---

## 3. 하드웨어별 MTP 가속 효율성 병목 분석

### 1) 통합 메모리 (Apple Silicon Mac)
- **가속률**: 최대 65% 향상 (N-gram 캐시 결합 시).
- **특징**: CPU와 GPU가 물리적 메모리를 공유(Unified Memory)하므로, PCIe 버스 전송 페널티(통신 비용)가 0에 수렴하여 MTP의 가속 잠재력을 100% 흡수한다.

### 2) 버젯 GPU (8GB 이하 VRAM + CPU 오프로딩)
- **가속률**: 20~25% 향상.
- **병목 1 (CPU 오프로딩 대기)**: 모델 크기가 VRAM보다 커서 램(RAM)에 일부 레이어를 얹은 경우, GPU 쪽에서 MTP로 연산을 스킵하더라도 결국 느릿느릿한 CPU 레이어의 연산이 끝날 때까지 대기(Wait)해야 하므로 가속률이 반토막 난다.
- **병목 2 (PCIe 병목 페널티)**: MTP의 임베딩 처리 과정에서 GPU와 시스템 RAM 간의 데이터 왕복이 발생해 프롬프트 처리(Prompt Processing) 속도가 15~30% 저하된다.

---

## 4. 8GB VRAM 환경 최적화 룰: MTP Tax (세금) 계산
MTP 활성화 시 주의해야 할 가장 큰 함정은 **'MTP 전용 KV 캐시 확보'** 다.

- MTP 헤드는 예측을 수행하기 위해 별도의 상태(State) 공간을 요구하며, 64K 컨텍스트 기준 **약 900MB의 추가 VRAM(Tax)** 을 집어삼킨다.
- **Ildo 시스템 (RX 6600 8GB) 적용 가이드**: 
  - VRAM 한계까지 꽉 채운 모델에 MTP를 켜면 이 900MB 세금 때문에 모델 레이어가 CPU로 밀려나(Swapping) 속도가 오히려 붕괴된다.
  - 따라서 MTP를 켜기 전, 양자화 단계를 낮추거나(8-bit -> 4-bit) 컨텍스트 길이를 절반으로 깎아 반드시 1GB 이상의 여유 VRAM을 선제적으로 확보해야 한다.

---

## 🔗 관련 문서
- [[llama_cpp_MTP_다중토큰예측_가속_분석_Codacus]]
- [[MoE_메모리_최적화_및_저가형_모델의_로직_환각_한계]]
- [[하네스_우위의_법칙_Harness_Beats_the_Tier_및_VRAM_엔지니어링]]
