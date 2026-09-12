---
source_url: https://youtu.be/MT73AqiDI94?si=yQjji8P-fvn1pD07
ingested: 2026-09-12
---

# Video: Are More Bots Better? 🧠 How I Level Up My Hermes Agent Team

Wanderloots(Callum)가 설명하는 Hermes Bot 모드 기반 전문가 에이전트 팀 고도화 및 LLM Wiki 연동 실전 워크플로.

## 1. 봇 개수보다 '전문성(Specialization)'이 핵심
- 에이전트(봇) 수만 늘린다고 팀 성과가 좋아지지 않음.
- 파운더/기획자 에이전트의 지시를 받는 **전문가 봇(Specialist Bot)**에 구조화된 스킬과 전용 도구(MCP, 외부 DB)를 주입해야 전체 팀의 보고서 및 코드 품질이 급상승함.

## 2. Researcher 에이전트에 주입한 3대 강화 스킬
1. **체계적 리서치 방법론 스킬 (LLM Wiki Research)**:
   - 학술 연구(Academic), 현재 현실(Current Reality), 미래 과제(Open Questions) 렌즈로 자료를 멀티 앵글 분석하는 구조화 가이드라인.
2. **Zotero 레퍼런스 연결 스킬**:
   - 개인 학술 논문/PDF 라이브러리인 Zotero DB와 연동하여 에이전트가 사용자가 이미 수집한 신뢰 자료를 직접 조회·인용.
3. **Consensus MCP 연동 스킬**:
   - Consensus AI 논문 검색 MCP 서버와 연동하여 최신 학술 논문 및 검증된 학술 지식을 자동으로 발견·비교.

## 3. 에이전트 팀 루프 (Collaborative Loop)
- **사용자 / Orchestrator**: 연구 주제 하사 (예: "에이전트 기억 오염 방지(Agentic Memory Poisoning)").
- **Researcher**: Zotero + Consensus MCP + 리서치 스킬을 가동해 교차 검증된 정밀 보고서 작성 (상충점, 오픈 퀘스천 포함).
- **Orchestrator**: 품질 검증(QA Check). 기준 미달 시 리서처에게 재작성 요청, 통과 시 사용자 승인 요청.
- **Librarian (사서 봇)**: 사용자 승인 완료 시 결과를 **LLM Wiki**에 수집. 기존 개념 문서(`agentic-memory.md`)와 [[위키링크]]로 상호 연결하고 `index.md` / `log.md` 동기화.

## 4. 에이전트 기억 오염(Agentic Memory Poisoning) 방어
- 에이전트에게 검증되지 않은 외부 정보를 무분별하게 메모리로 저장하게 하면 기억 오염이 발생함.
- **해결책**: 인간/Orchestrator가 품질을 검증하는 게이트웨이 레이어를 두고, 검증된 지식만 지식 저장소(LLM Wiki)에 인제스트하는 구조 채택.

## 5. 다음 단계
- 칸반(Kanban) 및 크론/목표(Goal) 루프를 도입해 에이전트 간 주고받기(Handoff) 및 정기 스케줄링 자동화 추진.
