---
title: "Qwen 3.6 35B A3B(MoE) 6GB 구형 GPU에서 256K 컨텍스트 17 tok/s 초고속 구동 가이드 — Codacus"
aliases: ["Qwen 35B 6GB 구동", "Codacus MoE 최적화", "llama.cpp 5대 플래그", "TurboQuant 256K"]
category: "01_AI_시스템_및_도구"
source: "https://youtu.be/8F_5pdcD3HY"
published_date: "2026-05-04"
created_date: "2026-09-12"
tags: ["AI", "LLM", "MoE", "llama.cpp", "6GBVRAM", "GTX1060", "TurboQuant", "CPU오프로드", "mlock", "최적화"]
knowledge_type: source
---

# Qwen 3.6 35B A3B(MoE) 6GB 구형 GPU에서 256K 컨텍스트 17 tok/s 초고속 구동 가이드 — Codacus

## 📌 아카이빙 필수 메타데이터
- **원본 출처**: https://youtu.be/8F_5pdcD3HY
- **원본 정보 발행일자**: 2026-05-04
- **내 보관소 등록일자**: 2026-09-12
- **채널명**: Codacus

---

## 💡 핵심 요약 (Level 0)
1. **8년 된 6GB 그래픽카드(GTX 1060)에서 35B MoE 17 tok/s 실현**: 총 350억 개 파라미터 중 토큰당 30억 개(8개 전문가)만 활성화되는 MoE 특성을 간파하여, 어텐션 코어는 GPU에 두고 256개 전문가는 시스템 RAM으로 격리하는 방식으로 기본 3 tok/s에서 **17 tok/s(+466%)**로 속도를 폭증시켰다.
2. **DeepMind Turbo Quant로 256K 전체 컨텍스트 단일 6GB 카드 정복**: 비대칭 양자화(`--ctk turbo4 --ctv turbo3`)를 적용하여 Q8 대비 품질 저하 없이 KV 캐시 크기를 대폭 압축, 64K에서 **256K 토큰(단일 도서 또는 대형 코드베이스 통째 주입)**으로 컨텍스트를 4배 확장하면서도 VRAM 5.9GB 내에서 17 tok/s 속도를 불변 유지했다.
3. **상용 안정성 5대 플래그 및 투기적 디코딩 실패 원인 규명**: 장기 가동 시 메모리 페이징을 막는 `mlock` 3계층 설정과 `--no-mmap`의 사전 로딩을 정립했다. 또한 MoE 및 SSM(State Space Model) 구조에서는 투기적 디코딩(Speculative Decoding)이 전문가 페칭 병목과 순차적 상태 연산 특성 때문에 오히려 속도를 17에서 11 tok/s로 깎아먹는 역효과를 낳는다는 아키텍처적 한계를 실측 규명했다.

---

## 📜 상세 분석 및 타임스탬프 근거 (Level 1 Claims)

### 1. 테스트 환경과 멍청한 베이스라인(Dumb Baseline)의 한계 [00:00~02:45]
- **테스트 장비 (2026년 기준 최악의 바닥 사양)**:
  - GPU: 8년 전 출시된 **NVIDIA GTX 1060 6GB VRAM (PCIe Gen 3)**.
  - CPU: 8년 전 출시된 인텔 i3-8100 (4코어 4스레드, 하이퍼스레딩 없음).
  - RAM: 24GB 일반 DDR4.
- **모델 제원**: `Qwen 3.6 35B A3B (MoE)`
  - 총 파라미터 35B, 토큰당 활성 파라미터 3B.
  - 256개 전문가 중 토큰당 8개 전문가만 활성화.
- **Dumb Baseline (단순 절반 레이어 분할 `-ngl 20`)**:
  - 결과: **초당 3토큰 (3 tok/s)** ➔ 한 문장 나오는 데 30초 소요 (위성전화 수준).
  - 원인: 레이어를 통째로 나누면 레이어 안의 모든 전문가 가중치까지 CPU에 남아 매 토큰마다 PCIe 버스를 타고 대량 데이터가 왕복하며 대역폭이 질식함.

### 2. 17 tok/s를 달성한 5대 핵심 플래그 진화 과정 [02:45~11:03]

```mermaid
graph LR
    Base[단순 레이어 분할 -ngl 20<br>3 tok/s] -->|플래그 1: --n-cpu-moe 41| Step1[전문가 전원 CPU 격리<br>10 tok/s]
    Step1 -->|플래그 2: --no-mmap| Step2[사전 램 완충<br>13.5 tok/s]
    Step2 -->|플래그 3: --n-cpu-moe 35| Step3[6개 레이어 GPU 복귀<br>17 tok/s]
    Step3 -->|플래그 4: Turbo Quant| Step4[256K 컨텍스트 확장<br>17 tok/s 불변]
    Step4 -->|플래그 5: --mlock| Prod[1주일 무중단 안정화<br>17 tok/s 지속]
```

1. **플래그 1: `--n-cpu-moe 41` (전문가 가중치 CPU 핀 고정)**:
   - 핵심 발상: 빠르게 상시 발화하는 어텐션/공통 코어는 GPU에 남기고, 대부분 자고 있는 거대 전문가 블록(256개 중 248개 수면)만 시스템 RAM에 밀어넣음.
   - 결과: **3 tok/s ➔ 10 tok/s (230% 가속, 하드웨어 변경 0원)**.
