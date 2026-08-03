# 🦸 Claude 슈퍼파워 설정

> 설치 완료: 2026-04-11

## 설치된 플러그인 5종

| 플러그인 | 버전 | 용도 |
|---------|------|------|
| **gstack** | ~최신 | CEO/엔지니어/디자이너 역할 전환 |
| **Superpowers** | 5.0.7 | TDD, 체계적 개발 워크플로우 |
| **oh-my-claudecode** | 4.11.4 | 멀티 에이전트 팀 오케스트레이션 |
| **context7** | 최신 | 라이브러리 최신 문서 실시간 주입 |
| **github** | 최신 | GitHub 레포/PR/이슈 직접 제어 |
| **serena** | 최신 | 코드 의미 분석 및 리팩터링 |

---

## gstack — 역할 기반 판단

Garry Tan(Y Combinator CEO)이 만든 셋업. 하나의 Claude가 여러 전문가 역할로 전환.

```
/plan-ceo-review      — CEO 시각으로 아이디어/계획 검토
/plan-eng-review      — 엔지니어링 관점 구현 계획 리뷰
/plan-design-review   — 디자이너 시각 리뷰
/qa                   — QA 리드로 버그 찾고 수정
/ship                 — 릴리즈 매니저로 배포
/health               — 코드 품질 점수
/investigate          — 버그 원인 추적
/review               — PR 코드 리뷰
/browse               — 실제 브라우저로 웹사이트 테스트
/cso                  — 보안 감사
```

---

## Superpowers — TDD 개발 워크플로우

Jesse Vincent(obra)가 만든 체계적 개발 방법론.

### 핵심 워크플로우
```
1. /brainstorm   — 아이디어 브레인스토밍
2. /write-plan   — 구현 계획 작성
3. /execute-plan — 계획 실행 (TDD 방식)
```

### 내장 스킬들
- `test-driven-development` — 진짜 TDD (빨강→초록→리팩터)
- `systematic-debugging` — 체계적 버그 추적
- `subagent-driven-development` — 서브에이전트로 코드 작성
- `requesting-code-review` — 코드 리뷰 요청
- `brainstorming` — 구조적 브레인스토밍
- `writing-plans` — 명확한 구현 계획
- `using-git-worktrees` — Git 워크트리 활용

---

## oh-my-claudecode (OMC) — 멀티에이전트 팀

19개의 전문 에이전트가 팀처럼 협업.

### 에이전트 목록
| 에이전트 | 역할 |
|---------|------|
| `architect` | 시스템 설계 |
| `planner` | 작업 계획 |
| `executor` | 코드 실행 |
| `code-reviewer` | 코드 리뷰 |
| `debugger` | 버그 수정 |
| `qa-tester` | QA 테스트 |
| `security-reviewer` | 보안 검토 |
| `designer` | UI/UX |
| `writer` | 문서 작성 |
| `analyst` | 데이터 분석 |
| `scientist` | 연구/실험 |
| `critic` | 비판적 검토 |
| `verifier` | 결과 검증 |
| `tracer` | 코드 추적 |
| `git-master` | Git 작업 |
| `explore` | 코드 탐색 |

---

## 세 가지를 함께 쓰는 방법

```
gstack  → "무엇을, 왜?" 결정 (CEO/엔지니어 판단)
Superpowers → "어떻게 만들까?" 실행 (TDD 워크플로우)
OMC     → "누가 맡을까?" 팀 구성 (멀티에이전트)
```

### 실전 예시
```
새 기능 만들 때:
1. /plan-ceo-review  → CEO로 아이디어 검증
2. /brainstorm       → 아이디어 구체화
3. /write-plan       → 구현 계획
4. /execute-plan     → TDD로 개발
5. /review           → 코드 리뷰
6. /ship             → 배포
```

---

## 설치 명령어 (재설치 시)

```bash
claude plugin marketplace add obra/superpowers-marketplace
claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode
claude plugin install superpowers@superpowers-marketplace
claude plugin install oh-my-claudecode@omc
```

현재 상태 확인:
```bash
claude plugin list
claude mcp list
```
