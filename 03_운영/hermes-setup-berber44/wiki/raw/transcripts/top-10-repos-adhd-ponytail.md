---
source_url: https://youtu.be/aX8Y183qDpY?si=6Q-qyEPBHuWDc-Us
ingested: 2026-09-12
---

# Video: Top 10 Repos explained: ADHD, Ponytail, and more

The Next New Thing 채널의 Andrew Warner와 Adam이 선정한 AI 코딩을 더 똑똑하고 심플하게 만드는 GitHub 레포 10선 + 청중 제출작 4선.

## 핵심 레포지토리 10선

### 1. I Have ADHD (https://github.com/ayghri/i-have-adhd)
- **문제**: AI가 장황한 벽돌 텍스트를 뱉어내 사용자가 핵심을 놓침.
- **해결**: AI에게 "ADHD 환자 대하듯" 핵심만 간결하게 전달하도록 강제하는 스킬.
- **효과**: 토큰 절약, 가독성 향상, 프롬프트마다 "간결하게 말해줘" 반복 불필요.

### 2. ECC (Engineering Process for AI Coders) (https://github.com/affaan-m/ECC)
- **컨셉**: Plan → Test → Build → Review 순서의 엔지니어링 프로세스를 AI에 주입.
- **배경**: Anthropic 해커톤 우승자의 Claude Code 플레이북 공개.
- **대상**: 제품 개발/엔지니어링 마인드셋이 부족한 바이브 코더에게 품질과 속도 동시 확보.

### 3. Ponytail (https://github.com/DietrichGebert/ponytail)
- **핵심 철학**: "전략적 게으름(Strategic Laziness)" — 노련한 개발자(포니테일 형님)는 바퀴를 재발명하지 않고 기존 브라우저 API, 라이브러리, 심플한 솔루션을 씀.
- **예시**: Date picker 요청 시 flatpickr + 래퍼 + 스타일시트 + 타임존 논의(아마추어) vs `<input type="date">` 한 줄(포니테일).
- **효과**: 코드 베이스 경량화, 유지보수성 확보, 토큰 대폭 절감.

### 4. Zapier MCP (https://zapier.com/dk)
- 8,000+ 툴과 에이전트 연결을 위한 MCP 서버 + SDK 제공.

### 5. HumanLayer Skills (https://github.com/humanlayer/skills)
- 5개 소형 애드온. 핵심: **Claude Code가 CLAUDE.md 규칙을 무시하는 버그 수정** — 규칙을 조건부 트리거로 재작성해 관련 있을 때만 발동.

### 6. OpenAI Plugins (https://github.com/openai/plugins)
- Codex용 플러그인 생태계. 스킬보다 진화된 형태로, 구조화된 툴 호출과 권한 관리 내장.

### 7. Archify (https://github.com/tt-a1i/archify)
- 코드와 프로세스를 시각적 다이어그램(아키텍처, 플로우차트)으로 자동 변환.

### 8. Context Mode (https://github.com/mksglu/context-mode)
- 도구 실행 결과를 컨텍스트 윈도우에 넣지 않고 로컬 인덱스에 저장해 토큰 절약.

### 9. Matt Pocock Skills (https://github.com/mattpocock/skills)
- TypeScript 권위자 Matt Pocock이 만든 실용 스킬 모음.

### 10. Humanizer (https://github.com/blader/humanizer)
- AI 문체를 인간적으로 다듬는 스킬 (한국어 natural-writing 가이드와 유사 목적).

### 11. OpenAI Skills (https://github.com/openai/skills) — **Deprecated**
- OpenAI가 스킬을 폐기하고 Plugins로 대체함.

## 청중 제출작 (Audience Submissions)

- **Reckoner** (https://github.com/CaptainASIC/reckoner): 멀티 프로바이더 AI 청구 모니터링 대시보드 (한눈에 잔액/경고 확인).
- **Tim Harris Skills** (https://github.com/timharris707/skills): 코드 안 읽는 사람을 위한 23개 스킬.
- **Clodex** (https://github.com/Aotricx/Clodex): Claude Code 터미널 유지하며 내부 모델을 GPT로 교체.
- **AI Marketing Panel** (https://github.com/rodaddy/ai-marketing-panel): 가상 페르소나(임산부, 마라토너 등)로 마케팅 카피 사전 검증.

---

## 요약 인사이트 (Minto Pyramid)
**"AI 코딩의 품질은 '스킬/프로세스 주입'으로 결정된다: ADHD(간결성), ECC(엔지니어링 프로세스), Ponytail(전략적 게으름/단순함)이 3대 핵심 축이며, OpenAI는 스킬을 폐기하고 Plugins로 진화했다."**

## 파인만 비유 (ELI5)
> 초보 요리사(AI)에게 "맛있게 해"라고만 하면 재료 다 때려넣고 난장판이 됩니다.  
> **ADHD 스킬** = "간만 맞춰, 군더더기 빼"  
> **ECC 스킬** = "레시피 보고 → 재료 손질 → 조리 → 시식 순서대로 해"  
> **Ponytail 스킬** = "냉장고에 있는 걸로 제일 쉽게 해, 새로 사지 마"  
> 이 세 가지만 챙겨줘도 요리(코드)가 먹고 쓸 만해집니다.
