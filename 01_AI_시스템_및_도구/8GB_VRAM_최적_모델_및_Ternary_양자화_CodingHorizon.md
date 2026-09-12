---
title: "8GB VRAM 최적 모델 및 Ternary 양자화 — Coding Horizon"
aliases: ["Coding Horizon", "Ternary Bonsai", "Nanbeige", "Poolside", "한국형 314B"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/DqMn9RTT04c"
published_date: "2026-07-31"
created_date: "2026-09-12"
tags: ["AI", "VRAM", "Ternary", "1.58-bit", "Nanbeige", "Layer_Looping"]
knowledge_type: source
---

# 8GB VRAM 최적 모델 및 Ternary 양자화 — Coding Horizon

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/DqMn9RTT04c
- **원본 정보 발행일자**: 2026-07-31
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: Coding Horizon

---

## 💡 핵심 요약 (Level 0)
1. **8GB의 구원자, Ternary(1.58-bit) Bonsai 27B**: 27B 모델을 일반 양자화로 누르면 9GB라 8GB VRAM에 못 들어간다. Prism ML은 모든 가중치를 3개의 숫자(-1, 0, 1)로 강제 학습시킨 'Ternary Bonsai'를 만들었고, 용량을 6GB 밑으로 깎아내면서도 지능을 95% 보존하여 8GB 로컬 AI의 '지능 밀도(Intelligence Density)'를 극대화했다.
2. **Nanbeige의 레이어 루핑(Layer Looping) 기법**: 메모리(VRAM)가 없을 때 가장 좋은 전략은 '시간(Time)을 지불'하는 것이다. 레이어를 쌓는 대신 있는 레이어를 여러 번 반복 연산하여 크기를 극단적으로 줄였으며, 9B 모델을 압도하는 코딩 능력을 보여준다.
3. **24GB 이상 환경의 Reflection(생각) 최적화**: 24GB 유저는 압축 없는 원본 모델을 돌리지만, 최신 모델들의 '생각하는 과정(Rambling)'이 길어 사용자가 너무 오래 대기해야 한다. 똑같은 점수를 내면서 생각하는 시간을 반으로 줄인 특화 파인튜닝(Fine-tune) 모델이 코더들에게 필수적이다.

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. 8GB VRAM 브래킷과 Ternary 양자화 [00:46~02:29]
- 27B 모델은 원본이 54GB이며, 억지로 짜내도 9GB라 8GB 카드 유저는 튕기거나 스왑(RAM)의 늪에 빠진다.
- Prism ML의 방식은 사후 양자화(PTQ)가 아니라 태생부터 -1, 0, 1의 3개 상태(Ternary, 1.58-bit)만 가지도록 임베딩부터 출력단까지 통째로 재학습(Retrain) 시킨 것이다.
- 그 결과, 6GB 미만의 용량(1-bit는 4GB 미만)으로 압축되면서도 원본 지능의 거의 95%를 유지한다. 스마트폰이나 8GB 랩탑에서 도구 호출(Tool Calling)과 비전 처리를 즉각적으로(Instant) 수행해낸다.

### 2. Nanbeige 랩의 '시간-메모리 교환' 워크호스 [02:37~03:26]
- Nanbeige 랩에서 나온 모델은 독특한 트릭을 쓴다. 새로운 레이어를 층층이 쌓아 용량을 불리는 대신, 가지고 있는 얇은 레이어를 '여러 번 반복해서(runs the ones it has more than once)' 구동한다.
- 즉, 'VRAM 메모리'가 모자라니 '연산 시간'을 희생하는(Pay in time rather than memory) 영리한 전략이다.
- 크기는 9B나 12B보다 훨씬 작으면서도 GitHub 이슈 해결이나 대학원 과학 시험에서 1년 전 플래그십 수준의 점수를 낸다. 태깅, 분류 등 백그라운드 대량(High-volume) 배치 작업에 완벽하다.

### 3. 고용량(128GB~300GB) 브래킷의 세계 [04:36~06:17]
- **128GB (Mac Studio급)**: 샌프란시스코 스타트업 Poolside의 모델. 엄청난 희소성(Sparsity, MoE)을 활용해 토큰당 얇은 조각만 깨워 코드를 짠다. 빈 폴더에서 완벽히 작동하는 브라우저 엔진을 한 번에 코딩해내는 기염을 토함.
- **300GB+ (한국형 오픈 가중치)**: 3,140억 개(314B) 파라미터를 가진 한국의 오픈 모델. 384개의 전문가(Expert) 중 단 9개만 토큰마다 활성화된다. 2대의 Mac Studio(192GBx2)를 묶은 환경에서 로컬로 구동 가능하며 중/미 모델을 제외한 최고의 오픈 모델로 평가됨.

---

## 🛠️ AI(나) 및 3-PC 사용자 환경 적용점 (Level 2 System Actions)

1. **PC B (8GB VRAM) '6GB 법칙' 기반 Ternary 도입 (ADR 업데이트)**:
   - [[8GB_VRAM의_실질_마지노선_6GB_법칙]]에 정확히 부합하는 모델이 바로 **Ternary Bonsai 27B (5.9GB)**임. 
   - 1-bit(3.9GB)보다는 똑똑하고, 6GB 리미트에는 아슬아슬하게 들어가는 최적의 타협점임. 기존 ADR에서 허가한 네이티브 1-bit 옵션 중 1.58-bit(Ternary) 포맷을 1순위로 탐색하여 적용함.
2. **Nanbeige 방식 백그라운드 배치 작업 분리**:
   - "메모리가 없으면 시간을 지불하라"는 철학은 Ildo의 옵시디언 대규모 파일 정리/분류 자동화 작업과 완벽히 부합함. 
   - 응답 속도(Latency)가 중요하지 않은 대규모 텍스트 분류/태깅(Tagging) 작업 시에는 9B 모델조차 무거울 수 있으므로, Nanbeige 같은 '레이어 반복형(Layer-Looping)' 소형 모델을 백그라운드로 돌려 VRAM 부하를 없애는 방향을 시스템 설계에 편입함.

---

## 🔗 관련 문서 및 위키 링크
- [[반복_레이어_아키텍처와_시간_메모리_교환_법칙]] (신규 위키)
- [[네이티브_1bit_아키텍처와_PTQ_양자화의_지능_차이]]
- [[8GB_VRAM의_실질_마지노선_6GB_법칙]]
