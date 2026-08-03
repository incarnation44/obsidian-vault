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

이 문서는 시스템 WMI 및 디바이스 진단을 통해 수집한 **모든 PC 개별 부품의 정확한 제조사, 구체적 부품 모델명, 스토리지 모델 정보**를 정밀하게 정리한 시스템 명세서입니다.

---

## 🧩 1. 핵심 부품 개별 모델명 모음 (Summary Table)

| 부품 구별 | 제조사 (Brand) | 구체적 부품 모델명 (Exact Part Model) | 규격 / 세부 정보 |
| :---: | :---: | :--- | :--- |
| **메인보드** | **Gigabyte** | **Gigabyte A520M K V2** | AMD AM4 소켓, M.2 지원 |
| **CPU (프로세서)** | **AMD** | **AMD Ryzen 5 5600XT 6-Core Processor** | 6코어 12스레드 / 3.7GHz |
| **GPU (그래픽카드)**| **AMD** | **AMD Radeon RX 6600** | VRAM 8GB GDDR6 / DirectML |
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
- **제조사**: AMD
- **모델명**: **AMD Radeon RX 6600**
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
   - **역할**: 윈도우 OS, AI 모델 파일, 메인 개발 워크스페이스
2. **보조 SSD 1 (D: 드라이브)**
   - **모델명**: **InnoDisk M.2 (P42) 3TE6 NVMe SSD**
   - **용량**: ~240 GB
   - **역할**: 보조 스토리지 및 서브 파일
3. **보조 SSD 2 (E: 드라이브)**
   - **모델명**: **ADATA Premier Pro SP900 SSD (`SP900`)**
   - **용량**: ~128 GB
   - **역할**: 보조 백업 스토리지

---

## 🔗 관련 문서
- [[💻 PC 시스템 세팅 및 오류 해결 노하우]]
- [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]]
- [[🛠️ 설치된 도구 목록]]
- [[📚 인덱스]]
