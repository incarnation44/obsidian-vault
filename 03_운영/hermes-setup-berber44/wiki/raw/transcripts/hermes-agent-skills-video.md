---
source_url: https://youtu.be/WJgxX0Eib6k?si=VQsrAjCjgdSeGapc
ingested: 2026-09-11
---

# Video: Hermes Agent Skills That Make It 10x More Powerful

## 6대 핵심 스킬 요약
1. **Planning with Files**
   - 긴 대화에서 맥락 분실(Opus 모델 등)을 막기 위해 `task_plan.md`, `findings.md`, `progress.md` 3개 파일로 할 일을 구조화.
   - Hermes의 훅(Hook) 기능을 사용해 이 파일들을 컨텍스트에 강제 삽입하여 이탈 방지.
2. **Delegate Setup**
   - Hermes를 총괄 오케스트레이터로 활용하여 Claude Code, Codex, Cursor 등 시스템에 설치된 타 에이전트에 일감을 배분하고 통합 보고서 수령.
3. **RTK (Terminal Output Filter)**
   - 터미널 출력값의 90%에 달하는 불필요한 노이즈를 필터링하여 컨텍스트 낭비 최소화.
4. **Mantis**
   - Google의 보안 검토 툴셋으로 모바일/웹 보안 감사 수행. Hermes의 상시 크론(Cron)으로 실행하여 자동화하기에 적합.
5. **Agent Reach**
   - Reddit, GitHub, Twitter 등 수집이 제한된 플랫폼에 우회 접근하여 실 사용자 경험 및 상세 정보 수집.
6. **Skill Retriever**
   - 모든 스킬 정보를 컨텍스트에 주입하는 대신 질의와 가장 일치하는 스킬만 골라 주입. 매 턴 9,000토큰 이상 절약 효과.
