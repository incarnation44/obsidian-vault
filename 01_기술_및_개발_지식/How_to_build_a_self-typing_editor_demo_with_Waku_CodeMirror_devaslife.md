---
title: "How to build a self-typing editor demo with Waku + CodeMirror"
aliases: ["Waku CodeMirror 데모", "셀프 타이핑 에디터 리플레이", "devaslife 에디터 데모"]
tags:
  - "웹개발/프론트엔드"
  - "React/Waku"
  - "CodeMirror"
  - "인터랙티브UI"
  - "랜딩페이지"
  - "devaslife"
created: 2026-09-10
source: "https://youtu.be/Rt7xwb1SOcY"
source_published: "2026-09-07"
vault_registered: 2026-09-10
knowledge_type: "source"
---

# 🎬 How to build a self-typing editor demo with Waku + CodeMirror

> **출처**: [devaslife (Takuya Matsuyama) - YouTube](https://youtu.be/Rt7xwb1SOcY)  
> **발행일**: 2026-09-07  
> **등록일**: 2026-09-10  
> **연관 개념 카드**: [[인터랙티브_에디터_리플레이_아키텍처_JSONL_CodeMirror]]

---

## 💡 핵심 요약 (3줄)

1. Inkdrop 개발자 타쿠야(Takuya)가 랜딩페이지용으로 실제 동작하는 CodeMirror 에디터와 배경 작업 영상을 1:1로 동기화한 셀프 타이핑(Self-Typing) 리플레이 데모를 직접 구현했다.
2. 에디터의 키 입력, 줄바꿈, 커서 이동 트랜잭션을 밀리초 타임스탬프와 함께 **JSONL 포맷**으로 기록한 뒤, 브라우저 메모리 Blob으로 즉시 추출하는 자체 레코더 파이프라인을 구축했다.
3. 리플레이 재생 시 `IntersectionObserver`로 뷰포트 진입 시점만 렌더링을 시작하고, 싱글톤 비디오 참조 모듈과 오프셋 튜닝을 통해 배경 WebM 영상의 타건 시점과 에디터 입력을 밀리초 오차 없이 결합했다.

---

## 📜 핵심 주장 및 타임스탬프 근거 (Level 1 Claims)

### 1. 가짜 영상(Mock/GIF) 대신 실제 웹 에디터를 랜딩페이지에 띄우는 이유
- **타임스탬프**: `[00:59] ~ [01:23]`
- **핵심 근거**: 일반적인 홍보 영상이나 GIF는 사용자가 직접 체험할 수 없다. 실제 앱 UI를 웹 브라우저에 그대로 띄우고 실제 타이핑 세션을 재생하면 사용자가 앱을 다운로드하기 전에 편집 경험을 즉시 체감할 수 있다.

### 2. 가벼운 React SSR 프레임워크 Waku와 CodeMirror의 결합
- **타임스탬프**: `[02:49] ~ [06:06]`, `[28:23] ~ [30:28]`
- **핵심 근거**: Next.js 같은 무거운 풀스택 대신 최소형 React SSR 프레임워크인 Waku를 선택해 번들 크기와 초기 진입 속도를 극대화했다. 에디터 코어로는 확장성이 뛰어난 CodeMirror를 채택해 GFM(GitHub Flavored Markdown) 코드 블록과 TypeScript 문법 강조를 무결점으로 연동했다.

### 3. 트랜잭션 기록 포맷으로 JSONL을 선택한 이유
- **타임스탬프**: `[31:58] ~ [34:07]`
- **핵심 근거**: 에디터 내에서 발생하는 모든 변화는 시계열 트랜잭션의 연속이다. 한 줄마다 독립된 JSON 레코드를 갖는 JSONL은 대용량 트랜잭션 시퀀스를 라인 단위로 직렬화하고 파싱하기에 최적의 데이터 구조다.

### 4. `/record` 전용 라우트와 브라우저 메모리 기반 무설치 녹화
- **타임스탬프**: `[43:17] ~ [56:49]`
- **핵심 근거**: 백엔드 서버나 별도 DB 없이 브라우저 내에서 직접 세션을 녹화하기 위해 `/record` 페이지를 임시 구현했다. CodeMirror 뷰 참조(Ref)를 연결해 트랜잭션을 캡처하고, 세션 종료 시 `Blob`과 보이지 않는 `<a>` 태그 클릭 기법으로 로컬에 `.jsonl` 파일을 즉시 저장했다.

### 5. 정밀 리플레이 엔진과 뷰포트 부하 제어
- **타임스탬프**: `[63:45] ~ [74:30]`
- **핵심 근거**:
  - 개발자 콘솔에서 ESM 동적 import로 JSONL을 파싱해 리플레이 검증을 거쳤다.
  - 에디터가 포커스를 받지 않아도 커서가 자연스럽게 깜빡이도록 CSS 속성을 보정했다.
  - 화면 밖에서 백그라운드 리소스가 낭비되지 않도록 `IntersectionObserver`를 적용해 사용자가 해당 섹션에 도달했을 때만 재생을 시작시켰다.

### 6. 배경 비디오와 에디터 트랜잭션 싱크 (싱글톤 & 오프셋)
- **타임스탬프**: `[75:53] ~ [83:19]`
- **핵심 근거**: ffmpeg로 변환한 WebM 배경 영상과 웹 에디터는 서로 다른 생명주기를 가진다. 둘 간의 타이밍 어긋남을 잡기 위해 비디오 요소를 공유하는 싱글톤 모듈을 만들고, 비디오 재생/일시정지 상태를 에디터 리플레이와 바인딩한 뒤 정밀 오프셋(offset) 값을 주어 영상 속 타건 소리와 실제 화면의 글자 출력을 완벽히 일치시켰다.

---

## 🧠 추출된 지식 카드 (Level 2)

- [[인터랙티브_에디터_리플레이_아키텍처_JSONL_CodeMirror]]: 시계열 에디터 이벤트 직렬화 및 미디어 싱크 메커니즘을 정리한 원자적 기술 카드.

---

## ⚖️ 5-Gate 심사 및 의사결정 (Level 3+)

| 평가 항목 | 판별 결과 | 상세 이유 |
| :--- | :---: | :--- |
| **1. 실제 문제인가?** | ❌ NO | 현재 내 개발 환경이나 세컨드 브레인 시스템에 직접 발생한 결함이나 요구사항이 아님 |
| **2. 기존 기능으로 해결 가능한가?** | ✅ YES | 향후 웹앱/랜딩페이지 제작 시 기존 React/Vite/Next.js 스택과 프론트엔드 스킬로 수용 가능 |
| **3. 자동화 가치가 있는가?** | ❌ NO | 반복 실행용 자동화 기능이 아닌 일회성 UI/UX 인터랙션 구현 기법 |
| **4. 복잡성 대비 효용이 큰가?** | ❌ NO | 코어 에이전트 시스템에 코드나 패키지를 추가하면 불필요한 시스템 비대화 초래 |
| **5. 쉽게 삭제 가능한가?** | ✅ YES | 독립적인 기술 레퍼런스 카드 형태로 안전하게 보관 가능 |

- **최종 결정: `NO CHANGE ⭐` (성공적인 시스템 비대화 방지)**  
  - 불필요한 의존성 설치나 시스템 변경을 하지 않고, 고급 랜딩페이지 인터랙션 패턴으로서 Level 2 지식 카드로 분리 보관한다.

---

<details>
<summary>📜 타임스탬프 스크립트 발췌 (접기/펼치기)</summary>

```text
[00:42] Hey, what's up? It's Takuya here. Long time no see!
[00:49] I've been working hard on my Markdown note-taking app called Inkdrop.
[00:55] Recently, I built a new landing page for it.
[00:59] It features an interactive demo powered by the actual app UI.
[01:05] On the page, a real editing session is synchronized with a background video of me composing a tech note.
[01:17] It's a great way to demonstrate how the app works.
[01:23] Since it's a real editor, you can actually try it out without downloading the app.
[02:49] I'm gonna use Waku for this project. It's a minimal React framework with SSR support.
[02:59] Gonna add CodeMirror modules.
[28:23] I really admire CodeMirror's flexibility for customizing with extensions.
[28:46] It supports GFM codeblocks out of the box. So I'm adding TypeScript to the code languages.
[32:04] JSONL is a format where each line is a JSON value separated by a newline character. Optimal for storing transaction sequences.
[34:07] Create a serializer/de-serializer of the JSONL format.
[43:17] Gonna add a separate page for recording a take. Add a new page /record.
[52:22] Create a blob to download, convert it to a URI, create an invisible anchor element, let the browser click it.
[56:49] Yeah, it seems like the transactions are properly recorded! Time to implement a replay module.
[63:50] Gonna directly import ESMs in the dev console. Let's load the JSONL file and run it.
[70:06] Make the cursor always visible even without focus.
[73:03] Use IntersectionObserver so the demo only starts when visible enough in the viewport.
[75:53] I converted the m4v video to webm using ffmpeg. Add it as a background video in the masthead.
[78:09] The video element has to be shared between the player and the editor. Gonna create a simple singleton module.
[79:22] Define an offset value to adjust the timing.
[83:19] It got synced!
```

</details>
