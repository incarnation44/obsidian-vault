# 🔑 API 키 및 연동 서비스 관리

## 🌟 Google Gemini API (공식 최신 AI 추론)
- **등록 모델**: `gemini-3.6-flash`, `gemini-3.5-flash`, `gemini-flash-latest`
- **주요 용도**: Discord Personal AI Agent v2 메인 브레인 (초고속 한국어 추론, 24시간 실시간 대화) & Antigravity IDE
- **상태**: 활성화 완료 (Active ✅)

---

## 🚀 Groq API (초고속 LPU AI 추론)
- **발급일**: 2026-08-07
- **주요 특징**: 초당 500 ~ 1,500+ 토큰 초고속 추론 (Llama 3.3 70B 등)
- **상태**: 활성화 완료 (Active ✅)

---

## 🌌 xAI Grok API (시스템 전역 등록)
- **등록일**: 2026-08-11
- **환경 변수**: `XAI_API_KEY`, `GROK_API_KEY` (시스템 User 환경 변수 등록 완료)
- **연동 도구**: OpenCode, Grok CLI (`~/.config/opencode/config.json`), 프로젝트 `.env`
- **상태**: 인증 정상 확인 완료 (Active ✅)

---

## ⚡ 로컬 Ollama 세팅 현황
- **엔드포인트**: `http://localhost:11434`
- **버전**: `v0.32.7` (최신 업데이트 완료)
- **GPU 가속**: AMD Radeon RX 6600 8GB Vulkan 백엔드 활성화
- **설치 모델**:
  - `qwen2.5:7b` (37~88 tps / 일반 대화 및 코딩)
  - `deepseek-r1:8b` (38.64 tps / 심층 논리 추론)
  - `qwen2.5-coder:7b` (코딩 특화)
- **주요 용도**: 외부 인터넷/API 장애 시 100% 오프라인 로컬 Fallback 엔진

---

## 🌙 Moonshot Kimi Code CLI
- **버전**: `v0.34.0` (`kimi.exe`)
- **셸 환경 변수**: `KIMI_SHELL_PATH = C:\Program Files\Git\bin\bash.exe`
- **상태**: 설치 및 터미널 연동 완료 (Active ✅)

---

## 🤖 Discord AI Bot 인프라
- **Bot Name**: `제미나이#2585` (App ID: `1534724905621262446`)
- **실행 스크립트**: `C:\bots\discord_bot.py`
- **상주 모드**: Windows 시작프로그램 백그라운드 자동 상주 (`pythonw.exe`)
- **보안 및 락**: 싱글톤 소켓 락 (Port 19876), 비동기 유저 락
