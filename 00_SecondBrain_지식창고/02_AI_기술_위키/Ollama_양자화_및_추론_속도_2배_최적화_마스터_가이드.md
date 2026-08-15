# ⚡ Ollama 양자화 및 추론 속도 2배 최적화 마스터 가이드

> **수집일**: 2026-08-15  
> **출처**: [괴발자 - Ollama 양자화 설정법 & 추론 속도 2배 최적화](https://youtu.be/yU3IKCmzw74)  
> **태그**: `#AI` `#Ollama` `#Quantization` `#GPUOptimization` `#RX6600` `#VRAM` `#LocalLLM`

---

## 📌 1. 개요
Ollama의 기본값(`Q4_K_M`, 단일 처리, 5분 언로드 등)을 탈피하여 **VRAM 8GB(라데온 RX 6600) 환경에 최적화된 양자화 선택법과 4가지 핵심 환경변수 튜닝 기법**을 정리한 가이드이다.

---

## ⚙️ 2. 8GB VRAM 맞춤 핵심 환경변수 4가지 (시스템 적용 완료)

| 환경 변수명 | 추천 설정값 | 핵심 역할 및 기대 효과 |
| :--- | :---: | :--- |
| **`OLLAMA_FLASH_ATTENTION`** | `1` | Attention 연산 최적화로 VRAM 사용량 절감 및 장문 컨텍스트 속도 대폭 향상 |
| **`OLLAMA_KV_CACHE_TYPE`** | `q8_0` | 대화 기록/코드 컨텍스트(KV Cache)를 8-bit로 압축하여 VRAM 여유 공간 확보 (품질 손실 0%에 수렴) |
| **`OLLAMA_NUM_PARALLEL`** | `2` | 동시 병렬 요청 수. 8GB VRAM 용량 초과로 인한 CPU 오프로딩(렉)을 방지하면서 에이전트 2개 동시 처리 최적화 |
| **`OLLAMA_KEEP_ALIVE`** | `24h` | 모델이 5분 뒤 메모리에서 언로드되는 현상 방지 (매번 디스크에서 재로딩하는 딜레이 제거) |

---

## 🎯 3. 모델 크기별 양자화 선택 전략 (RX 6600 8GB 기준)

1. **7B ~ 8B 경량 모델 (Qwen 2.5 7B, DeepSeek R1 8B 등)**
   * **기본 추천**: `Q4_K_M` (약 4.2~4.7GB VRAM 차지 -> 8GB에 완벽하게 안정적)
   * **초고품질 모드**: `q8_0` 태그 사용 (`ollama run qwen2.5:7b-q8_0`) -> 8GB VRAM 꽉 채워 지능/논리 정밀도 극대화

2. **14B 중형 모델 (Qwen 2.5 14B 등)**
   * **초경량 압축 모드**: `Q3_K_M` 또는 `IQ3_M` 양자화 GGUF 등록 -> 8GB VRAM 내에서 부드럽게 14B 구동

---

## 🛠️ 4. HuggingFace 커스텀 GGUF 모델 등록법
Ollama 공식 태그에 없는 특수 양자화(Q3, IQ2 등) 모델 등록:
1. HuggingFace(예: `bartowski` 등)에서 `.gguf` 파일 다운로드
2. `Modelfile` 작성:
   ```dockerfile
   FROM ./다운로드한_모델.gguf
   ```
3. Ollama 등록:
   ```bash
   ollama create 내모델이름 -f ./Modelfile
   ```

---

## 🔗 상호 링크
- [[00_SecondBrain_지식창고/00_지식창고_대시보드|🧠 지식창고 대시보드]]
- [[00_SecondBrain_지식창고/02_AI_기술_위키/AI_코딩_필수_안전_설정_8가지_및_보안_가이드|AI 코딩 필수 안전 설정 8가지 및 보안 가이드]]
