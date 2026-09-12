---
title: "llama.cpp 8GB VRAM 35B 오프로딩 최적화 튜토리얼 — AI ProgBr"
aliases: ["llama.cpp", "8GB VRAM 최적화", "AI ProgBr"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/ZwNCsUTNWOA"
published_date: "2026-05-18"
created_date: "2026-09-12"
tags: ["AI", "llama.cpp", "VRAM", "Offloading", "MoE", "KV Cache", "Quantization"]
knowledge_type: source
---

# llama.cpp 8GB VRAM 35B 오프로딩 최적화 튜토리얼 — AI ProgBr

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/ZwNCsUTNWOA
- **원본 정보 발행일자**: 2026-05-18
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: AI ProgBr

---

## 💡 핵심 요약 (Level 0)
1. **8GB VRAM의 한계 돌파**: 낡은 GTX 1070 8GB 그래픽카드와 16GB 시스템 램(DDR5) 환경에서, llama.cpp를 조율하여 Qwen 3.6 35B (MoE) 모델을 초당 약 20토큰(20 tok/s)의 쾌적한 속도로 구동하는 데 성공함.
2. **MoE 맞춤형 CPU 오프로딩**: 21GB에 달하는 모델(Q4 양자화)을 8GB VRAM에 욱여넣기 위해, 메인 레이어는 GPU에 올리고 용량을 많이 차지하는 MoE 전문가(Experts) 레이어 30개를 CPU로 정밀 타격하여 오프로딩(Offload)함.
3. **KV 캐시 양자화를 통한 컨텍스트 확장**: 초기 4,000 토큰에 불과했던 문맥 창(Context Window)을 늘리기 위해, VRAM을 파먹는 주범인 KV 캐시를 4-bit로 양자화(`-ctk q4_0`, `-ctv q4_0`)하여 속도 저하 없이 무려 132,000 토큰의 컨텍스트를 확보함.

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. 하드웨어 및 모델 세팅 [01:14~02:44]
- **시스템**: Zima Cube Pro (NAS 장비), i5 12세대, 16GB DDR5 RAM, GTX 1070 8GB. (총 가용 메모리 약 24GB).
- **모델**: Qwen 3.6 35B (활성 파라미터 3B의 MoE 모델).
- **용량 최적화**: 21.2GB 크기의 Q4(4-bit) 모델을 선택했으며, 멀티모달용 비전(Vision) 프로젝터 파트(약 900MB)를 아예 로드하지 않고 텍스트 모듈만 단독으로 띄워 VRAM을 쥐어짬.

### 2. 레이어 수동 분배 (Manual Layer Offloading) [07:29~10:14]
- 40개의 레이어를 모두 GPU로 올리려 시도(`-ngl 99`)했으나 VRAM 초과로 크래시 발생.
- 모델 총 용량 20GB 중 8GB(40%)만 VRAM에 들어가므로, 나머지 60%를 CPU(RAM)로 넘겨야 함. 
- MoE 모델의 특성을 살려 전문가(Experts) 레이어만 CPU로 강제 오프로드. 40개 레이어 중 28~30개를 CPU로 할당하고 나머지를 GPU로 몰아넣음으로써 7.9GB의 VRAM을 꽉 채워 병목을 최소화함.
- **결과**: 이 조율만으로 18~22 tokens/second의 엄청난 속도를 확보함.

### 3. 컨텍스트 윈도우 확장과 KV 캐시 양자화 [11:28~16:56]
- **문제점**: 속도는 빠르나 컨텍스트 창이 4,096 토큰에 불과했음. 64K로 무작정 늘리려 하자 VRAM 부족으로 크래시 및 심각한 스왑(Swap) 지연 발생.
- **해결책 (KV Cache Quantization)**: llama.cpp의 플래그인 `-ctk q4_0` (Key 캐시 양자화)와 `-ctv q4_0` (Value 캐시 양자화)를 적용하여, 모델의 맥락 기억 장치(Cache) 크기를 절반 이상으로 압축함.
- **최종 결과**: GPU에 적재된 레이어 배분을 미세 조정한 끝에, **초당 15~18 토큰의 속도를 유지하면서 무려 132,000 토큰의 컨텍스트 윈도우(회의록 전체를 넣을 수 있는 크기)를 8GB VRAM 환경에서 달성**함.

---

## 🛠️ AI(나) 및 3-PC 사용자 환경 적용점 (Level 2 System Actions)

1. **메인 데스크톱 (PC B: RX 6600 8GB + 32GB RAM) 35B 세팅 적용**:
   - Ildo의 데스크톱은 영상과 완벽히 동일한 8GB VRAM 제약을 가지며, 시스템 RAM은 32GB로 훨씬 넉넉함.
   - 30B 체급 이상의 MoE 모델(Mixture of Experts)을 구동할 때, llama.cpp 기반 서버나 LM Studio를 켜고 맹목적으로 GPU 레이어만 조절하는 대신, **① MoE 전문가 레이어만 핀셋으로 CPU 오프로딩**, **② KV 캐시 Q4 양자화(`-ctk q4_0 -ctv q4_0`)** 두 가지 플래그를 반드시 적용하는 런북을 구성함.
2. **Trade-off 인지 및 가드레일**:
   - 앞서 학습한 "1-bit 양자화의 브레인 데미지"와 마찬가지로, 모델 자체의 가중치를 Q4로 깎고 **KV 캐시마저 Q4로 깎으면** 긴 코딩 파일을 다룰 때 변수명을 헷갈리거나 맥락(Logic)을 상실할 위험이 일부 존재함. 
   - 따라서 일상적인 문서 요약이나 아이디어 브레인스토밍에는 이 세팅을 극대화하여 사용하되, 정밀한 코딩 디버깅이나 논리 추론 시에는 컨텍스트를 줄이더라도 KV 캐시 양자화(FP16 유지)를 풀고 VRAM에 8B 모델을 온전히 올리는 분기(Routing) 의사결정(ADR)을 채택함.

---

## 🔗 관련 문서 및 위키 링크
- [[KV_캐시_양자화와_MoE_특화_CPU_오프로딩]]
- [[1-bit_양자화와_하이브리드_오프로딩_트레이드오프]]
- [[MTP_Multi_Token_Prediction_및_VRAM_최적화_트레이드오프]]
