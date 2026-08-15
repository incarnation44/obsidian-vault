# 🚀 GitHub Stacked PRs (스택드 PR) 실전 가이드 & 워크플로우

> **작성일자:** 2026-08-08  
> **태그:** `#Git` `#GitHub` `#StackedPRs` `#개발생산성` `#코드리뷰` `#CI_CD` `#협업`

---

## 📌 1. 개요: 스택드 PR(Stacked PRs)이란?

**스택드 PR(Stacked PRs)**은 대규모 기능 개발이나 복잡한 코드 변경을 **의존 관계(체이닝)를 가진 여러 개의 작고 독립적인 Pull Request로 쪼개어 계층(Stack) 형태로 관리하는 최신 Git 워크플로우**입니다.

```
[ 기존 방식 (Monolithic PR) ]
main ───► [ 1,000줄 거대 PR ] (리뷰 지연, 충돌 위험 극대화)

[ 스택드 PR 방식 (Stacked PRs) ]
main ───► [ PR 1: 데이터 모델 (200줄) ] 
               └───► [ PR 2: 비즈니스 로직 (250줄) ] 
                         └───► [ PR 3: UI 컴포넌트 (180줄) ]
```

---

## 🌟 2. 왜 써야 하는가? (핵심 도입 효과)

| 항목 | 기존 단일 PR 방식 | 스택드 PR (Stacked PRs) 방식 |
| :--- | :--- | :--- |
| **코드 리뷰 속도** | 수천 줄 압박으로 리뷰 지연 및 방치 | **200~300줄 단위로 3분 만에 즉시 승인/머지** |
| **개발 연속성** | 1단계 승인될 때까지 2단계 작업 보류/블로킹 | **승인을 기다리지 않고 다음 단계 브랜치 계속 작업** |
| **충돌(Conflict) 관리**| 선행 코드 수정 시 후속 브랜치 수동 Rebase 지옥 | **선행 PR 머지 시 GitHub가 후속 Base 브랜치 자동 리베이스** |
| **롤백(Rollback) 안전성**| 문제 발생 시 전체 기능 통째로 롤백 | **버그가 발생한 마이크로 PR만 핀포인트 Revert** |
| **AI 페어 프로그래밍** | AI가 대량 생성한 코드 검증 어려움 | **AI 생성 모듈을 단계별로 검증하며 안전하게 배포** |

---

## 🛠️ 3. 실전 적용 방법 (How to Use)

### 방법 A: 순수 Git & GitHub 웹에서 즉시 적용 (설치 불필요)

1. **1단계 브랜치 생성 및 PR (Base: `main`)**
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feat/step1-data-model
   # 코드 작성 및 커밋
   git push origin feat/step1-data-model
   # GitHub 웹에서 Base를 'main'으로 하여 PR #1 생성
   ```

2. **2단계 브랜치 생성 및 PR (Base: `feat/step1-data-model`)**
   ```bash
   # 1단계 브랜치 위에서 바로 새 브랜치 분기
   git checkout -b feat/step2-business-logic
   # 코드 작성 및 커밋
   git push origin feat/step2-business-logic
   # GitHub 웹에서 Base를 'feat/step1-data-model'로 지정하여 PR #2 생성
   ```

3. **3단계 브랜치 생성 및 PR (Base: `feat/step2-business-logic`)**
   ```bash
   git checkout -b feat/step3-ui-view
   # 코드 작성 및 커밋
   git push origin feat/step3-ui-view
   # GitHub 웹에서 Base를 'feat/step2-business-logic'으로 지정하여 PR #3 생성
   ```

4. **자동 병합 & 리베이스 메커니즘**
   * PR #1이 리뷰 후 `main`에 머지되면, GitHub가 **PR #2의 Base 브랜치를 자동으로 `main`으로 스위칭 및 리베이스**합니다.

---

### 방법 B: GitHub CLI (`gh`) 활용 자동화

GitHub CLI를 활용하면 터미널 단 한 줄의 명령어로 전체 스택을 생성 및 제출할 수 있습니다.

```powershell
# 1. GitHub CLI 설치 (Windows)
winget install --id GitHub.cli
gh auth login

# 2. 스택 PR 생성 및 일괄 제출 예시
gh pr create --base feat/step1-data-model --head feat/step2-business-logic --title "feat: 비즈니스 로직 연동" --body "Stacked on #1"
```

---

## 📋 4. 실전 체크리스트 & Best Practice

- [x] **단일 책임 원칙:** 각 PR은 하나의 명확한 목적(타입 정의, API 연결, UI 뷰 등)만 가질 것.
- [x] **PR 크기 제한:** 각 스택 PR은 `+200 ~ 400줄` 이내를 유지하여 리뷰 피로도 최소화.
- [x] **Base 브랜치 확인:** PR 생성 시 타겟(Base) 브랜치가 직전 단계 브랜치로 올바르게 설정되었는지 확인.
- [x] **PR 본문에 스택 구조 명시:** 본문에 `Depends on #1`, `Part of Stack #1 -> #2 -> #3` 형태로 링크를 달아 리뷰어 편의 증대.

---

## 🔗 연관 문서
* [[인덱스]] - 옵시디언 메인 대시보드
* [[04_개발_및_히스토리/코딩_및_개발_지식_정리]] - 핵심 개발 지식 정리

## 관련
- [[코딩_및_개발_지식_정리]]
- [[React_웹에서_ReactNative_모바일앱_개발_핵심_가이드]]
