---
title: "바이브코딩 좋은 사례 vs 보안 참사 — Antigravity 7단계 시스템 학습 루프 및 Security Gate 분석"
created: 2026-09-06
tags:
  - youtube-archive
  - closed-loop-learning
  - security-gate
  - zerocho
  - system-gap-analysis
source: https://youtube.com/shorts/LzbaKEXjxTk
video_id: LzbaKEXjxTk
published: 2026-04-15
archived: 2026-09-06
channel: ZeroCho TV (조현영)
transcript_language: ko
transcript_source: youtube_transcript_api
pipeline_version: "7-Step Knowledge-to-System Loop v4.0"
decision: ADOPTED_AND_INTEGRATED
linked_knowledge_card: "[[생성_능력과_검증_능력의_비대칭성]]"
---

# 바이브코딩 좋은 사례 vs 보안 참사 — Antigravity 7단계 시스템 학습 루프 및 Security Gate 분석

- **원본 출처**: https://youtube.com/shorts/LzbaKEXjxTk
- **원본 정보 발행일자**: 2026-04-15
- **내 보관소 등록일자**: 2026-09-06
- **채널명**: ZeroCho TV (조현영)
- **추출된 지식 카드**: [[생성_능력과_검증_능력의_비대칭성]]
- **파이프라인**: 7-Step Knowledge-to-System Loop (Source ➔ Claims ➔ GAP ➔ Decision ➔ Implementation ➔ Verification ➔ Outcome)

---

## 1단계: SOURCE (원본 사실 및 자막 보존)

> AI 요약을 원본처럼 취급하지 않기 위해 스크립트 원문을 100% 손실 없이 보존합니다.

<details>
<summary><b>📜 원본 타임스탬프 전체 자막 펼치기 (클릭)</b></summary>

```text
[00:00] 네, 오늘은 바이브 코딩의 좋은
[00:01] 사례와 나쁜 사례 둘 다 한번 보여
[00:03] 드리도록 하겠습니다. 좋은 사례는
[00:04] 일단 덴마이 슬로우 KT라는 걸 KT
[00:06] 인터넷이 너무 느려서 직접 만드신 거
[00:08] 같은데요. 저도 KT 인터넷 쓰고
[00:09] 있거든요. 이게 KT 인터넷 쓰시면
[00:11] 계약 속도의 50%를 미달하면 측정한
[00:13] 날에 요금을 깎아 줘야 된다는 규정이
[00:15] 있어요. 그래서 매일 측정해야 매일
[00:16] 감면되기 때문에 매일매일 이걸 측정을
[00:18] 해 보고 만약에 모든 날이 느리면
[00:20] 공짜로 그냥 쓸 수 있는 것이죠.
[00:21] 근데 이거 측정하는데 25분 걸리기
[00:23] 때문에 매일 하는 사람이 없어서 직접
[00:25] 만드셨다고 합니다. 계약 속도 대비
[00:26] 측정 속도가 너무 느리면 알아서이
[00:28] 신청해서 요금을 감면 받는 그런
[00:29] 거예요. 그래서 매과 윈도우 이렇게
[00:31] 되고요. 설치한 다음에 실행을 하시면
[00:32] 되는데 한 가지 찜찜한 점은 KTID
[00:34] 비밀번호 번호를 물어보기 때문에 그
[00:36] 부분은 조금 찜찜하실 수가 있습니다.
[00:38] 어쨌든 이렇게 자기가 쓸 거 바이브
[00:40] 코딩으로 만들면 좋아요. 아주 좋은
[00:41] 사례라고 생각을 합니다. 근데 이번에
[00:43] 참사를 한번 또 설명드리자면 이런
[00:45] 경우 요즘 진짜 많이 발생을 합니다.
[00:46] 의료 기관 직원이 코딩 에이전트로
[00:48] 환자 관리 시스템 이거 매우 민감
[00:50] 정보거든요. 개인의 건강 진료
[00:51] 내역이기 때문에 근데 데이터가
[00:53] 인터넷에 암호화 없이 노출이 됐다고
[00:54] 해요. 진료대와 녹음에 대한 자동
[00:56] 요약 같은게 읽기 쓰기 권한이 열려
[00:58] 있었다고 합니다. 이거 아예 법적인
[00:59] 처벌을 받을 수도 있거든요. 근데
[01:01] 바이브 코딩하는 사람들 중에
[01:02] 데이터베이스나 보안에 대한 개념 같은
[01:04] 걸 아예 모르기 때문에 이런 실수를
[01:05] 저지르는 사람이 많습니다. 접근 제원
[01:07] 로직이 클라이언트 측에만 존재한다.
[01:09] 여기만 봐도 딱 알겠죠? DB에도
[01:10] 접근 제어가 전혀 없었다. 그래서
[01:12] 제가 예전에 비발자가 하면 좋은
[01:14] 바이브 코딩 이런 쇼츠를 올렸었는데
[01:15] 1년이 지났는데도 그 말이
[01:16] 유효하냐라고 물어보시는 분들이
[01:18] 계세요. 제가 말씀드리자면 한 가지
[01:20] 변한 거는 이제 코드 한 줄 안 치고
[01:21] 제품을 출시할 수 있게 되었어요.
[01:23] 그런데 안전하게 만드는 거는 다른
[01:25] 영역입니다. 그 안전 점검도 AI한테
[01:27] 시키면 되지 않냐 하실 수 있는데
[01:29] 개발자가 아니셨던 분들은 그 안전
[01:30] 점검을 시킬 수 있는 능력이 없는
[01:32] 경우가 많습니다. 물론 또 1년
[01:34] 뒤에는 어떻게 될지 몰라요. 지금은
[01:35] 이런 보안 참사가 일어나는 경우가
[01:37] 매우 많을 거라고 생각이 됩니다.
[01:38] AI 개발 소식 들으시려면 구독
[01:40] 좋아요 한 번씩 눌러 주세요.
```

