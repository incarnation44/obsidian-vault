# 🤖 Grok 터미널 에이전트 활용법

> 마지막 업데이트: 2026-04-13

## 설치 상태
- `opencode-ai` 전역 설치 완료
- 터미널 명령 추가:
  - `opencode`
  - `grok`

## 개념
- 이 환경에서 `grok` 명령은 OpenCode CLI를 xAI 모델로 바로 실행하는 래퍼다.
- 즉, `codex`, `claude`처럼 터미널에서 바로 AI 에이전트를 띄우는 용도로 쓴다.

## 첫 사용 전 준비
1. xAI 계정에서 API 키 발급
   - 사이트: `https://console.x.ai/`
2. 터미널에서 provider 로그인
   - 명령: `opencode auth login xai`
3. 안내에 따라 xAI API 키 입력

## 기본 실행
```powershell
grok
```

- 기본 모델은 `xai/grok-4`
- 현재 폴더를 기준으로 터미널형 AI 에이전트 세션이 열린다.

## 자주 쓰는 예시
```powershell
grok
grok "이 폴더 구조를 분석해줘"
grok -c
grok -m xai/grok-4-fast
opencode models xai
opencode auth list
```

## 명령 설명
- `grok`
  - Grok 기본 모델로 새 세션 시작
- `grok "질문"`
  - 질문과 함께 바로 실행
- `grok -c`
  - 마지막 세션 이어서 시작
- `grok -m xai/grok-4-fast`
  - 더 빠른 다른 xAI 모델로 실행
- `opencode models xai`
  - 사용 가능한 xAI 모델 목록 확인
- `opencode auth list`
  - 로그인된 provider 상태 확인

## 확인 포인트
- `opencode --version` 으로 설치 확인 가능
- PowerShell 실행 정책 때문에 `.ps1`보다 `.cmd` 명령 경로를 사용하도록 `grok.cmd`를 추가해 둠

## 참고
- OpenCode 공식 문서: `https://opencode.ai/docs/models`
- xAI 공식 문서: `https://docs.x.ai/developers/models`
