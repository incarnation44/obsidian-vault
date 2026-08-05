---
title: ⚡ Antigravity & 로컬 AI (Ollama) 세팅 및 사용 가이드
tags:
  - antigravity
  - local-ai
  - ollama
  - deepseek
  - qwen
  - mcp
date: 2026-08-03
---

# ⚡ Antigravity & 로컬 AI (Ollama) 세팅 및 사용 가이드

이 문서는 **Antigravity AI 에이전트**와 **컴퓨터 내 로컬 AI 시스템(Ollama)**의 세팅 내역, 성능 검증 결과, 그리고 사람과 다른 AI 에이전트가 쉽게 읽고 활용할 수 있도록 정리한 가이드입니다.

---

## 🖥️ 1. 하드웨어 사양 및 가속 환경

* **CPU**: AMD Ryzen 5 5600XT (6 Cores / 12 Threads)
* **GPU**: **AMD Radeon RX 6600 (VRAM 8GB)** ➔ ROCm/DirectML 기반 GPU 가속 적용
* **RAM**: **32 GB** (대형 14B급 모델 연산 가능)
* **저장공간**: C드라이브 여유공간 368 GB+

---

## 🛠️ 2. 구축된 로컬 AI 엔진 & 모델 정보

### ⚙️ 로컬 AI 엔진: Ollama
* **버전**: v0.32.5
* **서비스 데몬**: `ollama serve` (포트 `http://localhost:11434` 대기 중)
* **비용**: **0원 (100% 무료 / 무제한 사용)**

### 📦 설치 및 업그레이드 모델 상세

| 모델명 | 파라미터 / 타입 | 주요 특징 및 업그레이드 이점 |
| :--- | :--- | :--- |
| **`qwen3.8` / `qwen2.5:7b`** | 7B~8B / General & Coding | **`44.72 tps`** 한국어 및 자율 코딩, 문서 요약, 일반 대화 (Qwen3.8 업그레이드 시 한국어 표현 및 코딩 추론 능력 대폭 향상) |
| **`deepseek-r1:8b`** | 8B / Deep Reasoning | **`38.64 tps`** 깊은 심층 논리 추론, 복잡한 코드 및 알고리즘 분석 |

#### 🚀 Qwen 모델 업그레이드 방법 (Ollama)
다른 컴퓨터(학원 PC 등)나 현재 PC에서 최신 Qwen 모델로 업그레이드할 때 파워셸(PowerShell)에서 아래 명령어를 실행합니다:
```bash
ollama pull qwen3.8
# 또는
ollama run qwen3.8
```
* **업그레이드 장점**:
  1. **한국어 품질 향상**: 번역투가 감소하고 자연스러운 한국어 표현력 대폭 강화
  2. **코딩 및 에러 해결 능력 강화**: 복잡한 파이썬, JS 코드 작성 및 디버깅 성능 향상
  3. **심층 추론 능력 발전**: 논리적인 복합 문제 해결 능력 증대
  4. **RX 6600 GPU 가속 최적화**: VRAM 8GB / RAM 32GB 환경에서 속도 지연 없이 최상의 효율 발휘

---

## 📁 3. 워크스페이스 및 코드 파일 구조

- **작업 전용 폴더**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`
- **주요 파일**:
  - `README.md`: 작업 가이드 및 명령어 예시
  - `test_local_ai.py`: 로컬 AI 응답 속도(tokens/sec) 벤치마크 테스트 스크립트
  - `local_ai_agent.py`: 파이썬 프로그램에서 로컬 AI를 쉽게 호출하는 클래스 모듈

---

## 🤖 4. AI & 사람을 위한 활용 방법

### 1) Antigravity 대화창에서 활용하는 방법
Antigravity 대화창에서 아래와 같이 요구사항을 편하게 작성하면 AI가 즉시 수행합니다:
* *"로컬 AI(Qwen) 사용해서 파이썬 웹 스크래퍼 코드 작성해줘."*
* *"DeepSeek 추론 모델 써서 이 복잡한 로직 분석해줘."*
* *"내 컴퓨터 폴더 안의 파일들을 확장자별로 정리해줘."*

### 2) 파이썬 코드로 로컬 AI 호출하는 방법 (API)
```python
from local_ai_agent import LocalAIAgent

agent = LocalAIAgent(default_model="qwen2.5:7b")
response = agent.ask("파이썬 코딩 팁 3가지 알려줘.")
print(response)
```

---

## 🔒 5. 보안 및 시스템 특이사항
1. **데이터 유출 없음**: 모든 로컬 AI 연산은 사용자의 PC 내부(`localhost:11434`)에서만 수행됩니다.
2. **시스템 부담 소모 없음**: 대기 중(`ollama serve`)일 때는 CPU/GPU 점유율이 0%에 가까우며, 질문 처리 시에만 순간 가속됩니다.

---

*최종 업데이트: 2026-08-03 | 작성: Antigravity AI Agent*