</details>

---

## 2단계: CLAIMS (영상 주장 사실 분리)

영상 속 화자의 발언을 사실(Fact), 의견(Opinion), 사례(Case) 단위로 분리합니다.

| Claim ID | 핵심 주장 내용 | 출처 구간 | 유형 | 팩트체크 / 신뢰도 |
| :--- | :--- | :--- | :--- | :--- |
| **CLM-01** | KT 인터넷 계약 속도 50% 미달 시 요금 감면 규정이 있으며, 25분 걸리는 측정을 자동화해 신청하는 툴('덴마이 슬로우 KT')을 개인이 직접 제작함 | [00:00 - 00:41] | 개인 개발 모범사례 | **사실 부합**: KT 인터넷 SLA 품질보증제도에 따라 최저보장속도 미달 시 일 요금 감면 규정 실존. |
| **CLM-02** | 의료 기관 직원이 코딩 에이전트로 환자 관리 시스템을 만들었으나, 암호화 없이 공용 인터넷에 노출되고 진료 녹음 요약이 읽기/쓰기로 개방됨 | [00:41 - 01:10] | 보안 참사 사례 | **사실 부합**: 비개발자가 클라이언트 단 조건문만 두고 DB 권한(RLS) 및 백엔드 인증을 누락한 전형적인 사고. |
| **CLM-03** | 접근 제어 로직이 클라이언트(브라우저) 측에만 존재하고 데이터베이스(DB) 자체에는 접근 제어가 아예 없었음 | [01:05 - 01:11] | 기술 취약점 분석 | **사실 부합**: UI 버튼만 숨기고 REST 엔드포인트나 Supabase 테이블이 Public Open 상태인 Zero-Trust 결여. |
| **CLM-04** | 코드 한 줄 안 치고 제품 출시가 가능해졌으나 안전하게 만드는 것은 완전히 다른 영역이며, 비개발자는 AI에게 보안 점검을 시킬 역량이 부족함 | [01:10 - 01:42] | 업계 트렌드 전망 | **사실 부합**: 생성 능력과 검증 능력 사이의 비대칭성(Asymmetry)으로 인한 보안 사고 급증. |

---

## 3단계: GAP ANALYSIS (현재 Antigravity 시스템 비교 분석) ⭐

> **"모든 Insight가 Action으로 직행해서는 안 된다. 현재 시스템에 이미 존재하는지, 무엇이 부족한지 먼저 대조한다."**

| 외부 지식 / 교훈 | 현재 Antigravity 상태 (Before) | GAP 식별 결과 | 변경 필요 여부 |
| :--- | :--- | :--- | :---: |
| **Builder ≠ Auditor** (자가 승인 불가) | Verification Loop는 있었으나 AI의 "정리 완료했습니다" 보고를 신뢰하는 경향 잔존 | **GAP 존재**: 코드를 짠 Builder 에이전트의 자기 승인을 시스템 수준에서 거부하는 규칙 미흡 | **필요 (HIGH)** |
| **Created ≠ Verified** (증거 없는 안전 선언 금지) | "검사 완료 = 안전"으로 처리되어 미검증 항목(런타임 등)을 구분하지 않음 | **GAP 존재**: 정적 검사만 거친 항목을 NOT VERIFIED로 정직하게 공시하는 상태 모델 부재 | **필요 (CRITICAL)** |
| **Risk Detection ≠ Risk Confirmation** | 단순 키워드 매칭(sqlite3 등)을 원격 DB와 동일 취급하여 오탐 및 자체 오염 발생 | **GAP 존재**: Context Classification(스캐너, 테스트, 프로덕션 코드) 분리 로직 결여 | **필요 (HIGH)** |
| **Automated Enforcement** | security_gate.py 스크립트가 수동 파일로만 존재 | **GAP 존재**: 실제 작업 완료 시 trust_layer에서 강제 차단하는 자동 결합 미구현 | **필요 (CRITICAL)** |
| **개인 생산성 마이크로 도구 가치** | Vibe Mode가 이미 존재하여 로컬 스크립트는 가볍게 실행 가능함 | **GAP 없음**: 기존 Vibe Mode의 속도 우선 로컬 자동화 철학은 이미 부합함 | **NO CHANGE** |

---

