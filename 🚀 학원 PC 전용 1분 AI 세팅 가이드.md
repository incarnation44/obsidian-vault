---
title: 🚀 학원 PC 전용 1분 AI 세팅 가이드
tags:
  - academy-pc
  - setup
  - local-ai
  - ollama
  - antigravity
  - automation
date: 2026-08-03
---

# 🚀 학원 PC 전용 1분 AI 세팅 가이드

9월에 컴퓨터 학원에 가서 **새 학원 PC에서 1분 만에 앤티그래피티(Antigravity) + 무료 로컬 AI(Ollama + Qwen + DeepSeek) 세팅을 완료하는 가이드**입니다.

---

## ⚡ 1단계: 학원 PC 도착 시 단 1줄 실행하기 (자동 설치)

학원 PC의 **PowerShell(파워셸)**을 열고 아래 1줄 명령어를 복사해서 실행하면 설치부터 AI 모델 다운로드, 가속 세팅까지 1분 만에 자동으로 끝납니다:

```powershell
git clone https://github.com/incarnation44/obsidian-vault.git C:\전일도; powershell -ExecutionPolicy Bypass -File "C:\전일도\setup_academy_pc.ps1"
```
*(또는 옵시디언 볼트 폴더 `C:\전일도\setup_academy_pc.ps1` 파일을 오른쪽 클릭 ➔ [PowerShell로 실행] 클릭)*

---

## 🛠️ 자동 세팅되는 항목들

1. **Ollama (무료 로컬 AI 엔진)** 자동 다운로드 및 설치
2. **`ollama serve` 데몬** 백그라운드 자동 실행
3. **Qwen 2.5 (7B)** 모델 자동 다운로드 (초고속 코딩/한국어)
4. **DeepSeek-R1 (8B)** 모델 자동 다운로드 (깊은 추론 모델)
5. **학원 PC 작업 폴더 생성**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace`
6. **파이썬 속도 테스트 스크립트(`test_local_ai.py`)** 자동 복사

---

## 🤖 2단계: 앤티그래피티(Antigravity) 켜서 사용하기

학원 PC에서 **Antigravity**를 켜고 저에게 아래처럼 말씀하시면 바로 실행됩니다:

* *"학원 PC 로컬 AI 세팅 잘 완료됐는지 파이썬으로 테스트해줘"*
* *"오늘 학원 수업 내용 파이썬 코딩 작성해줘"*
* *"오늘 공부한 내용 요약해서 내 깃허브(GitHub)에 업로드해줘"*

---

## 💾 3단계: 학원 PC 이동 시 챙겨갈 유용한 지품 (체크리스트)

- [ ] **GitHub 계정 로그인 정보** (학원 PC에서 `git push` 등록용)
- [ ] **옵시디언 볼트(`C:\전일도`) 폴더** (구글 드라이브 / USB / 깃허브로 백업해가기)
- [ ] **Antigravity 프로그램 실행 파일**

---

## 🔗 관련 노트
- [[⚡ Antigravity & 로컬 AI(Ollama) 세팅 및 가이드]]
- [[🛠️ 설치된 도구 목록]]
- [[📚 인덱스]]
