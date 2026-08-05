# 💻 PC 시스템 및 하드웨어 종합 가이드

> **통합 업데이트**: 2026-08-05
> **개요**: PC 하드웨어 사양, RX 6600 GPU 가속, 오류 해결 노하우 및 시스템 모니터링 대시보드 통합 문서입니다.

---

## 💻 1. PC 상세 하드웨어 사양 및 가속 환경

---
title: 💻 PC 상세 하드웨어 사양 및 가속 환경
tags:
  - pc-spec
  - hardware
  - gigabyte
  - amd
  - crucial
  - adata
  - aone
date: 2026-08-03
---

# 💻 PC 상세 하드웨어 사양 및 가속 환경

이 문서는 시스템 WMI 및 디바이스 진단을 통해 수집한 **모든 PC 개별 부품의 정확한 제조사, 구체적 부품 모델명, 스토리지 모델 정보**를 정밀하게 정리한 시스템 명세서입니다. *(로컬 전용)*

---

## 🧩 1. 핵심 부품 개별 모델명 모음 (Summary Table)

| 부품 구별 | 제조사 (Brand) | 구체적 부품 모델명 (Exact Part Model) | 규격 / 세부 정보 |
| :---: | :---: | :--- | :--- |
| **메인보드** | **Gigabyte** | **Gigabyte A520M K V2** | AMD AM4 소켓, M.2 지원 |
| **CPU (프로세서)** | **AMD** | **AMD Ryzen 5 5600XT 6-Core Processor** | 6코어 12스레드 / 3.7GHz |
| **GPU (그래픽카드)**| **XFX (STCOM)** | **XFX 라데온 RX 6600 Speedster SWFT 210 Core D6 8GB** | VRAM 8GB GDDR6 / DirectML 가속 |
| **RAM (메모리)** | **기타/삼성** | **DDR4 3200MHz 32GB** (16GB x 2) | 듀얼채널 구성 (3200 MHz) |
| **메인 SSD (C:)** | **Crucial** | **Crucial P3 Plus 1TB NVMe M.2 SSD (`CT1000P3PSSD8`)** | 1TB NVMe PCIe M.2 SSD |
| **보조 SSD (D:)** | **InnoDisk** | **M.2 (P42) 3TE6 Industrial NVMe SSD** | 240GB NVMe M.2 SSD |
| **보조 SSD (E:)** | **ADATA** | **ADATA Premier Pro SP900 128GB SSD (`SP900`)** | 128GB 2.5인치 SATA3 SSD |
| **파워서플라이** | **AONE** | **AONE 시그니처 750W 80PLUS BRONZE 풀모듈러 베이직 ATX 3.1** | 750W / 80PLUS Bronze / ATX 3.1 |
| **OS** | **Microsoft** | **Windows 11 Pro (64-bit)** | Build 10.0.26200 |

---

## 🖥️ 2. 부품별 상세 하드웨어 정보

### 1) 메인보드 (Motherboard)
- **제조사**: Gigabyte Technology Co., Ltd.
- **모델명**: **Gigabyte A520M K V2**
- **특징**: AMD AM4 라이젠 5000 시리즈 완벽 지원, M.2 NVMe 슬롯 보유, 콤팩트 M-ATX 폼팩터.

### 2) CPU (프로세서)
- **제조사**: AMD
- **모델명**: **AMD Ryzen 5 5600XT 6-Core Processor**
- **사양**: 6 코어 / 12 스레드 / 기본 3.70 GHz
- **특징**: 로컬 AI 연산 보조 및 다중 작업 최적화.

### 3) GPU (그래픽카드 & 가속)
- **제조사**: **XFX (유통사: STCOM)**
- **모델명**: **XFX 라데온 RX 6600 Speedster SWFT 210 Core D6 8GB**
- **VRAM**: 8 GB GDDR6
- **가속 기반**: DirectML / ROCm / Vulkan 지원
- **로컬 AI 생성 속도**: Qwen 2.5 7B (`44.72 tokens/sec`), DeepSeek-R1 8B (`38.64 tokens/sec`)

### 4) 메인 메모리 (RAM)
- **용량**: **32 GB** (16 GB x 2)
- **동작 속도**: **DDR4 3200 MHz**
- **특징**: 32GB 대용량 메모리로 14B급 대형 AI 연산 및 개발 환경 동시 실행.