## 4단계: DECISION (적용 의사결정)

무분별한 시스템 비대화를 막기 위해 4가지 결정 유형으로 확정합니다.

1. **`ADOPT` (신규 원칙 도입)**:
   - `Builder ≠ Auditor` 및 `Created ≠ Verified`를 행동 헌법에 도입.
   - `Evidence ≠ Conclusion`: 무엇을 검사했는지(Evidence)와 무엇을 검사하지 못했는지(Limitations)를 분리.
2. **`ADAPT` (환경에 맞춘 변형)**:
   - 단일 상태 모델 폐지 ➔ `Gate Status 5종 (PASS, FAIL, WARNING, NOT VERIFIED, NOT APPLICABLE)`과 `Overall Verdict 5종 (APPROVED, APPROVED_WITH_WARNINGS, BLOCKED, REQUIRES_AUDIT, INSUFFICIENT_EVIDENCE)`으로 이원화.
   - Context Classification을 통해 탐지 규칙 자체의 자기 오염(Self-trigger) 배제.
3. **`NO CHANGE` (기존 시스템 유지)**:
   - 로컬 마이크로 툴에 대한 🟢 LOW RISK Vibe Mode는 그대로 유지 (과도한 검증 오버헤드 방지).
4. **`REJECT` (기각)**:
   - "모든 코드에 런타임 브라우저 모의해킹 강제" 방안은 배터리 및 로컬 자원 낭비로 기각하고, 대신 `NOT VERIFIED + REQUIRES_AUDIT`로 감사관에게 증거를 넘기는 방식으로 대체.

---

## 5단계: IMPLEMENTATION (실제 변경 및 배포)

> **Created(생성됨)와 Integrated(연동됨)를 엄격히 분리합니다.**

| 구성 요소 | 작업 내용 | Created | Integrated | 물리적 파일 경로 |
| :--- | :--- | :---: | :---: | :--- |
| **Canonical 헌법** | Protocol 33 개정 (증거 한계 공시, 이원화) | **YES** | **YES** | `C:/Users/ildoc/.gemini/config/rules/GEMINI.md` |
| **볼트 복사본** | SHA-256 해시 바이트 단위 100% 동기화 | **YES** | **YES** | `C:/전일도/GEMINI.md` |
| **보안 게이트 엔진** | security_gate.py v3.0 (컨텍스트 분류, 한계 보고) | **YES** | **YES** | `my_ai_workspace/core/security_gate.py` |
| **파이프라인 결합** | trust_layer.py 내 자동 실행 및 실패 시 차단 | **YES** | **YES** | `my_ai_workspace/core/trust_layer.py` |
| **원자적 지식 카드** | [[생성_능력과_검증_능력의_비대칭성]] 분리 보존 | **YES** | **YES** | `00_SecondBrain_지식창고/02_AI_기술_위키/` |

---

## 6단계: VERIFICATION (증거 기반 다층 검증)

| 검증 층위 | 검증 방법 | 상태 | 실증 증거 (Evidence) |
| :--- | :--- | :---: | :--- |
| **Static Verified** | AST 및 정규식 코드 검사 | **VERIFIED** | 12개 파일(1,506줄) 스캔 결과 하드코딩 자격증명 0건 |
| **Runtime Verified** | 실제 비인가 엔드포인트 호출 | **NOT VERIFIED** | 런타임 통합 테스트 스위트 부재로 정직하게 NOT VERIFIED 공시 |
| **Integration Verified**| trust_layer 자동 실행 여부 | **VERIFIED** | `trust_layer.verify_and_record` 구동 시 `SecGate` 자동 판정 확인 |
| **Flaw Detection & Block** | trust_layer 경로 결함 주입 차단 | **VERIFIED** | `sk-` 키 주입 테스트 시 `Result: False`, `Security Gate BLOCKED` 차단 실증 |
| **Complete Bypass Prevention** | 모든 배포/완료 경로의 우회 불가능성 | **NOT VERIFIED** | Git `--no-verify` 플래그 및 CLI 직접 배포 등 우회 경로 완전 차단은 미검증 상태 |

---

## 7단계: OUTCOME / REVIEW (학습 결과 및 정기 재검토)

- **최종 판정**: `ADOPTED_AND_INTEGRATED`
- **시스템 변화**:
  1. 외부 유튜브 영상 ➔ 단순 텍스트 저장이 아닌 **"원자적 지식 카드([[생성_능력과_검증_능력의_비대칭성]])"**로 개념 분리 완료.
  2. Antigravity 빌드 루프(`trust_layer`)에 `security_gate.py`가 물리적으로 강제 결합되어 보안 결함 시 보고 완료 차단.
  3. AI 특유의 "모든 것이 완벽합니다" 거짓 선언을 시스템적으로 차단하고 `NOT VERIFIED`와 `REQUIRES_AUDIT`를 공식 수용.
- **다음 정기 재검토 (Review Trigger)**: **2026-10-06**
  - 점검 항목: 실제 웹/풀스택 프로젝트 투입 시 런타임 인가 테스트(Layer C) 자동 생성기 탑재 필요성 평가.
