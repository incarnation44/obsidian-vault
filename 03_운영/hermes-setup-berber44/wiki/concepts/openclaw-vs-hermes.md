---
title: OpenClaw vs Hermes Agent — Comparison & Decision Guide
created: 2026-09-12
updated: 2026-09-12
type: concept
tags: [ai-agents, openclaw, hermes-agent, comparison, security, curator]
sources: [raw/transcripts/openclaw-vs-hermes-agent.md]
confidence: high
---

# OpenClaw vs Hermes Agent — 비교 및 선택 가이드

두 오픈소스 AI 에이전트의 핵심 차이, 장단점, 보안 이력, 사용자 프로필별 추천을 정리.

## 설계 철학 차이

| 차원 | OpenClaw | Hermes Agent |
|------|----------|--------------|
| **핵심 베팅** | 커뮤니티 카탈로그 (ClawHub) | 에이전트 자기 개선 (Curator) |
| **스킬 획득** | 마켓플레이스에서 원클릭 설치 | 작업 수행 중 자동 생성·축적 |
| **스킬 승인** | 기본 수동 승인 (Skill Workshop) | 완전 자동 (Curator, v0.12~) |
| **Day-1 툴박스** | 50,000+ 스킬로 두꺼움 | 얇음, 사용하며 두꺼워짐 |
| **프로바이더** | 50+ 네이티브 지원 | 기본 6종 + OpenRouter 경유 |
| **기본 UI** | 웹 대시보드 기본 탑재 | CLI 우선, 대시보드 별도 설치 |

---

## 보안 이력 비교 (2026년 기준)

### OpenClaw
- **CVE 130+ 건** (2026년 2~4월 집중). 고위험 RCE 포함.
- **ClawHub 악성 스킬 1,000+ 개** 플래그.
- **대응**: 신뢰 퍼블리셔만 설치, 버전 최신 유지 필수.

### Hermes
- **CVE 12+ 건** (2026년 전체). 4월 감사 Critical 4, High 9 패치됨.
- 서드파티 마켓플레이스 없음 → 공격 표면 본질적으로 작음.

> **공통**: 최신 버전 유지가 최선의 방어. VPS 격리 권장.

---

## 비용 구조
- 서버 비용: 동일 (VPS/자체 하드웨어)
- 모델 비용: 동일 (같은 모델, 프롬프트 캐싱 ~90%)
- **차이**: 반복 작업 시 Hermes가 Curator로 조기 비용 평탄화. 다양한 일회성 작업이면 비슷.
- 월 $20 이하 운영 가능 (가장 저렴한 모델 기준).

---

## 사용자 프로필별 추천

### 🎯 Profile A: 첫 에이전트, 개인 비서, 장기 사용
> **추천: Hermes**
> - Curator가 자동으로 내 업무 패턴 학습·스킬화
> - 설정 마찰 최소, 기본값이 실용적
> - 오래 쓸수록 복리 효과

### 🎯 Profile B: 기성 스킬 마켓플레이스, 대시보드, 프로바이더 다양성
> **추천: OpenClaw**
> - 50,000+ 스킬 원클릭, 웹 UI 즉시 사용
> - 50+ 프로바이더 네이티브, 세밀 설정 가능
> - **단, 보안 위생(업데이트, 신뢰 퍼블리셔만) 필수**

### 🎯 Profile C: 매일 같은 반복 작업 자동화·비용 절감
> **추천: Hermes**
> - 반복 작업 자동 스킬화 → 이후 거의 무료 실행
> - OpenClaw Skill Workshop은 승인 대기→절감 실현 지연

---

## Hermes 사용자 메모 (berber44 프로필)
- 현재 Hermes는 **Curator 자동 학습 루프**가 핵심 자산.
- `noir` 스킨 등 커스텀 설정은 `~/wiki` 위키와 연계해 영구 자산화.
- OpenClaw의 ClawHub 같은 외부 마켓플레이스 의존도 없음 → 공급망 공격 리스크 낮음.
- `hermes-agent` 스킬의 `references/themes.md`대로 스킨 직접 제작·적용 가능.

---

## 관련 문서
- [[hermes-agent]]
- [[hermes-agent-skills]]
- [[llm-wiki-architecture]]
