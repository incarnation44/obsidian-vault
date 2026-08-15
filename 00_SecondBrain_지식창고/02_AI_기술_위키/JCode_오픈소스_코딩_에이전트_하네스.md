# 🚀 JCode (j-code) - 오픈소스 AI 코딩 에이전트 하네스

> **출처**: [YouTube Shorts (enFgYQvI1dM)](https://youtube.com/shorts/enFgYQvI1dM)  
> **등록일**: 2026-08-07  
> **태그**: `#AI` `#CodingAgent` `#Rust` `#OpenSource` `#JCode`

---

## 📌 개요
**JCode(j-code)**는 Rust로 재설계된 초경량, 고성능 오픈소스 AI 코딩 에이전트 하네스(Harness)입니다.  
Cursor, Claude Code, GitHub Copilot 등 유료 코딩 에이전트의 높은 리소스 사용량과 성능 병목을 해결하기 위해 개발되었습니다.

---

## 🔑 주요 특징 및 성능 주장
1. **Rust 기반 초경량 하네스**
   - 에이전트의 프롬프트, 세션, 메모리를 조율하는 코어 하네스 레이어를 Rust로 작성.
   - Claude Code 대비 **메모리 효율 20배 향상**.
   - Codex 대비 **처리 속도 63배 향상**.
2. **멀티 세션 & Swarm 에이전트 협업**
   - 여러 개의 코딩 세션을 성능 저하 없이 동시 구동 가능.
   - 메인 에이전트와 하위 작업 에이전트가 단일 코드베이스에서 분담 작업 지원.
3. **인터페이스 & 모델 자유도**
   - CLI(터미널), 데스크톱 앱, 브라우저 UI 지원.
   - OpenAI 호환 API 및 로컬 Ollama (`qwen2.5:7b`, `deepseek-r1:8b` 등) 연동 가능.
   - MIT 라이선스 오픈소스 (GitHub `1jehuang/jcode`).

---

## ⚖️ Antigravity와의 차이점
- **JCode**: AI 모델 자체가 아닌 **Rust 기반 세션 실행 프레임워크(하네스)**. 로컬 AI와 조합 시 오프라인/무료 구축에 강점.
- **Antigravity**: Google DeepMind 기반 **통합 에이전트 서비스**. 대용량 추론, 멀티모달(이미지 생성/UI), 브라우저 제어(Playwright), 옵시디언 자율 관리 등 광범위한 업무 자동화 지원.

---

## 🔗 상호 링크
- [[00_SecondBrain_지식창고/00_지식창고_대시보드|🧠 지식창고 대시보드]]
- [[01_AI_시스템_및_도구/AI_에이전트_및_도구_통합_마스터_가이드|🤖 AI 에이전트 및 도구 통합 마스터 가이드]]

## 같이 볼 노트
- [[01_AI_시스템_및_도구/OpenCode_오픈소스_AI_코딩에이전트_완전분석]]
- [[01_AI_시스템_및_도구/Hermes_Agent_분석_및_Antigravity_v3_통합_아키텍처]]
