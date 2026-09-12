# Hermes berber44 새 PC 이식 가이드

노트북 세팅을 본체 등 새 PC에서 재현하는 순서다. 비밀키(`.env`, API 키)는 번들에 없다. 새 PC에서 직접 넣는다.

## 0. 전제

- 새 PC에 Hermes Agent 설치済み, `berber44` 프로필 생성済み.
- 이 폴더는 볼트 동기화로 새 PC에 내려받는다 (`git pull origin master`).

## 1. 스킬 2건 복사

`skills/` 폴더 통째로 프로필 스킬 폴더에 복사한다.

- Windows: `%LOCALAPPDATA%\hermes\profiles\berber44\skills\`
- `HERMES_HOME` 환경변수가 있으면 그 아래 `profiles\berber44\skills\`를 쓴다.

대상: `i-have-adhd`, `planning-with-files` (각 SKILL.md 1개씩, 프롬프트 전용이라 의존성 없음).
복사 후 `hermes skills list`에 `local`로 뜨면 끝이다.

## 2. 위키 복사

`wiki/` 폴더 통째로 `C:\Users\<사용자>\wiki`에 복사한다 (`.git` 포함이라 이력도 이어진다).

## 3. 모델·MCP 수동 설정 (2026-09-12 기준, 변동 가능)

- 프로바이더: openrouter, 기본 모델: `google/gemini-3.8-flash` (바뀌었을 수 있으니 확인).
- MCP `chrome-devtools`: `npx -y firecrawl-mcp`, `FIRECRAWL_API_KEY`는 새 PC에서 재발급해 `.env`에 넣는다.
- Ollama 별칭은 기기별로 다르다. 노트북은 `local-qwen`(qwen2.5:3b, CPU), 본체는 RX 6600 기준 7B·8B로 잡는다.

## 4. 메모리 수동 등록

`memory-reentry.md` 내용을 새 PC Hermes 메모리에 그대로 등록한다. 자동 이식 안 된다.

## 5. 확인 체크

- [ ] `hermes skills list`에 2건 `local` 표시
- [ ] `~/wiki` 열리고 `index.md` 보인다
- [ ] 모델·MCP·Ollama 동작 확인
- [ ] 메모리 등록됨
