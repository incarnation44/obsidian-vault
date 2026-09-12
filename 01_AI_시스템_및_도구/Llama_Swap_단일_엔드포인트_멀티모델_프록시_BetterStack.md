---
title: "Llama-Swap: 제한된 VRAM을 위한 단일 엔드포인트 자동 모델 스위칭 프록시 — Better Stack"
aliases: ["Llama-Swap", "단일 엔드포인트 프록시", "로컬 LLM 포트 관리"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/GtTzO5ZOQr4"
published_date: "2026-05-13"
created_date: "2026-09-12"
tags: ["AI", "LLM", "Llama-Swap", "Proxy", "VRAM", "llama.cpp", "API"]
knowledge_type: source
---

# Llama-Swap: 제한된 VRAM을 위한 단일 엔드포인트 자동 모델 스위칭 프록시 — Better Stack

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/GtTzO5ZOQr4
- **원본 정보 발행일자**: 2026-05-13
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: Better Stack

---

## 💡 핵심 요약 (Level 0)
1. **단일 엔드포인트(Single Endpoint) 통합**: Cursor, Continue 등 다양한 코딩 도구에서 모델을 바꿀 때마다 포트와 URL을 수정할 필요 없이, Llama-Swap이 단일 API 창구(Front-door) 역할을 하여 백엔드의 모델들을 자동으로 교체해 줍니다.
2. **TTL 기반 VRAM 자동 반환**: YAML 설정 파일에 모델별 유휴 한계 시간(TTL)을 지정하면, 요청이 끝난 뒤 일정 시간 후 모델을 메모리에서 강제로 내려(Unload) 제한된 GPU VRAM을 복구합니다.
3. **Ollama와의 차별점 (통제권 극대화)**: 초보자용 다운로더나 GUI가 아닌, 원시(Raw) `llama.cpp`나 `vLLM` 바이너리에 직접 커스텀 플래그(GPU 레이어 수, KV 캐시 크기 등)를 주입하고 싶은 '통제광(Control Freak)' 개발자들을 위한 서버 전용 미들웨어입니다.

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. 로컬 LLM 환경의 고질적 병목: 포트 저글링(Port Juggling) [00:34~01:40]
- **현상**: 코딩용 무거운 모델(Qwen Coder)과 채팅용 가벼운 모델(Small LM)을 전환할 때마다, 개발자들은 `llama-server` 프로세스를 죽이고, 포트를 바꾸고, UI 툴의 OpenAI Base URL 설정을 매번 수정하는 번거로움을 겪습니다.
- **원인**: GUI 도구(LM Studio, Ollama)가 주는 편의성을 버리고 완벽한 커스텀 플래그(컨텍스트 사이즈, GPU 오프로드 비율)를 쓰기 위해 Raw 바이너리 구동 방식으로 넘어오면서 발생하는 페널티입니다.

### 2. Llama-Swap의 아키텍처와 해결책 [01:42~03:44]
- **Go 기반 프록시**: OpenAI 및 Anthropic 호환 API 요청을 가로채는 가벼운 프록시 서버입니다.
- **작동 방식**: 
  - 클라이언트는 오직 Llama-Swap의 Base URL 하나만 알고 있습니다.
  - 클라이언트가 API 요청 JSON의 `model` 필드에 "QwenCoder"를 실어 보내면, Llama-Swap이 YAML 파일에서 해당 모델의 구동 명령어(Command)를 찾아 프로세스를 띄웁니다.
  - 직후 `model: small-lm2` 요청이 들어오면, 기존 모델을 내리고 새 모델을 띄워 요청을 릴레이(Relay)합니다. 툴(Client) 입장에서는 백그라운드에서 무슨 일이 일어났는지 모른 채 일관된 응답을 받습니다.

### 3. TTL(Time-To-Live)과 VRAM 풋프린트 방어 [04:00~04:24]
- 10개 이상의 로컬 모델을 SSD에 보유하더라도, GPU VRAM(예: 8GB)의 한계 때문에 동시에 메모리에 띄울 수 있는 모델은 1~2개뿐입니다.
- Llama-Swap은 각 모델의 `TTL`을 추적하여, 지정된 시간 동안 API 호출이 없으면 모델 프로세스를 킬(Kill)하여 VRAM을 강제 회수합니다.

---

## 🛠️ AI(나) 및 3-PC 사용자 환경 적용점 (Level 2 System Actions)

1. **메인 데스크톱 (PC B: RX 6600 8GB) 멀티 에이전트 환경 구축**:
   - Ildo의 데스크톱은 8GB VRAM이라는 가혹한 제약이 있어, 코딩(WORKER) 모델과 로직 검증(AUDITOR) 모델을 VRAM에 동시 상주시키는 것이 불가능합니다.
   - **조치 방안**: PC B에 Llama-Swap을 미들웨어로 도입합니다. `yaml` 설정에 `flash-worker` (초고속 코딩 타이핑용)와 `pro-architect` (복잡한 물리/논리 검증용) 두 모델을 등록하고, TTL을 60초로 짧게 잡아 VRAM 8GB를 두 모델이 번갈아 가며 점유하도록(Hot-swapping) 파이프라인을 구축합니다.
2. **Rule #1 (에이전트 역할 분리)의 로컬 하드웨어적 구현**:
   - 기존에는 Cursor나 UI에서 모델을 바꿀 때 수동 조작이 필요했으나, Llama-Swap을 도입하면 Antigravity(또는 n8n 등) 오케스트레이터가 단일 로컬 엔드포인트(`http://localhost:8080/v1`)로 다양한 에이전트 역할을 자동 호출할 수 있게 됩니다.
3. **Ollama와의 공존 및 이관**:
   - Llama-Swap은 모델 다운로더가 아니므로, GGUF 파일 관리는 기존 방식을 유지하되, 실행 제어권(명령어 플래그)만 Llama-Swap의 `config.yaml`로 이관하여 GPU 레이어 배치와 KV 캐시(예: 이전 비디오의 MTP Tax 제어)를 정밀하게 튜닝합니다.

---

## 🔗 관련 문서 및 위키 링크
- [[Llama_Swap을_활용한_제한된_VRAM_환경에서의_멀티에이전트_오케스트레이션]]
- [[MTP_Multi_Token_Prediction_및_VRAM_최적화_트레이드오프]] (Llama-Swap YAML에서 MTP 플래그 튜닝 가능)
