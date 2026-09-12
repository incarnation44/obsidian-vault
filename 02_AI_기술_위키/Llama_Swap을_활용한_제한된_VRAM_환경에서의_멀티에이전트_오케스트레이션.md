---
title: "Llama-Swap을 활용한 제한된 VRAM 환경에서의 멀티에이전트 오케스트레이션"
aliases: ["Llama-Swap", "VRAM 핫스왑", "로컬 미들웨어", "모델 스위칭"]
category: "02_AI_기술_위키"
created_date: "2026-09-12"
updated_date: "2026-09-12"
tags: ["AI", "Architecture", "VRAM", "Proxy", "Orchestration", "Llama-Swap"]
knowledge_type: concept
---

# Llama-Swap을 활용한 제한된 VRAM 환경에서의 멀티에이전트 오케스트레이션

## 1. 개요
단일 GPU(예: 8GB, 12GB VRAM) 환경에서 여러 개의 로컬 LLM을 동시에 구동하는 것은 불가능에 가깝다. 멀티 에이전트 시스템(예: 코딩 에이전트, 검증 에이전트, 리서치 에이전트)을 로컬에서 구현하기 위해 **Llama-Swap**과 같은 미들웨어 프록시를 도입하여, 단일 API 엔드포인트 뒤에서 모델을 동적으로 적재(Load)하고 해제(Unload)하는 VRAM 시분할(Time-sharing) 아키텍처가 필수적이다.

---

## 2. 기존 환경의 병목 (포트 저글링과 VRAM OOM)
- **VRAM 부족 (OOM)**: 8GB GPU에 8B 파라미터 모델 하나를 올리면 여유 공간이 1~2GB 남짓이다. 다른 역할의 모델을 동시에 띄우면 시스템 램(RAM) 스와핑이 발생하여 속도가 극단적으로 느려진다.
- **클라이언트 의존성**: Cursor, Continue, n8n 등 각각의 도구가 서로 다른 포트나 프로세스를 바라보게 설정하면, 모델이 켜져 있지 않을 때 Connection Refused 에러가 발생하며 전체 자동화 파이프라인이 중단된다.

---

## 3. Llama-Swap 기반 아키텍처

Llama-Swap은 Go 언어로 작성된 가벼운 리버스 프록시로, OpenAI 호환 API 요청을 가로채어 백엔드 프로세스(`llama-server`, `vLLM` 등)를 직접 통제한다.

### 1) 단일 진실 공급원 (Single Endpoint)
- 클라이언트(에이전트 프레임워크)는 `http://localhost:8080/v1` 이라는 단 하나의 엔드포인트만 알고 있으면 된다.
- 클라이언트가 API Body에 `{ "model": "auditor-model" }`을 실어 보내면, 프록시가 이를 해석하여 해당 모델을 백그라운드에서 띄운 후 응답을 반환한다.

### 2) TTL 기반 VRAM 가비지 컬렉션 (Garbage Collection)
- 각 모델별로 `TTL(Time-To-Live)`을 설정하여, 지정된 시간(예: 60초) 동안 API 요청이 없으면 SIGTERM 신호를 보내 프로세스를 종료시킨다.
- 이를 통해 GPU VRAM을 항시 비워두어 다음 에이전트가 즉각적으로 메모리를 100% 사용할 수 있도록 보장한다.

### 3) Raw CLI 플래그 통제권 (Config as Code)
- Ollama 등 추상화된 런타임과 달리, YAML 파일에 `llama-server`의 실행 명령어(`--n-gpu-layers`, `--ctx-size`, `--spec-type draft-mtp` 등)를 문자열 단위로 직접 기록한다.
- 하드웨어 제약(예: RX 6600 특유의 ROCm 플래그, MTP를 위한 KV 캐시 제한)을 각 모델의 역할에 맞춰 마이크로 컨트롤 할 수 있다.

---

## 4. 로컬 멀티에이전트 시스템 적용 시나리오

1. **사용자 요청**: "기존 코드를 리팩토링하고 보안을 검토해 줘."
2. **Worker 에이전트 호출 (Qwen 2.5 Coder)**: Llama-Swap을 통해 코딩 특화 모델이 VRAM에 로드되어 리팩토링 코드(초안)를 순식간에 작성한다.
3. **유휴 전환 (TTL)**: 코드가 완성되면 Worker 모델은 대기 상태로 전환되고 60초 후 VRAM에서 Unload 된다.
4. **Auditor 에이전트 호출 (Gemini Pro 또는 로컬 Llama 3 Architect)**: 보안 검토를 위해 파라미터가 크고 추론력이 높은 모델이 새롭게 VRAM에 로드되어 Worker의 코드를 검증한다.
5. **무결점 파이프라인**: 툴(오케스트레이터) 입장에서는 포트 변경이나 서버 재시작 로직 없이, 단순히 API에 던지는 `model` 이름만 바꿔가며 거대한 멀티 에이전트 루프를 로컬에서 $0 비용으로 무한 실행한다.

---

## 🔗 관련 문서
- [[Llama_Swap_단일_엔드포인트_멀티모델_프록시_BetterStack]]
- [[MTP_Multi_Token_Prediction_및_VRAM_최적화_트레이드오프]]
- [[하네스_우위의_법칙_Harness_Beats_the_Tier_및_VRAM_엔지니어링]]
