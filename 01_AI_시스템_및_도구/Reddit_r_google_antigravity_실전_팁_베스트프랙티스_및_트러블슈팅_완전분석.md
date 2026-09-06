---
title: Reddit r/google_antigravity 커뮤니티 실전 팁, 베스트 프랙티스 및 트러블슈팅 분석
category: 01_AI_시스템_및_도구
tags:
  - GoogleAntigravity
  - Reddit
  - 커뮤니티팁
  - 컨텍스트관리
  - 베스트프랙티스
  - SpecDriven
created: 2026-09-06
updated: 2026-09-06
source: https://www.reddit.com/r/google_antigravity/
source_date: 2026-09-06
---

# 🌐 Reddit r/google_antigravity 커뮤니티 실전 팁 & 운영 노하우 완전분석

> **출처**: [Reddit r/google_antigravity Subreddit Community Insights](https://www.reddit.com/r/google_antigravity/)  
> **분석일자**: 2026-09-06  
> **보관소 등록일자**: 2026-09-06  

---

## 💡 개요
전 세계 Google Antigravity 개발자들이 모인 공식/비공식 커뮤니티(/google_antigravity)에서 반복적으로 논의되는 **실전 워크플로우 팁, 컨텍스트 오염 방지법, 빈출 에러 및 트러블슈팅 해결책**을 종합 정리함.

---

## 📌 커뮤니티 핵심 워크플로우 팁 (Best Practices)

### 1. Spec-Driven Development (스펙 기반 개발)
* **문제점**: 대화창(Chat history)에만 의존하여 작업을 이어가면 세션이 길어질수록 과거의 실패 접근법을 반복하거나 환각(Hallucination)이 급증함.
* **해결책**: 프로젝트 루트에 항상 SPEC.md 또는 PROJECT_STATUS.md 같은 마크다운 단일 진실 공급원(SSOT)을 유지. 에이전트가 언제든 세션의 목표와 현재 상태를 재참조하도록 강제.

### 2. 전역 규칙(Rules)과 스킬의 비대화(Bloat) 경계
* **주의사항**: 에이전트에게 자동으로 규칙을 짜라고 시키면 쓸데없는 문구가 덕지덕지 붙어 컨텍스트 스마트 존을 낭비함.
* **해결책**:
  * 핵심 규칙(GEMINI.md / ules.md)은 사람이 직접 정밀하고 간결하게 큐레이션할 것.
  * 복잡한 지침은 통째로 프롬프트에 넣지 말고, 필요할 때만 호출되는 단위 스킬(skills/)로 분리할 것.

### 3. 기획-실행 2단계 분리 (The Two-Pass Flow)
* 복잡한 작업을 하나의 프롬프트로 "다 만들어줘" 하고 원샷 요청하지 않음.
* 1단계: 아키텍트/플래너 모드로 기획 및 위협 모델 분석 (implementation_plan.md).
* 2단계: 승인된 계획에 따라 실제 코드 구현 및 테스트 검증.

---

## ⚠️ 커뮤니티 빈출 문제 및 트러블슈팅 (Issues & Workarounds)

### 1. 컨텍스트 오염 (Context Pollution) 및 루프 갇힘
* **증상**: 에이전트가 동일한 에러를 2회 이상 연속으로 시도하거나 지능이 급격히 저하됨.
* **대응**:
  * 세션을 길게 끌지 말고 세션을 초기화(Reset)하거나, 파일 상태판(TODO.md / PROJECT_STATUS.md)에 상태를 기록한 뒤 새 세션으로 분기.

### 2. 쿼터/레이트 리밋 (Rate Limits) 및 불투명성
* **증상**: Antigravity 무료 티어 사용 중 갑작스럽게 할당량 초과 에러 발생 (UI에 남은 버킷이 명확히 표시되지 않음).
* **대응**:
  * 1인 개발 시 채팅창에 장문의 텍스트나 전체 로그를 쏟아붓지 말고 파일 기반 핀셋 참조로 토큰을 극단적으로 아낄 것.
  * 서드파티 비공식 확장프로그램은 보안 권한 탈취 위험이 있으므로 주의.

### 3. 스탠드얼론 앱 vs IDE 충돌
* **증상**: Antigravity 2.0 독립 실행형 앱과 VS Code 기반 IDE 확장이 단축키나 파일 점유에서 충돌.
* **대응**: 독립적인 경로로 관리하고, 단축키 및 실행 프로필을 분리하여 사용.

---

## 🧭 우리 시스템과의 대조 및 적용점 평가

| 커뮤니티 추천 팁 | 우리 현재 Antigravity 시스템 상태 | 평가 및 조치 |
| :--- | :--- | :--- |
| **SPEC / 상태 문서 유지** | KH_AI/PROJECT_STATUS.md 완비 | **이미 완벽 구현됨 (유지)** |
| **Rules 간결화 & 큐레이션** | GEMINI.md 헌법 6대 원칙 중심 통제 | **이미 반영됨 (불필요한 비대화 차단)** |
| **Two-Pass 플로우** | 8단계 검증 루프 (PLAN ➔ EXECUTE ➔ VERIFY) | **이미 헌법 제10조로 강제 중** |
| **장기 세션 초기화 습관** | 컨텍스트 요약 및 서브에이전트 격리 | **적극 준수 (긴 세션 시 체크포인트 분기)** |

---

## 📎 아카이빙 3대 메타데이터
* **원본 출처**: https://www.reddit.com/r/google_antigravity/
* **원본 정보 발행일자**: 2026-09-06
* **내 보관소 등록일자**: 2026-09-06