2. **플래그 2: `--no-mmap` (디스크 페이징 원천 차단)**:
   - `mmap`의 문제: OS가 디스크에서 온디맨드로 페이징하므로 새 전문가 호출 시 디스크 I/O 발생 및 토큰 지연.
   - `--no-mmap`: 시작 시 20GB 모델 전체를 RAM에 즉시 적재하여 페이지 폴트 제거.
   - 결과: **10 tok/s ➔ 13.5 tok/s (+35% 가속)**.
3. **플래그 3: `--n-cpu-moe 35` (가용 VRAM 정밀 미세 조정)**:
   - 13.5 tok/s 시점에서 VRAM 여유가 2GB 남음.
   - CPU 전문가 수를 41에서 35로 줄여 6개 레이어의 전문가를 GPU로 복귀시킴.
   - 결과: VRAM 5.5GB 점유, **13.5 tok/s ➔ 17.0 tok/s (말하는 속도보다 빠름)**.
4. **플래그 4: DeepMind Turbo Quant (`--ctk turbo4 --ctv turbo3`)**:
   - VRAM이 5.5GB 차면서 컨텍스트가 64K로 줄어듦 ➔ 256K로 복구하기 위한 전략.
   - 구글 딥마인드 논문의 랜덤 회전 기반 고압축 기술 적용 (GQA 8:1 비율에 맞춰 Keys 4비트, Values 3비트 비대칭 압축). Q8 대비 체감 손실 없음.
   - `--n-cpu-moe 36`으로 1개 레이어만 양보하자, **VRAM 5.9GB에서 256,000 토큰(256K) 적재 성공!**
   - 결과: 책 한 권 또는 전체 코드베이스를 통째로 넣고도 **17 tok/s 속도 유지**.
5. **플래그 5: `--mlock` 및 3중 메모리 잠금 (운영 안정성)**:
   - 문제: 며칠 켜두면 OS 커널이 RAM에 있는 전문가 가중치를 스왑 디스크로 내쫓아 갑자기 버벅거림 (`mlocked 12KB`).
   - 해결: `LXC 컨테이너 권한` + `Docker --cap-add=IPC_LOCK` + `llama.cpp --mlock` 3중 결합.
   - 결과: `mlocked 16GB` 고정, 1주일 내내 17 tok/s 항구 유지.

### 3. 투기적 디코딩(Speculative Decoding) 실패 원인 심층 분석 [11:03~13:30]
- **시도**: 드래프터로 `Qwen 3.5 800M`을 붙여 8개 토큰 동시 예측 (예측 채택률 65%로 준수).
- **충격적 결과**: 속도가 **17 tok/s ➔ 11 tok/s로 35% 역주행 하락**.
- **원인 1 (MoE 메모리 스래싱)**:
  - 8개 토큰을 묶어 검증할 때 레이어당 최대 64개의 서로 다른 전문가를 RAM에서 PCIe로 동시에 긁어와야 하므로 버스 병목 폭발.
- **원인 2 (SSM 레이어의 순차성)**:
  - 모델 40개 레이어 중 30개가 SSM(State Space Model) 레이어로, 이전 위치의 상태에 엄격히 종속되어 병렬 검증이 불가능함.
- **결론**: MoE + SSM 하이브리드 모델에서는 전통적 Speculative Decoding이 역효과를 냄.

---

## 🛠️ AI(나) 및 사용자 3-PC 환경 적용점 (Level 2 System Actions)

1. **메인 데스크톱 (Ildo 본체: RX 6600 8GB + Ryzen 5600X + 32GB RAM) 적용 시뮬레이션**:
   - 영상의 테스트 장비는 6GB VRAM + 구형 4코어 i3 + PCIe 3.0 환경에서 17 tok/s를 뽑아냄.
   - **사용자 본체(RX 6600 8GB + 6코어 5600X + PCIe 4.0 + 32GB RAM)에 적용 시**:
     - PCIe 4.0으로 버스 대역폭 2배 확보 ➔ 전문가 전송 속도 급증.
     - 8GB VRAM이므로 `--n-cpu-moe 28~30` 수준으로 더 많은 전문가를 GPU에 적재 가능.
     - 32GB 시스템 RAM으로 20GB 모델 전체 `--no-mmap` 및 `--mlock` 완벽 수용.
     - **예상 실측 성능**: Qwen 35B MoE 모델 구동 시 **22~28 tok/s 이상의 초고속 실시간 대화 및 256K 코드베이스 분석 완결 가능**.
2. **로컬 배포 도커 1-Line 프로덕션 템플릿 자산화**:
   ```bash
   docker run --gpus all --cap-add=IPC_LOCK -v /models:/models      ghcr.io/ggerganov/llama.cpp:server      -m /models/qwen3.6-35b-a3b.gguf      --n-cpu-moe 32      --no-mmap      --mlock      --ctk turbo4 --ctv turbo3      -c 262144      --port 8080
   ```
3. **MoE 모델에 Speculative Decoding 강제 금지 가드레일**:
   - MoE/SSM 계열 모델에는 드래프트 모델(MTP, 경량 모델)을 무리하게 붙이지 말고, 순수 텐서 핀닝과 Turbo Quant에 집중하도록 파라미터 정책 고정.

---

## 🔗 관련 링크 및 지식 네트워크 (Level 3 Knowledge Links)
- [[02_AI_기술_위키/MoE_CPU_전문가_오프로딩_및_TurboQuant_KV_캐시_아키텍처]]
- [[01_AI_시스템_및_도구/Qwen3.8_27B_모든_GPU_8GB_32GB_로컬_실행_가이드_RepoChad]]
- [[01_AI_시스템_및_도구/Qwen3.8_27B_단일_8GB_그래픽카드_실전구동_성능_분석_RedStapler]]
