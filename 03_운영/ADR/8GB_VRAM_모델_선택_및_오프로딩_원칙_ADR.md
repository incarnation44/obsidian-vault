---
title: "[ADR] 8GB VRAM 모델 선택 및 CPU 오프로딩 원칙"
aliases: ["8GB 로컬 AI 전략", "이원화 라우팅 전략"]
category: "03_운영/ADR"
created_date: "2026-09-12"
updated_date: "2026-09-12"
tags: ["ADR", "Architecture", "VRAM", "Local AI", "Hardware"]
knowledge_type: decision
---

# [ADR] 8GB VRAM 모델 선택 및 CPU 오프로딩 원칙

## 1. Context (배경)
- 사용자(Ildo)의 메인 로컬 AI 연산 장비(PC B)는 **AMD Radeon RX 6600 (8GB VRAM)**과 32GB 시스템 RAM을 갖추고 있다.
- 최근 27B~35B 체급의 고성능 오픈소스 모델(Qwen 3.x 시리즈 등)이 주류로 자리 잡았으나, 8GB VRAM이라는 물리적 한계로 인해 이를 구동하기 위한 극단적 1-bit 양자화나 무리한 CPU 오프로딩 기법이 난립하고 있다.
- 이에 따라 코딩, 문서 요약, 대화 등 다양한 작업에서 속도(Latency)와 지능(Quality), 컨텍스트 유지력(Context Window) 간의 충돌이 발생하고 있다.

## 2. Problem (문제 정의)
- **단일 모델의 한계**: 8GB VRAM 환경에서는 모든 작업을 완벽하게 수행하는 '단일 거대 모델'을 상주시키는 것이 불가능하다.
- **오프로딩의 함정**: CPU RAM으로 모델을 넘기면 큰 모델을 켤 수는 있지만, PCIe 병목으로 인해 챗봇이나 실시간 코딩 피드백 용도로 쓰기엔 체감 속도(TTFT)가 박살난다.
- **양자화의 함정**: 모델을 1-bit나 2-bit로 억지로 압축하여 8GB에 밀어 넣으면 속도는 빠르지만, 지능이 파괴되어 로직 환각(Logic Hallucination)이 발생한다.
- **소형 모델의 함정**: 8GB에 쏙 들어가는 9B 체급 모델(Q4)은 빠르고 똑똑하지만, 컨텍스트가 10K를 넘어가면 중간 정보를 다 잊어버린다(Lost in the middle).

## 3. Decision (결정 사항)
로컬 AI 작업을 **'반응성 우선(Interactive)'**과 **'문맥 우선(Batch/Context)'** 두 가지로 철저히 분리하고, 각 목적에 맞는 모델 2개를 스위칭하여 사용하는 **이원화 라우팅 전략(Dual-Routing Strategy)**을 채택한다.

1. **대화 및 정밀 코딩 (Interactive & Coding)**
   - **선택 모델**: 9B 체급 모델의 4-bit 양자화 (예: `Qwen 3.5 9B Q4` 또는 `Ornith 9B Q4`)
   - **구동 방식**: VRAM 100% 적재 (No CPU Offloading)
   - **이유**: 8GB VRAM에 오프로딩 없이 완벽히 들어가며, 초당 35~40토큰의 광속 피드백을 제공한다. 짧은 코드 스니펫이나 즉각적인 질문 답변에 최적화되어 있다.

2. **거대 문서 분석 및 코드베이스 전체 요약 (Batch & Context)**
   - **선택 모델**: 35B 체급 MoE 모델의 4-bit 양자화 (예: `Qwen 3.6 35B MoE Q4`)
   - **구동 방식**: KV 캐시 양자화(`-ctk q4_0`) 적용 및 MoE 전문가 레이어 30개 CPU 오프로딩
   - **이유**: 속도는 초당 15토큰 이하로 떨어지지만, 대형 모델 특유의 방대한 컨텍스트 유지력으로 수만 단어의 문서나 코드 더미에서 핵심 정보를 망각 없이 추출해낸다.

3. **절대 금지 조항 (Constraints)**
   - 1-bit, 2-bit (Q1, IQ2 등) 양자화 모델은 어떠한 경우에도 코딩/업무용으로 사용을 금지한다.
   - 추론 모델의 Reflection(Thinking) 모드를 인위적으로 끄는 행위는 금지한다.

## 4. Consequences (결과 및 영향)
- **Positive**: 
  - 코딩 시 속도 답답함이 해결되고 환각이 줄어든다.
  - 대형 문서 요약 시 엉뚱한 결론(Lost in the middle)을 내는 빈도가 0에 가깝게 수렴한다.
- **Negative**:
  - 목적에 따라 Ollama나 LM Studio에서 모델을 스위칭(언로드/로드)해야 하는 번거로움이 발생한다.
  - VRAM과 RAM 사이의 스위칭 시간을 작업 플로우에 감안해야 한다.

## 5. Related Documents
- [[2026년_VRAM_구간별_최적_로컬_AI_모델_가이드_RepoChad]]
- [[9B_이하_소형_모델의_대규모_컨텍스트_망각_한계]]
- [[1-bit_양자화와_하이브리드_오프로딩_트레이드오프]]
- [[llama_cpp_8GB_VRAM_35B_오프로딩_최적화_AIProgBr]]