### 5) 파워서플라이 (PSU - 전원 공급 장치)
- **제조사/모델명**: **AONE 시그니처 750W 80PLUS BRONZE 풀모듈러 베이직 ATX 3.1**
- **정격 출력**: **750 W**
- **효율 인증**: 80PLUS BRONZE
- **특징**: 750W 고용량 풀모듈러 파워로 그래픽카드 업그레이드 전력 공급 가능.

---

## 💾 3. 저장장치 (SSD 개별 모델 명세)

1. **메인 SSD (C: 드라이브)**
   - **모델명**: **Crucial P3 Plus 1TB NVMe M.2 SSD (`CT1000P3PSSD8`)**
   - **용량**: ~1,000 GB (1 TB)
2. **보조 SSD 1 (D: 드라이브)**
   - **모델명**: **InnoDisk M.2 (P42) 3TE6 NVMe SSD**
   - **용량**: ~240 GB
3. **보조 SSD 2 (E: 드라이브)**
   - **모델명**: **ADATA Premier Pro SP900 SSD (`SP900`)**
   - **용량**: ~128 GB

---

## 🔗 관련 문서
- [[💻 PC 시스템 세팅 및 오류 해결 노하우]]
- [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]]
- [[🛠️ 설치된 도구 목록]]
- [[📚 인덱스]]


---

## 🛠️ 2. PC 시스템 세팅 및 오류 해결 노하우

---
title: 💻 PC 시스템 세팅 및 오류 해결 노하우
tags:
  - pc-setup
  - windows
  - troubleshooting
  - optimization
date: 2026-08-03
---

# 💻 PC 시스템 세팅 및 오류 해결 노하우

이 문서는 대화 및 작업 히스토리를 바탕으로 **윈도우 PC 시스템 최적화, 시작 프로그램 관리, 각종 시스템 오류 해결법**을 정리한 가이드 문서입니다.

---

## 1. 🚀 시작 프로그램 설정 및 부팅 최적화

### 📌 부팅 속도 저하 방지 관리법
- **AMDAutoUpdate 팝업/검은 창 조치**:
  - `C:\Program Files\AMD\AutoUpdate\AMDAutoUpdate.exe` 백그라운드 주기 실행 문제.
  - 해결: 작업 관리자 [시작 앱] 탭 비활성화 및 [작업 스케줄러]의 AMD 자동 업데이트 트리거 비활성화.
- **체크 경로**:
  - `작업 관리자(Ctrl+Shift+Esc)` ➔ [시작 앱]
  - 레지스트리: `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`

---

## 2. 🛠️ 시스템 오류 해결 조치 모음

### 🖥️ 모니터 & 계정 로그인 오류 해결
- **증상**: 윈도우 부팅 후 모니터 화면 미출력 또는 계정 로그인 실패/무한 로딩.
- **해결 절차**:
  1. 안전 모드(Safe Mode) 진입 후 그래픽 드라이버(DDU) 재설치.
  2. `sysdm.cpl` ➔ 원격/디스플레이 설정 및 Fast Startup(빠른 시작) 기능 비활성화.

### 🔄 윈도우 & 프로그램 업데이트 오류 해결
- **증상**: 업데이트 다운로드 중 멈춤 또는 오류 코드 발생.
- **해결 절차**:
  1. `Windows Update` 서비스 중지 (`net stop wuauserv`).
  2. `C:\Windows\SoftwareDistribution` 폴더 내부 임시 파일 삭제 후 서비스 재시작(`net start wuauserv`).

### 📱 휴대폰 스크린샷 자동 연동 해제
- **증상**: 스마트폰으로 캡처한 스크린샷이 PC로 자동 동기화되어 저장 공간을 차지함.
- **해결**: [Windows 휴대폰과 연결] ➔ 설정 ➔ 사진/스크린샷 동기화 옵션 비활성화.

---

## 🔗 관련 문서
- [[🛠️ 설치된 도구 목록]]
- [[📋 터미널 작업 히스토리]]
- [[📚 인덱스]]


---

## 📊 3. Antigravity 종합 시스템 모니터링 대시보드

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


