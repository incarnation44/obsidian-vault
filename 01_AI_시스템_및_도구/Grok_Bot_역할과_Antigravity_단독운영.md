---
created: 2026-08-15
updated: 2026-08-15
tags:
  - GrokBot
  - Antigravity
  - 세팅
---

# Grok 봇 역할과 Antigravity 단독 운영

2026-08-15에 전일도 PC 기준으로 나눈 역할. 요금 숫자는 [[Grok_4.6_초가성비_성능분석_및_요금_한국원화_환산_가이드]] 가 원본이다.

## 한 줄
Grok 봇은 화면을 안 막고 옵시디언·파일·웹·백그라운드를 한다. Antigravity는 이 Windows PC의 Gemini IDE다. GCP·노트북은 그쪽에서 한다.

## Grok 봇이 하는 일
- 옵시디언 `C:\전일도` 노트 작성·정리 (묻지 않고)
- 바탕화면·D: 파일, 웹 조사, 유튜브 아카이브
- 루틴(시간 맞춰 깨우기), 클라우드 PR 에이전트
- 이식해 둔 워크플로 13개: 아카이브, 옵시디언, 웹 분기, 프론트, UI UX Pro Max, 스크롤스토리, 그래프 오케스트레이션, 코드그래프, chunkless-rag, 파이썬, 데이터손실 방지, ML, 유튜브

## Grok 봇이 안 하는 일
- BigQuery, Cloud SQL 관리, 노트북 셀 실행
- Antigravity 전용 메모리·스킬 설치 위치 대신 쓰기
- 로컬 Ollama 추론. `http://localhost:11434` 의 `qwen2.5:7b`, `deepseek-r1:8b` 는 설치 사실만. 시키면 그때만
- git push. 깃허브에 올리라고 분명히 말할 때만
- 볼트 `.agents` 삭제. 그건 gstack 팩이고 Antigravity 스킬(`.gemini\config\skills`)과 다름

## Antigravity가 혼자 돌아가게 해 둔 것
Grok 봇이 유료로 막혀도 로컬 Antigravity는 아래만 보면 된다.

- 헌법(동일 내용): `C:\Users\ildoc\.gemini\config\rules\GEMINI.md` 와 `C:\전일도\GEMINI.md`
- 포인터: `C:\Users\ildoc\.gemini\config\GEMINI.md`
- 워크스페이스: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\`
  - `ANTIGRAVITY_STANDALONE.md`
  - `AGENTS.md`
  - `README.md`
  - `core\chunkless_tree_rag.py` (폴백)
- MCP는 기존처럼 Playwright + Cloud SQL
- 매일 쓰는 쪽은 Antigravity. Grok을 기다리거나 넘기지 말 것

## 미디어·자료 위치
- 코드 아닌 사진·자료는 D: (`D:\사진`, `D:\개인자료`)
- 오늘 예외: 공부 HTML/PDF와 베팅 캡처는 바탕화면. 전일도가 거기를 지정함

## 관련
- [[Grok_Bot_클라우드_자율에이전트_분석_및_Antigravity_비교]]
- [[Grok_4.6_초가성비_성능분석_및_요금_한국원화_환산_가이드]]
- [[05_일일_리포트/2026-08-15]]
- [[인덱스]]
