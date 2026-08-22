---
type: reference
title: Google Data Agent Kit 데이터 엔지니어링 및 Antigravity 연동 완전분석
description: Google Cloud Tech 공식 핸즈온 심층 분석 - Antigravity IDE/CLI와 BigQuery, Cloud SQL, AlloyDB, dbt, AI.FORECAST 연동 실전 가이드
tags:
  - data-agent-kit
  - antigravity
  - google-cloud
  - bigquery
  - cloud-sql
  - mcp
  - dbt
  - second-brain
---

# Google Data Agent Kit: 코딩 에이전트의 데이터 인프라 직접 제어 및 엔드투엔드 데이터 엔지니어링

> **📌 아카이빙 3대 필수 메타데이터**
> - **원본 출처:** [Data agent kit: Your coding agent can now query your data (YouTube)](https://youtu.be/Vs2_Palg1QY)
> - **원본 정보 발행일자:** 2025-05-20 (Google Cloud Tech)
> - **내 보관소 등록일자:** 2026-08-22
> - **출연자:** Annie (Google Cloud) & Jeff (Developer Advocate at Google Cloud)

---

## 💡 핵심 3줄 요약

1. **Google Data Agent Kit**은 Antigravity IDE, Gemini CLI, Cloud Code 등 코딩 에이전트 환경에서 **BigQuery, Cloud SQL, AlloyDB, Spanner, GCS** 등 분산된 데이터 저장소를 단일 뷰에서 탐색하고 안전하게 쿼리할 수 있도록 지원하는 공식 도구 모음(Skills + MCP)이다.
2. CFO의 긴급 매출 분석 요청(평균 주문 금액 하락 원인 규명)을 받아 **BigQuery 통계 집계, Cloud SQL 고객 프로필 분석, GCS 프로모션 JSON 파싱**을 단일 자연어 대화로 수행하고, 재발 방지를 위한 **dbt 파이프라인과 TimesFM 기반 AI.FORECAST 시계열 예측 모델**을 자동 구축했다.
3. 분석 결과를 바탕으로 **Jupyter Notebook 시각화 보고서**를 생성함은 물론, 라이브 이커머스 웹사이트에 **BigQuery ML(ML.GENERATE_TEXT)과 시맨틱 임베딩 생성**을 실시간 반영하는 엔드투엔드 풀스택 데이터 개발 흐름을 완성했다.

---

## 🏗️ Data Agent Kit 핵심 아키텍처

`mermaid
flowchart TD
    User([사용자 / CFO / 개발자]) -->|자연어 질문 및 요청| AGY[Antigravity IDE / Gemini CLI]
    
    subgraph DataAgentKit [Google Data Agent Kit]
        direction TB
        subgraph LayerSkills [Agent Skills 레이어]
            S1[bigquery-sql / bigquery-ai-ml]
            S2[dbt-bigquery / dataform-bigquery]
            S3[notebook-guidance / gcp-spark]
        end
        
        subgraph LayerMCP [MCP 서버 레이어]
            M1[BigQuery MCP]
            M2[Cloud SQL MCP]
            M3[Spanner / AlloyDB MCP]
            M4[Knowledge Catalog MCP]
        end
    end
    
    AGY --> LayerSkills
    AGY --> LayerMCP
    
    LayerMCP -->|보안 인증 쿼리| BQ[(BigQuery Analytics)]
    LayerMCP -->|인스턴스 탐색 & 쿼리| CSQL[(Cloud SQL Transactions)]
    AGY -->|gcloud CLI| GCS[(Cloud Storage Logs & JSON)]
    
    BQ & CSQL & GCS --> Out1[원인 규명: B2B 도매 채널 신설]
    Out1 --> Out2[자동화: dbt 파이프라인 모델 & 테스트]
    Out2 --> Out3[예측 & 리포트: TimesFM AI.FORECAST & Jupyter Notebook]
    Out3 --> Out4[실시간 앱 반영: ML.GENERATE_TEXT & 시맨틱 임베딩]
`

---

## 📌 주요 타임스탬프별 핵심 내용 및 실전 시나리오

### 1. [00:00 - 09:20] Data Agent Kit 개요 및 2대 핵심 축 (Skills vs MCP)
- **도입 배경:** 기존 개발 환경에서는 콘솔 탭을 수십 개 띄워 BigQuery, Cloud SQL, GCS를 오가며 수동으로 쿼리를 작성해야 했음. Data Agent Kit은 Antigravity IDE 내부에서 전체 Data Cloud 자산을 단일 뷰로 통합 관리.
- **Skills vs MCP 역할 분담:**
  - **Agent Skills (나침반/가이드북):** Google Cloud 데이터 환경 최적화 규칙, AI.FORECAST 특화 문법, dbt 모델링 모범 사례, Spark 서버리스 작성법 등 프롬프트 지침 제공.
  - **MCP Tools (연결기/실행기):** BigQuery, Cloud SQL, Spanner 등 실제 클라우드 인프라와 안전하게 통신하며 스키마 조회, 건수 집계, Dry-run 구문 검증, 쿼리 실행을 수행.

---

### 2. [09:23 - 24:19] 실전 시나리오 1: CFO 지표 분석 (AOV 하락 원인 규명)
- **상황 설정:** 반려동물 용품 커머스(Symbol Pets)의 CFO가 2025년 1월 평균 주문 금액(AOV) 하락 원인 규명을 요청.
- **다중 저장소 분산 구조:**
  - **Cloud SQL (트랜잭션 DB):** 동시성 높고 행 단위 갱신이 빠른 고객 프로필(Customers) 및 반려동물 프로필(Pet Profiles).
  - **BigQuery (분석용 DW):** 200만 건 이상의 주문(Orders), 400만 건 이상의 주문 상세(Order Items) 열 지향(Columnar) 집계.
  - **Cloud Storage (GCS):** 마케팅 부서가 업로드한 프로모션 캠페인 JSON 파일.
- **에이전트 자율 분석:**
  - BigQuery MCP를 호출하여 2024년 8월부터 2025년 1월까지의 월별 AOV 집계.
  - 평소 110달러 수준이던 AOV가 2025년 1월 103달러로 하락한 것을 포착.
  - 주문 유형(Order Type)별 드릴다운 쿼리를 수행하여, 1월에 새롭게 추가된 **B2B 도매(Wholesale) 세그먼트**의 대량 소액 주문이 전체 평균을 낮춘 원인임을 규명. (기존 온라인/오프라인 일반 소매는 정상 성장 중)

---

### 3. [24:20 - 35:32] 실전 시나리오 2: Cloud SQL 프로필 조회 및 GCS 마케팅 JSON 교차 검증
- **Cloud SQL 인스턴스 탐색:** B2B 고객 명단을 확인하기 위해 Cloud SQL MCP로 Customers 테이블을 조회하고 지역별 분포와 기업 계정 특성을 파악.
- **GCS 비정형 로그 검증:** 마케팅 팀이 공유한 GCS 버킷의 JSON 프로모션 설정 파일을 gcloud storage로 확인하여, 1월에 진행된 신규 B2B 도매 프로모션 캠페인의 상세 조건을 상호 대조.
- **최종 결론:** 기업의 실적 악화가 아니라 신규 B2B 비즈니스 라인 확장에 따른 믹스 변화임을 확정.

---

### 4. [35:33 - 46:02] 실전 시나리오 3: dbt 파이프라인 자동 생성 및 1:N 조인 Fan-out 방어
- **dbt 도입 필요성:** 단순 일회성 쿼리로 끝내지 않고, 향후 매시간/매일 AOV를 자동 추적하기 위해 dbt(Data Build Tool) 파이프라인 구축.
- **Fan-out(조인 뻥튀기) 방어:**
  - 고객 1명당 여러 반려동물(Pets)이 연결된 1:N 관계에서 단순 JOIN 시 주문 데이터가 복제되어 합산 금액이 왜곡되는 문제를 에이전트가 사전 인지.
  - order_id 기준의 고유성(Uniqueness)을 보장하는 중간 CTE와 집계 모델(Marts/Staging)을 자동 생성.
- **자가 치유 빌드 루프:** 에이전트가 로컬 환경에서 dbt build와 단위 테스트를 자율 실행하여 성공 검증 후 코드 확정.

---

### 5. [46:03 - 52:45] 실전 시나리오 4: TimesFM 기반 AI.FORECAST 및 Jupyter Notebook 시각화
- **0-Shot 시계열 예측 (TimesFM):**
  - 수십억 개 시계열 데이터로 사전 학습된 파운데이션 모델 **TimesFM** 기반의 BigQuery 고유 함수 AI.FORECAST를 호출.
  - 과거 데이터로 별도 파인튜닝 없이 다음 분기 AOV 및 주문량 추세를 즉시 투사.
- **CFO 전용 보고서 & 노트북 산출:**
  - 총이익률(Gross Margin)과 세그먼트별 매출 전망을 담은 Executive Summary 작성.
  - notebook-guidance 스킬을 통해 차트와 테이블이 포함된 인터랙티브 .ipynb 파일을 단 몇 초 만에 생성 및 일괄 실행.

---

### 6. [52:46 - 59:21] 실전 시나리오 5: 라이브 웹사이트 데이터 연동 (BigQuery ML & 시맨틱 검색)
- **신규 상품 등록 자동화:**
  - 제품명만 입력하면 BigQuery ML의 ML.GENERATE_TEXT(Gemini 연동)를 호출해 상세 설명과 쇼퍼 맞춤 홍보 문구를 자동 생성하고 DB에 즉시 삽입.
- **실시간 벡터 임베딩 & 시맨틱 검색:**
  - 신규 등록된 상품의 임베딩 벡터를 즉시 생성하여 테이블에 저장.
  - 웹 프론트엔드에서 '요로 건강 케어' 등 자연어 증상 검색 시 방금 추가된 시니어 캣 사료가 실시간 상위에 정확히 노출되는 엔드투엔드 데이터 앱 완성.

---

## 🛠️ AI(나/Antigravity)에게 적용할 점

1. **내장된 Data Cloud 스킬 & MCP 원스톱 즉시 가동**
   - 현재 내 시스템(C:\Users\ildoc\.gemini\config\skills\)에 이미 탑재된 igquery-sql, igquery-ai-ml, 
otebook-guidance, dbt-bigquery, dataform-bigquery, datacloud_cloud-sql_remote MCP를 적극 연동하여, 사용자의 데이터 분석/DB 관리 요청 시 별도 외부 도구 없이 단일 컨텍스트에서 완결.
2. **관계형 데이터 조인 시 1:N Fan-out 사전 방어 원칙**
   - 사용자 테이블, 트랜잭션, 로그 조인 시 단순 JOIN을 지양하고, PK 고유성 훼손 여부와 수치 왜곡을 선제 진단하는 안전한 CTE 집계 쿼리를 기본 작성.
3. **분석 요청 시 3단계 완결형 번들 제공**
   - 데이터 분석/로그 감사 작업 시 단순 텍스트 답변에 그치지 않고, **[1. 핵심 결론 요약 (Executive Table) -> 2. 검증된 재현 쿼리/dbt 모델 -> 3. 시각화 노트북 또는 다이어그램]**의 3박자 산출물을 원스톱 제시.

---

## 🔗 관련 내부 문서 (Second Brain)
- [[Antigravity_3계층_아키텍처_Memory_Skill]]
- [[Google_AntiGravity_멀티에이전트_실전_가동_가이드]]
- [[Google_Cloud_Run_AI_에이전트_배포_및_MCP_연동_완전가이드]]
- [[바이브코딩_필수_백엔드_3요소_API_WAS_배포_완전정복]]