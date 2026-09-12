---
title: AI Coding Skills Landscape (2026-09)
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [ai-coding, skills, ponytail, ecc, adhd, context-optimization]
sources: [raw/transcripts/top-10-repos-adhd-ponytail.md]
confidence: high
---

# AI Coding Skills Landscape (2026-09)

The Next New Thing 라운드업 기준, 현재 AI 코딩 에이전트 품질을 결정하는 핵심 스킬/도구 생태계 요약.

## 3대 필수 스킬 축 (The Big Three)

### 1. I Have ADHD — 간결성 강제 (Conciseness Enforcement)
- **GitHub**: https://github.com/ayghri/i-have-adhd
- **역할**: AI의 장황한 설명을 차단하고 팩트/액션만 출력하게 함.
- **적용**: 시스템 프롬프트 또는 스킬로 주입. "벽돌 텍스트 금지" 규칙 자동화.

### 2. ECC (Engineering Process) — 프로세스 주입 (Process Injection)
- **GitHub**: https://github.com/affaan-m/ECC
- **역할**: Plan → Test → Build → Review 순서 강제. "생각 없이 짜기" 방지.
- **배경**: Anthropic 해커톤 우승자 플레이북. 제품 수준 코드 품질 보장.

### 3. Ponytail — 전략적 게으름/단순함 (Strategic Laziness / Simplicity)
- **GitHub**: https://github.com/DietrichGebert/ponytail
- **역할**: 기존 라이브러리/브라우저 API/표준 기능 우선 사용. 과설계(Over-engineering) 차단.
- **핵심**: "포니테일 형님" 마인드셋 — 유지보수 비용 최소화, 토큰 절약, 런타임 의존성 축소.

---

## 차세대 패러다임: OpenAI Plugins
- **OpenAI Skills → Deprecated**. Plugins로 대체.
- **차이점**: 스킬 = 프롬프트 주입 / Plugins = 구조화된 툴 스키마 + 권한 게이트 + 버전 관리 + 마켓플레이스.
- **의미**: 에이전트 기능 확장이 "프롬프트 엔지니어링"에서 "타입 안전한 툴 레지스트리"로 이동.

---

## 컨텍스트 최적화 도구
| 도구 | 접근법 |
|------|--------|
| **Context Mode** | 도구 출력을 컨텍스트 밖 로컬 인덱스에 저장, 필요 시 검색 |
| **RTK** (이전 영상) | 터미널 출력을 DB 필터링 후 컨텍스트 전달 |
| **Headroom** | 도구 출력을 압축해 컨텍스트 진입 전 용량 축소 |
| **Magic Compact** | 컨텍스트를 디스크로 이동, 무손실 압축 |

---

## 실전 적용 가이드 (Hermes Agent 기준)

1. **ADHD 스킬 설치** → `hermes skill install ayghri/i-have-adhd` (또는 유사 스킬)
2. **Ponytail 원칙 내재화** → 시스템 프롬프트에 "최소 변경, 기존 코드 재사용, 표준 API 우선" 명시
3. **ECC 워크플로 채택** → `/plan` → `/test` → `/build` → `/review` 슬래시 커맨드 또는 스킬로 루틴화
4. **Context Mode/RTK 연동** → 대형 리팩토링 시 컨텍스트 폭발 방지

---

## 관련 문서
- [[hermes-agent-skills]]
- [[llm-wiki-architecture]]
- [[ai-agency-business-model]]
