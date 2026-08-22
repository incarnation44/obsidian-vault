# 🏛️ Architect Specification Template (`ARCHITECT.md`)

이 템플릿은 복합 개발 프로젝트 진행 시 메인 에이전트와 서브에이전트 간의 역할 경계와 완료 보고 체계를 고정하는 하네스 명세서입니다.

---

## 🎯 1. 프로젝트 목표 & 문제 정의
- **목표**: 
- **핵심 요구사항**:

---

## 👥 2. 서브에이전트 역할 및 산출물 분담

| 서브에이전트 ID | 담당 역할 | 전담 산출물 경로 | 입력 인터페이스 | 출력 인터페이스 |
| :--- | :--- | :--- | :--- | :--- |
| `worker-backend` | 백엔드 API & DB 로직 | `src/api/`, `src/db/` | 요청 파라미터 / DTO | REST API 엔드포인트 & JSON 응답 |
| `worker-frontend` | UI 컴포넌트 & 반응형 화면 | `src/components/`, `src/app/` | 백엔드 API 엔드포인트 | 사용자 인터랙션 UI |
| `worker-mock-data` | 시드/데모 데이터 & 검증 스크립트 | `src/data/`, `tests/` | 데이터 스키마 명세 | Mock JSON 및 단위 테스트 코드 |

---

## 🔒 3. 컨텍스트 격리 원칙 (Context Isolation)
1. 서브에이전트는 각자의 독립 컨텍스트에서 코드 작성 및 단위 실행/디버깅을 자율적으로 완결한다.
2. 중간 탐색 과정의 방대한 로그, 원시 데이터, 실패 에러 메시지는 서브에이전트 내부에 격리한다.
3. 메인 에이전트는 하위 작업의 중간 과정을 일일이 주입받지 않고 오직 정형 완료 보고만 수신한다.

---

## 📋 4. 서브에이전트 정형 완료 보고 양식 (Completion Report Format)

각 서브에이전트는 작업 완료 시 아래 포맷으로만 메인 에이전트에게 보고한다.

```markdown
### 🚀 [서브에이전트 ID] 작업 완료 보고
1. **생성/수정된 산출물 경로**:
   - `src/api/routes.ts`
2. **핵심 구현 요약**:
   - 사용자 인증 및 CRUD API 엔드포인트 구현 완료
3. **자체 검증 결과 (Self-Evaluation)**:
   - TypeScript 컴파일 성공 (0 errors)
   - 단위 테스트 통과 (Pass)
4. **외부 노출 인터페이스**:
   - `POST /api/v1/auth/login` (Body: `{ email, password }`)
```
