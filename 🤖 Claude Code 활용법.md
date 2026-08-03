# 🤖 Claude Code 활용법

## 기본 실행
```bash
claude          # 대화형 모드 시작
claude "질문"   # 한 줄 질문
```

## MCP 관리
```bash
claude mcp list              # 연결된 MCP 서버 목록 확인
claude mcp add <name> <cmd>  # 새 MCP 추가
```

### 현재 연결된 MCP
| 이름 | 상태 | 용도 |
|------|------|------|
| playwright | ✅ 연결됨 | 브라우저 자동화 |
| Gmail | ⚠️ 인증 필요 | 이메일 읽기/쓰기 |
| Google Calendar | ⚠️ 인증 필요 | 일정 조회/생성 |

> Gmail/Calendar 인증: Claude Code 대화 중 "Gmail 열어줘" 하면 인증 링크 뜸

---

## 스킬(Skills) 사용법

슬래시 명령어로 사용:
```
/browse         — 브라우저로 웹사이트 열어서 테스트
/qa             — 웹앱 자동 QA 테스트 + 버그 수정
/qa-only        — QA 테스트만 (수정 안 함)
/review         — PR/코드 리뷰
/ship           — 코드 커밋 → PR 생성 → 배포
/health         — 코드 품질 점수 확인
/investigate    — 버그 원인 추적
/checkpoint     — 지금 작업 상태 저장 (다음 세션에서 이어받기)
/design-shotgun — UI 디자인 여러 개 생성해서 비교
/design-review  — 디자인 검토
/careful        — 위험한 명령 실행 전 경고 켜기
/plan-eng-review — 구현 계획 엔지니어링 검토
```

---

## Playwright MCP 활용 예시

Claude Code 대화 중 바로 브라우저 제어 가능:
```
"네이버 뉴스 첫 번째 기사 제목 가져와"
"github.com/chunildo44 들어가서 레포 목록 알려줘"
"이 폼에 데이터 입력하고 버튼 눌러줘"
```

---

## 플러그인 활용

`C:\Users\ildoc\.claude\plugins\marketplaces\claude-plugins-official\external_plugins\` 경로:
- `playwright` — 브라우저 자동화
- `github` — GitHub 연동
- `discord` / `telegram` — 메시지 플랫폼
- `firebase` / `supabase` — 데이터베이스
- `linear` — 이슈 트래킹
