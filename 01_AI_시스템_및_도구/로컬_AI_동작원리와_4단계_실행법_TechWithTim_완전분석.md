---
title: 로컬 AI 동작 원리와 4단계 실행법 완전분석 (Tech With Tim)
category: 01_AI_시스템_및_도구
tags:
  - 로컬AI
  - Ollama
  - LMStudio
  - llamacpp
  - VRAM최적화
  - 양자화
  - GGUF
created: 2026-09-06
updated: 2026-09-06
source: https://youtu.be/edIHPoWgIKU
source_date: 2026-08-31
---

# 💻 로컬 AI 동작 원리와 4단계 실행법 완전분석

> **원본 영상**: [Tech With Tim - Local AI Explained: How to Run AI Models on Your Computer](https://youtu.be/edIHPoWgIKU)  
> **채널명**: Tech With Tim  
> **원본 정보 발행일자**: 2026-08-31  
> **내 보관소 등록일자**: 2026-09-06  

---

## 💡 핵심 요약 (Level 0)

* **로컬 AI의 본질**: 클라우드 의존 없이 내 컴퓨터에 저장된 모델 파일(가중치)을 로컬 추론 엔진(Inference Engine)으로 직접 연산하는 체계.
* **3대 이점과 트레이드오프**: 완전한 개인정보 보호(Privacy), 구독료·토큰 비용 제로($0), 오프라인 구동이 장점이나, 클라우드 초대형 모델 대비 모델 크기(파라미터)와 컨텍스트 한계가 명확함.
* **4대 실행 계층**: 1) LM Studio(초보자용 GUI), 2) Ollama(개발자용 CLI/API), 3) Docker Model Runner(컨테이너 기반 배포), 4) llama.cpp 직접 코드 바인딩(초경량 커스텀).

---

## ⚙️ 1. 로컬 AI의 4대 핵심 구성 요소 (Building Blocks)

### ① 모델 가중치 파일 (Weights)
* AI 모델은 생각하는 주체가 아니라, 학습 과정에서 고정된 수십억~수천억 개의 숫자 덩어리(파일)임.
* 파라미터 수(B = Billion)가 많을수록 지능이 높아지지만, 파일 크기와 요구 VRAM/RAM이 비례하여 증가함.

### ② 양자화 (Quantization, GGUF)
* 사진을 압축하듯, 높은 부동소수점 정밀도(FP16)를 낮은 정밀도(Q8, Q6, Q4 등)로 압축하는 기법.
* 원래 16GB가 필요한 모델을 Q4 양자화를 통해 5~7GB 수준으로 줄이면서도 추론 성능 저하는 미미하게 유지함. 일반 PC에서 대형 모델을 돌릴 수 있는 핵심 기반.

### ③ 추론 엔진 (Inference Engine)
* 모델 가중치 파일 자체는 실행 파일이 아니므로, 이를 메모리에 올리고 행렬 연산을 수행하는 런타임 엔진이 필수적임.
* 현재 대다수 로컬 AI 도구(Ollama, LM Studio 등)는 내부적으로 **`llama.cpp`** C++ 엔진을 백엔드로 사용함.

### ④ 하드웨어 병목: 메모리 용량(Capacity) vs 메모리 대역폭(Bandwidth)
* **메모리 용량(VRAM / Unified Memory)**: 모델이 들어갈 수 있는 크기를 결정.
  * 8GB VRAM: 3B~4B 파라미터 모델 (또는 타이트한 Q4 7B~8B)
  * 16GB VRAM: 7B~8B 파라미터 모델 여유 구동
  * 32GB 이상: 14B~35B 파라미터 모델 (로컬 AI에서 실질적 지능 체감이 시작되는 스윗스팟)
* **메모리 대역폭(속도)**: 초당 생성 토큰 수(Tokens/sec)를 결정.
  * 외장 전용 GPU(NVIDIA RTX 등)는 VRAM 용량은 작아도 대역폭이 넓어 추론 속도가 매우 빠름 (100~200 tok/s).
  * Mac 통합 메모리는 128GB 등 대용량 적재가 가능하나, 대역폭 차이로 인해 초거대 모델 구동 시 속도가 상대적으로 느림.
* **컨텍스트 윈도우 메모리**: 긴 대화나 대형 문서를 넣을수록 KV 캐시 메모리가 VRAM을 추가로 점유하므로, 기본 모델 크기보다 여유 공간이 확보되어야 함.

---

## 🛠️ 2. 로컬 AI를 구동하는 4가지 실전 계층

| 계층 | 도구 | 주요 특징 | 추천 대상 |
| :--- | :--- | :--- | :--- |
| **Tier 1** | **LM Studio** | 직관적인 GUI, 내 사양에 맞는 모델 추천, 슬라이더 설정, 로컬 OpenAI 호환 서버 지원 | 터미널 조작을 피하고 화면에서 대화/테스트하고 싶은 사용자 |
| **Tier 2** | **Ollama** | 가벼운 CLI 명령어(`ollama run`), 백그라운드 상주 서비스, REST API 연동 | 스크립트, VS Code, 코딩 에이전트와 연동하려는 개발자 |
| **Tier 3** | **Docker Model Runner** | 도커 이미지처럼 LLM을 취급(`docker model`), Docker Compose 배포 용이 | 컨테이너 스택 내에서 AI 서비스를 함께 배포하려는 환경 |
| **Tier 4** | **Pure Code (`llama-cpp-python`)** | 중간 서비스 없이 파이썬/C++ 코드 내에서 모델 파일을 직접 로드하여 실행 | 종속성을 최소화하고 단일 독립 바이너리/앱을 빌드하려는 경우 |

---

## 🔍 3. 우리 시스템(Antigravity) 대조 및 시사점

1. **현재 3-PC 아키텍처의 적합성 재확인**:
   * **서브 노트북 (Dell Latitude 7440 / Iris Xe 내장)**: VRAM이 없으므로 로컬 구동을 지양하고 Gemini Flash 클라우드 API를 사용하는 현재 방침이 배터리와 발열 면에서 100% 최적임.
   * **메인 본체 (RX 6600 8GB VRAM)**: 8GB VRAM 용량 한계에 맞춰 3B~8B Q4 모델(Ollama) 위주로 선택적 활용하고, 무거운 에이전틱 작업은 클라우드로 처리하는 현재 구성이 하드웨어 스펙과 정확히 일치함.
2. **도구 도입 게이트 및 FREEZE 판정**:
   * LM Studio, Docker Model Runner 등은 굳이 새로 설치할 필요가 없음.
   * 현재 본체에 구축된 **Ollama** 하나만으로 코딩 에이전트 및 로컬 API 연동 요구사항을 완벽히 충족하므로 **[FREEZE]**를 유지함.
