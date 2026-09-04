---
title: "VS Code Agent Plugins 오픈 표준 분석과 동기화 아키텍처 비교"
created: 2026-09-04
tags:
  - youtube
  - vscode
  - agent-plugin
  - mcp
  - skills
  - sync
source: "https://youtu.be/Mnyc9gUTq7E"
published: "2026-09-04"
archived: 2026-09-04
channel: "Visual Studio Code"
---

# VS Code Agent Plugins 오픈 표준 분석과 동기화 아키텍처 비교

- 원본 출처: https://youtu.be/Mnyc9gUTq7E
- 원본 정보 발행일자: 2026-09-04
- 내 보관소 등록일자: 2026-09-04
- 채널: Visual Studio Code (Microsoft 공식)

---

## 💡 핵심 3줄
1. VS Code가 발표한 '에이전트 플러그인(Agent Plugins)'은 파편화된 **스킬, MCP 서버, 커스텀 에이전트, 훅, 규칙**을 하나의 번들로 묶어 어디서나 한 번에 설치/공유하는 오픈 표준 규격이다.
2. 기기간(데스크톱-노트북) 동기화와 프로젝트별 확장을 위해 마켓플레이스나 GitHub URL 기반으로 플러그인을 원클릭 설치/업데이트하는 생태계를 지향한다.
3. 우리 시스템은 이미 `Git 기반 안전 동기화(skills_sync, GEMINI.md, MCP)`로 이 문제를 선제 해결했으므로, **VS Code 플러그인 설치는 불필요하며 '모듈 번들링 설계 원칙'만 참고**한다.

---

## 📌 1. VS Code 에이전트 플러그인 핵심 내용

### ① 문제 의식: 에이전트 커스터마이징의 파편화
- 사용자가 프롬프트 지침, 스킬, MCP 서버, 훅 등을 제각각 만들어 쓰다 보면, 다른 기기로 옮기거나 프로젝트가 바뀔 때마다 설정을 일일이 복사하고 최신 상태를 유지하기가 매우 번거로움.

### ② 해결책: 올인원 에이전트 플러그인 번들
- **포함 요소**: `Skills` + `MCP Servers` + `Custom Agents` + `Hooks` + `Rules & Instructions` + `Slash Commands`.
- **배포 및 설치 방식**:
  - VS Code 내장 마켓플레이스 검색 설치
  - GitHub 저장소 URL 직접 붙여넣기 (`git clone` 기반 자동 설치)
  - 로컬 폴더 직접 지정
- **오픈 표준 지향**: VS Code뿐만 아니라 Copilot CLI, 웹 앱 등 다양한 에이전트 런타임에서 공통 지원.

---

## 📊 2. VS Code 플러그인 방식 vs 현재 Antigravity 시스템 비교

| 비교 항목 | VS Code Agent Plugins (영상) | 현재 Antigravity 시스템 (우리 구조) | 평가 및 시사점 |
| :--- | :--- | :--- | :--- |
| **동기화 대상** | 스킬 + MCP + 훅 + 지침 | 스킬 + MCP + 헌법(GEMINI.md) + 볼트 | 동일한 문제 영역을 다룸 |
| **동기화 수단** | 마켓플레이스 / 확장 프로그램 UI | 순수 Git (`sync_safe_update.ps1`) | **우리 구조가 벤더 종속 없이 가볍고 안전함** |
| **관리 방식** | 패키지 번들 단위 설치/제거 | 중앙 집중식 단일 헌법 및 폴더 동기화 | 충돌 방지와 무결점 검증에 우리 방식이 최적 |
| **적용 필요성** | 신규 도입 시 추가 레이어 발생 | 이미 양 기기 무결점 동기화 완성 | ❌ **VS Code 플러그인 도입 불필요 (중복)** |

---

## ⚙️ 3. Antigravity 시스템 적용 검토

1. **기존 시스템 대비 중복 여부 (완벽히 중복됨 / 추가 설치 불필요)**:
   - **중복됨**: 우리는 이미 데스크톱과 서브 노트북 간에 `C:\전일도\scripts\sync_safe_update.ps1`을 통해 `GEMINI.md(헌법)`, `config/skills/(스킬)`, `mcp_config.json(MCP)`의 바이트 단위 양방향 동기화를 완성했습니다.
   - 외부 벤더의 플러그인 마켓플레이스를 추가할 필요가 전혀 없으며, 시스템만 복잡해집니다.

2. **설계적으로 흡수할 인사이트 (향후 도메인별 모듈 번들링)**:
   - 나중에 `D:\KH_AI` (비솔 Vision AI 전용 작업)처럼 완전히 분리된 프로젝트를 다룰 때, **[Vision AI 전용 스킬 + 전용 룰 + 전용 툴]을 하나의 패키지 폴더처럼 묶어서 관리하는 번들링 개념**은 구조 설계 시 유용한 아이디어로 참고할 수 있습니다.

3. **하드웨어 사양 고려**:
   - 데스크톱과 서브 노트북 모두 불필요한 VS Code 플러그인 프로세스를 상주시키지 않고, 가벼운 순수 로컬 스크립트 동기화를 유지하여 RAM과 CPU를 온전히 메인 작업(코딩/Vision AI)에 집중시킵니다.
