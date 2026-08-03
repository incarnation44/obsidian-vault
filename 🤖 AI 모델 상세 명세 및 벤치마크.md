---
title: 🤖 AI 모델 상세 명세 및 벤치마크
tags:
  - ai-model
  - ollama
  - qwen
  - deepseek
  - gemini
  - benchmark
date: 2026-08-03
---

# 🤖 AI 모델 상세 명세 및 벤치마크

이 문서는 사용 중인 **로컬 AI 모델(Ollama 기반)과 클라우드 에이전트 모델(Gemini)**의 파라미터 크기, 양자화(Quantization), 문맥 길이(Context Length), 파일 용량, 벤치마크 측정 속도를 정밀하게 기록한 명세서입니다.

---

## 💻 1. 로컬 AI 모델 상세 명세 (Ollama 엔진)

### 🟢 1) Qwen 2.5 (7B) — 초고속 코딩 & 한국어 모델
- **모델 ID**: `845dbda0ea48`
- **파일 용량**: **4.7 GB**
- **아키텍처**: `Qwen2`
- **파라미터 수**: **7.6 Billion (7.6B)**
- **양자화 (Quantization)**: **`Q4_K_M`** (고품질 4비트 양자화)
- **최대 문맥 길이 (Context Length)**: **32,768 tokens (32K)**
- **임베딩 차원 (Embedding Length)**: 3,584
- **측정 생성 속도 (AMD RX 6600 가속)**: **`44.72 tokens/sec`** *(응답 소요 시간: 4.09초)*
- **주요 기능**: 코딩, 파이썬/웹 개발, 한국어 자연어 대화, 문서 요약, 도구(Tools) 호출

---

### 🔵 2) DeepSeek-R1 (8B) — 심층 논리 추론 (Reasoning) 모델
- **모델 ID**: `6995872bfe4c`
- **파일 용량**: **5.2 GB**
- **아키텍처**: `Qwen3 (DeepSeek-R1 Distill Qwen 8B)`
- **파라미터 수**: **8.2 Billion (8.2B)**
- **양자화 (Quantization)**: **`Q4_K_M`** (고품질 4비트 양자화)
- **최대 문맥 길이 (Context Length)**: **131,072 tokens (131K / 128K)**
- **임베딩 차원 (Embedding Length)**: 4,096
- **측정 생성 속도 (AMD RX 6600 가속)**: **`38.64 tokens/sec`**
- **주요 기능**: 심층 논리 추론 (`<think>` 태스크), 수학 증명, 복잡한 알고리즘 분석
- **기본 파라미터**: `temperature = 0.6`, `top_p = 0.95`

---

## ☁️ 2. 클라우드 AI 에이전트 모델 명세 (Google Antigravity)

| 모델명 | 서비스 | 플랜 | 주요 역할 및 특징 |
| :--- | :--- | :--- | :--- |
| **Gemini 3.6 Flash** | Google Antigravity | Google AI Pro (High Limit) | 초고속 종합 에이전트, 파일 조작, 코딩, 이미지 생성 |
| **Gemini 3.6 Pro** | Google Antigravity | Google AI Pro (High Limit) | 대형 코드베이스 분석 및 복잡한 아키텍처 설계 |

---

## 📊 3. 모델별 비교 및 벤치마크 표

| 모델명 | 사양 구분 | 용량 / 파라미터 | 양자화 | 문맥(Context) | 생성 속도 |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Qwen 2.5 7B** | 로컬 (Ollama) | 4.7 GB / 7.6B | Q4_K_M | 32,768 (32K) | **44.72 tps** |
| **DeepSeek-R1 8B** | 로컬 (Ollama) | 5.2 GB / 8.2B | Q4_K_M | 131,072 (131K) | **38.64 tps** |
| **Gemini 3.6 Flash** | 클라우드 | 대형 거대 모델 | - | 1,000,000+ | 초고속 실시간 |

---

## 🔗 관련 문서
- [[💻 PC 상세 하드웨어 사양 및 가속 환경]]
- [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]]
- [[📚 인덱스]]
