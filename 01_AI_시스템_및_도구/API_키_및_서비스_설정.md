# API 키 및 연동 서비스 관리

## 🌟 Google Gemini API (공식 최신 AI 추론)
- **등록 모델**: `gemini-3.6-flash`, `gemini-3.5-flash`, `gemini-flash-latest`
- **주요 용도**: Discord Personal AI Agent v2 메인 브레인 (초고속 한국어 추론, 24시간 실시간 대화)
- **상태**: 활성화 완료 (Active ✅)

---

## 🚀 Groq API (초고속 LPU AI 추론)
- **발급일**: 2026-08-07
- **주요 특징**: 초당 500 ~ 1,500+ 토큰 초고속 추론 (Llama 3.3 70B 등)
- **상태**: 활성화 완료 (Active ✅)

---

## ⚡ 로컬 Ollama 세팅 현황
- **엔드포인트**: `http://localhost:11434`
- **모델**: `qwen2.5:7b` (44.72 tps), `deepseek-r1:8b` (38.64 tps)
- **주요 용도**: 외부 인터넷/API 장애 시 100% 오프라인 로컬 Fallback 엔진

---

## 🤖 Discord AI Bot 인프라
- **Bot Name**: `제미나이#2585` (App ID: `1534724905621262446`)
- **실행 스크립트**: `C:\bots\discord_bot.py`
- **상주 모드**: Windows 시작프로그램 백그라운드 자동 상주 (`pythonw.exe`)
- **보안 및 락**: 싱글톤 소켓 락 (Port 19876), 비동기 유저 락
